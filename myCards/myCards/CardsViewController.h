//
//  CardsViewController.h
//  myCards
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardsViewController : UIViewController<UIScrollViewDelegate>
{
    UILabel * btnBottom;
    UIScrollView * mainScrollView;   //主滑动视图
    NSArray * themeName;    //主题名称
    
    
    NSMutableDictionary * defaultImage;
    NSMutableDictionary * bgImage;
    NSMutableDictionary * imageName;
    NSMutableDictionary * greetingWords;
    
}

@property(nonatomic, retain)NSString * name;
@property(nonatomic, retain)NSString * phone;
@end
