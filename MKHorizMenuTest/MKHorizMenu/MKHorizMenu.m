//
//  MKHorizMenu.m
//  MKHorizMenuDemo
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

#import "MKHorizMenu.h"
#define kButtonBaseTag 10000

#define kImageBaseTag 20000

#define kLeftOffset 0
#define number 4
#define kWidth 320

@implementation MKHorizMenu

@synthesize titles = _titles;
@synthesize itemSelectedDelegate = _itemSelectedDelegate;
@synthesize dataSource;
@synthesize itemCount = _itemCount;

-(void) awakeFromNib
{
    self.bounces = NO;
    self.scrollEnabled = NO;
    self.alwaysBounceHorizontal = YES;
    self.alwaysBounceVertical = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}
     
-(void) reloadData:(NSInteger)index
{
    self.itemCount = [dataSource numberOfItemsForMenu:self];
    
    self.backgroundColor = [dataSource backgroundColorForMenu:self];
    
    self.arrayOfBtn=[NSMutableArray arrayWithCapacity:0];
   
    UIFont *font = [UIFont systemFontOfSize:11];
   
    int tag = kButtonBaseTag;
    
    int xPos = kLeftOffset;
    
    int viewHeight= self.frame.size.height;
    
    _selectedIndex=index;
    
    self.item_bg=[[UIImageView alloc] initWithFrame:CGRectMake((kWidth/number)*_selectedIndex, 0, kWidth/number, viewHeight)];
    
    [self.item_bg setImage:[[UIImage imageNamed:@"Tabbar_Icon_bg"] stretchableImageWithLeftCapWidth:32 topCapHeight:23]];
    
    [self addSubview:_item_bg];
    
    for(int i = 0 ; i < self.itemCount; i ++)
    {
        NSString *title = [dataSource horizMenu:self titleForItemAtIndex:i];
        
        NSString *image = [dataSource horizMenu:self imageForItemAtIndex:i];
        
        NSString *selectedImage=[dataSource horizMenu:self selectedImageForItemAtIndex:i];
        
        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        customButton.frame=CGRectMake(xPos, 0, kWidth/number, viewHeight);

        customButton.tag = tag++;
        
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *image_content=[[UIImageView alloc] init];
        
        [image_content setImage:[UIImage imageNamed:image]];
        
        [image_content setHighlightedImage:[UIImage imageNamed:selectedImage]];
        
        if (_selectedIndex==i) {
            
            [image_content setHighlighted:YES];
            
        }else{
        
            [image_content setHighlighted:NO];
        }
        
        image_content.frame=CGRectMake((kWidth/number-30)/2,3,30, 30);
        
        image_content.tag=kImageBaseTag+i;
        
        [customButton addSubview:image_content];
        
        [self.arrayOfBtn addObject:customButton];
        
        UILabel *lab=[[UILabel alloc] init];
        
        lab.backgroundColor=[UIColor clearColor];
        
        lab.frame=CGRectMake(0, image_content.frame.origin.y+image_content.frame.size.height, kWidth/number, font.pointSize);
        
        lab.text=title;
        
        lab.textAlignment=NSTextAlignmentCenter;
        
        lab.font=font;
        
        lab.textColor=[UIColor whiteColor];
        
        [customButton addSubview:lab];
        
        [self addSubview:customButton];
        
        xPos=xPos+kWidth/number;
        
    }
        
    self.contentSize = CGSizeMake(xPos, self.frame.size.height);
    
    [self layoutSubviews];  
}

-(void)setSelectedIndex:(int)selectedIndex{

    UIButton *btn=[self.arrayOfBtn objectAtIndex:selectedIndex];

    [self buttonTapped:btn];

}

-(void) buttonTapped:(id) sender
{
    UIButton *button = (UIButton*) sender;
    
    if (_selectedIndex!=button.tag-kButtonBaseTag) {
        
        for(int i = 0; i < self.itemCount; i++)
        {
            UIImageView *thisImage = (UIImageView*) [self viewWithTag:i + kImageBaseTag];
            
            if(i  == button.tag-kButtonBaseTag)
                [thisImage setHighlighted:YES];
            else
               [thisImage setHighlighted:NO];
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1];
        [_item_bg setFrame:CGRectMake((button.tag-kButtonBaseTag)*(kWidth/number), 0, _item_bg.frame.size.width, _item_bg.frame.size.height)];
        [UIView commitAnimations];
    }

    [self.itemSelectedDelegate horizMenu:self itemSelectedAtIndex:button.tag-kButtonBaseTag];
    
    _selectedIndex=button.tag-kButtonBaseTag;
}


@end
