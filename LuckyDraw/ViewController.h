//
//  ViewController.h
//  LuckyDraw
//
//  Created by Sheck on 1/7/16.
//  Copyright © 2016 gaoteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property NSMutableArray *arr;
@property NSMutableArray *arrGrade;
@property NSMutableArray *arrDegree;
@property NSMutableArray *arrName;

- (IBAction)tapWinning:(id)sender;
@end

