//
//  ViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"

@interface ViewController : UIViewController<MKHorizMenuDataSource,MKHorizMenuDelegate>

@property (weak, nonatomic) IBOutlet MKHorizMenu *myMKHorizMenu;
@property (nonatomic, strong) NSMutableArray *arrayOfImg;
@property (nonatomic, strong) NSMutableArray *arrayOfSelectedImg;
@property (nonatomic, strong) UIView *transitionView;
@property(nonatomic, strong) NSMutableArray *viewControllers;
@end
