//
//  FromFirstViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "FromFirstViewController.h"
#import "CustomNavigationBar.h"
#import "FisrstToThirdViewController.h"
#import "MyDB.h"

@interface FromFirstViewController ()

@end

@implementation FromFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withMenuName:(NSString*)name
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.menuName = name;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    [self initNavigationBar];
    
    [self initDataAndRefreshView];
    
}
- (void)initDataAndRefreshView
{
    self.lbl_menuName.text = self.menuName;
    
    self.txt_menuDetails.text = [[MyDB getInstance] detailsWithTheMenuName:self.menuName];
    
}
- (void)initNavigationBar
{
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"NavBtn_Back"] highlight:[UIImage imageNamed:@"NavBtn_Back_D"]  leftCapWidth:14.0];
    self.navigationItem.title=self.menuName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightBtn.frame=CGRectMake(0.0, 0.0, 60, 45);
    
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"NavBtn"] forState:UIControlStateNormal];
    
    [_rightBtn setImage:[UIImage imageNamed:@"Nav_Icon_add_site"] forState:UIControlStateNormal];
    
    [_rightBtn addTarget:self action:@selector(rightBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [_rightBtn setTitle:@"Delete" forState:UIControlStateNormal];
    
    [_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
}

- (void)rightBtnTouch:(id)sender
{
    NSString *message = [NSString stringWithFormat:@"Are you sure to delete:%@?",self.menuName];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
}
#pragma mark -
#pragma mark UIAlertView Delegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[MyDB getInstance] deleteMenuWithMenuName:self.menuName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)modifyMenuInfo_Touch:(id)sender {
    [[MyDB getInstance] setMenuDetailsForMenu:self.menuName withDetails:self.txt_menuDetails.text];
}

- (IBAction)moveTheKeyBoard:(id)sender {

    [self.txt_menuDetails resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)return:(id)sender {
    FisrstToThirdViewController *fisrstToThirdViewController=[[FisrstToThirdViewController alloc]initWithNibName:@"FisrstToThirdViewController" bundle:nil];
    [self.navigationController pushViewController:fisrstToThirdViewController animated:YES];
}


- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    NSLog(@"%f",translation.x);
    NSLog(@"%f",self.view.frame.origin.x);
    if (self.view.frame.origin.x<=-50) {
        FisrstToThirdViewController *fisrstToThirdViewController=[[FisrstToThirdViewController alloc]initWithNibName:@"FisrstToThirdViewController" bundle:nil];
        [self.navigationController pushViewController:fisrstToThirdViewController animated:YES];
    }else if(self.view.frame.origin.x >=50)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
