//
//  OptimizationView.h
//  Eleven
//
//  Created by Peanut on 2019/3/14.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoActionButton.h"

typedef enum : NSUInteger {
    OptimizationViewTypeOptimization,
    OptimizationViewTypeEnhance
} OptimizationViewType;

NS_ASSUME_NONNULL_BEGIN

typedef void(^OptimizationCancelBlock)(void);
typedef void(^OptimizationActionBlock)(PhotoActionButton *actionButton);

@interface OptimizationView : UIView

@property (nonatomic,assign) OptimizationViewType type;
@property (nonatomic,strong) NSDictionary *actionData;
@property (nonatomic,weak) UIScrollView *actionScroll;
@property (nonatomic,copy) OptimizationCancelBlock optimizationCancelBlock;
@property (nonatomic,copy) OptimizationActionBlock optimizationActionBlock;
@property (nonatomic,assign) NSInteger optimizationTapIndx;

@end

NS_ASSUME_NONNULL_END
