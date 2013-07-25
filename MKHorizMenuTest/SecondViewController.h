//
//  SecondViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txt_MenuName;
@property (weak, nonatomic) IBOutlet UITextView *txt_MenuDetails;
- (IBAction)removeKeyboard:(id)sender;
- (IBAction)addMenu_Touch:(id)sender;

@end
