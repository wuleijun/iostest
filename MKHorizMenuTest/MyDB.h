//
//  MyDB.h
//  MKHorizMenuTest
//
//  Created by jun on 13-7-13.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface MyDB : NSObject
@property(strong,nonatomic) FMDatabase *db;
+(MyDB *)getInstance;
-(NSMutableArray *)arrayOfAllTheMenuNames;

-(NSMutableString*)detailsWithTheMenuName:(NSString *)menuname;
-(void)setMenuDetailsForMenu:(NSString*)menuname withDetails:(NSString*)newdetails;
-(void)deleteMenuWithMenuName:(NSString *)menuname;
@end
