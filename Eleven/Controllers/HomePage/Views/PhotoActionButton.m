//
//  PhotoActionButton.m
//  Eleven
//
//  Created by Peanut on 2019/3/14.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "PhotoActionButton.h"

@implementation PhotoActionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width = self.imageView.height = 18;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = 0;
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = 11;
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 10;
}

@end
