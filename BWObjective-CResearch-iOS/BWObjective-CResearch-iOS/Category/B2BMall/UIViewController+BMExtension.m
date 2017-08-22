//
//  UIViewController+BMExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/22.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "UIViewController+BMExtension.h"

#define BM_EXTENSION_NAVIGATION_BAR_HEIGHT 44.0

@implementation UIViewController (BMExtension)

- (void)bmB2B_setNavigationLeftItemWithTitle:(NSString *)title action:(SEL)action {
    UIFont *font = [UIFont boldSystemFontOfSize:16.0];
    UIColor *textColor = [UIColor whiteColor];
    CGFloat width = [[self class] sizeForText:title font:font];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(12, 0, width, BM_EXTENSION_NAVIGATION_BAR_HEIGHT);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = [[self class] bm_arrayAddedFixedSpaceItemWithItemArray:@[item]];
}

- (void)bmB2B_setNavigationRightItemWithTitle:(NSString *)title action:(SEL)action {
    UIFont *font = [UIFont systemFontOfSize:14.0];
    UIColor *textColor = [UIColor whiteColor];
    CGFloat width = [[self class] sizeForText:title font:font];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(12, 0, width, BM_EXTENSION_NAVIGATION_BAR_HEIGHT);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = [[self class] bm_arrayAddedFixedSpaceItemWithItemArray:@[item]];
}

- (void)bmB2B_setNavigationRightItemWithIcon:(UIImage *)iconImage action:(SEL)action {
    [self bmB2B_setNavigationRightItemWithIconArray:@[iconImage] actionArray:@[NSStringFromSelector(action)]];
}

- (void)bmB2B_setNavigationRightItemWithIconArray:(NSArray<UIImage *> *)iconArray actionArray:(NSArray<NSString *> *)actionStringArray {
    CGFloat max_x = 0.0, width = 24.0, space = 12.0, barHeight = BM_EXTENSION_NAVIGATION_BAR_HEIGHT;
    UIView *customView = [[UIView alloc] init];
    
    for (NSInteger index = 0; index < iconArray.count; index++) {
        UIImage *iconImage = iconArray[index];
        if (!iconImage || ![iconImage isKindOfClass:[UIImage class]]) continue;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(max_x, (barHeight - width) / 2, width, width);
        [button setImage:iconArray[index] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(actionStringArray[index]) forControlEvents:UIControlEventTouchUpInside];
        [customView addSubview:button];
        
        max_x = CGRectGetMaxX(button.frame) + space;
    }
    
    customView.frame = CGRectMake(0, 0, max_x, barHeight);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItems = [[self class] bm_arrayAddedFixedSpaceItemWithItemArray:@[item]];
}

#pragma mark - Tool

+ (NSArray<UIBarButtonItem *> *)bm_arrayAddedFixedSpaceItemWithItemArray:(NSArray<UIBarButtonItem *> *)itemArray {
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];  // 创建UIBarButtonSystemItemFixedSpace
    spaceItem.width = -20;  // 创建UIBarButtonSystemItemFixedSpace的Item，让BarButtonItem紧靠屏幕边缘
    NSArray *resultArray = [@[spaceItem] arrayByAddingObjectsFromArray:itemArray];
    return resultArray;
}

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
    result.width = ceil(result.width);
    result.height = ceil(result.height);
    return result;
}

+ (CGFloat)sizeForText:(NSString *)text font:(UIFont *)font {
    CGSize size = [text sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

@end
