//
//  FourthViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "FourthViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FourthViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollerView;

@property(strong,nonatomic)NSMutableArray *arrayOfData;

@property(strong,nonatomic)NSMutableArray *arrayOfView;

@end

@implementation FourthViewController

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    [self.locationManager startUpdatingLocation];
    
    _scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 370)];
    
//    [_scrollerView setDelegate:self];
    
    _scrollerView.pagingEnabled = YES;
    
//    _scrollerView.userInteractionEnabled = YES;
    
//    _scrollerView.showsHorizontalScrollIndicator = NO;
//    
//    _scrollerView.showsVerticalScrollIndicator = NO;
    
    
    _scrollerView.bounces = NO;
//    _scrollerView.scrollEnabled = NO;
//    _scrollerView.alwaysBounceHorizontal = YES;
//    _scrollerView.alwaysBounceVertical = NO;


    
    _arrayOfData=[[NSMutableArray alloc]init];
    
    _arrayOfView=[[NSMutableArray alloc]init];
    
    for(int i=0;i<10;i++){
    
        [_arrayOfData addObject:[NSString stringWithFormat:@"test%d",i]];
    }
    
    UITableView *tabel=[self pushView:_scrollerView.frame];
    
    [_arrayOfView addObject:tabel];
    
    [_scrollerView addSubview:tabel];
    
    
    
    
    [self.view addSubview:_scrollerView];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        
        if ([placemarks count]>0 ) {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//设置当前省份
//设置当前城市
//设置当前区域
            NSLog(@"%@-%@-%@",placemark.administrativeArea,placemark.locality,placemark.subLocality);
            
            CLLocationDegrees latitude = self.locationManager.location.coordinate.latitude;
            
            CLLocationDegrees longitude = self.locationManager.location.coordinate.longitude;
            
            NSLog(@"%2f",longitude);//经度
            
             NSLog(@"%2f",latitude);//纬度
            
            [self.locationManager stopUpdatingLocation];
            
            //            NSLog(@"%@==%@==%@==%f==%f",[Global getInstance].currentProvince,[Global getInstance].currentCity,[Global getInstance].currentCountry,[Global getInstance].posX,[Global getInstance].posY);
        }
        
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"获取经纬度失败，失败原因：%@", [error description]);
}


-(UITableView *)pushView:(CGRect)rect{
    
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    
    table.delegate=self;
    
    table.dataSource=self;
    
    return  table;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_arrayOfData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[_arrayOfData objectAtIndex:[indexPath row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

    UITableView *table=[self pushView:CGRectMake(320*[_arrayOfView count], 0, 320, 370)];
    
    [_scrollerView addSubview:table];

    [_arrayOfView addObject:table];
    
    [_scrollerView setContentSize:CGSizeMake([_arrayOfView count]*320, 370)];
    
    [_scrollerView setContentOffset:CGPointMake(320*([_arrayOfView count]-1), 0) animated:YES];
    
    NSLog(@"%@",NSStringFromCGRect(table.frame));
    
    NSLog(@"%@",NSStringFromCGSize(_scrollerView.contentSize));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
