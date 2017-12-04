//
//  BMCustomCalloutView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/30.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMCustomCalloutView.h"

#define kArrorHeight        10

#define kPortraitMargin     5

#define kTitleWidth         120
#define kTitleHeight        20

@interface BMCustomCalloutView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong, readwrite) UIButton *rightButton;

@end

@implementation BMCustomCalloutView

#pragma mark - Life Cycle

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

#pragma mark - Private Method

- (void)initSubViews
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Title";
    [self addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin * 2 + kTitleHeight, kTitleWidth, kTitleHeight)];
    self.subtitleLabel = subtitleLabel;
    subtitleLabel.font = [UIFont systemFontOfSize:12];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.text = @"Subtitle";
    [self addSubview:subtitleLabel];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = rightButton;
    rightButton.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + kPortraitMargin, 0, 30, kTitleHeight * 2);
    [rightButton setTitle:@"导航" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    rightButton.backgroundColor = [UIColor blueColor];
    [rightButton addTarget:self action:@selector(navigationAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
}

- (void)navigationAction {
    if (self.navigationBlock) self.navigationBlock();
}

#pragma mark - Setter and Getter

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle {
    self.subtitleLabel.text = subtitle;
}

@end
