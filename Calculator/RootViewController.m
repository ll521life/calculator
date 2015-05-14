//
//  RootViewController.m
//  Calculator
//
//  Created by qf on 15/4/21.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "RootViewController.h"
#import "Header.h"
#import "Calculator.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置颜色
    self.view.backgroundColor = [UIColor blackColor];
#pragma mark--设置顶端view条
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor colorWithRed:178/255.0 green:189/255.0 blue:200/255.0 alpha:0.5];
    [self.view addSubview:view];
    [view release];

#pragma mark--添加Calculator
    Calculator *cal = [[Calculator alloc] initWithFrame:CGRectMake(0,20, SCREEN_WIDTH,SCREEN_HEIGHT-20)];
    [self.view addSubview:cal];
    [cal release];
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
