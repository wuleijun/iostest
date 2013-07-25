//
//  FirstViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArray;
}
@property (strong,nonatomic) NSMutableArray *dataArray;
- (IBAction)button_touch:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
