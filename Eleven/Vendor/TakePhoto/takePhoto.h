//
//  takePhoto.h
//  App
//
//  Created by wodada on 2017/1/2.
//  Copyright © 2017年 李焕明. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//使用block 返回值
typedef void (^sendPictureBlock)(UIImage *image);

@interface takePhoto : NSObject<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic,copy)sendPictureBlock sPictureBlock;
@property (nonatomic,assign) BOOL isEdit;


+ (takePhoto *)sharedModel;

+(void)chooseViewController:(UIViewController *)viewController isEdit:(BOOL)isEdit sharePicture:(sendPictureBlock)block;


@end


