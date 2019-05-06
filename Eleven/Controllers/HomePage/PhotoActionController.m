//
//  PhotoActionController.m
//  Eleven
//
//  Created by Peanut on 2019/3/13.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "PhotoActionController.h"
#import "PhotoActionButton.h"
#import "UIView+LXShadowPath.h"
#import "OptimizationView.h"
#import "QiSlider.h"

@interface PhotoActionController () <UIScrollViewDelegate>{
    GPUImageOutput<GPUImageInput> *filter;
//    GPUImageOutput<GPUImageInput> *filter1;
    GPUImagePicture *staticPicture;
}

@property (nonatomic, assign) BOOL statusBarStyleControl; // 状态栏状态控制
@property (nonatomic,weak) UIView *actionBottom;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIScrollView *optimizationScrollView;
@property (nonatomic,weak) UIImageView *img;
@property (nonatomic,weak) UIImageView *currentImg;
@property (nonatomic,weak) UIImageView *preImg;
@property (nonatomic,weak) UIImageView *nextImg;
@property (nonatomic,strong) UIView *feintCoverView;
@property (nonatomic,strong) UIView *previousFeintView;
@property (nonatomic,strong) UIView *currentFeintView;
@property (nonatomic,strong) UIView *nextFeintView;
@property (nonatomic,strong) OptimizationView *optimizationView;
@property (nonatomic,strong) QiSlider *optimizationSlider;
@property (nonatomic,strong) UIButton *optimizationChangeBtn;
@property (nonatomic,assign) NSInteger tapIndex;
@property (nonatomic,assign) NSInteger optimizationTapIndex;
@property (nonatomic,assign) BOOL isActionViewShow;

@property (nonatomic,strong) UIImage *newsImage;

@end

@implementation PhotoActionController
//懒加载
- (UIView *)feintCoverView
{
    if (!_feintCoverView) {
        _feintCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.currentFeintView.width, self.currentFeintView.height)];
        _feintCoverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    return _feintCoverView;
}

- (UIView *)previousFeintView
{
    if (!_previousFeintView) {
        _previousFeintView = [[UIView alloc] initWithFrame:CGRectMake(-Screen_Width, STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT - 44, Screen_Width, self.scrollView.height)];
        _previousFeintView.backgroundColor = [UIColor blackColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((_previousFeintView.width - self.img.width) / 2, (_previousFeintView.height - self.img.height) / 2, self.img.width, self.img.height)];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.image = self.imgV;
        [_previousFeintView addSubview:imgV];
        self.preImg = imgV;
    }
    return _previousFeintView;
}

- (UIView *)currentFeintView
{
    if (!_currentFeintView) {
        _currentFeintView = [[UIView alloc] initWithFrame:CGRectMake(0, STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT - 44, Screen_Width, self.scrollView.height)];
        _currentFeintView.backgroundColor = [UIColor blackColor];

        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((_currentFeintView.width - self.img.width) / 2, (_currentFeintView.height - self.img.height) / 2, self.img.width, self.img.height)];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.image = self.imgV;
        [_currentFeintView addSubview:imgV];
        self.currentImg = imgV;
        
        [_currentFeintView addSubview:self.feintCoverView];
    }
    return _currentFeintView;
}

- (UIView *)nextFeintView
{
    if (!_nextFeintView) {
        _nextFeintView = [[UIView alloc] initWithFrame:CGRectMake(Screen_Width, STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT - 44, Screen_Width, self.scrollView.height)];
        _nextFeintView.backgroundColor = [UIColor blackColor];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((_nextFeintView.width - self.img.width) / 2, (_nextFeintView.height - self.img.height) / 2, self.img.width, self.img.height)];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.image = self.imgV;
        [_nextFeintView addSubview:imgV];
        self.nextImg = imgV;
    }
    return _nextFeintView;
}

- (OptimizationView *)optimizationView
{
    if (!_optimizationView) {
        _optimizationView = [[OptimizationView alloc] initWithFrame:CGRectMake(0, Screen_Height, Screen_Width, 200)];
        _optimizationView.backgroundColor = [UIColor colorFromHex:@"#181818"];
        switch (self.tapIndex) {
            case 0:
                {
                    _optimizationView.type = OptimizationViewTypeOptimization;
                    NSArray *actions = @[@{@"icon":ICON_FONT_FORBID,@"name":@"原图"},@{@"icon":ICON_FONT_AUTO,@"name":@"自动"},@{@"icon":ICON_FONT_FOOD,@"name":@"美食"},@{@"icon":ICON_FONT_FLOWER,@"name":@"静物"},@{@"icon":ICON_FONT_SCENERY,@"name":@"风景"},@{@"icon":ICON_FONT_FOG,@"name":@"去雾"},@{@"icon":ICON_FONT_CHARACTER,@"name":@"人物"},@{@"icon":ICON_FONT_PET,@"name":@"宠物"}];
                    _optimizationView.actionData = @{@"title":@"智能优化",@"actions":actions};
                }
                break;
            case 2:
                {
                    _optimizationView.type = OptimizationViewTypeEnhance;
                    NSArray *actions = @[@{@"icon":ICON_FONT_BRIGHT,@"name":@"亮度"},@{@"icon":ICON_FONT_CONTRAST,@"name":@"对比度"},@{@"icon":ICON_FONT_SHARPEN,@"name":@"锐化"},@{@"icon":ICON_FONT_SATURATION,@"name":@"饱和度"},@{@"icon":ICON_FONT_COLOR_TEMP,@"name":@"色温"},@{@"icon":ICON_FONT_SPECULARITY,@"name":@"高光调节"},@{@"icon":ICON_FONT_DARK_IMPRO,@"name":@"暗部改善"},@{@"icon":ICON_FONT_DISPERSION,@"name":@"色散"},@{@"icon":ICON_FONT_GRANULE,@"name":@"颗粒"},@{@"icon":ICON_FONT_COLOR_FADE,@"name":@"褪色"},@{@"icon":ICON_FONT_VIGNETTE,@"name":@"暗角"}];
                    _optimizationView.actionData = @{@"title":@"增强",@"actions":actions};
                }
                break;
            default:
                break;
        }
        @SJWeakObj(self);
        _optimizationView.optimizationCancelBlock = ^{
            [sjWeakself actionCancel];
        };
        _optimizationView.optimizationActionBlock = ^(PhotoActionButton *actionButton) {
            if (sjWeakself.optimizationView.type == OptimizationViewTypeOptimization) {
                if (actionButton.tag == 0) {
                    sjWeakself.optimizationSlider.hidden = YES;
                }else{
                    sjWeakself.optimizationSlider.hidden = NO;
                }
            }
            sjWeakself.optimizationTapIndex = actionButton.tag;
            [sjWeakself moveSlider:actionButton];
            //智能优化实现代码可写在这里
            [sjWeakself setUpFilterWithIndex:actionButton.tag];
        };
    }
    return _optimizationView;
}

- (QiSlider *)optimizationSlider
{
    if (!_optimizationSlider) {
        _optimizationSlider = [[QiSlider alloc] initWithFrame:CGRectMake(34, self.optimizationView.y - 20 - 20, Screen_Width - 2 * 34, 20)];
        _optimizationSlider.minimumValue = 0;
        _optimizationSlider.maximumValue = 100;
        _optimizationSlider.thumbTintColor = [UIColor whiteColor];
        _optimizationSlider.minimumTrackTintColor = [UIColor colorFromHex:@"#FF2F62"];
        _optimizationSlider.maximumTrackTintColor = [UIColor colorFromHex:@"#4A4A4A"];
        @SJWeakObj(self);
        _optimizationSlider.valueChanged = ^(QiSlider *sender) {
            [sjWeakself updateFilterWithValue:sender.value];
        };
    }
    return _optimizationSlider;
}

- (UIButton *)optimizationChangeBtn
{
    if (!_optimizationChangeBtn) {
        _optimizationChangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 40 - 20, 95, 40, 40)];
        _optimizationChangeBtn.layer.cornerRadius = 20;
        _optimizationChangeBtn.backgroundColor = [UIColor whiteColor];
        [_optimizationChangeBtn setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:ICON_FONT_CHANGE] inFont:ICONFONT size:22 color:[UIColor colorFromHex:@"#1C1C1D"]] forState:UIControlStateNormal];
    }
    return _optimizationChangeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav];
    
    [self initUI];
    
    [self initActionBottom];
}

- (void)initNav
{
    [self setupCustomNavigationBarDefault];
    [self setupCustomBlackBackButton];
    self.customNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(save) title:@"保存/分享" titleColor:[UIColor blackColor]];
}

- (void)initUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT, Screen_Width, Screen_Height - STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT - 34 - 120)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorFromHex:@"#F7F6F6"];
    UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
    doubleClick.numberOfTapsRequired = 2;
    [scrollView addGestureRecognizer:doubleClick];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [scrollView addGestureRecognizer:rightSwipe];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [scrollView addGestureRecognizer:leftSwipe];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //初始化imageview，设置图片
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.image = self.imgV;
    imgV.frame = CGRectMake(0, 0, scrollView.width, scrollView.height);
    [scrollView addSubview:imgV];
    self.img = imgV;
    
    //设置代理,设置最大缩放和虽小缩放
    scrollView.delegate = self;
    scrollView.maximumZoomScale = 50;
    scrollView.minimumZoomScale = 0.5;
    
    scrollView.contentSize = CGSizeMake(scrollView.width + LINE_HEIGHT, scrollView.height + LINE_HEIGHT);
}

- (void)initActionBottom
{
    UIView *actionBottom = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - 34 - 120, Screen_Width, 120)];
    actionBottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:actionBottom];
    self.actionBottom = actionBottom;
    
    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(actionBottom.width - 55, 0, 55, 120)];
    [actionBottom addSubview:actionView];
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, actionView.height)];
    shadowView.backgroundColor = [UIColor whiteColor];
    shadowView.layer.shadowColor = [UIColor colorFromHex:@"#F7F6F6"].CGColor;
    shadowView.layer.shadowOpacity = 0.8f;
    shadowView.layer.shadowRadius = 4.0f;
    shadowView.layer.shadowOffset = CGSizeMake(-10,0);
    [actionView addSubview:shadowView];
    
    PhotoActionButton *button = [[PhotoActionButton alloc] initWithFrame:CGRectMake(0, 40, 55, 42)];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitle:@"去美容" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorFromHex:@"#FD5C74"] forState:UIControlStateNormal];
    [button setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:ICON_FONT_HAIR] inFont:ICONFONT size:18 color:[UIColor colorFromHex:@"#FE2A6D"]] forState:UIControlStateNormal];
    [actionView addSubview:button];
    
    UIScrollView *actionScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, actionBottom.width - 55, 42)];
    actionScroll.showsVerticalScrollIndicator = NO;
    actionScroll.showsHorizontalScrollIndicator = NO;
    [actionBottom addSubview:actionScroll];

    NSArray *actions = @[@{@"icon":ICON_FONT_LAMP,@"name":@"智能优化"},@{@"icon":ICON_FONT_EDIT,@"name":@"编辑"},@{@"icon":ICON_FONT_TONE,@"name":@"增强"},@{@"icon":ICON_FONT_FILTER,@"name":@"滤镜"},@{@"icon":ICON_FONT_FRAME,@"name":@"边框"},@{@"icon":ICON_FONT_MOSAIC,@"name":@"马赛克"},@{@"icon":ICON_FONT_DOODLE,@"name":@"涂鸦笔"},@{@"icon":ICON_FONT_PASTER,@"name":@"贴纸"},@{@"icon":ICON_FONT_WORD,@"name":@"文字"},@{@"icon":ICON_FONT_REMOVE,@"name":@"消除笔"},@{@"icon":ICON_FONT_NULL,@"name":@"背景虚化"}];
    CGFloat actionW = (actionScroll.width - 10) / 5;
    CGFloat actionH = actionScroll.height;
    CGFloat actionY = 0;
    for (int i = 0; i < actions.count; i++) {
        NSDictionary *dict = actions[i];
        PhotoActionButton *actionButton = [[PhotoActionButton alloc] initWithFrame:CGRectMake(10 + i * actionW, actionY, actionW, actionH)];
        actionButton.tag = i;
        actionButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [actionButton setTitle:dict[@"name"] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor colorFromHex:@"#121212"] forState:UIControlStateNormal];
        [actionButton setImage:[ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:dict[@"icon"]] inFont:ICONFONT size:18 color:[UIColor blackColor]] forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [actionScroll addSubview:actionButton];
    }
    actionScroll.contentSize = CGSizeMake(actionW * actions.count + 20, 0);
}

- (void)setUpFilterWithIndex:(NSInteger)index
{
    staticPicture = [[GPUImagePicture alloc] initWithImage:self.imgV];
    if (self.optimizationView.type == OptimizationViewTypeOptimization) {
        switch (index) {
            case 0:
                self.img.image = self.imgV;
                break;
            case 1:
                filter = [[GPUImageHighlightShadowFilter alloc] init];
                [(GPUImageHighlightShadowFilter *)filter setHighlights:1];
                [(GPUImageHighlightShadowFilter *)filter setShadows:0];
                [self updateFilter];
                break;
            default:
                break;
        }
    }else{
        switch (index) {
            case 0:
                filter = [[GPUImageBrightnessFilter alloc] init];
                [(GPUImageBrightnessFilter *)filter setBrightness:0];
                self.optimizationSlider.minimumValue = -100;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 1:
                filter = [[GPUImageContrastFilter alloc] init];
                [(GPUImageContrastFilter *)filter setContrast:1];
                self.optimizationSlider.minimumValue = -100;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 2:
                filter = [[GPUImageSharpenFilter alloc] init];
                [(GPUImageSharpenFilter *)filter setSharpness:0];
                self.optimizationSlider.minimumValue = 0;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 3:
                filter = [[GPUImageSaturationFilter alloc] init];
                [(GPUImageSaturationFilter *)filter setSaturation:1];
                self.optimizationSlider.minimumValue = -100;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 4:
                filter = [[GPUImageWhiteBalanceFilter alloc] init];
                [(GPUImageWhiteBalanceFilter *)filter setTint:0];
                self.optimizationSlider.minimumValue = -100;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 5:
                filter = [[GPUImageHighlightShadowFilter alloc] init];
                [(GPUImageHighlightShadowFilter *)filter setHighlights:0.5];
                self.optimizationSlider.minimumValue = -100;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 6:
                filter = [[GPUImageHighlightShadowFilter alloc] init];
                [(GPUImageHighlightShadowFilter *)filter setHighlights:0.5];
                self.optimizationSlider.minimumValue = -100;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 7:
                filter = [[GPUImageMedianFilter alloc] init];
                [(GPUImageMedianFilter *)filter setTexelWidth:0];
                [(GPUImageMedianFilter *)filter setTexelHeight:0];
                self.optimizationSlider.minimumValue = 0;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
            case 8:
                filter = [[GPUImageEmbossFilter alloc] init];
                [(GPUImageEmbossFilter *)filter setIntensity:0];
                self.optimizationSlider.minimumValue = 0;
                self.optimizationSlider.maximumValue = 100;
                self.optimizationSlider.value = 0;
                [self updateFilter];
                break;
                break;
            default:
                break;
        }
    }
}

- (void)updateFilterWithValue:(CGFloat)value
{
    if (self.optimizationView.type == OptimizationViewTypeOptimization) {
        switch (self.optimizationTapIndex) {
            case 0:
                break;
            case 1:
            {
                CGFloat updateValue = 1 - (0.8 * value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue));
                [(GPUImageHighlightShadowFilter *)filter setHighlights:updateValue];
                [(GPUImageHighlightShadowFilter *)filter setShadows:0];
                [self updateFilter];
            }
                break;
            default:
                break;
        }
    }else{
        switch (self.optimizationTapIndex) {
            case 0:
                {
                    CGFloat updateValue = value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue) / 2;
                    [(GPUImageBrightnessFilter *)filter setBrightness:updateValue];
                    [self updateFilter];
                }
                break;
            case 1:
                {
                    CGFloat updateValue = 0.0;
                    if (value == 0) {
                        updateValue = 1.0;
                    }else if (value < 0){
                        updateValue = 1 - fabs(value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue));
                    }else if (value > 0){
                        updateValue = 1 + value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                    }
                    [(GPUImageContrastFilter *)filter setContrast:updateValue];
                    [self updateFilter];
                }
                break;
            case 2:
                {
                    CGFloat updateValue = value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                    [(GPUImageSharpenFilter *)filter setSharpness:updateValue];
                    [self updateFilter];
                }
                break;
            case 3:
                {
                    CGFloat updateValue = 0.0;
                    if (value == 0) {
                        updateValue = 1.0;
                    }else if (value < 0){
                        updateValue = 1 - fabs(value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue));
                    }else if (value > 0){
                        updateValue = 1 + value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                    }
                    [(GPUImageSaturationFilter *)filter setSaturation:updateValue];
                    [self updateFilter];
                }
                break;
            case 4:
                {
                    CGFloat updateValue = 0.0;
                    if (value == 0) {
                        updateValue = 0;
                    }else if (value < 0){
                        updateValue = fabs(value * 2);
                    }else if (value > 0){
                        updateValue = - (value * 2);
                    }
                    [(GPUImageWhiteBalanceFilter *)filter setTint:updateValue];
                    [self updateFilter];
                }
                break;
            case 5:
                {
                    CGFloat updateValue = 0.0;
                    if (value == 0) {
                        updateValue = 0.5;
                    }else if (value < 0){
                        updateValue = 0.5 - fabs(value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue));
                    }else if (value > 0){
                        updateValue = 0.5 + value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                    }
                    [(GPUImageHighlightShadowFilter *)filter setHighlights:updateValue];
                    [self updateFilter];
                }
                break;
            case 6:
            {
                CGFloat updateValue = 0.0;
                if (value == 0) {
                    updateValue = 0.5;
                }else if (value < 0){
                    updateValue = 0.5 - fabs(value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue));
                }else if (value > 0){
                    updateValue = 0.5 + value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                }
                [(GPUImageHighlightShadowFilter *)filter setHighlights:updateValue];
                [self updateFilter];
            }
                break;
            case 7:
                {
                    CGFloat updateValue = value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                    [(GPUImageMedianFilter *)filter setTexelWidth:updateValue];
                    [(GPUImageMedianFilter *)filter setTexelHeight:updateValue];
                    [self updateFilter];
                }
                break;
            case 8:
                {
                    CGFloat updateValue = value / (self.optimizationSlider.maximumValue - self.optimizationSlider.minimumValue);
                    [(GPUImageEmbossFilter *)filter setIntensity:updateValue];
                    [self updateFilter];
                }
                break;
            default:
                break;
        }
    }
}

- (void)updateFilter
{
//    [staticPicture removeAllTargets];
    [staticPicture addTarget:filter];
    [staticPicture processImage];
    [filter useNextFrameForImageCapture];
    UIImage *newsImage = [filter imageFromCurrentFramebuffer];
    self.img.image = newsImage;
}

- (void)moveSlider:(PhotoActionButton *)btn
{
    CGPoint contentOffset = self.optimizationScrollView.contentOffset;
    contentOffset.x += (btn.frame.origin.x + btn.width / 2) - self.optimizationScrollView.contentOffset.x - Screen_Width / 2;
    
    if (contentOffset.x < 0) {
        contentOffset.x = 0;
    }
    
    if (contentOffset.x + Screen_Width > self.optimizationScrollView.contentSize.width) {
        contentOffset.x = self.optimizationScrollView.contentSize.width - Screen_Width;
    }
    [self.optimizationScrollView setContentOffset:contentOffset animated:YES];
}

- (void)rightSwipe
{
    if (self.isActionViewShow && self.scrollView.scrollEnabled == NO && self.optimizationTapIndex > 0) {
        [self.view insertSubview:self.previousFeintView aboveSubview:self.scrollView];
        [self.view insertSubview:self.currentFeintView aboveSubview:self.scrollView];
        self.optimizationTapIndex -= 1;
        self.optimizationView.optimizationTapIndx = self.optimizationTapIndex;
        @SJWeakObj(self);
        [UIView animateWithDuration:0.9 animations:^{
            sjWeakself.previousFeintView.x = 0;
            sjWeakself.currentFeintView.x = Screen_Width;
            sjWeakself.feintCoverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
        } completion:^(BOOL finished) {
            [sjWeakself.feintCoverView removeFromSuperview];
            sjWeakself.feintCoverView = nil;
            [sjWeakself.previousFeintView removeFromSuperview];
            sjWeakself.previousFeintView = nil;
            [sjWeakself.currentFeintView removeFromSuperview];
            sjWeakself.currentFeintView = nil;
        }];
    }
}

- (void)leftSwipe
{
    if (self.isActionViewShow && self.scrollView.scrollEnabled == NO && self.optimizationTapIndex < 7) {
        [self.view insertSubview:self.nextFeintView aboveSubview:self.scrollView];
        [self.view insertSubview:self.currentFeintView aboveSubview:self.scrollView];
        self.optimizationTapIndex += 1;
        self.optimizationView.optimizationTapIndx = self.optimizationTapIndex;
        @SJWeakObj(self);
        [UIView animateWithDuration:0.9 animations:^{
            sjWeakself.nextFeintView.x = 0;
            sjWeakself.currentFeintView.x = -Screen_Width;
            sjWeakself.feintCoverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
        } completion:^(BOOL finished) {
            [sjWeakself.feintCoverView removeFromSuperview];
            sjWeakself.feintCoverView = nil;
            [sjWeakself.nextFeintView removeFromSuperview];
            sjWeakself.nextFeintView = nil;
            [sjWeakself.currentFeintView removeFromSuperview];
            sjWeakself.currentFeintView = nil;
        }];
    }
}

- (void)action:(PhotoActionButton *)button
{
    self.isActionViewShow = YES;
    self.customNavigationBarBackgroundView.alpha = 0;
    self.statusBarStyleControl = YES;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    self.view.backgroundColor = [UIColor blackColor];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.actionBottom.hidden = YES;
    self.actionBottom.y = Screen_Height;
    self.tapIndex = button.tag;
    switch (button.tag) {
        case 0:
            if (self.scrollView.zoomScale <= 1) {
                self.scrollView.scrollEnabled = NO;
            }else{
                self.scrollView.scrollEnabled = YES;
            }
            self.optimizationTapIndex = 1;
            [self.view insertSubview:self.optimizationView aboveSubview:self.scrollView];
            self.optimizationScrollView = self.optimizationView.actionScroll;
            break;
        case 2:
            self.optimizationTapIndex = 0;
            [self.view insertSubview:self.optimizationView aboveSubview:self.scrollView];
            self.optimizationScrollView = self.optimizationView.actionScroll;
            break;
        default:
            break;
    }
    @SJWeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        sjWeakself.scrollView.y = STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT - 44;
        switch (button.tag) {
            case 0:
                sjWeakself.optimizationView.y = Screen_Height - 200;
                break;
            case 2:
                sjWeakself.optimizationView.y = Screen_Height - 200;
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            switch (button.tag) {
                case 0:
                    [sjWeakself.view insertSubview:self.optimizationSlider aboveSubview:self.scrollView];
                    [sjWeakself.view insertSubview:self.optimizationChangeBtn aboveSubview:self.scrollView];
                    sjWeakself.optimizationView.optimizationTapIndx = self.optimizationTapIndex;
//                    [sjWeakself setUpFilterWithIndex:self.optimizationTapIndex];
                    break;
                case 2:
                    [sjWeakself.view insertSubview:self.optimizationSlider aboveSubview:self.scrollView];
                    [sjWeakself.view insertSubview:self.optimizationChangeBtn aboveSubview:self.scrollView];
                    sjWeakself.optimizationView.optimizationTapIndx = self.optimizationTapIndex;
//                    [sjWeakself setUpFilterWithIndex:self.optimizationTapIndex];
                    break;
                default:
                    break;
            }
        }
    }];
}

- (void)actionCancel
{
    self.img.image = self.imgV;
    self.isActionViewShow = NO;
    self.customNavigationBarBackgroundView.alpha = 1;
    self.statusBarStyleControl = NO;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView.backgroundColor = [UIColor colorFromHex:@"#F7F6F6"];
    self.actionBottom.hidden = NO;
    switch (self.tapIndex) {
        case 0:
            self.scrollView.scrollEnabled = YES;
            [self.optimizationView removeFromSuperview];
            self.optimizationView = nil;
            [self.optimizationSlider removeFromSuperview];
            self.optimizationSlider = nil;
            [self.optimizationChangeBtn removeFromSuperview];
            self.optimizationChangeBtn = nil;
            break;
        case 2:
            [self.optimizationView removeFromSuperview];
            self.optimizationView = nil;
            [self.optimizationSlider removeFromSuperview];
            self.optimizationSlider = nil;
            [self.optimizationChangeBtn removeFromSuperview];
            self.optimizationChangeBtn = nil;
            break;
        default:
            break;
    }
    @SJWeakObj(self);
    [UIView animateWithDuration:0.3 animations:^{
        sjWeakself.scrollView.y = STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT;
        sjWeakself.actionBottom.y = Screen_Height - 34 - 120;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)doubleClick:(UITapGestureRecognizer *)gestureRecognizer {
    
    if (self.scrollView.zoomScale != 1) {
        [self.scrollView setZoomScale:1 animated:YES];
    } else {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.img];
        CGFloat newZoomScale = 2;
        CGFloat xsize = self.scrollView.frame.size.width / newZoomScale;
        CGFloat ysize = self.scrollView.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize / 2, touchPoint.y - ysize / 2, xsize, ysize) animated:YES];
    }
}

//代理方法，告诉ScrollView要缩放的是哪个视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.img;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (self.isActionViewShow) {
        if (scale <= 1) {
            self.scrollView.scrollEnabled = NO;
        }else{
            self.scrollView.scrollEnabled = YES;
        }
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView

{
    
    NSLog(@"%f-----------%f",scrollView.bounds.size.width,scrollView.contentSize.width);
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    self.img.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                            
                            scrollView.contentSize.height * 0.5 + offsetY);
    if (scrollView.contentSize.width <= scrollView.bounds.size.width) {
            self.scrollView.contentSize = CGSizeMake(scrollView.width + LINE_HEIGHT, scrollView.height + LINE_HEIGHT);
    }
}

- (void)save
{
    
}

#ifdef __IPHONE_8_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.statusBarStyleControl) {
        return UIStatusBarStyleLightContent;
    }
    else {
        return UIStatusBarStyleDefault;
    }
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

@end
