//
//  BWNetworkResearchVC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/12/28.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWNetworkResearchVC.h"

@interface BWNetworkResearchVC ()

@property (weak, nonatomic) IBOutlet UITextView *textView0;

@end

@implementation BWNetworkResearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)httpPostRequest:(id)sender {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/account/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *bodyJSONString = @"{\"account\":\"bob\", \"password\":\"123\"}";
    request.HTTPBody = [[NSData alloc] initwithstring];
    [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
}

@end
