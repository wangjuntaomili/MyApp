//
//  PreviewViewController.m
//  myCards
//
//  Created by qianfeng on 15/12/27.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import "PreviewViewController.h"
#import <MessageUI/MessageUI.h>
//#import "AFNetworkTool.h"

@interface PreviewViewController ()

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加页面访问控件
    CGRect frame = [UIScreen mainScreen].bounds;
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    webView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    webView.scalesPageToFit = NO;
    
    
    NSMutableDictionary *dicAry=[[NSMutableDictionary alloc]initWithCapacity:3];
    [dicAry setObject:@"A" forKey:@"default_01"];
    [dicAry setObject:@"B" forKey:@"wish_01"];
    [dicAry setObject:@"E" forKey:@"default_02"];
    [dicAry setObject:@"C" forKey:@"wish_02"];
    [dicAry setObject:@"D" forKey:@"friend_01"];
    [dicAry setObject:@"F" forKey:@"wish_03"];
    [dicAry setObject:@"G" forKey:@"wish_04"];
    [dicAry setObject:@"H" forKey:@"festival_01"];
    [dicAry setObject:@"I" forKey:@"festival_02"];
    [dicAry setObject:@"J" forKey:@"festival_03"];
    [dicAry setObject:@"K" forKey:@"festival_04"];
    [dicAry setObject:@"D3" forKey:@"festival_05"];
    [dicAry setObject:@"D2" forKey:@"festival_06"];
    [dicAry setObject:@"D4" forKey:@"festival_07"];
    [dicAry setObject:@"N3" forKey:@"festival_08"];
    [dicAry setObject:@"N1" forKey:@"festival_09"];
    [dicAry setObject:@"N2" forKey:@"festival_10"];
    [dicAry setObject:@"N6" forKey:@"festival_11"];
    [dicAry setObject:@"N7" forKey:@"festival_12"];
    [dicAry setObject:@"N8" forKey:@"festival_13"];
    [dicAry setObject:@"N9" forKey:@"festival_14"];
    [dicAry setObject:@"N5" forKey:@"festival_15"];
    [dicAry setObject:@"N4" forKey:@"festival_16"];
    
    NSString * imageName = [self.infoDic objectForKey:@"Picture"];
    NSLog(@"444%@",imageName);
    NSString * ID = [dicAry objectForKey:imageName];
    url = [NSString stringWithFormat:@"http://101.251.226.68/GC/%@.aspx",ID];
    NSLog(@"%@",url);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    //添加底部视图
    [self createBottomView];
}

- (void)createBottomView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-55, frame.size.width, 60)];
    [bottomImage setImage:[UIImage imageNamed:@"main_top.png"]];
    bottomImage.userInteractionEnabled = YES;
    [self.view addSubview:bottomImage];
    
    //添加发送按钮
    UIButton * send = [UIButton buttonWithType:UIButtonTypeCustom];
    send.frame = CGRectMake(20, 10, 70, 40);
    send.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [send setBackgroundImage:[UIImage imageNamed:@"payment_1"] forState:UIControlStateNormal];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    [send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomImage addSubview:send];
    
}

//发送功能
-(void)sendClick{
    phoneNumber=[self.infoDic objectForKey:@"phone"];
    [self showMessageView:[NSArray arrayWithObjects:phoneNumber, nil] title:@"贺卡" body:url];
    [webView stringByEvaluatingJavaScriptFromString:@"audioPlay()"];
}
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息"
        message:@"该设备不支持短信功能"delegate:nil
        cancelButtonTitle:@"确定"
        otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-44)];
    
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}

//    加载完成或失败时，去掉loading效果
- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
    [webView stringByEvaluatingJavaScriptFromString:@"downLoadBtnHide()"];
    
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
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
