//
//  Constants.h
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define iPhone_6s_Width 375
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define IS_DEVICE_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define IS_DEVICE_4_0_INCH ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define IS_DEVICE_4_7_INCH ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define IS_DEVICE_5_5_INCH ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE

#define KIsiPhoneX ((int)((Screen_Height/Screen_Width)*100) == 216) ? YES : NO

//Navigation Controller
#define STATUS_BAR_HEIGHT                      (([UIApplication sharedApplication].statusBarFrame.size.height == 0) ? 20 : [UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATION_BAR_HEIGHT                  self.navigationController.navigationBar.frame.size.height
#define TOOLBAR_HEIGHT                         self.navigationController.toolbar.frame.size.height
//#define TAB_BAR_HEIGHT                         self.tabBarController.tabBar.frame.size.height
#define STATIC_NAVIGATION_BAR_HEIGHT           44.0f
#define STATIC_TOOLBAR_HEIGHT                  44.0f
#define STATUS_AND_NAVIGATION_BAR_HEIGHT        (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define STATIC_STATUS_AND_NAVIGATION_BAR_HEIGHT (STATUS_BAR_HEIGHT + STATIC_NAVIGATION_BAR_HEIGHT)

#define TAB_BAR_HEIGHT ((KIsiPhoneX == YES) ? (49.f + 34.f) : 49.f)

#define DEMAIN  @"http://60.205.188.38:8181"

//line
#define LINE_HEIGHT 0.5

/* color  颜色  */
#define WHITE_GREY                                                          @"#F0F0F1"

#define ICONFONT                                                 @"iconfont"

//iconfont
#define ICON_FONT_LAMP                      @"&#xe626;"
#define ICON_FONT_EDIT                      @"&#xe61d;"
#define ICON_FONT_TONE                      @"&#xe618;"
#define ICON_FONT_FILTER                    @"&#xe9fb;"
#define ICON_FONT_FRAME                     @"&#xe620;"
#define ICON_FONT_MOSAIC                    @"&#xe613;"
#define ICON_FONT_DOODLE                    @"&#xe6b2;"
#define ICON_FONT_PASTER                    @"&#xe60e;"
#define ICON_FONT_WORD                      @"&#xe6df;"
#define ICON_FONT_REMOVE                    @"&#xe625;"
#define ICON_FONT_NULL                      @"&#xe774;"
#define ICON_FONT_HAIR                      @"&#xe609;"
#define ICON_FONT_GOU                       @"&#xe630;"
#define ICON_FONT_CHA                       @"&#xe601;"
#define ICON_FONT_FORBID                    @"&#xe628;"
#define ICON_FONT_AUTO                      @"&#xe60a;"
#define ICON_FONT_FOOD                      @"&#xe65a;"
#define ICON_FONT_FLOWER                    @"&#xe62f;"
#define ICON_FONT_SCENERY                   @"&#xe622;"
#define ICON_FONT_FOG                       @"&#xe60d;"
#define ICON_FONT_CHARACTER                 @"&#xe7fc;"
#define ICON_FONT_PET                       @"&#xe653;"
#define ICON_FONT_WATER                     @"&#xe66c;"
#define ICON_FONT_CHANGE                    @"&#xe6c3;"
#define ICON_FONT_BRIGHT                    @"&#xe61e;"
#define ICON_FONT_CONTRAST                  @"&#xe623;"
#define ICON_FONT_SHARPEN                   @"&#xe62b;"
#define ICON_FONT_SATURATION                @"&#xe652;"
#define ICON_FONT_COLOR_TEMP                @"&#xea4d;"
#define ICON_FONT_SPECULARITY               @"&#xe79a;"
#define ICON_FONT_DARK_IMPRO                @"&#xe611;"
#define ICON_FONT_DISPERSION                @"&#xe624;"
#define ICON_FONT_GRANULE                   @"&#xe731;"
#define ICON_FONT_COLOR_FADE                @"&#xe6f4;"
#define ICON_FONT_VIGNETTE                  @"&#xe621;"


#define BLACK_RETURN [ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:@"&#xe605;"]  inFont:ICONFONT size:22 color:[UIColor colorFromHex:@"#000000"]]
// 返回按钮
#define WHITE_RETURN [ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:@"&#xe605;"]  inFont:ICONFONT size:22 color:[UIColor whiteColor]]

#endif /* Constants_h */
