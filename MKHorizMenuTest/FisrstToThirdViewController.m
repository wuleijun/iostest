//
//  FisrstToThirdViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "FisrstToThirdViewController.h"
#import "CustomNavigationBar.h"

@interface FisrstToThirdViewController ()

@end

@implementation FisrstToThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"NavBtn_Back"] highlight:[UIImage imageNamed:@"NavBtn_Back_D"]  leftCapWidth:14.0];
    self.navigationItem.title=@"22222";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}
- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    NSLog(@"%f",translation.x);
    NSLog(@"%f",self.view.frame.origin.x);
    if (self.view.frame.origin.x>=100) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
