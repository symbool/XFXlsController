//
//  XFXlsController.h
//  XFEXCEL
//
//  Created by 小非 on 15/5/29.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTableLayout.h"
#import "XFCollectionViewCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface XFXlsController : UIViewController<UICollectionViewDataSource, XFTableLayoutDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) UIEdgeInsets cellPadding;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;
@property (nonatomic, assign) NSInteger titleLineNum;
@property (nonatomic, assign) NSInteger titleRowNum;
@property (nonatomic, assign) CGSize maxCellSize;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) BOOL directionalLockEnabled;
@end
