//
//  FourthViewController.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-11.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface FourthViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic)   CLGeocoder *geocoder;
@end
