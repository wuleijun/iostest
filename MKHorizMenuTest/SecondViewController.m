//
//  SecondViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "SecondViewController.h"
#import "MyDB.h"
#import "FMDatabase.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    
    self.navigationItem.title=@"Add Menu";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeKeyboard:(id)sender {
    [_txt_MenuDetails resignFirstResponder];
    [_txt_MenuName resignFirstResponder];
}

- (IBAction)addMenu_Touch:(id)sender {
    FMDatabase *mydb=[MyDB getInstance].db;
    if ([mydb open]) {
        if ([mydb executeUpdate:@"INSERT INTO menus (menuname,menudetails) VALUES (?,?)",_txt_MenuName.text,_txt_MenuDetails.text]) {
            NSLog(@"插入成功!");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"插入成功" message:@"已加入一条数据" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}
@end
