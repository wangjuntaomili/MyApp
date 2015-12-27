//
//  ReceiveViewController.m
//  myCards
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import "ReceiveViewController.h"
#import "CardsViewController.h"

@interface ReceiveViewController ()

@end

@implementation ReceiveViewController

//.m文件中对属性的拷贝
@synthesize nameTextField = _nameTextField;
@synthesize phoneTextField = _phoneTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.navigationItem.title = @"贺卡";
    
    //设置手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldHide)];
    [self.view addGestureRecognizer:tap];
    
    
    //创建背景
    //画面的大小
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height)];
    bgView.backgroundColor = [UIColor yellowColor];
    
    
    //背景图片
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bgImageView.image = [UIImage imageNamed:@"receive_bg.png"];
    bgImageView.userInteractionEnabled = YES;
    [bgView addSubview:bgImageView];
    
    
    //姓名输入框的背景图片
    UIImageView * nameImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 200, bgImageView.frame.size.width-180,40)];
    nameImageView.image = [UIImage imageNamed:@"input_edit_name_bg.png"];
    nameImageView.userInteractionEnabled = YES;
    //添加至背景图片(父视图)中
    [bgImageView addSubview:nameImageView];
    
    
    //姓名输入框textField
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(55, 5, 130, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.keyboardType = UIKeyboardTypeAlphabet;
    _nameTextField.delegate = self;
    [nameImageView addSubview:_nameTextField];
    
    
    //电话号码输入框的背景图片
    UIImageView * phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 270, bgImageView.frame.size.width-120,40)];
    phoneImageView.image = [UIImage imageNamed:@"input_edit_phone_bg.png"];
    phoneImageView.userInteractionEnabled = YES;
    //添加至背景图片(父视图)中
    [bgImageView addSubview:phoneImageView];
    
    
    //联系人按钮
    UIButton * contactsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    contactsButton.frame = CGRectMake(bgImageView.frame.size.width-110, 200, 50, 40);
    [contactsButton addTarget:self action:@selector(contactsClick) forControlEvents:UIControlEventTouchUpInside];
    [contactsButton setBackgroundImage:[UIImage imageNamed:@"contact_btn_bg.png"] forState:UIControlStateNormal];
    [bgImageView addSubview:contactsButton];
    
    
    
    //电话号码输入框textField
    _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(55, 5, 190, 30)];
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.delegate = self;
    [phoneImageView addSubview:_phoneTextField];
    
    
    
    //制作贺卡按钮
    UIButton * makeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    makeButton.frame = CGRectMake(100, 400, bgImageView.frame.size.width-200, 50);
    [makeButton setBackgroundImage:[UIImage imageNamed:@"card_button_begain.png"] forState:UIControlStateNormal];
    [makeButton addTarget:self action:@selector(makeClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:makeButton];
    
    
    [self.view addSubview:bgView];
    
}

//输入完文字时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textFieldHide];
    return YES;
}


//设置键盘影藏
- (void)textFieldHide
{
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}

- (void)contactsClick
{
    [self textFieldHide];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能还在开发中..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)makeClick
{
    
    if ([_nameTextField.text isEqual:@""] ||
        [_phoneTextField.text isEqual:@""]) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的姓名和电话号码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    if(![self isMobileNumber:_phoneTextField.text])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确地手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    CardsViewController * cdsController = [[CardsViewController alloc]init];
    cdsController.name = _nameTextField.text;
    cdsController.phone = _phoneTextField.text;
    [self.navigationController pushViewController:cdsController animated:YES];
    
    
}

//电话号码隐藏
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2-478])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
