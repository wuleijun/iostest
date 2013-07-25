//
//  MyViewViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-18.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//
@class MyViewViewController;
@protocol myViewDeletate <NSObject>

-(void)viewRemovedFinished;

@end
#import <UIKit/UIKit.h>
@interface MyViewViewController : UIViewController
@property (assign, nonatomic) id<myViewDeletate> delegate;
@property (strong, nonatomic) IBOutlet UIView *inner_View;
- (IBAction)touch_back:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

@end
