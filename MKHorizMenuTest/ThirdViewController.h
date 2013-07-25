//
//  ThirdViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewViewController.h"
#import "PopoverView.h"

@interface ThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,myViewDeletate>

@property(strong, nonatomic) PopoverView *myPopoverView;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *arrayOfCurrentViews;
- (IBAction)getRandomMenu:(id)sender;
@end
