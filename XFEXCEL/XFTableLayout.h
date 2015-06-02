//
//  XFTableLayout.h
//  SEARCH
//
//  Created by 小非 on 15/5/21.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFTableLayoutDelegate <UICollectionViewDelegate>

@required

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface XFTableLayout : UICollectionViewLayout {
    
    NSMutableArray *_heightOfRows;
    NSMutableArray *_widthOfList;
    NSMutableArray *_sizes;
    NSUInteger _maxList;
}

@property (nonatomic, assign) NSInteger titleLineNum;
@property (nonatomic, assign) NSInteger titleRowNum;
@property (nonatomic, assign) CGPoint originContentOffset;
@property (nonatomic, assign) BOOL needCalculate;
@property (nonatomic, assign) UIEdgeInsets padding;

@end
