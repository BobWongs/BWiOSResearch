//
//  UIViewController+BMExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/22.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "UIViewController+BMExtension.h"

@implementation UIViewController (BMExtension)

- (void)bmB2B_setNavigationLeftItemWithTitle:(NSString *)title action:(SEL)action {
    UIFont *font = [UIFont boldSystemFontOfSize:16.0];
    UIColor *textColor = [UIColor whiteColor];
    CGFloat width = [[self class] sizeForText:title font:font];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, width, 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)bmB2B_setNavigationRightItemWithTitle:(NSString *)title action:(SEL)action {
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor whiteColor];
    CGFloat width = [[self class] sizeForText:title font:font];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, width, 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)bmB2B_setNavigationRightItemWithIcon:(UIImage *)iconImage action:(SEL)action {
    [self bmB2B_setNavigationRightItemWithIconArray:@[iconImage] actionArray:@[NSStringFromSelector(action)]];
}

- (void)bmB2B_setNavigationRightItemWithIconArray:(NSArray<UIImage *> *)iconArray actionArray:(NSArray<NSString *> *)actionStringArray {
    
}

#pragma mark - Tool

+ (CGSize)sizeForText:(NSString *)text font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attr context:nil];
    result = rect.size;
    return result;
}

+ (CGFloat)sizeForText:(NSString *)text font:(UIFont *)font {
    CGSize size = [text sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

@end
