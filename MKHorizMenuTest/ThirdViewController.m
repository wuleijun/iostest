//
//  ThirdViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "ThirdViewController.h"
#import "Tools.h"
#import "CustomNavigationBar.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    [backButton addTarget:self action:@selector(showpopoverView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title=@"22222";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, 100) style:UITableViewStylePlain] ;
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    [self.tableView setDelegate:self];
    
    [self.tableView setDataSource:self];
    
    _arrayOfCurrentViews = [[NSMutableArray alloc]init];
}

- (void)showpopoverView
{
    self.myPopoverView = [PopoverView showPopoverAtPoint:CGPointMake(280, 0) inView:self.view withContentView:self.tableView delegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayOfCurrentViews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *siteCell=@"siteSectionCell";
    
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:siteCell];
    
    if(cell ==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:siteCell] ;
        
        [cell.textLabel setFont:[UIFont systemFontOfSize:17.0]];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        
        cell.selectedBackgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SectionCell_Mid_d"]];
        
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%d",[indexPath row]]];
    
    return cell;
}

- (IBAction)getRandomMenu:(id)sender {
    
       MyViewViewController * myViewViewController = [[MyViewViewController alloc]initWithNibName:@"MyViewViewController" bundle:nil];
    
    myViewViewController.delegate = self;
    [self.view addSubview:myViewViewController.view];
    UIButton *nextbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [nextbutton setTitle:@"next" forState:UIControlStateNormal];
    [nextbutton addTarget:self action:@selector(nextTouch:) forControlEvents:UIControlEventTouchUpInside];
    [myViewViewController.inner_View addSubview:nextbutton];
    
    [UIView animateWithDuration:0.3f animations:^(void){
        [myViewViewController.inner_View setFrame:CGRectMake(0, 0, myViewViewController.inner_View.frame.size.width, myViewViewController.inner_View.frame.size.height)];
    }completion:^(BOOL finished){
        if (finished) {
            NSLog(@"animation finished");
        }
    }];
    [self.arrayOfCurrentViews addObject:myViewViewController];
    [self.tableView reloadData];
}

- (void)nextTouch:(id)sender
{
       MyViewViewController *_secondViewController = [[MyViewViewController alloc]initWithNibName:@"MyViewViewController" bundle:nil];
    [self.view addSubview:_secondViewController.view];
    
    UIButton *nextbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [nextbutton setTitle:@"nextThird" forState:UIControlStateNormal];
    [nextbutton addTarget:self action:@selector(thirdTouch:) forControlEvents:UIControlEventTouchUpInside];
    [_secondViewController.inner_View addSubview:nextbutton];
    
    _secondViewController.inner_View.backgroundColor = [UIColor blueColor];
    _secondViewController.delegate = self;
    [UIView animateWithDuration:0.3f animations:^(void){
        [_secondViewController.inner_View setFrame:CGRectMake(0, 0, _secondViewController.inner_View.frame.size.width, _secondViewController.inner_View.frame.size.height)];
    }completion:^(BOOL finished){
        if (finished) {
            NSLog(@"animation finished");
        }
    }];
    [self.arrayOfCurrentViews addObject:_secondViewController];
    [self.tableView reloadData];
    
}

-(void)thirdTouch:(id)sender
{

      MyViewViewController*  _thirdViewController = [[MyViewViewController alloc]initWithNibName:@"MyViewViewController" bundle:nil];
    
    [self.view addSubview:_thirdViewController.view];
//    UIButton *nextbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
//    [nextbutton setTitle:@"nextThird" forState:UIControlStateNormal];
//    [nextbutton addTarget:self action:@selector(thirdTouch:) forControlEvents:UIControlEventTouchUpInside];
//    [_thirdViewController.inner_View addSubview:nextbutton];
    
    _thirdViewController.inner_View.backgroundColor = [UIColor greenColor];
    _thirdViewController.delegate = self;
    [UIView animateWithDuration:0.3f animations:^(void){
        [_thirdViewController.inner_View setFrame:CGRectMake(0, 0, _thirdViewController.inner_View.frame.size.width, _thirdViewController.inner_View.frame.size.height)];
    }completion:^(BOOL finished){
        if (finished) {
            NSLog(@"animation finished");
        }
    }];
    [self.arrayOfCurrentViews addObject:_thirdViewController];
    [self.tableView reloadData];
}

-(void)viewRemovedFinished
{
    [self.arrayOfCurrentViews removeLastObject];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSLog(@"%d",[indexPath row]);
    [self.view bringSubviewToFront:((MyViewViewController*)[_arrayOfCurrentViews objectAtIndex:[indexPath row]]).view];
    
    int cha=[_arrayOfCurrentViews count]-[indexPath row]-1;
    
    for(int i=0;i<cha;i++){
    
        MyViewViewController *controller=[_arrayOfCurrentViews objectAtIndex:[_arrayOfCurrentViews count]-1];
        
        [controller.view removeFromSuperview];
        
        [_arrayOfCurrentViews removeObjectAtIndex:[_arrayOfCurrentViews count]-1];
    }
    [self.tableView reloadData];

}
@end
