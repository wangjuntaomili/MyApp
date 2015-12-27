//
//  EditViewController.m
//  myCards
//
//  Created by qianfeng on 15/12/26.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import "EditViewController.h"
#import "PreviewViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldHide)];
    [self.view addGestureRecognizer:tap];
    
    infoDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    //设置背景和背景图片
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height)];
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.image = [UIImage imageNamed:@"cellbackImg.png"];
    [bgView addSubview:bgImageView];
    
    //贺卡定制标签
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10,0, frame.size.width, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor redColor];
    label.text = @"贺卡定制";
    [bgImageView addSubview:label];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, frame.size.width-20, 2)];
    line.backgroundColor = [UIColor redColor];
    [bgImageView addSubview:line];
    
    //祝福语标签
    message = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 70, 40)];
    message.text = @"祝福语:";
    [bgImageView addSubview:message];
    
    //祝福语显示框
    messageTextView = [[UITextView alloc]initWithFrame:CGRectMake(100, 40, 200, 120)];
    messageTextView.textAlignment = NSTextAlignmentLeft;
    messageTextView.textColor = [UIColor grayColor];
    messageTextView.font = [UIFont systemFontOfSize:15.0f];
    messageTextView.text = self.greetWords;
    messageTextView.delegate = self;
    messageTextView.contentSize = CGSizeMake(0, 300);
    
    messageTextView.backgroundColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.0f];
    [bgImageView addSubview:messageTextView];
    
    
    //发件人标签
    name = [[UILabel alloc]initWithFrame:CGRectMake(30, 200, 70, 40)];
    name.text = @"发件人:";
    [bgImageView addSubview:name];
    
    //发件人姓名输入框
    senderNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 205, 300, 30)];
    senderNameTextField.delegate = self;
    senderNameTextField.font = [UIFont systemFontOfSize:15.0f];
    senderNameTextField.backgroundColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.0f];
    senderNameTextField.text = @"发件人签名:";
    senderNameTextField.textColor = [UIColor grayColor];
    senderNameTextField.returnKeyType = UIReturnKeyDone;
    [bgImageView addSubview:senderNameTextField];
    
    
    //预览按钮设置
    previewBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    previewBtn.frame = CGRectMake((frame.size.width-250)/2, frame.size.height-350, 250, 40);
    [previewBtn setBackgroundImage:[UIImage imageNamed:@"login2_07@2x.png"] forState:UIControlStateNormal];
    [previewBtn setTitle:@"预 览" forState:UIControlStateNormal];
    [previewBtn addTarget:self action:@selector(previewClick) forControlEvents:UIControlEventTouchUpInside];
    [previewBtn setTintColor:[UIColor whiteColor]];
    [bgImageView addSubview:previewBtn];
    
    [self.view addSubview:bgView];
    
}

- (void)textFieldHide
{
    [messageTextView resignFirstResponder];
    [senderNameTextField resignFirstResponder];
}

//发送者框点击键盘确认时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textFieldHide];
    return YES;
}

//发送者框编辑完毕
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.textColor = [UIColor blackColor];
    if ([textField.text isEqualToString:@"发送者签名"]) {
        textField.text = nil;
    }
}

//发送者框开始编辑字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 10) {
        return  NO;
    }
    return YES;
}

//发送者开始编辑时调用
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.textColor = [UIColor grayColor];
    if ([textField.text isEqualToString:@""]) {
        textField.text = @"发送者签名";
    }
}


//祝福信息输入框开始编辑时调用
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = [UIColor blackColor];
}

//祝福信息输入框编辑完调用
-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.textColor = [UIColor grayColor];
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.greetWords;
    }
}

//编辑时字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * newStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (newStr.length >= 100) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@""message:@"最多只能输入100个字符!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        textView.text = [newStr substringToIndex:newStr.length-text.length];
        return NO;
    }
    return YES;
}

- (void)previewClick
{
    NSString * picture = self.name;
    NSString * people = self.peopleName;
    NSString * phoneNumber = self.phone;
    
    NSLog(@"222%@",picture);
    
    [infoDic setObject:people forKey:@"Name"];
    [infoDic setObject:phoneNumber forKey:@"Phone"];
    [infoDic setObject:picture forKey:@"Picture"];
    [infoDic setObject:messageTextView.text forKey:@"Message"];
    [infoDic setObject:senderNameTextField.text forKey:@"Sender"];
    
    NSLog(@"333%@",infoDic);
    
    PreviewViewController * preview = [[PreviewViewController alloc]init];
    preview.infoDic = infoDic;
    [self.navigationController pushViewController:preview animated:YES];
    [self textFieldHide];
    
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
