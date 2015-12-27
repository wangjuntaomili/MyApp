//
//  CardsViewController.m
//  myCards
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import "CardsViewController.h"
#import "EditViewController.h"

#define  Festival_NUM  16

@interface CardsViewController ()

@end

@implementation CardsViewController
{
    NSArray * _data;
    NSArray * _bgCards;
    NSArray * _imageName;
    NSArray * _greetWords;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化贺卡信息
    [self loadData];
    
    //设置视图的颜色为浅灰色
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //在视图上添加提示按钮
    [self createBtn];
    
    //在视图上添加滚动视图
    CGRect frame = [UIScreen mainScreen].bounds;
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+40, frame.size.width, frame.size.height-64-40)];
    mainScrollView.contentSize = CGSizeMake(frame.size.width *(themeName.count), frame.size.height-64-40);
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建界面上方的按钮
- (void)createBtn
{
    themeName = @[@"热门",@"节日",@"友谊",@"祝福",@"其他"];
    
    for (int i = 0; i < 5; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*70, 64, 70, 30);
        
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        if (i == 0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        }
        
        [btn setTitle:themeName[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(changeImageTheme:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 100 + i;
        [self.view addSubview:btn];
    }
    
    //设置按钮下的红色框
    btnBottom = [[UILabel alloc]initWithFrame:CGRectMake(15, 64+30, 70, 5)];
    btnBottom.backgroundColor = [UIColor redColor];
    [self.view addSubview:btnBottom];
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(15, 64+33, 345, 2)];
    line.backgroundColor = [UIColor redColor];
    [self.view addSubview:line];
}

//设置按钮点击时的动作
- (void)changeImageTheme: (UIButton *)btn
{
    
    for(UIView *view in mainScrollView.subviews)
    {
        if([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *scr= (UIScrollView *)view;
            scr.contentOffset=CGPointMake(0, 0);
        }
    }
    
    _data = nil;
    _bgCards = nil;
    _imageName = nil;
    _greetWords = nil;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    NSUInteger i = btn.tag - 100;
    NSLog(@"*********i = %ld",i);
    
    //设置滑动视图的坐标偏移值
    mainScrollView.contentOffset = CGPointMake(i * frame.size.width, 0);
    [self initdata:i];
    
    //设置按钮focus改变时,下方的红色标签的动画
    [UIView animateWithDuration:0.5 animations:^{
        btnBottom.frame=CGRectMake((btn.tag-100)*70+15, 64+30, 70, 5);
    }];
    
    //设置当前focus的按钮背景为红色, 字体为17号大小, 其他按钮背景为深灰色, 字号大小为15号大小
    for (int i = 0; i < 5; i++) {
        
        UIButton * button = (UIButton*)[self.view viewWithTag:i+100];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
}

//初始化相关信息
- (void)initdata:(NSInteger)i
{
    _data = [[NSArray alloc]initWithArray:[defaultImage objectForKey:[NSString stringWithFormat:@"theme%ld",i+1]]];
    _bgCards = [[NSArray alloc]initWithArray:[bgImage objectForKey:[NSString stringWithFormat:@"theme%ld",i+1]]];
    _imageName = [[NSArray alloc]initWithArray:[imageName objectForKey:[NSString stringWithFormat:@"theme%ld",i+1]]];
    _greetWords = [[NSArray alloc]initWithArray:[greetingWords objectForKey:[NSString stringWithFormat:@"theme%ld",i+1]]];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _data = nil;
    _imageName = nil;
    _bgCards = nil;
    _greetWords = nil;
    
    for (int i = 0; i < 5; i++) {
        UIButton * button = (UIButton*)[self.view viewWithTag:i+100];
        
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    
    CGRect frame = [UIScreen mainScreen].bounds;
    int i = mainScrollView.contentOffset.x/frame.size.width;
    
    UIButton * btn = (UIButton*)[self.view viewWithTag:i+100];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    [UIView animateWithDuration:0.1 animations:^{
        btnBottom.frame=CGRectMake((btn.tag-100)*60+10, 30, 60, 5);
    }];
    
    [self initdata:i];
    
}

- (void)createView
{
    int tag = 0;
    while (tag < themeName.count) {
        [self initdata:tag];
        
        //NSLog(@"%@",_data);
        //NSLog(@"**************");
        //NSLog(@"%@",_imageName);
        
        CGRect frame = [UIScreen mainScreen].bounds;
        UIScrollView * subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(frame.size.width*tag, 0, frame.size.width,frame.size.height-mainScrollView.bounds.origin.y)];
        
        subScrollView.delegate = self;
        
        if (_data.count <= 4) {
            subScrollView.contentSize = CGSizeMake(0,frame.size.height-mainScrollView.bounds.origin.y+20);
        }
        else if (_data.count > 4){
            subScrollView.contentSize = CGSizeMake(0,frame.size.height-mainScrollView.bounds.origin.y+(20+190)*((_data.count-4)%2+(_data.count-4)/2));
        }
        
        subScrollView.showsHorizontalScrollIndicator = NO;
        subScrollView.showsVerticalScrollIndicator = NO;
        subScrollView.userInteractionEnabled = YES;
        subScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackImg.png"]];
        
        int j = 0;
        for (int i = 0; i < _data.count; i++) {
            //NSLog(@"_data.count =   %ld",_data.count);
            if (i%2 == 0 && i > 0) {
                j++;
            }
            
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(20+(i%2)*(160+15), 10+210*j, 160, 190)];
            view.backgroundColor = [UIColor whiteColor];
            view.userInteractionEnabled = YES;
            
            //添加滑动视图的图片
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(3, 2, 154, 170);
            [button setImage:[UIImage imageNamed:_data[i]] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            //添加滑动视图图片下的标签说明
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 173, 160, 17)];
            label.text = _imageName[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:13.0f];
            [view addSubview:label];
            
            [subScrollView addSubview:view];
        }
        
        [mainScrollView addSubview:subScrollView];
        tag++;
    }
    
    _data = nil;
    _bgCards = nil;
    _imageName = nil;
    _greetWords = nil;
    [self initdata:0];
}



- (void)btnClick:(UIButton*)btn
{
    EditViewController * editViewController = [[EditViewController alloc]init];
    editViewController.peopleName = self.name;
    editViewController.phone = self.phone;
    editViewController.name = _data[btn.tag];
    NSLog(@"111%@",_imageName[btn.tag]);
    editViewController.greetWords = _greetWords[btn.tag];
    [self.navigationController pushViewController:editViewController animated:YES];
    
}

//初始化数据
- (void)loadData
{
    //1.
    NSMutableArray * array1 = [[NSMutableArray alloc]initWithObjects:@"festival_01",@"festival_02",@"festival_03" ,@"wish_03",nil];
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    for (int i = 1; i <= Festival_NUM; i++) {
        [array2 addObject:[NSString stringWithFormat:@"festival_0%d",i]];
    }
    
    NSMutableArray * array3 = [[NSMutableArray alloc]initWithObjects:@"friend_01", nil];
    NSMutableArray * array4 = [[NSMutableArray alloc]initWithObjects:@"wish_01",@"wish_02",@"wish_03",@"wish_04" ,nil];
    
    NSMutableArray * array5 = [[NSMutableArray alloc]initWithObjects:@"default_01", @"default_02", nil];
    defaultImage = [[NSMutableDictionary alloc]initWithCapacity:1];
    
    [defaultImage setObject:array1 forKey:@"theme1"];
    [defaultImage setObject:array2 forKey:@"theme2"];
    [defaultImage setObject:array3 forKey:@"theme3"];
    [defaultImage setObject:array4 forKey:@"theme4"];
    [defaultImage setObject:array5 forKey:@"theme5"];

    
    //2.加载用图片名字
    bgImage = [[NSMutableDictionary alloc]initWithCapacity:1];
    
    [bgImage setObject:array1 forKey:@"theme1"];
    [bgImage setObject:array2 forKey:@"theme2"];
    [bgImage setObject:array3 forKey:@"theme3"];
    [bgImage setObject:array4 forKey:@"theme4"];
    [bgImage setObject:array5 forKey:@"theme5"];
    
    
    //3.图片中文名
    NSArray *name1=[[NSArray alloc]initWithObjects:@"圣诞快乐",@"新年快乐",@"元旦快乐",@"喜结良缘",nil];
    NSArray *name2=[[NSArray alloc]initWithObjects:@"圣诞快乐",@"新年快乐",@"元旦快乐",@"元宵快乐",@"圣诞祝福",@"圣诞快乐",@"羊年卷轴",@"新年快乐",@"羊年大吉",@"新年祝福",@"新年大吉",@"羊年大吉",@"新春快乐",@"赢在羊年",@"青花瓷",@"大吉大利",nil];
    NSArray *name3=[[NSArray alloc]initWithObjects:@"注意保暖",nil];
    NSArray *name4=[[NSArray alloc]initWithObjects:@"福运相伴",@"幸福气球",@"喜结良缘",@"新婚祝福",nil];
    NSArray *name5=[[NSArray alloc]initWithObjects:@"宝宝出生",@"开业大吉",nil];
    imageName=[[NSMutableDictionary alloc]initWithCapacity:1];
    
    [imageName setObject:name1 forKey:@"theme1"];
    [imageName setObject:name2 forKey:@"theme2"];
    [imageName setObject:name3 forKey:@"theme3"];
    [imageName setObject:name4 forKey:@"theme4"];
    [imageName setObject:name5 forKey:@"theme5"];
    
    
    //4.祝福语
    NSArray *word1=[[NSArray alloc]initWithObjects:
                    @"平安夜，报平安，幸福钟声响；情是雪，谊是花，飘落到你家；鹿儿跑，拉雪橇，千里送鹅毛；山迢迢，水迢迢，我的祝福到。礼轻情意重，愿你平安夜快乐！",
                    @"新年好梦，梦梦成真。梦见玉器，好运如影随形；梦见黄金，财神有求必应；梦见红绳，良缘水到渠成；梦见帆船，前程一帆风顺。祝你新年，心想事成！",
                    @"元旦祝福：祝新年快乐，前程似锦，吉星高照，财运亨通，合家欢乐，飞黄腾达，福如东海，寿比南山，幸福美满，官运亨通，美梦连连！",
                    @"祝福你们新婚愉快，幸福美满，激情永在，白头偕老！ ",nil];
    NSArray *word2=[[NSArray alloc]initWithObjects:
                    @"平安夜，报平安，幸福钟声响；情是雪，谊是花，飘落到你家；鹿儿跑，拉雪橇，千里送鹅毛；山迢迢，水迢迢，我的祝福到。礼轻情意重，愿你平安夜快乐！",
                    @"新年好梦，梦梦成真。梦见玉器，好运如影随形；梦见黄金，财神有求必应；梦见红绳，良缘水到渠成；梦见帆船，前程一帆风顺。祝你新年，心想事成！",
                    @"元旦祝福：祝新年快乐，前程似锦，吉星高照，财运亨通，合家欢乐，飞黄腾达，福如东海，寿比南山，幸福美满，官运亨通，美梦连连！",
                    @"新年月圆人团圆，汤圆滚滚香又甜，花好月圆群灯艳，亲人团聚庆团圆。真心祝福您：春风春雨春常在，花好月圆人团圆。愿您元宵节快乐，生活幸福美满!",
                    @"片片祝福，就象落叶缤纷伴着平安夜的钟声，温暖你的每个黑夜！MERRY CHRISTMAS！",
                    @"点点星光，声声祝愿。祈祷平安，共贺圣诞。圣诞老头，微笑床前。神秘礼物，祝福心间。精彩无限，好运不断。快乐相随，梦想实现。幸福开心，岁岁年！",
                    @"新年好梦，梦梦成真。梦见玉器，好运如影随形；梦见黄金，财神有求必应；梦见红绳，良缘水到渠成；梦见帆船，前程一帆风顺。祝你新年，心想事成!",
                    @"朋友，当你忆起我的时候，也正是我想念你最深的时刻，在这想念的日子里，我想问候你近来好吗？快乐吗？祝你新年快乐！",
                    @"得得失失平常事，是是非非任由之，恩恩怨怨心不愧，冷冷暖暖我自知，坎坎坷坷人生路，曲曲折折事业梯，凡事不必太在意，愿你一生好运气！",
                    @"得得失失平常事，是是非非任由之，恩恩怨怨心不愧，冷冷暖暖我自知，坎坎坷坷人生路，曲曲折折事业梯，凡事不必太在意，愿你一生好运气！",
                    @"新年好梦，梦梦成真。梦见玉器，好运如影随形；梦见黄金，财神有求必应；梦见红绳，良缘水到渠成；梦见帆船，前程一帆风顺。祝你新年，心想事成!",
                    @"新年月圆人团圆，汤圆滚滚香又甜，花好月圆群灯艳，亲人团聚庆团圆。真心祝福您：春风春雨春常在，花好月圆人团圆。愿您元宵节快乐，生活幸福美满!",
                    @"得得失失平常事，是是非非任由之，恩恩怨怨心不愧，冷冷暖暖我自知，坎坎坷坷人生路，曲曲折折事业梯，凡事不必太在意，愿你一生好运气！",
                    @"朋友，当你忆起我的时候，也正是我想念你最深的时刻，在这想念的日子里，我想问候你近来好吗？快乐吗？祝你新年快乐！",
                    @"新年好梦，梦梦成真。梦见玉器，好运如影随形；梦见黄金，财神有求必应；梦见红绳，良缘水到渠成；梦见帆船，前程一帆风顺。祝你新年，心想事成！",
                    @"朋友，当你忆起我的时候，也正是我想念你最深的时刻，在这想念的日子里，我想问候你近来好吗？快乐吗？祝你新年快乐",
                    nil];
    NSArray *word3=[[NSArray alloc]initWithObjects:@"简单的问候送朋友，岁月易逝红颜易老，时间过得很快，天又要冷了，不变的祝福，要多穿点衣服才对啊!", nil];
    NSArray *word4=[[NSArray alloc]initWithObjects:
                    @"今天是你的生日!为你送上我的祝福!愿你永远快乐!健康!幸福!一生平安！",
                    @"愿每天的太阳带给你光明的同时,也带给你快乐。真心祝你生日快乐！",
                    @"祝福你们新婚愉快，幸福美满，激情永在，白头偕老！ ",
                    @"相亲相爱幸福永，同德同心幸福长。愿你俩情比海深！", nil];
    NSArray *word5=[[NSArray alloc]initWithObjects:
                    @"欣闻得娇儿，令人无比快慰，祝贺你俩和你们幸运的小宝贝！",
                    @"财路广进，生意兴隆！祝贺发家，开业大吉!", nil];
    greetingWords=[[NSMutableDictionary alloc]initWithCapacity:1];
    [greetingWords setObject:word1 forKey:@"theme1"];
    [greetingWords setObject:word2 forKey:@"theme2"];
    [greetingWords setObject:word3 forKey:@"theme3"];
    [greetingWords setObject:word4 forKey:@"theme4"];
    [greetingWords setObject:word5 forKey:@"theme5"];
    
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
