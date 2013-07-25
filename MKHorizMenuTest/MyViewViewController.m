//
//  MyViewViewController.m
//  MKHorizMenuTest
//
//  Created by jun on 13-7-18.
//  Copyright (c) 2013年 wu leijun. All rights reserved.
//

#import "MyViewViewController.h"

@interface MyViewViewController ()

@end

@implementation MyViewViewController

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
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
    [self.inner_View addGestureRecognizer:panGestureRecognizer];

}

- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    if (!(self.inner_View.frame.origin.x == 0 && translation.x < 0)) {
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
        [recognizer setTranslation:CGPointZero inView:self.inner_View];
        NSLog(@"%f",translation.x);
        NSLog(@"%f",self.inner_View.frame.origin.x);
        float viewX = self.inner_View.frame.origin.x;
        if (viewX>=160 && recognizer.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.15f animations:^(void){
                [self.inner_View setFrame:CGRectMake(320, 0, self.inner_View.frame.size.width, self.inner_View.frame.size.height)];
            }completion:^(BOOL finished){
                if (finished) {
                    [self.view removeFromSuperview];
                    if ([self.delegate respondsToSelector:@selector(viewRemovedFinished)]) {
                        [self.delegate viewRemovedFinished];
                    }
                }
            }];
        }else if(viewX < 160 && recognizer.state == UIGestureRecognizerStateEnded){
            [UIView animateWithDuration:0.15f animations:^(void){
                [self.inner_View setFrame:CGRectMake(0, 0, self.inner_View.frame.size.width, self.inner_View.frame.size.height)];
            }completion:^(BOOL finished){
                if (finished) {
                    NSLog(@"回到原位");            }
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touch_back:(id)sender {
    [UIView animateWithDuration:0.3f animations:^(void){
        [self.inner_View setFrame:CGRectMake(320, 0, self.inner_View.frame.size.width, self.inner_View.frame.size.height)];
    }completion:^(BOOL finished){
        if (finished) {
            [self.view removeFromSuperview];
            if ([self.delegate respondsToSelector:@selector(viewRemovedFinished)]) {
                [self.delegate viewRemovedFinished];
            }
        }
    }];
}
@end
