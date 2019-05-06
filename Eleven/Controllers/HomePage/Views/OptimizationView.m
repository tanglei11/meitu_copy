//
//  OptimizationView.m
//  Eleven
//
//  Created by Peanut on 2019/3/14.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "OptimizationView.h"

@interface OptimizationView ()

@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation OptimizationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 40 - 34, frame.size.width, 40)];
        [self addSubview:bottomView];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, (bottomView.height - 23) / 2, 23, 23)];
        [cancelButton setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:ICON_FONT_CHA] inFont:ICONFONT size:18 color:[UIColor whiteColor]] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:cancelButton];
        
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(bottomView.width - 23 - 10, (bottomView.height - 23) / 2, 23, 23)];
        [confirmButton setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:ICON_FONT_GOU] inFont:ICONFONT size:18 color:[UIColor whiteColor]] forState:UIControlStateNormal];
        [bottomView addSubview:confirmButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelButton.frame) + 10, (bottomView.height - 17) / 2, confirmButton.x - CGRectGetMaxX(cancelButton.frame) - 10 - 10, 17)];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIScrollView *actionScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 42)];
        actionScroll.showsVerticalScrollIndicator = NO;
        actionScroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:actionScroll];
        self.actionScroll = actionScroll;
        
    }
    return self;
}

- (void)setActionData:(NSDictionary *)actionData
{
    _actionData = actionData;
    
    self.titleLabel.text = actionData[@"title"];
    
    //先移除
    [self.actionScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //创建
    NSArray *actions = actionData[@"actions"];
    CGFloat actionW = (self.actionScroll.width - (self.actionScroll.width) / 5 / 2) / 5;
    CGFloat actionH = self.actionScroll.height;
    CGFloat actionY = 0;
    for (int i = 0; i < actions.count; i++) {
        NSDictionary *dict = actions[i];
        PhotoActionButton *actionButton = [[PhotoActionButton alloc] initWithFrame:CGRectMake(i * actionW, actionY, actionW, actionH)];
        actionButton.tag = i;
        actionButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [actionButton setTitle:dict[@"name"] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor colorFromHex:@"#9B9A9B"] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor colorFromHex:@"#C33B50"] forState:UIControlStateSelected];
        [actionButton setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:dict[@"icon"]] inFont:ICONFONT size:18 color:[UIColor colorFromHex:@"#9B9A9B"]] forState:UIControlStateNormal];
        [actionButton setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:dict[@"icon"]] inFont:ICONFONT size:18 color:[UIColor colorFromHex:@"#C33B50"]] forState:UIControlStateSelected];
//        if (i == _optimizationTapIndx) {
//            actionButton.selected = YES;
//        }
        [actionButton addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionScroll addSubview:actionButton];
    }
    self.actionScroll.contentSize = CGSizeMake(actionW * actions.count, 0);
}

- (void)setOptimizationTapIndx:(NSInteger)optimizationTapIndx
{
    _optimizationTapIndx = optimizationTapIndx;
//    [self.actionScroll setContentOffset:CGPointMake(<#CGFloat x#>, 0) animated:YES];
    PhotoActionButton *actionButton = self.actionScroll.subviews[optimizationTapIndx];
    [self actionClick:actionButton];
}

- (void)actionClick:(PhotoActionButton *)button
{
    for (id obj in self.actionScroll.subviews) {
        if ([obj isKindOfClass:[PhotoActionButton class]]) {
            PhotoActionButton *actionButton = (PhotoActionButton *)obj;
            actionButton.selected = NO;
        }
    }
    button.selected = YES;
    self.optimizationActionBlock(button);
}

- (void)cancelClick
{
    self.optimizationCancelBlock();
}

@end
