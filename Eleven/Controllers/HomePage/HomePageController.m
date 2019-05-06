//
//  HomePageController.m
//  Eleven
//
//  Created by Peanut on 2019/3/13.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "HomePageController.h"
#import "takePhoto.h"

//控制器
#import "PhotoActionController.h"

@interface HomePageController ()

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav];
    
    UIButton *button = [[UIButton alloc] init];
    button.layer.cornerRadius = 17.5;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"选择照片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorFromHex:@"#FE286D"];
    [button addTarget:self action:@selector(picker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
    }];
}

- (void)initNav
{
    [self setupCustomNavigationBarDefault];
}

- (void)picker
{
    @SJWeakObj(self);
    [takePhoto chooseViewController:self isEdit:NO sharePicture:^(UIImage *image) {
        PhotoActionController *photoActionController = [[PhotoActionController alloc] init];
        photoActionController.imgV = image;
        [sjWeakself.navigationController pushViewController:photoActionController animated:YES];
    }];
}

@end
