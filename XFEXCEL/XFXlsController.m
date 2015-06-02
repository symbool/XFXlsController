//
//  XFXlsController.m
//  XFEXCEL
//
//  Created by 小非 on 15/5/29.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import "XFXlsController.h"

@interface XFXlsController ()

@end

@implementation XFXlsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createCollectionView {
    
    XFTableLayout *layout = [[XFTableLayout alloc]init];
    layout.originContentOffset = CGPointMake(0, 0);
    layout.padding = self.cellPadding;
    layout.titleLineNum = self.titleLineNum;
    layout.titleRowNum = self.titleRowNum;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[XFCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.directionalLockEnabled = self.directionalLockEnabled;
    [self.view addSubview:self.collectionView];
}



#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.data) {
        
        return self.data.count;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *dataOfSection = [self.data objectAtIndex:section];
    if (dataOfSection) {
        return [dataOfSection count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSString *text = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    NSUInteger section = indexPath.section;
    NSUInteger item = indexPath.item;
    NSUInteger preCount;
    if (section > 0) {
        preCount = [self collectionView:collectionView numberOfItemsInSection:section - 1];
    }
    BOOL needTopSeparater = (item > preCount - 1);
    
    cell.separaterColor = [UIColor lightGrayColor];
    cell.needTopSeparater = needTopSeparater;
    cell.text = text;
    cell.padding = self.cellPadding;
    cell.selectedBackgroundColor = self.cellSelectedBackgroundColor;
    
    return cell;
}

#pragma mark -
#pragma mark XFTableLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    UIFont *font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    
    CGSize maxSize = self.maxCellSize;
    if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
        CGFloat maxWidth = SCREEN_WIDTH * 2 / 3;
        CGFloat maxHeight = 200;
        maxSize = CGSizeMake(maxWidth, maxHeight);
    }
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return CGSizeMake(rect.size.width, rect.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
