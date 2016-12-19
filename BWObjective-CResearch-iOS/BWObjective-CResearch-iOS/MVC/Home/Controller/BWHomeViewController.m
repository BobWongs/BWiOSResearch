//
//  BWHomeViewController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/12.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWHomeViewController.h"
#import "BWHomeTableViewCell.h"
#import "BWResearchVC.h"

#import "UITableViewRowAction+JZExtension.h"
#import "JZNavigationExtension.h"

#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

#import <ContactsUI/ContactsUI.h>

@interface BWHomeViewController () <UITableViewDataSource, UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate, CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
     TableView注册重用Cell
     */
//    [_tableView registerClass:[BWHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
//    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
    
    
//    self.navigationController.jz_fullScreenInteractivePopGestureEnabled = YES;  // 打开全屏Pop手势
//    [self.navigationController jz_setInteractivePopGestureRecognizerCompletion:^(UINavigationController *navigationController, BOOL finished) {
//        if (finished) {
//            NSLog(@"finished");
//        }
//    }];  // 全屏Pop手势回调
//    self.navigationController.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleDoppelganger;  // 改变导航栏渐变动画
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BWHomeTableViewCell *cell = (BWHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
    BWHomeTableViewCell *cell = (BWHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWHomeTableViewCell class]) owner:nil options:nil].firstObject;
//        NSLog(@"new");
    } else {
//        NSLog(@"have reuse");
    }
    cell.lbName.text = @"Name";
    cell.lbMobile.text = [NSString stringWithFormat:@"13800138000+%ld", (long)indexPath.row];
    cell.imageView.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    UIViewController *vc = [UIViewController new];
//    vc.title = @"New";
//    vc.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    BWResearchVC *vcResearch = [[BWResearchVC alloc] init];
//    [self.navigationController pushViewController:vcResearch animated:YES];
    
    // ---------- 打开通讯录 ----------
    
    
    if (NSClassFromString(@"CNContactPickerViewController")) {
        // iOS 9, 10, use CNContactPickerViewController
        CNContactPickerViewController *picker = [[CNContactPickerViewController alloc] init];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        picker.predicateForSelectionOfContact = [NSPredicate predicateWithValue:false];
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        // iOS 8 Below, use ABPeoplePickerNavigationController
        ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        if([UIDevice currentDevice].systemVersion.integerValue >= 8){
            picker.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];  // 在iOS8之后，需要添加nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];这一段代码，否则选择联系人之后会直接dismiss，不能进入详情选择电话。
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    // ---------- 打开通讯录 ----------
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone && phoneNO.length == 11) {
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    
    [peoplePicker pushViewController:personViewController animated:YES];
    
    
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0)
{
    return YES;
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0)
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone && phoneNO.length == 11) {
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    return YES;
}

#pragma mark - iOS10

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSLog(@"didSelectContact");
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    NSLog(@"didSelectContactProperty");
}

// 选多个
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts {
//    NSLog(@"didSelectContacts");
//}
//
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties {
//    NSLog(@"didSelectContactProperties");
//}



// 实现代理
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    void(^rowActionHandler)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"%@", action);
        [tableView setEditing:false animated:true];
    };
    
    UIButton *buttonForImage = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault image:[buttonForImage imageForState:UIControlStateNormal] handler:rowActionHandler];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"disenable" handler:rowActionHandler];
    action2.enabled = false;
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"emjoy👍" handler:rowActionHandler];
    
    return @[action1,action2,action3];
}

@end
