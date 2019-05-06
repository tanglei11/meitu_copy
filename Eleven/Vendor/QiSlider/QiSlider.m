//
//  QiSlider.m
//  QiSlider
//
//  Created by QiShare on 2018/7/31.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiSlider.h"

@interface QiSlider ()

/*! @brief slider的thumbView */
@property (nonatomic, strong) UIView *thumbView;
/*! @brief 显示value的label */
@property (nonatomic,weak) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *valueImage;

@end

@implementation QiSlider

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addTarget:self action:@selector(sliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        //添加点击手势
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)]];
    }
    return self;
}

#pragma mark - Overwrite functions

//- (CGRect)trackRectForBounds:(CGRect)bounds {
//    /*! @brief 重写方法-返回进度条的bounds-修改进度条的高度 */
//    bounds = [super trackRectForBounds:bounds];
//    return CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - 3.0) / 2, bounds.size.width, 3.0);
//}

- (void)setValue:(float)value animated:(BOOL)animated {
    
    [super setValue:value animated:animated];
    [self sliderValueChanged:self];
}

- (void)setValue:(float)value {
    
    [super setValue:value];
    [self sliderValueChanged:self];
}

#pragma mark - Setter functions

- (void)setValueText:(NSString *)valueText {
    
    if (![_valueText isEqualToString:valueText]) {
        _valueText = valueText;
        
        self.valueLabel.text = valueText;
//        [self.valueLabel sizeToFit];
        self.valueImage.center = CGPointMake(self.thumbView.bounds.size.width / 2, - 8 - self.thumbView.bounds.size.height / 2);
        
        if (!self.valueImage.superview) {
            [self.thumbView addSubview:self.valueImage];
        }
    }
}


#pragma mark - Getter functions

- (UIView *)thumbView {
    
    if (!_thumbView && self.subviews.count > 2) {
        _thumbView = self.subviews[2];
    }
    return _thumbView;
}

- (UIImageView *)valueImage {
    
    if (!_valueImage) {
        _valueImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        _valueImage.image = [ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:ICON_FONT_WATER] inFont:ICONFONT size:35 color:[UIColor whiteColor]];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (_valueImage.height - 14) / 2, _valueImage.width, 14)];
        valueLabel.font = [UIFont systemFontOfSize:14];
        valueLabel.textColor = [UIColor colorFromHex:@"#131415"];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        [_valueImage addSubview:valueLabel];
        self.valueLabel = valueLabel;
    }
    return _valueImage;
}


#pragma mark - Action functions

- (void)sliderTouchDown:(QiSlider *)sender {
    self.valueImage.hidden = NO;
    if (_touchDown) {
        _touchDown(sender);
    }
}

- (void)sliderValueChanged:(QiSlider *)sender {
    
    sender.valueText = [NSString stringWithFormat:@"%.0f", sender.value];
    if (_valueChanged) {
        _valueChanged(sender);
    }
}

- (void)sliderTouchUpInside:(QiSlider *)sender {
    self.valueImage.hidden = YES;
    if (_touchUpInside) {
        _touchUpInside(sender);
    }
}

- (void)sliderTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self];
    CGFloat value = (self.maximumValue - self.minimumValue) * (touchPoint.x / self.frame.size.width);
    //    NSUInteger index = (NSUInteger)(value + 0.5);
    [self setValue:value animated:YES];
}

#pragma mark -

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

@end
