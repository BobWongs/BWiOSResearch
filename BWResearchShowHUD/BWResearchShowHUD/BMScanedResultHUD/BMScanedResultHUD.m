//
//  BMScanedResultHUD.m
//  BMBlueMoonAngel
//
//  Created by BobWong on 16/9/22.
//  Copyright © 2016年 elvin. All rights reserved.
//

#import "BMScanedResultHUD.h"

#define FONT_TEXT [UIFont systemFontOfSize:17]
#define COLOR_TEXT [UIColor blackColor]
#define COLOR_HIGHTLIGHT_TEXT [UIColor redColor]

@interface BMScanedResultHUD ()

@property (nonatomic, strong) UIView *viewBg;
@property (nonatomic, strong) UILabel *lbHUD;

@end

@implementation BMScanedResultHUD

+ (BMScanedResultHUD *)sharedView {
    static dispatch_once_t once;
    static BMScanedResultHUD *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _viewBg = [[UIView alloc] initWithFrame:self.bounds];
        _viewBg.backgroundColor = [UIColor blackColor];
        _viewBg.alpha = 0.4;
        [self addSubview:_viewBg];
        
        _lbHUD = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 115)];
        _lbHUD.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _lbHUD.numberOfLines = 0;
        _lbHUD.textAlignment = NSTextAlignmentCenter;
        _lbHUD.font = FONT_TEXT;
        _lbHUD.textColor = COLOR_TEXT;
        _lbHUD.backgroundColor = [UIColor whiteColor];
        _lbHUD.layer.cornerRadius = 4.0;
        _lbHUD.clipsToBounds = YES;
        [self addSubview:_lbHUD];
    }
    return self;
}

+ (void)showDescriptionText:(NSString *)textDesc
              highlightText:(NSString *)textHighlight {
    NSString *textAll = [NSString stringWithFormat:@"%@%@", textDesc, textHighlight];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textAll];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10.0];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dictAttrDesc = @{
                                   NSFontAttributeName: FONT_TEXT,
                                   NSForegroundColorAttributeName: COLOR_TEXT,
                                   NSParagraphStyleAttributeName: style
                                   };
    NSDictionary *dictAttrHL = @{
                                   NSFontAttributeName: FONT_TEXT,
                                   NSForegroundColorAttributeName: COLOR_HIGHTLIGHT_TEXT,
                                   NSParagraphStyleAttributeName: style
                                   };
    
    NSRange rangeDesc = [textAll rangeOfString:textDesc];
    NSRange rangeHighlight = [textAll rangeOfString:textHighlight];
    [attributedString setAttributes:dictAttrDesc range:rangeDesc];
    [attributedString setAttributes:dictAttrHL range:rangeHighlight];
    
    [self sharedView].lbHUD.attributedText = attributedString;
    
    // 加入显示和移除隐藏
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedView]];
    NSTimeInterval displayInterval = [[self class] displayDurationForString:textAll];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(displayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self sharedView] removeFromSuperview];
    });
}

+ (void)showDescriptionText:(NSString *)textDesc {
    [[self class] showDescriptionText:textDesc highlightText:@""];
}

+ (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MIN((float)string.length*0.13 + 0.5, 5.0);
}

@end
