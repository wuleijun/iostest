//
//  FirstViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "FirstViewController.h"
#import "FromFirstViewController.h"
#import "FirstViewTableCell.h"
#import "MyDB.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize dataArray = _dataArray;

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
    self.navigationItem.title=@"Menus";
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
//    [self.view addGestureRecognizer:panGestureRecognizer];
    _dataArray = [[NSMutableArray alloc]init];
    [self initTableViewData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self initTableViewData];
    [_myTableView reloadData];
}

-(void)initTableViewData
{
    [_dataArray removeAllObjects];
    _dataArray = [[MyDB getInstance] arrayOfAllTheMenuNames];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button_touch:(id)sender {
    
    FromFirstViewController *fromFirstViewController=[[FromFirstViewController alloc]initWithNibName:@"FromFirstViewController" bundle:nil];
    [self.navigationController pushViewController:fromFirstViewController animated:YES];
}

- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    NSLog(@"%f",self.view.frame.origin.x);
    if (self.view.frame.origin.x <= -100) {
        FromFirstViewController *fromFirstViewController=[[FromFirstViewController alloc]initWithNibName:@"FromFirstViewController" bundle:nil];
        [self.navigationController pushViewController:fromFirstViewController animated:YES];
    }
}
#pragma mark -
#pragma mark TableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    
    static NSString *FirstViewTableCellID = @"FirstViewTableCellID";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"FirstViewTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:FirstViewTableCellID];
        nibsRegistered = YES;
    }
    FirstViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstViewTableCellID];
    cell.lbl_FirstTableView.text = [_dataArray objectAtIndex:row];
    [cell.btn_FisrtTableView setBackgroundImage:[UIImage imageNamed:@"SectionCell_Up_d"] forState:UIControlStateHighlighted];
    [cell.btn_FisrtTableView addTarget:self action:@selector(celltouched:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)celltouched:(id)sender
{
    //UIButton *myBtn=(UIButton *)sender;
    FirstViewTableCell *myCell=(FirstViewTableCell*)[[sender superview] superview];
    NSString *menuName = myCell.lbl_FirstTableView.text;
    
    FromFirstViewController *fromFirstViewController= [[FromFirstViewController alloc]initWithNibName:@"FromFirstViewController" bundle:nil withMenuName:menuName];
    
    [self.navigationController pushViewController:fromFirstViewController animated:YES];  
}

@end
