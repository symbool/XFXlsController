//
//  XFCollectionViewCell.h
//  SEARCH
//
//  Created by 小非 on 15/5/25.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFCollectionViewCell : UICollectionViewCell {
    
    UILabel *_label;
    CALayer *_rightSeparater;
    CALayer *_bottomSeparater;
    CALayer *_topSeparater;
}

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL needTopSeparater;
@property (nonatomic, strong) UIColor *separaterColor;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

@end
