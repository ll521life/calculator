//
//  Calculator.h
//  Calculator
//
//  Created by qf on 15/4/21.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculator : UIView
{
    UILabel *_qLabel;
    NSMutableString *_string;
}
@property(nonatomic, copy)NSMutableString *string;
@property(nonatomic ,retain)UILabel *qLabel;
@end
