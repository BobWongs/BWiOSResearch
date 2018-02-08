//
//  BWAnimationViewController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2018/2/8.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import "BWAnimationViewController.h"

@interface BWAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView *view0;

@end

@implementation BWAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)testAction:(id)sender {
    UIView *subview = [[UIView alloc] initWithFrame:self.view0.bounds];
    subview.backgroundColor = [UIColor orangeColor];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    [self.view0 addSubview:subview];
    [self.view0.layer addAnimation:transition forKey:@"animation"];
}

@end
