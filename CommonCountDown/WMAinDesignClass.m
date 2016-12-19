//
//  WMAinDesignClass.m
//  Wemart
//
//  Created by 冯文秀 on 16/6/14.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMAinDesignClass.h"
#import<CommonCrypto/CommonDigest.h>

@implementation WMAinDesignClass
+ (void)addClickEvent:(id)target action:(SEL)action owner:(UIView *)view
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    gesture.numberOfTouchesRequired = 1;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:gesture];
}

+ (void)setUILabel:(UILabel *)label Data:(NSString *)string SetData:(NSString *)setstring Color:(UIColor *)color Font:(CGFloat)font Underline:(BOOL)isbool
{
    NSRange str = [label.text rangeOfString:setstring];
    if (str.location != NSNotFound) {
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:label.text];
        [str1 addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(string.length,setstring.length)]; //设置字体颜色
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(string.length,setstring.length)];
        if (isbool) {
            
            [str1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(string.length,setstring.length)];
        }
        label.attributedText = str1;
    }
}

+ (void)makeCorner:(CGFloat)corner view:(UIView *)view{
    CALayer *layer = view.layer;
    layer.cornerRadius = corner;
    layer.masksToBounds = YES;
}

#pragma mark 边框
+(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color
{
    CALayer * fileslayer = [view layer];
    fileslayer.borderColor = [color CGColor];
    fileslayer.borderWidth = corner;
}

+(CGFloat)ReturnViewFrame:(UIView *)view Direction:(NSString *)string{
    if ([string  isEqual: @"Y"]) {
        return view.frame.origin.y + view.frame.size.height;
    }else{
        return view.frame.origin.x + view.frame.size.width;
    }
}

#pragma mark 底部灰色线条
+(void)setFoursides:(UIView *)view Direction:(NSString *)dirction sizeWidth:(CGFloat)sizeWidth{
    
    if ([dirction  isEqual: @"left"]) {
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, sizeWidth)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
        
    }else if([dirction  isEqual: @"right"]){
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width - 0.5, 0, 0.5, sizeWidth)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
        
    }else if([dirction  isEqual: @"top"]){
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeWidth, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
        
    }else if([dirction  isEqual: @"bottom"]){
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 0.5, sizeWidth, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
        [view addSubview:bottomview];
    }
}
#pragma mark --- 字典转字符串 ---
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark --- 字符串解析成字典 ---
+ (NSDictionary *)receiveDicWithString:(NSString *)str
{
    NSData *resultData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //系统自带JSON解析
    id result = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary * messageDic = result;
    return messageDic;
}

#pragma mark --- 字符串解析成数组 ---
+ (NSArray *)receiveArrayWithString:(NSString *)str
{
    NSData *resultData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //系统自带JSON解析
    id result = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:nil];
    NSArray * messageArray = result;
    return messageArray;
}


// 颜色转换
+ (UIColor *)colorWithHexString:(NSString *) hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

// 通过bundle路径 获取文件
+ (NSString *)getWemartImageBundlePath:(NSString *)fileName
{
    NSBundle *libBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Wemart.bundle"]];
    
    if (libBundle && fileName) {
        NSString *path = [[libBundle resourcePath] stringByAppendingPathComponent:fileName];
        path = [path stringByAppendingString:@".png"];
        return path;
    }
    return nil;
}

// 字典编码成字符串
+ (NSString *)encodingParaDicWithDataDic:(NSDictionary *)paraDic
{
    NSData *paraData = [NSJSONSerialization dataWithJSONObject:paraDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paraStr = [[NSString alloc] initWithData:paraData encoding:NSUTF8StringEncoding];
    paraStr = [paraStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    return paraStr;
}

// 根据尺寸 放大 缩小图片
+ (UIImage*)imageCompressWithSimple:(UIImage*)image scaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


// 输出NSDate需要加差,就是当前系统准确的时间
// NSTimeInterval time = 8 * 60 * 60;
// NSDate *dateNow = [date dateByAddingTimeInterval:time];
// 输出 formatterString 不存在差值
+ (NSString *)receiveCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // 设置日期格式
    NSDate *date = [NSDate date]; // 创建日期
//    NSLog(@"%@", date);// 当前时间 相对于我们的时间 是减去了8h的
    // 但输出 formatterString 则不存在差值
    NSString *string = [formatter stringFromDate:date]; // 将NSDate 转化成string
//    NSLog(@"string    %@", string);
    return string;
}

+ (NSString *)getfewDaysAgoWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // 设置日期格式
    NSDate *date = [NSDate date]; // 创建日期
    // 当前时间减去8h
    NSString *string = [formatter stringFromDate:date]; // 将NSDate 转化成string
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSString *beforDateStr = [formatter stringFromDate:newdate];
//    NSLog(@"---%ld年%ld月%ld天前    %@", year, month, day, beforDateStr);
    return beforDateStr;
}

#pragma mark --- 时间戳 转具体时间 ---
+ (NSString *)timeStampToSpecificTimeWithTimeStamp:(NSInteger)time
{
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *createStr = [formatter stringFromDate:createDate];
    return createStr;
}

#pragma mark --- base64 --
+ (NSString *)base64FromOriginString:(NSString *)originStr
{
    NSString *base64Str = [[originStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    return base64Str;
}

#pragma mark --- MD5加密 ---  需要引入<CommonCrypto/CommonDigest.h>
+ (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

#pragma mark --- 数字转十六进制字符串 ---
+ (NSString *)stringWithHexNumber:(NSUInteger)hexNumber
{
    char hexChar[6];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    NSLog(@"hexString ---- %@", hexString);
    return hexString;
}


@end
