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

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

@interface BWResearchVC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField *tfFirst;
@property (nonatomic, strong) UITextField *tfRegEx;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BWResearchVC

- (void)buttonActNew:(UIButton *)sender {
    _imageView.highlighted = !_imageView.highlighted;
}

- (void)dealloc {
    NSLog(@"dealloc BWResearchVC");
    
//    if ([_timer isValid]) {
//        [_timer invalidate];
//        _timer = nil;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIView *view = [[UIView alloc] init];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UIImage *image = [UIImage imageNamed:@"bg_study"];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 64, 200, 50)];
    imageView2.image = image;
    [self.view addSubview:imageView2];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.backgroundColor = [UIColor grayColor];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    UIView *view0 = [[UIView alloc] init];
    view0.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view0];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view1];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(200);
        make.bottom.mas_equalTo(view1.mas_bottom).offset(50);
    }];
    
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(view.mas_top).offset(30);
        make.height.mas_equalTo(50);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(view0.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 50)];
//    label.text = @"100";
//    label.numberOfLines = 1;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor grayColor];
//    
//    label.text = nil;
//    [self.view addSubview:label];
//
//    __block NSInteger count = 100;
//    __weak UINavigationController *weakNvgtVC = self.navigationController;
//    __weak typeof(self) weakSelf = self;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
////        在这里执行事件
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        
//        count -= 1;
//        NSLog(@"vc:%p count is %ld", strongSelf, count);
//        if (count == 95) {
//            [strongSelf.navigationController popViewControllerAnimated:YES];
//        }
//    }];
    
//    NSTimeInterval period = 1.0; //设置时间间隔
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        //在这里执行事件
//        count -= 1;
//        NSLog(@"count is %ld", count);
//        if (count == 95) {
//            
//        }
//    });
//    
//    dispatch_resume(_timer);
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
////    [button setTitle:@"按钮文本" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor greenColor];
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
////    [button addTarget:self action:@selector(nil) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    CGFloat w_btn = 200;
//    
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.width.mas_equalTo(w_btn);
//        make.top.mas_equalTo(100);
//        make.height.mas_equalTo(50);
//    }];
//    
//    CGFloat w_image = 30;
//    CGFloat w_title = 60;
////    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -w_image, 0, w_image)];
////    [button setImageEdgeInsets:UIEdgeInsetsMake(0, w_title, 0, -w_title)];
//    
//    return ;
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    [self.view addSubview:_tableView];
//    
//    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
//    viewFooter.backgroundColor = [UIColor grayColor];
//    _tableView.tableFooterView = viewFooter;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(45, 20, 100, 50);
//    [button setTitle:@"Button" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(buttonActNew:) forControlEvents:UIControlEventTouchUpInside];
//    [viewFooter addSubview:button];
    
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(45);
//        make.right.mas_equalTo(-45);
//        make.top.mas_equalTo(20);
//        make.height.mas_equalTo(50);
//    }];
    
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
    return 0;
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
