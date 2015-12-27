//
//  EditViewController.h
//  myCards
//
//  Created by qianfeng on 15/12/26.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    UITextView * messageTextView;   //贺卡信息输入框
    UITextField * senderNameTextField;  //发件人姓名
    UILabel * message;  //信息提示标签
    UILabel * name;     //发件人姓名提名标签
    UIButton * previewBtn;  //预览按钮
    NSMutableDictionary * infoDic;
}

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * peopleName;
@property(nonatomic,copy)NSString * greetWords;
@end
