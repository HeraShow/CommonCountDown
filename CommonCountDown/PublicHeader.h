//
//  PublicHeader.h
//  CommonCountDown
//
//  Created by 冯文秀 on 16/12/19.
//  Copyright © 2016年 Hera. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWScale (KScreenWidth / 375.f)


#define WemartFont(FontSize) [UIFont fontWithName:@"HelveticaNeue-Light" size:FontSize]
#define WMBoldFont(FontSize) [UIFont fontWithName:@"HelveticaNeue-Bold" size:FontSize]
#define WMMediumFont(FontSize) [UIFont fontWithName:@"HelveticaNeue-Medium" size:FontSize]
#define WMRegularFont(FontSize) [UIFont fontWithName:@"HelveticaNeue-Regular" size:FontSize]

#define ColorRGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define WMHPDark ColorRGB(55, 59, 64, 1)
#define WMSearchBarBg ColorRGB(247, 248, 250, 1)
#define WMBlueColor ColorRGB(16, 169, 235, 1)

#define KTopViewHeight 64.f

#endif /* PublicHeader_h */
