//
//  VideoTabBarController.m
//  reigns'expweek
//
//  Created by reigns on 2017/7/3.
//  Copyright © 2017年 B14041316. All rights reserved.
//

#import "VideoTabBarController.h"
#import "VideoViewController.h"


@interface VideoTabBarController ()

@end

@implementation VideoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupVideoViewControllers];
    
}

#pragma mark - setup views
//添加视图
- (void)setupVideoViewControllers{
    VideoViewController * vvc1 = [VideoViewController new];
    vvc1.title = @"视频";
    vvc1.tabBarItem.image = [UIImage imageNamed:@"视频红"];
    UINavigationController * Video1 = [[UINavigationController alloc]initWithRootViewController:vvc1];
    
    VideoViewController * vvc2 = [VideoViewController new];
    vvc2.title = @"图片";
    vvc2.tabBarItem.image = [UIImage imageNamed:@"图片红"];
    UINavigationController * Video2 = [[UINavigationController alloc]initWithRootViewController:vvc2];
    
    VideoViewController * vvc3 = [VideoViewController new];
    vvc3.title = @"新闻";
    vvc3.tabBarItem.image = [UIImage imageNamed:@"新闻红"];
    UINavigationController * Video3 = [[UINavigationController alloc]initWithRootViewController:vvc3];
    
    VideoViewController * vvc4 = [VideoViewController new];
    vvc4.title = @"我的";
    vvc4.tabBarItem.image = [UIImage imageNamed:@"我的红"];
    UINavigationController * Video4 = [[UINavigationController alloc]initWithRootViewController:vvc4];
    [self setViewControllers:@[Video1,Video2,Video3,Video4]];
    
}
@end
