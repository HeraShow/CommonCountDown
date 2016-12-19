//
//  WMAinDesignClass.h
//  Wemart
//
//  Created by 冯文秀 on 16/6/14.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WMAinDesignClass : NSObject

//添加单击手势
+(void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view;

//给某个控件设圆角
+(void)makeCorner:(CGFloat)corner view:(UIView *)view;

//边框
+(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color;

//控件边缘灰色线条
+(void)setFoursides:(UIView *)view Direction:(NSString *)dirction sizeWidth:(CGFloat)sizeWidth;

// 设置UILabel的不同颜色与大小
+(void)setUILabel:(UILabel *)label Data:(NSString *)string SetData:(NSString *)setstring Color:(UIColor *)color Font:(CGFloat)font Underline:(BOOL)isbool;

+(CGFloat)ReturnViewFrame:(UIView *)view Direction:(NSString *)string;


// 字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
// 字符串转字典
+ (NSDictionary *)receiveDicWithString:(NSString *)str;
// 字符串转数组
+ (NSArray *)receiveArrayWithString:(NSString *)str;

/**
 *  将十六进制色值转换成UIColor模式
 *
 *  @param hexString 十六进制颜色
 *
 *  @return 返回UIColor类型
 */
+ (UIColor *)colorWithHexString:(NSString *) hexString;


+ (NSString *)getWemartImageBundlePath:(NSString *)fileName;
// 编码
+ (NSString *)encodingParaDicWithDataDic:(NSDictionary *)paraDic;

// 缩放UIImage
+ (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size;



+ (NSString *)receiveCurrentDate;
+ (NSString *)getfewDaysAgoWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

#pragma mark --- 时间戳 转具体时间 ---
+ (NSString *)timeStampToSpecificTimeWithTimeStamp:(NSInteger)time;
#pragma mark --- base64 --
+ (NSString *)base64FromOriginString:(NSString *)originStr;
#pragma mark --- MD5加密 ---  需要引入<CommonCrypto/CommonDigest.h>
+ (NSString *)md5HexDigest:(NSString *)url;
#pragma mark --- 数字转十六进制字符串 ---
+ (NSString *)stringWithHexNumber:(NSUInteger)hexNumber;

@end
