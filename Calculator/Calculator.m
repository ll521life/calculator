//
//  Calculator.m
//  Calculator
//
//  Created by qf on 15/4/21.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "Calculator.h"
#import "Header.h"
@implementation Calculator
@synthesize qLabel = _qLabel;
@synthesize string = _string;
- (void)dealloc{
    [_qLabel release];
    [_string release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
#pragma mark--添加tabel
        _qLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, (SCREEN_HEIGHT-20)/4)];
        _qLabel.backgroundColor = [UIColor whiteColor];
        //label.text = @"0";
        _qLabel.text = @"0";
        [self addSubview:_qLabel];
        _qLabel.font = [UIFont systemFontOfSize:100];
        _qLabel.adjustsFontSizeToFitWidth = YES ;
        [_qLabel setTextAlignment:NSTextAlignmentRight];
       // [label release];
#pragma mark -计算器按钮
        NSArray *array=@[@"AC",@"7",@"4",@"1",@"0",@"+/-",@"8",@"5",@"2",@".",@"%",@"9",@"6",@"3",@"<-",@"÷",@"×",@"-",@"+",@"="];
        _string =[@"" mutableCopy];
        NSInteger k = 0;
UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,(SCREEN_HEIGHT-20)/4, SCREEN_WIDTH, SCREEN_HEIGHT-20-(SCREEN_HEIGHT-20)/4)];
        for (NSInteger i = 0; i < 4; i++) {
            for (NSInteger j = 0; j < 5; j++,k++) {
                UIButton *button =[[UIButton alloc]initWithFrame: CGRectMake(i*BUTTION_WIDTH,j*BUTTION_HEIGHT, BUTTION_WIDTH-1, BUTTION_HEIGHT-1)];
                [button setTitle:array[k] forState:UIControlStateNormal];
                //[self.qButton setTitle:array[k] forState:UIControlStateNormal];
                UIImage *buttonBg = [UIImage imageNamed:@"buttonbg.png"];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                [button setBackgroundImage:buttonBg forState:UIControlStateHighlighted];
                [button titleLabel].font = [UIFont systemFontOfSize:30];
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                [self addSubview:view];
                if (i != 3) {
                    button.backgroundColor = [UIColor colorWithRed:164/255.0 green:165/255.0 blue:170/255.0 alpha:0.5];
                }else{
                    button.backgroundColor = [UIColor colorWithRed:103/255.0 green:200/255.0 blue:249/255.0 alpha:0.5];
                }
                [button release];
            }
        }
        
    }
    return self;
}
- (void)buttonClicked:(UIButton *)button{
    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"AC"]) {
        self.qLabel.text =@"0";
     //   [_string setString:self.qLabel.text];
        [_string setString:@""];
    }
    else if([[button titleForState:UIControlStateNormal] isEqualToString:@"="]){
        //进行加减乘除等计算
        if ([_string compare:@""] == NSOrderedSame){
            return;
        }else{
        NSInteger flag = 0;
        NSMutableString *mathString2 = [NSMutableString stringWithString:_string];
        if ([mathString2 hasPrefix:@"-"]) {
            flag = 1;
            [mathString2 deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        NSArray *numtemp = [mathString2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"+-×÷%"]];
        NSMutableArray *num = [[NSMutableArray alloc] initWithArray:numtemp];
        [num removeObject:@""];
        NSArray *signtemp = [mathString2 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789."]];
        NSMutableArray *sign = [[NSMutableArray alloc] initWithArray:signtemp];
        [sign removeObject:@""];
        CGFloat sum=0;
        NSMutableString *s = [NSMutableString string];
        for(NSInteger index = 0; index < [sign count];index ++){
            NSString *str1 = [NSString stringWithFormat:@"%@",sign[index]];
            if([str1 compare:@"÷"] == NSOrderedSame){
                sum =[num[index] floatValue]/[num[index+1] floatValue];
                s = [NSMutableString stringWithFormat:@"%g",sum];
                [num removeObjectAtIndex:index];
                [sign removeObjectAtIndex:index];
                num[index] = s;
                index =0;
            }
            else if([str1 compare:@"×"] == NSOrderedSame){
                s = [NSMutableString stringWithFormat:@"%g",[num[index] floatValue]*[num[index+1] floatValue]];
                [num removeObjectAtIndex:index];
                [sign removeObjectAtIndex:index];
                num[index] = s;
                index =0;
            }else if([str1 compare:@"%"] == NSOrderedSame){
                s = [NSMutableString stringWithFormat:@"%ld",[num[index] integerValue]%[num[index+1] integerValue]];
                [num removeObjectAtIndex:index];
                [sign removeObjectAtIndex:index];
                num[index] = s;
                index =0;
            }

        }
        if(flag == 1){
            sum = [num[0] floatValue];
            sum = -sum;
        }
        else{
            sum = [num[0] floatValue];
        }
        for(NSInteger index = 0; index < [sign count];index ++){
            
            NSString *str1 = [NSString stringWithFormat:@"%@",sign[index]];
            if([str1 compare:@"+"] == NSOrderedSame){
                sum +=[num[index+1] floatValue];
            }
            else if([str1 compare:@"-"] == NSOrderedSame){
                sum -=[num[index+1] floatValue];
            }
        }
        self.qLabel.text = [NSString stringWithFormat:@"%g",sum];
        [_string setString:self.qLabel.text];
        }
        
    }else if([[button titleForState:UIControlStateNormal] isEqualToString:@"+/-"]){
        if ([_string floatValue] > 0) {
            self.qLabel.text =[NSString stringWithFormat:@"-%g",[_string floatValue]];
            [_string setString:self.qLabel.text];
        }else if([_string floatValue] < 0){
            self.qLabel.text =[NSString stringWithFormat:@"%g",-[_string floatValue]];
            [_string setString:self.qLabel.text];
            
        }
    }else if ([[button titleForState:UIControlStateNormal] isEqualToString:@"<-"]){
        if ([_string compare:@""] != NSOrderedSame ){
        [_string deleteCharactersInRange:NSMakeRange(_string.length-1, 1)];
        self.qLabel.text = _string;
        }
        else {
            return ;
        }
        
    }else{
        [_string appendString:[button titleForState:UIControlStateNormal]];
        self.qLabel.text = _string;
    }

}
@end
