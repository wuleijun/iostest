//
//  MyDB.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-13.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "MyDB.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation MyDB


+(MyDB *)getInstance{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(id)init{
    if (self = [super init]) {
        NSFileManager *fm=[NSFileManager defaultManager];
		
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
		NSString *dbPath=([paths count]>0) ? [paths objectAtIndex:0] : nil ;
        
		NSString *writableDBPath = [dbPath stringByAppendingPathComponent:@"mydb.sqlite"];
        
		if(![fm fileExistsAtPath:writableDBPath]){
			
			[fm createFileAtPath:writableDBPath contents:nil attributes:nil];
		}
        
        NSLog(@"=============%@",writableDBPath);
        
        _db=[FMDatabase databaseWithPath:writableDBPath];
    }
    return self;
}

-(NSMutableArray *)arrayOfAllTheMenuNames
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if ([_db open]) {
        [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS menus (menuname text, menudetails)"];
        FMResultSet *rs = [_db executeQuery:@"SELECT menuname,menudetails FROM menus"];
        while ([rs next]) {
            NSLog(@"%@",[rs stringForColumn:@"menuname"]);
            [array addObject:[rs stringForColumn:@"menuname"]];
        }
    }
    return array;
}

-(NSMutableString*)detailsWithTheMenuName:(NSString *)menuname
{
    NSMutableString *details;
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:@"SELECT menudetails FROM menus WHERE menuname = ?",menuname];
        while ([rs next]) {
            NSLog(@"%@",[rs stringForColumn:@"menudetails"]);
            details = [NSMutableString stringWithString:[rs stringForColumn:@"menudetails"]];
        }
    }
    return details;
}

-(void)setMenuDetailsForMenu:(NSString*)menuname withDetails:(NSString*)newdetails
{
    if ([_db open]) {
        [_db executeUpdate:@"UPDATE menus SET menudetails = ? WHERE menuname = ?",newdetails,menuname];
    }
}

-(void)deleteMenuWithMenuName:(NSString *)menuname
{
    if ([_db open]) {
        [_db executeUpdate:@"DELETE FROM menus WHERE menuname = ?",menuname];
    }
}
@end
