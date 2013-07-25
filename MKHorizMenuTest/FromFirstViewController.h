//
//  FromFirstViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FromFirstViewController : UIViewController

@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) NSString *menuName;
@property (strong, nonatomic) NSString *menuDetails;
@property (weak, nonatomic) IBOutlet UILabel *lbl_menuName;
@property (weak, nonatomic) IBOutlet UITextView *txt_menuDetails;

- (IBAction)return:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withMenuName:(NSString*)name;
- (IBAction)modifyMenuInfo_Touch:(id)sender;
- (IBAction)moveTheKeyBoard:(id)sender;
@end
