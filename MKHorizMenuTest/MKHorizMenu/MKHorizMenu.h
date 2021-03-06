//
//  MKHorizMenu.h
//  MKHorizMenuDemo
//
//  Created by Mugunth on 09/05/11.
//  Copyright 2011 Steinlogic. All rights reserved.

//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8h on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import <UIKit/UIKit.h>

@class MKHorizMenu;

@protocol MKHorizMenuDataSource <NSObject>

@required

- (UIColor*) backgroundColorForMenu:(MKHorizMenu*) tabView;

- (int) numberOfItemsForMenu:(MKHorizMenu*) tabView;

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu titleForItemAtIndex:(NSUInteger) index;

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu imageForItemAtIndex:(NSUInteger) index;

- (NSString*) horizMenu:(MKHorizMenu*) horizMenu selectedImageForItemAtIndex:(NSUInteger) index;

@end

@protocol MKHorizMenuDelegate <NSObject>
@required
- (void)horizMenu:(MKHorizMenu*) horizMenu itemSelectedAtIndex:(NSUInteger) index;
@end

@interface MKHorizMenu : UIScrollView {

    int _itemCount;
    NSMutableArray *_titles;
    id <MKHorizMenuDataSource> dataSource;
    id <MKHorizMenuDelegate> itemSelectedDelegate;
}

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) IBOutlet id <MKHorizMenuDelegate> itemSelectedDelegate;
@property (nonatomic, strong) IBOutlet id <MKHorizMenuDataSource> dataSource;
@property (nonatomic, strong) UIImageView *item_bg;
@property (nonatomic, assign) int itemCount;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) NSMutableArray *arrayOfBtn;

-(void) reloadData:(NSInteger)index;
@end
