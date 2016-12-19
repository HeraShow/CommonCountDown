//
//  ViewController.m
//  CommonCountDown
//
//  Created by 冯文秀 on 16/12/19.
//  Copyright © 2016年 Hera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate, UISearchBarDelegate>
@property (nonatomic, strong) UIImageView *wemartImgView;
@property (nonatomic, strong) UILabel *wemartLabel;
@property (nonatomic, strong) UIView *mobileView;
@property (nonatomic, strong) UITextField *mobilTextField;
@property (nonatomic, strong) UIButton *getAuthCode;
@property (nonatomic, strong) UIView *codeView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIView *supportView;


@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UIView *searchBgView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UITextField *searchField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.title = @"登录";
    
    // WMAinDesignClass 小功能类
    
    [self layoutBindingInterface];
    [self showWemartSupportSign];
    
    
    // 自定义搜索框
//    [self buildCustomSearchView];
}

- (void)buildCustomSearchView
{
    self.searchBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, KScreenWidth, 44)];
    self.searchBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchBgView];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 7, KScreenWidth - 82, 30)];
    self.searchBar.backgroundImage = [[UIImage alloc]init];
    self.searchBar.backgroundColor = WMSearchBarBg;
    self.searchBar.layer.cornerRadius = 4;
    self.searchBar.clipsToBounds = YES;
    self.searchBar.placeholder = @"请输入所需搜索的内容";
    self.searchBar.translucent = NO;
    self.searchBar.delegate = self;
    self.searchField = [self.searchBar valueForKey:@"searchField"];
    if (self.searchField) {
        self.searchField.font = WemartFont(13);
        self.searchField.backgroundColor = WMSearchBarBg;
        self.searchField.textColor = WMHPDark;
        [self.searchField setValue:ColorRGB(196, 197, 201, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [self.searchField setValue:WemartFont(13) forKeyPath:@"_placeholderLabel.font"];
        
        UIView *iconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 28)];
        iconView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearText)];
        [iconView addGestureRecognizer:tap];
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wemart_clear"]];
        self.imgView.frame = CGRectMake(0, 7, 14, 14);
        [iconView addSubview:_imgView];
        
        self.searchField.rightView = iconView;
        self.searchField.rightViewMode = UITextFieldViewModeWhileEditing;
    }
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor blackColor];
    
 
    [self.searchBgView addSubview:_searchBar];
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 72, 8, 52, 28)];
    searchButton.layer.cornerRadius = 4;
    searchButton.backgroundColor = WMBlueColor;
    searchButton.titleLabel.font = WMMediumFont(12);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchThings:) forControlEvents:UIControlEventTouchDown];
    [self.searchBgView addSubview:searchButton];
}

#pragma mark --- 布局绑定界面 ---
- (void)layoutBindingInterface
{
    self.wemartImgView = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth - 60)/2, KTopViewHeight + 36, 60, 60)];
    self.wemartImgView.image = [UIImage imageNamed:@"wemart_bind_icon"];
    [self.view addSubview:_wemartImgView];
    
    self.wemartLabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth - 60)/2, KTopViewHeight + 97, 60, 20)];
    self.wemartLabel.text = @"微猫渠道";
    self.wemartLabel.font = WemartFont(12.f);
    self.wemartLabel.textColor = ColorRGB(135, 135, 135, 1);
    self.wemartLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_wemartLabel];
    
    self.mobileView = [[UIView alloc]initWithFrame:CGRectMake(25, KTopViewHeight + 144, KScreenWidth - 145,30)];
    self.mobileView.layer.cornerRadius = 1;
    self.mobileView.layer.borderWidth = 0.4f;
    self.mobileView.layer.borderColor = ColorRGB(193, 193, 193, 1).CGColor;
    self.mobileView.clipsToBounds = YES;
    [self.view addSubview:_mobileView];
    
    self.mobilTextField = [[UITextField alloc]initWithFrame:CGRectMake(7, 2, KScreenWidth - 159, 26)];
    self.mobilTextField.delegate = self;
    self.mobilTextField.font = WemartFont(12.f);
    self.mobilTextField.tag = 100;
    self.mobilTextField.placeholder = @"输入11位手机号码";
    self.mobilTextField.borderStyle = UITextBorderStyleNone;
    self.mobilTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.mobileView addSubview:_mobilTextField];
    
    self.getAuthCode = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 105, KTopViewHeight + 144, 80, 30)];
    self.getAuthCode.userInteractionEnabled = NO;
    self.getAuthCode.backgroundColor = ColorRGB(135, 135, 135, 1);
    self.getAuthCode.layer.cornerRadius = 2;
    self.getAuthCode.clipsToBounds = YES;
    self.getAuthCode.titleLabel.font = WemartFont(11.f);
    [self.getAuthCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getAuthCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getAuthCode addTarget:self action:@selector(receiveAuthCode:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_getAuthCode];
    
    self.codeView = [[UIView alloc]initWithFrame:CGRectMake(25, KTopViewHeight + 188, KScreenWidth - 50,30)];
    self.codeView.layer.cornerRadius = 1;
    self.codeView.layer.borderWidth = 0.4f;
    self.codeView.layer.borderColor = ColorRGB(193, 193, 193, 1).CGColor;
    self.codeView.clipsToBounds = YES;
    [self.view addSubview:_codeView];
    
    self.codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(7, 2, KScreenWidth - 64, 26)];
    self.codeTextField.userInteractionEnabled = NO;
    self.codeTextField.delegate = self;
    self.codeTextField.font = WemartFont(12.f);
    self.codeTextField.tag = 200;
    self.codeTextField.placeholder = @"输入短信验证码";
    self.codeTextField.borderStyle = UITextBorderStyleNone;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.codeView addSubview:_codeTextField];
    
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(25, KTopViewHeight + 245, KScreenWidth - 50, 30)];
    self.confirmButton.userInteractionEnabled = NO;
    self.confirmButton.backgroundColor = ColorRGB(135, 135, 135, 1);
    self.confirmButton.layer.cornerRadius = 2;
    self.confirmButton.clipsToBounds = YES;
    self.confirmButton.titleLabel.font = WemartFont(11.f);
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmBind:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_confirmButton];
}

#pragma mark --- 由微猫提供技术支持 ---
- (void)showWemartSupportSign
{
    self.supportView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - KTopViewHeight - 80, KScreenWidth, 40)];
    UIColor *textColor = ColorRGB(181, 181, 181, 1);
    UIFont *smallFont = WemartFont(12.f);
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth - 114)/2, 10, 12, 15)];
    fromLabel.textColor = textColor;
    fromLabel.text = @"由";
    fromLabel.textColor = textColor;
    fromLabel.font = smallFont;
    [self.supportView addSubview:fromLabel];
    UIButton *homePage = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 114)/2 + 12, 4, 30, 27)];
    homePage.titleLabel.font = smallFont;
    [homePage setTitle:@"微猫" forState:UIControlStateNormal];
    [homePage setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [homePage addTarget:self action:@selector(pushToWemartHomePage) forControlEvents:UIControlEventTouchUpInside];
    [self.supportView addSubview:homePage];
    UILabel *support = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth - 114)/2 + 42, 10, 72, 15)];
    support.text = @"提供技术支持";
    support.textColor = textColor;
    support.font = smallFont;
    [self.supportView addSubview:support];
    [self.view addSubview:_supportView];
}

#pragma mark --- 跳转至公司主页 ---
- (void)pushToCompanyHomePage
{
    // 可替换成你需要的
}

#pragma mark --- 获取验证码 ---
- (void)receiveAuthCode:(UIButton *)authCode
{
    [self getAuthCodeBind];
}

#pragma mark --- 获取验证码 ---
- (void)getAuthCodeBind
{
    NSDictionary *resultDic = @{@"data":@"获取验证码的请求结果字典", @"returnMsg":@"ok"};
//    NSLog(@"resultDic ---- %@", resultDic);
    
    if ([resultDic[@"returnMsg"] isEqualToString:@"ok"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 发送成功 则开始倒计时
            self.codeTextField.userInteractionEnabled = YES;
            [self performSelector:@selector(startCountDown) withObject:nil];
        });
    }
}

#pragma mark --- 开启倒计时 ---
- (void)startCountDown
{
    self.count = 60;
    self.getAuthCode.enabled = NO;
    self.getAuthCode.backgroundColor = ColorRGB(255, 0, 0, 1);
    [self.getAuthCode setTitle:@"60秒" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceCount:) userInfo:nil repeats:YES];
}

- (void)reduceCount:(NSTimer *)timer
{
    if (self.count != 1) {
        self.count --;
        [self.getAuthCode setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.count] forState:UIControlStateDisabled];
    }
    else{
        [timer invalidate];
        timer = nil;  // 销毁定时器
        self.getAuthCode.enabled = YES;
        [self.getAuthCode setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getAuthCode.userInteractionEnabled = YES;
        self.getAuthCode.backgroundColor = ColorRGB(255, 0, 0, 1);
    }
}
#pragma mark --- 验证并绑定 ---
- (void)chargeCaptchaWithVertifyType
{
    NSDictionary *bindResult = @{@"result":@"验证请求结果 返回的字典"};
    //    NSLog(@"bind ---- %@", bindResult);
    if ([bindResult[@"returnMsg"] isEqualToString:@"ok"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"绑定成功" preferredStyle:UIAlertControllerStyleAlert];
        NSMutableAttributedString *messageText = [[NSMutableAttributedString alloc] initWithString:@"绑定成功"];
        [messageText addAttribute:NSFontAttributeName value:WMMediumFont(13.f) range:NSMakeRange(0, 4)];
        [messageText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
        [alert setValue:messageText forKey:@"attributedMessage"];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([bindResult[@"returnValue"] isEqual:@2102])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
        NSMutableAttributedString *messageText = [[NSMutableAttributedString alloc] initWithString:@"验证码错误"];
        [messageText addAttribute:NSFontAttributeName value:WMMediumFont(13.f) range:NSMakeRange(0, 5)];
        [messageText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 5)];
        [alert setValue:messageText forKey:@"attributedMessage"];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark --- 产生随机数 ---
- (NSString *)makeRandomNumberAndChange
{
    NSInteger num = (float)(1+arc4random()%9999999);
    //    NSLog(@"num  ---- %ld", num);
    NSString *numStr = [NSString stringWithFormat:@"%ld", num];
    while (numStr.length < 7) {
        numStr = [numStr stringByAppendingString:@"0"];
    }
    NSMutableArray *numArray = [NSMutableArray array];
    for (NSInteger i = numStr.length - 1; i > -1; i--) {
        [numArray addObject:[numStr substringWithRange:NSMakeRange(i, 1)]];
    }
    NSString *appendStr = [NSString string];
    for (NSString *numStr in numArray) {
        appendStr = [appendStr stringByAppendingString:numStr];
    }
    // 反转数
    NSInteger appendInt = [appendStr integerValue];
    // 1-9
    NSInteger textInt = (float)(1+arc4random()%9);
    // 标准式 ： num 拼接 textInt 拼接 (appedInt + textInt) * textInt
    NSInteger add = appendInt + textInt;
    NSInteger ride = add * textInt;
    NSString *resultStr = [NSString stringWithFormat:@"%ld%ld%ld", num, textInt, ride];
    return resultStr;
}


#pragma mark --- 确定绑定 ---
- (void)confirmBind:(UIButton *)confirmBind
{
    [self chargeCaptchaWithVertifyType];
    // 绑定成功后 跳转至主界面
    
}

#pragma mark --- 编辑事件 ---
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        if (textField.text.length == 11) {
            NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            BOOL isMatch = [pred evaluateWithObject:textField.text];
            if (!isMatch) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                return NO;
            }
            else{
                self.getAuthCode.userInteractionEnabled = YES;
                self.getAuthCode.backgroundColor = ColorRGB(255, 0, 0, 1);
            }
        }
    }
    if (textField.tag == 200) {
        if (textField.text.length == 6) {
            self.confirmButton.userInteractionEnabled = YES;
            self.confirmButton.backgroundColor = ColorRGB(255, 0, 0, 1);
        }
    }
    
    return YES;
}

#pragma mark --- textFiled 限制字数的代理方法 ---
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    NSLog(@"textField --- %@", textField.text);
    //    NSLog(@"textField string --- %@", string);
    //    NSLog(@"textField range.location --- %ld", range.location);
    
    if (textField.tag == 100) {
        if(range.location > 10)
        {
            return NO;
        }
        else{
            if (range.location == 10) {
                self.phoneStr = [NSString stringWithFormat:@"%@%@", textField.text, string];
                NSString *regex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                BOOL isMatch = [pred evaluateWithObject:self.phoneStr];
                if (!isMatch) {
                    [textField resignFirstResponder];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alert addAction:cancelAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    return NO;
                }
                else{
                    self.getAuthCode.userInteractionEnabled = YES;
                    self.getAuthCode.backgroundColor = ColorRGB(255, 0, 0, 1);
                }
                
            }
            else{
                self.getAuthCode.userInteractionEnabled = NO;
                self.getAuthCode.backgroundColor = ColorRGB(135, 135, 135, 1);
            }
            return [self validateNumber:string];
        }
    }
    if (textField.tag == 200) {
        if(range.location > 5)
        {
            return NO;
        }
        else{
            if (range.location == 5) {
                self.confirmButton.userInteractionEnabled = YES;
                self.confirmButton.backgroundColor = ColorRGB(255, 0, 0, 1);
            }
            else{
                self.confirmButton.userInteractionEnabled = NO;
                self.confirmButton.backgroundColor = ColorRGB(135, 135, 135, 1);
            }
            return [self validateNumber:string];
        }
    }
    return YES;
    
}

#pragma mark --- 防止第三方输入 限制只能输入0-9 ---
- (BOOL)validateNumber:(NSString*)number {
    BOOL limit = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            limit = NO;
            break;
        }
        i++;
    }
    return limit;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
