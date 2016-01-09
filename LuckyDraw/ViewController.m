//
//  ViewController.m
//  LuckyDraw
//
//  Created by Sheck on 1/7/16.
//  Copyright © 2016 gaoteam. All rights reserved.
//

#import "ViewController.h"

#define goldenColor                                                            \
  [UIColor colorWithRed:201 / 255.0 green:165 / 255.0 blue:97 / 255.0 alpha:1]

@interface ViewController () {
  NSTimer *gradeTimer;
  NSTimer *degreeTimer;
  NSTimer *nameTimer;
  int nGradeIndex;
  int nDegreeIndex;
  int nNameIndex;
  NSUInteger nFinalGradeIndex;
  NSUInteger nFinalDegreeIndex;
  NSUInteger nFinalNameIndex;
  NSUInteger nFinalIndex;
}
@property(weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(weak, nonatomic) IBOutlet UIButton *btnWinning;

@end

@implementation ViewController
@synthesize arr, arrGrade, arrDegree, arrName;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  NSString *plistPath =
      [[NSBundle mainBundle] pathForResource:@"Players" ofType:@"plist"];
  arr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];

  NSMutableSet *setGrade = [[NSMutableSet alloc] init];
  NSMutableSet *setDegree = [[NSMutableSet alloc] init];
  NSMutableSet *setName = [[NSMutableSet alloc] init];
  for (NSDictionary *dic in arr) {
    [setGrade addObject:[dic objectForKey:@"grade"]];
    [setDegree addObject:[dic objectForKey:@"degree"]];
    [setName addObject:[dic objectForKey:@"name"]];
  }

  arrGrade = [NSMutableArray arrayWithArray:[setGrade allObjects]];
  arrDegree = [NSMutableArray arrayWithArray:[setDegree allObjects]];
  arrName = [NSMutableArray arrayWithArray:[setName allObjects]];

  nGradeIndex = 0;
  nDegreeIndex = 0;
  nNameIndex = 0;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)tapWinning:(id)sender {
  [self.btnWinning setEnabled:NO];
  [self setupTimer];
}

- (void)setupTimer {
  NSTimer *startGradeTimer =
      [NSTimer scheduledTimerWithTimeInterval:0.2
                                       target:self
                                     selector:@selector(startGradeRoll)
                                     userInfo:nil
                                      repeats:YES];
  NSTimer *startDegreeTimer =
      [NSTimer scheduledTimerWithTimeInterval:0.2
                                       target:self
                                     selector:@selector(startDegreeRoll)
                                     userInfo:nil
                                      repeats:YES];
  NSTimer *startNameTimer =
      [NSTimer scheduledTimerWithTimeInterval:0.2
                                       target:self
                                     selector:@selector(startNameRoll)
                                     userInfo:nil
                                      repeats:YES];

  gradeTimer = startGradeTimer;
  degreeTimer = startDegreeTimer;
  nameTimer = startNameTimer;

  [NSTimer scheduledTimerWithTimeInterval:3
                                   target:self
                                 selector:@selector(stopGradeRoll)
                                 userInfo:nil
                                  repeats:NO];

  [NSTimer scheduledTimerWithTimeInterval:5
                                   target:self
                                 selector:@selector(stopDegreeRoll)
                                 userInfo:nil
                                  repeats:NO];

  [NSTimer scheduledTimerWithTimeInterval:8
                                   target:self
                                 selector:@selector(stopNameRoll)
                                 userInfo:nil
                                  repeats:NO];
}

- (void)startGradeRoll {
  [self.pickerView selectRow:nGradeIndex inComponent:0 animated:YES];
  nGradeIndex = arc4random() % [arrGrade count];
}

- (void)startDegreeRoll {
  [self.pickerView selectRow:nDegreeIndex inComponent:1 animated:YES];
  nDegreeIndex = arc4random() % [arrDegree count];
}

- (void)startNameRoll {
  [self.pickerView selectRow:nNameIndex inComponent:2 animated:YES];
  nNameIndex = arc4random() % [arrName count];
}

- (void)stopGradeRoll {
  [gradeTimer invalidate];
  gradeTimer = nil;

  nFinalIndex = arc4random() % [arr count];
  NSDictionary *dicResult = [arr objectAtIndex:nFinalIndex];

  nFinalGradeIndex = [arrGrade indexOfObject:[dicResult objectForKey:@"grade"]];
  nFinalDegreeIndex =
      [arrDegree indexOfObject:[dicResult objectForKey:@"degree"]];
  nFinalNameIndex = [arrName indexOfObject:[dicResult objectForKey:@"name"]];

  [self.pickerView selectRow:nFinalGradeIndex inComponent:0 animated:YES];
}

- (void)stopDegreeRoll {
  [degreeTimer invalidate];
  degreeTimer = nil;
  [self.pickerView selectRow:nFinalDegreeIndex inComponent:1 animated:YES];
}

- (void)stopNameRoll {
  [nameTimer invalidate];
  nameTimer = nil;
  [self.pickerView selectRow:nFinalNameIndex inComponent:2 animated:YES];

  [self.arr removeObjectAtIndex:nFinalIndex];
  [self.pickerView reloadComponent:2];
  [self.btnWinning setEnabled:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
  switch (component) {
  case 0:
    return [arrGrade count];
    break;
  case 1:
    return [arrDegree count];
    break;
  case 2:
    return [arrName count];
    break;

  default:
    return 1;
    break;
  }
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
  CGFloat height = self.pickerView.frame.size.height;
  CGFloat width = self.pickerView.frame.size.width;
  
  switch (component) {
  case 0: {
    UIView *myView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UILabel *myLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    myLabel.text = [arrGrade objectAtIndex:row];
    [myLabel setTextColor:goldenColor];
    [myLabel setTextAlignment:NSTextAlignmentCenter];
    myLabel.font = [UIFont systemFontOfSize:24];
    [myView addSubview:myLabel];
    return myView;
    break;
  }
  case 1: {
    UIView *myView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UILabel *myLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    myLabel.text = [arrDegree objectAtIndex:row];
    [myLabel setTextColor:goldenColor];
    [myLabel setTextAlignment:NSTextAlignmentCenter];
    myLabel.font = [UIFont systemFontOfSize:24];
    [myView addSubview:myLabel];
    return myView;
    break;
  }
  case 2: {
    UIView *myView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UILabel *myLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    myLabel.text = [arrName objectAtIndex:row];
    [myLabel setTextColor:goldenColor];
    [myLabel setTextAlignment:NSTextAlignmentCenter];
    myLabel.font = [UIFont systemFontOfSize:24];
    [myView addSubview:myLabel];
    return myView;
    break;
  }

  default:
    return nil;
    break;
  }
}
@end
