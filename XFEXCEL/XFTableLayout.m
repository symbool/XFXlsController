//
//  XFTableLayout.m
//  SEARCH
//
//  Created by 小非 on 15/5/21.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import "XFTableLayout.h"

@implementation XFTableLayout

- (instancetype)init {
    
    if (self = [super init]) {
        
        _heightOfRows = [[NSMutableArray alloc]init];
        _widthOfList = [[NSMutableArray alloc]init];
        _sizes = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if(_widthOfList.count > 0 && !self.needCalculate)/*_widthOfList不空说明不是第一次布局，所需的数值已经计算出来*/
        return;
    
    self.needCalculate = NO;
    [self calculateSize];
}

- (void)calculateSize {
    
    [_sizes removeAllObjects];
    [_heightOfRows removeAllObjects];
    [_widthOfList removeAllObjects];
    NSUInteger rows = [[self collectionView] numberOfSections];
    _maxList = 0;
    
    for (int i = 0; i < rows; i++) {
        
        NSUInteger count = [[self collectionView] numberOfItemsInSection:i];
        _maxList = MAX(_maxList, count);
    }
    id delegate = [[self collectionView] delegate];
    
    for (int row = 0; row < rows; row++) {
        
        CGFloat maxHeight = 0;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int list = 0; list < [[self collectionView] numberOfItemsInSection:row]; list++) {
            
            CGSize contentSize = [delegate collectionView:[self collectionView] layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:list inSection:row]];
            CGFloat width = contentSize.width + self.padding.left + self.padding.right;
            CGFloat height = contentSize.height + self.padding.top + self.padding.bottom;
            CGSize size = CGSizeMake(width, height);
            [array addObject:[NSValue valueWithCGSize:size]];
            maxHeight = MAX(maxHeight, size.height);
        }
        [_sizes addObject:array];
        [_heightOfRows addObject:[NSNumber numberWithFloat:maxHeight]];
    }
    
    for (int list = 0; list < _maxList; list++) {
        
        CGFloat maxWidth = 0;
        for (int row = 0; row < rows; row++) {
            
            if ([delegate conformsToProtocol:@protocol(XFTableLayoutDelegate)]) {
                
                NSUInteger items = [self.collectionView numberOfItemsInSection:row];
                if (list < items) {
                    
                    NSValue *value = [[_sizes objectAtIndex:row] objectAtIndex:list];
                    CGSize size = [value CGSizeValue];
                    maxWidth = MAX(maxWidth, size.width);
                }
            }else {
                //无法布局
            }
        }
        [_widthOfList addObject:[NSNumber numberWithFloat:maxWidth]];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    NSUInteger section = [[self collectionView] numberOfSections];
    CGFloat preHeight = 0;
    int preRow = 0;
    for (; preHeight <= rect.origin.y && preRow < section; preRow++) {
        
        preHeight += [[_heightOfRows objectAtIndex:preRow] floatValue];
    }
    CGFloat preWidth = 0;
    int preList = 0;
    for (; preWidth <= rect.origin.x && preList < _maxList; preList++) {
        
        preWidth += [[_widthOfList objectAtIndex:preList] floatValue];
    }
    preList = MAX(preList, 1);
    
    CGFloat height = preHeight;
    int row = preRow;
    for (; height <= CGRectGetMaxY(rect) && row < section; row++) {
        
        height += [[_heightOfRows objectAtIndex:row] floatValue];
    }
    preRow = MAX(preRow, 1);
    
    CGFloat width = preWidth;
    int list = preList;
    for (; width <= CGRectGetMaxX(rect) && list < _maxList; list++) {
        
        width += [[_widthOfList objectAtIndex:list] floatValue];
    }
    
    for (int i = preRow - 1; i < row; i++) {
        
        NSUInteger items = [self.collectionView numberOfItemsInSection:i];
        NSUInteger itemCount = MIN(list, items);
        for (int l = preList - 1; l < itemCount; l++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:l inSection:i];
            UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
            [mutableArray addObject:attri];
        }
        
        // 如果有列标题并且不在滚动出了列标题原在的rect时，加入这标题列中可视的部分
        NSInteger titleRowIndex = self.titleRowNum - 1;
        if (titleRowIndex < _maxList && (titleRowIndex < preList - 1 || titleRowIndex > itemCount - 1)) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:titleRowIndex inSection:i];
            UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
            [mutableArray addObject:attri];
        }
    }
    
    // 如果有行标题并且不在滚动出了行标题原在的rect时，加入这标题行中可视的部分
    NSInteger titleLineIndex = self.titleLineNum - 1;
    if (titleLineIndex < section && (titleLineIndex < preRow - 1 || titleLineIndex > row - 1)) {
        
        NSUInteger titleLineCount = [self.collectionView numberOfItemsInSection:titleLineIndex];
        NSUInteger titleLineCountInRect = MIN(titleLineCount, list);
        for (int l = preList - 1; l < titleLineCountInRect; l++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:l inSection:titleLineIndex];
            UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
            [mutableArray addObject:attri];
        }
    }
    
    //如果行列标题都存在，那么行列标题那个cell在任何地方都存在
    if (self.titleRowNum != 0 && self.titleLineNum != 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.titleRowNum - 1 inSection:titleLineIndex];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [mutableArray addObject:attri];
    }
    
    return mutableArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    if (self.titleLineNum  == 0 && self.titleRowNum == 0) {
        return NO;
    }
    return YES;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
//    
//    return proposedContentOffset;
//}
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    
//    return proposedContentOffset;
//}

- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context {
    
    [super invalidateLayoutWithContext:context];
    
    if (context.invalidateEverything) {
        [self calculateSize];
    }
}

- (CGSize)collectionViewContentSize {
    
    NSUInteger section = [[self collectionView] numberOfSections];
    NSUInteger item = _maxList;
    CGFloat height = 64;
    for (int row = 0; row < section; row++) {
        
        height += [[_heightOfRows objectAtIndex:row] floatValue];
    }
    CGFloat width = 0;
    for (int list = 0; list < item; list++) {
        
        width += [[_widthOfList objectAtIndex:list] floatValue];
    }
    
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSUInteger section = indexPath.section;
    NSUInteger item = indexPath.item;
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGFloat orignY = 0;
    for (int row = 0; row < section; row++) {
        
        orignY += [[_heightOfRows objectAtIndex:row] floatValue];
    }
    
    if (item == self.titleRowNum - 1 && section == self.titleLineNum - 1) {
        NSLog(@"");
    }
    /* 修正y值，使得拖动也能在屏幕上侧*/
    if (self.titleLineNum != 0) {
        
        NSInteger titleLineIndex = self.titleLineNum - 1;
        CGFloat offsetY = contentOffset.y - _originContentOffset.y;
        if (section == titleLineIndex) {
            orignY = MAX(offsetY, orignY);
            attri.zIndex = 1024;
        }else if (orignY + self.padding.top + self.padding.bottom < offsetY + [[_heightOfRows objectAtIndex:titleLineIndex] floatValue] && section > titleLineIndex) {
            attri.alpha = 0.1f;
        }
    }
    
    CGFloat orignX = 0;
    for (int list = 0; list < item; list++) {
        
        orignX += [[_widthOfList objectAtIndex:list] floatValue];
    }
    /* 修正x值，使得拖动也能在屏幕左侧*/
    
    if (self.titleRowNum != 0) {
        
        NSInteger titleRowIndex = self.titleRowNum - 1;
        if (item == titleRowIndex) {
            
            CGFloat offsetX = contentOffset.x - _originContentOffset.x;
            
            orignX = MAX(offsetX, orignX);
            attri.zIndex = 1024;
        }else if(orignX + self.padding.left + self.padding.right < contentOffset.x + [[_widthOfList objectAtIndex:titleRowIndex] floatValue] && item > titleRowIndex) {
            attri.alpha = 0.1f;
        }
    }
    
    CGFloat width = [[_widthOfList objectAtIndex:indexPath.item] floatValue];
    CGFloat height = [[_heightOfRows objectAtIndex:indexPath.section] floatValue];
    attri.frame = CGRectMake(orignX, orignY, width, height);
    
    return attri;
}

@end
