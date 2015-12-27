//
//  PreviewViewController.h
//  myCards
//
//  Created by qianfeng on 15/12/27.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface PreviewViewController : UIViewController<UIWebViewDelegate,MFMessageComposeViewControllerDelegate>
{
    UIWebView * webView;
    UIImageView * bottomImage;
    NSString * url;
    NSString * phoneNumber;
    NSString * cardsID;
    UIActivityIndicatorView * activityIndicator;
}

@property(nonatomic,copy)NSMutableDictionary * infoDic;
@end
