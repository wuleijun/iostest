//
//  ViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "CustomNavigationBar.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame=[[UIScreen mainScreen] applicationFrame];
    
    _transitionView = [[UIView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height- 45)];
    
    _transitionView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:_transitionView];
    
    _viewControllers = [[NSMutableArray alloc]init];
    
    //@"Tabbar_Icon_Tool"
    _arrayOfImg=[NSMutableArray arrayWithObjects:@"Tabbar_Icon_Call",@"Tabbar_Icon_New",@"Tabbar_Icon_Contact",@"Tabbar_Icon_Center",nil];
    
    //@"Tabbar_Icon_Tool_d"
    _arrayOfSelectedImg=[NSMutableArray arrayWithObjects:@"Tabbar_Icon_Call_d",@"Tabbar_Icon_New_d",@"Tabbar_Icon_Contact_d",@"Tabbar_Icon_Center_d",nil];
    
    UINavigationController *mfirstViewController=[self getCustomNavigationController:[FirstViewController class]];
    UINavigationController *msecondViewController=[self getCustomNavigationController:[SecondViewController class]];
    UINavigationController *mthirdViewController=[self getCustomNavigationController:[ThirdViewController class]];
    UINavigationController *mfourthViewController=[self getCustomNavigationController:[FourthViewController class]];

    self.viewControllers = [NSMutableArray arrayWithObjects:mfirstViewController,msecondViewController,mthirdViewController,mfourthViewController,nil];

    
    UINavigationController *selectVC=[self.viewControllers objectAtIndex:self.myMKHorizMenu.selectedIndex];
    
    selectVC.view.frame=CGRectMake(0, 0, _transitionView.frame.size.width,  _transitionView.frame.size.height);
    
    [_transitionView addSubview:selectVC.view];
    
    [_myMKHorizMenu reloadData:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark MKHorizMenuDataSource Method;

- (UIColor*) backgroundColorForMenu:(MKHorizMenu*) tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"Tabbar_bg"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu*) tabView
{
    return 4;
}

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu titleForItemAtIndex:(NSUInteger) index
{
    switch (index) {
        case 0:
            return @"Menus";
            break;
        case 1:
            return @"Add Menu";
        default:
            return @"Menu";
            break;
    }
}

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu imageForItemAtIndex:(NSUInteger) index
{
    return  [self.arrayOfImg objectAtIndex:index];
}

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu selectedImageForItemAtIndex:(NSUInteger) index
{
    return  [self.arrayOfSelectedImg objectAtIndex:index];
}

#pragma mark -
#pragma mark MKHorizMenuDelegate Method;
- (void)horizMenu:(MKHorizMenu*) horizMenu itemSelectedAtIndex:(NSUInteger) index
{
    
            UINavigationController *nav = [self.viewControllers objectAtIndex:index];
            
            [nav popToRootViewControllerAnimated:YES];
    
            [self displayViewAtIndex:index];
        
}

-(void)displayViewAtIndex:(NSInteger)index{
    
    UINavigationController *selectVC=[self.viewControllers objectAtIndex:index];
    
    selectVC.view.frame=CGRectMake(0, 0, _transitionView.frame.size.width,  _transitionView.frame.size.height);
    
    
    UIViewController *lastVC=[self.viewControllers objectAtIndex:self.myMKHorizMenu.selectedIndex];
    
    [lastVC.view removeFromSuperview];
    
    [_transitionView addSubview:selectVC.view];
    
}
-(UINavigationController *)getCustomNavigationController:(Class) class{
    
    UINavigationController *nav=[[UINavigationController  alloc] initWithNavigationBarClass:[CustomNavigationBar class] toolbarClass:nil];
    
    [nav setViewControllers:[NSArray arrayWithObjects:[[class alloc] initWithNibName:[class description] bundle:nil], nil]];
    
    
    CustomNavigationBar* customNavigationBarForNew = (CustomNavigationBar*)nav.navigationBar;
    
    customNavigationBarForNew.navigationController=nav;
    
    [customNavigationBarForNew setBackgroundWith:[UIImage imageNamed:@"Navbar_bg"]];
    
    return nav;
}

@end
