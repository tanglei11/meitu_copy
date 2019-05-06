//
//  YPSegmentController.h
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/2.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPSegmentBar.h"
#import "YPSegmentControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPSegmentController : UIViewController

/** 内容视图 */
@property (nonatomic, weak) UIScrollView *contentView;

/** 选项条 */
@property (nonatomic, weak) YPSegmentBar *segmentBar;

/** 是否开启预加载功能 默认为NO */
@property (nonatomic, assign) BOOL prefetchingEnabled;

/** 切换控制器时是否要开启动画过渡效果 默认为NO */
@property (nonatomic, assign) BOOL switchControllerAnimationEnabled;

/** 背景View */
@property (nonatomic, weak) UIView *backgroundView;

/** 
 *  设置数据源
 */
- (void)setUpWithItems:(NSArray <UIViewController *>*)items;

/**
 *  修改基本配置
 */
- (void)updateWithConfig:(void(^)(YPSegmentControllerConfig *config))block;


@end

@interface UIViewController (YPSegmentControllerItem)

@property(nullable, nonatomic,readonly,strong) YPSegmentController *segmentController;

@end

NS_ASSUME_NONNULL_END

