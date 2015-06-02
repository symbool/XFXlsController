//
//  XFCollectionViewCell.m
//  SEARCH
//
//  Created by 小非 on 15/5/25.
//  Copyright (c) 2015年 小非. All rights reserved.
//

#import "XFCollectionViewCell.h"

@implementation XFCollectionViewCell

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}

- (void)initView {
    
    [CATransaction setDisableActions:YES];
    _label = [[UILabel alloc]init];
    _label.numberOfLines = 0;
    _label.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_label];
    _rightSeparater = [[CALayer alloc]init];
    _rightSeparater.frame = CGRectMake(self.bounds.size.width - 1, 0, 1, self.bounds.size.height);
    _rightSeparater.backgroundColor = self.separaterColor.CGColor;
    [self.contentView.layer addSublayer:_rightSeparater];
    _bottomSeparater = [[CALayer alloc]init];
    _bottomSeparater.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
    _bottomSeparater.backgroundColor = self.separaterColor.CGColor;
    [self.contentView.layer addSublayer:_bottomSeparater];
}

- (void)prepareForReuse {
    [super prepareForReuse];

}

- (void)setSelected:(BOOL)selected {
    
    super.selected = selected;
    if (selected) {
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = self.selectedBackgroundColor;
        }];
    }else {
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}

- (void)setSeparaterColor:(UIColor *)separaterColor {
    
    _separaterColor = separaterColor;
    
    [CATransaction setDisableActions:YES];
    _topSeparater.backgroundColor = separaterColor.CGColor;
    _rightSeparater.backgroundColor = separaterColor.CGColor;
    _bottomSeparater.backgroundColor = separaterColor.CGColor;
    _topSeparater.frame = CGRectMake(0, -1, self.bounds.size.width, 1);
    _rightSeparater.frame = CGRectMake(self.bounds.size.width - 1, 0, 1, self.bounds.size.height);
    _bottomSeparater.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
}

- (void)setNeedTopSeparater:(BOOL)needTopSeparater {
    
    _needTopSeparater = needTopSeparater;
    _topSeparater.hidden = !needTopSeparater;
    if (!_topSeparater) {
        _topSeparater = [[CALayer alloc]init];
        _topSeparater.backgroundColor = self.separaterColor.CGColor;
        [self.contentView.layer addSublayer:_topSeparater];
    }
}

- (void)setPadding:(UIEdgeInsets)padding {
    
    _padding = padding;
    
    [self refreshLabelFrame];
}

- (void)refreshLabelFrame {
    
    CGRect frame = self.bounds;
    frame.origin.x = self.padding.left;
    frame.size.width = self.bounds.size.width - self.padding.left - self.padding.right;
    frame.origin.y = self.padding.top;
    frame.size.height = self.bounds.size.height - self.padding.top - self.padding.bottom;
    _label.frame = frame;
}

- (void)setText:(NSString *)text {
    
    _text = text;
    _label.text = text;
    
    [self refreshLabelFrame];
}

@end
