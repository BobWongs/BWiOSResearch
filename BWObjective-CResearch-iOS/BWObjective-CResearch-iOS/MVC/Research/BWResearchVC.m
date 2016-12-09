//
//  BWResearchVC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/11/17.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWResearchVC.h"
#import "Masonry.h"
#import "BWResearchCell.h"

#define NumbersWithDot     @"0123456789.\n"
#define NumbersWithoutDot  @"0123456789\n"

@interface BWResearchVC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField *tfFirst;
@property (nonatomic, strong) UITextField *tfRegEx;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BWResearchVC

- (void)buttonActNew:(UIButton *)sender {
    _imageView.highlighted = !_imageView.highlighted;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    return ;
    
//    double numA = 0.01;
//    NSString *strA = [NSString stringWithFormat:@"%.2f", numA];
//    double numB = 0.00;
//    NSString *strB = [NSString stringWithFormat:@"%.2f", numB];
//    NSLog(@"A: %@, B: %@", strA, strB);
    
    // UIImageView Normal and Hightlighted
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
//    _imageView = iv;
//    iv.image = [UIImage imageNamed:@"icon_discovery_selected"];
//    iv.highlightedImage = [UIImage imageNamed:@"icon_discovery_unselected"];
//    [self.view addSubview:iv];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(buttonActNew:)];
//    self.navigationItem.rightBarButtonItem = item;
    
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 50)];
//    self.tfFirst = textField;
////    textField.delegate = self;
//    textField.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:textField];
//    
//    UITextField *tfRegEx = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 200, 50)];
//    self.tfRegEx = tfRegEx;
//    tfRegEx.placeholder = @"Regular Expression";
//    tfRegEx.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:tfRegEx];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(buttonAct:)];
//    self.navigationItem.rightBarButtonItem = item;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    BWResearchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BWResearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60.0;
    
    BWResearchCell *cell = [[BWResearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1.0;
}

- (void)buttonAct:(UIButton *)sender
{
    NSString *text = _tfFirst.text;
//    NSString *textRegEx = _tfRegEx.text;
//    NSLog(@"double value is %f", text.doubleValue);
    
    BOOL isValid = [[self class] bm_checkIsNumberAndOneDotOnlyInString:text];
    if (isValid) {
        NSLog(@"valid");
    } else {
        NSLog(@"invalid");
    }
}

+ (BOOL)bm_checkIsNumberAndOneDotOnlyInString:(NSString *)string {
    NSString *regex =[NSString stringWithFormat:@"^[0-9.]+$"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [predicate evaluateWithObject:string];
    if (!isMatch) {
        return NO;
    }
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array && array.count > 2) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL hasDot = YES;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        hasDot = NO;
    }
    if ([string length] > 0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.')//数据格式正确
        {
            if([textField.text length] == 0){
                if(single == '.'){
                    // 第一个数字不能为小数点
                    return NO;
                }
            }
            if (single == '.')
            {
                if(!hasDot)  //text中还没有小数点
                {
                    hasDot=YES;
                    return YES;
                }
                else
                {
                    // 已经输入过小数点
                    return NO;
                }
            }
            else
            {
                if (hasDot)  //存在小数点
                {
                    // 判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    NSInteger tt = range.location - ran.location;
                    if (tt <= 2){
                        return YES;
                    } else {
                        // 最多输入两位小数
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        } else {
            // 输入的数据格式不正确
            return NO;
        }
    }

    return YES;
}

@end
