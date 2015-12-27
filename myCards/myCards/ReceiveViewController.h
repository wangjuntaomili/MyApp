//
//  ReceiveViewController.h
//  myCards
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import <UIKit/UIKit.h>


//贺卡的第一个界面
@interface ReceiveViewController : UIViewController <UITextFieldDelegate>
{
    
}

//姓名输入框
@property(nonatomic, retain)UITextField * nameTextField;
//电话号码输入框
@property(nonatomic, retain)UITextField * phoneTextField;

@end
