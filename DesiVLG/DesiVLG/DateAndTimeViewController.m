//
//  DateAndTimeViewController.m
//  AwesomeTPWidget
//
//  Created by Nisarg Vora on 10/15/15.
//  Copyright © 2015 Nisarg Vora. All rights reserved.
//

#import "DateAndTimeViewController.h"
#import "FlipView.h"
#import "AnimationDelegate.h"
#import "ViewController.h"
#import "DateTime.h"


@interface DateAndTimeViewController () <MZDayPickerDelegate, MZDayPickerDataSource, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
- (IBAction)ampmChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ampmButton;



@property (nonatomic) BOOL isMinutesFlip;
@property (nonatomic) BOOL isHoursFlip;


@property (nonatomic) NSString* amOrPMString;
@property (nonatomic) int hoursCounter;
@property (nonatomic) int minutesCounter;
@property (nonatomic) NSNumber * selectedDay;
@property (nonatomic) NSString * selectedWeekDay;
@property (nonatomic) DateTime *currentOrderDateTimeObject;

- (IBAction)confirmPressed:(id)sender;

@end

@implementation DateAndTimeViewController


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        step = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                  fromDate: currentDate]; // Get necessary date components
    
    int currentMonth = [components month]; //gives you month
    int currentDay = [components day]; //gives you day
    int currentYear = [components year]; // gives you year
    int currentHour = [dateComps hour];
    
    NSLog(@"%d",currentHour);
    
    
    int daysToAdd = 6;
    NSDate *endDate = [currentDate dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSCalendar* endCalendar = [NSCalendar currentCalendar];
    NSDateComponents* endComponents = [endCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:endDate]; // Get necessary date components
    
    int endMonth = [endComponents month]; //gives you month
    int endDay = [endComponents day]; //gives you day
    int endYear = [endComponents year]; // gives you year
    
    //NSLog(@" %d %d %d", currentMonth,currentDay,currentYear);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh mm a"];
    NSString *str_date = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableArray *currentTimeArray = [str_date componentsSeparatedByString:@" "];
    NSLog(@"str_date:%@",currentTimeArray);
    
    
    
    
    self.amOrPMString = currentTimeArray[2];
    [self.ampmButton setTitle:currentTimeArray[2] forState:UIControlStateNormal];
    int currentHourCounter = [currentTimeArray[0] intValue];
    self.hoursCounter = currentHourCounter;
    int currentMinuteCounter = [currentTimeArray[1] intValue];
    float minuteUnit = ceil((float) currentMinuteCounter / 15.0);
    int currentMinutes = minuteUnit * 15.0;
    // NSLog(@"%d",currentMinutes);
    self.minutesCounter = 00;
    
    
    
    
    
    
    
    
    self.title = @"Order for Later";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ScreenLaunch.png"]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    
    self.tableData = [@[] mutableCopy];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dayPicker.delegate = self;
    self.dayPicker.dataSource = self;
    
    self.dayPicker.dayNameLabelFontSize = 12.0f;
    self.dayPicker.dayLabelFontSize = 25.0f;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EE"];
    
    [self.dayPicker setStartDate:[NSDate dateFromDay:currentDay month:currentMonth year:currentYear] endDate:[NSDate dateFromDay:endDay month:endMonth year:endYear]];
    
    [self.dayPicker setCurrentDate:[NSDate dateFromDay:currentDay month:currentMonth year:currentYear] animated:YES];
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];
    [newDateFormatter setDateFormat:@"EEEE"];
    self.selectedWeekDay = [newDateFormatter stringFromDate:[NSDate date]];
    self.selectedDay = [NSNumber numberWithInt:currentDay];
    
    animationDelegate = [[AnimationDelegate alloc] initWithSequenceType:kSequenceControlled
                                                          directionType:kDirectionForward];
    animationDelegate.controller = self;
    animationDelegate.perspectiveDepth = 2000;
    
    self.flipView = [[FlipView alloc] initWithAnimationType:kAnimationFlipVertical
                                                      frame:CGRectMake(20, 270, 90, 200)];
    //self.flipView.layer.borderWidth=1;
    //self.flipView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.42 blue:0.06 alpha:1].CGColor;
    
    animationDelegate.transformView  = self.flipView;
    
    [self.view addSubview:self.flipView];
    
    self.flipView.textInset = CGPointMake(6.0, 0.0);
    //self.flipView.sublayerCornerRadius = 10;
    
    self.flipView.font = @"AppleGothic";
    self.flipView.textTruncationMode = kCATruncationEnd;
    
    self.flipView.fontSize = 130;
    self.flipView.fontAlignment = @"center";
    self.flipView.textOffset = CGPointMake(6.0, 76.0);
    
    
    for (int i=currentHourCounter; i<12; i++) {
        [self.flipView printText:@" " usingImage:[UIImage imageNamed:[NSString stringWithFormat:@"flipno%d",i+1]] backgroundColor:[UIColor  clearColor] textColor:[UIColor whiteColor]];
    }
    
    for (int i=1; i<currentHourCounter; i++) {
        [self.flipView printText:@" " usingImage:[UIImage imageNamed:[NSString stringWithFormat:@"flipno%d",i]] backgroundColor:[UIColor  clearColor] textColor:[UIColor whiteColor]];
    }
    
    //    [self.flipView printText:@" " usingImage:[UIImage imageNamed:@"flipno02"] backgroundColor:[UIColor  clearColor] textColor:[UIColor whiteColor]];
    
    
    
    self.flipView.fontSize = 130;
    self.flipView.fontAlignment = @"center";
    self.flipView.textOffset = CGPointMake(6.0, 76.0);
    //self.flipView.sublayerCornerRadius = 10;
    [self.flipView printText:@" " usingImage:[UIImage imageNamed:[NSString stringWithFormat:@"flipno%d",currentHourCounter]] backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
    
    
    
    animationDelegate2 = [[AnimationDelegate alloc] initWithSequenceType:kSequenceControlled
                                                           directionType:kDirectionForward];
    animationDelegate2.controller = self;
    animationDelegate2.perspectiveDepth = 2000;
    
    
    self.flipView2 = [[FlipView alloc] initWithAnimationType:kAnimationFlipVertical
                                                       frame:CGRectMake(120, 275, 190, 190)];
    //self.flipView.layer.borderWidth=1;
    //self.flipView.layer.borderColor = [UIColor colorWithRed:0.88 green:0.42 blue:0.06 alpha:1].CGColor;
    
    animationDelegate2.transformView  = self.flipView2;
    
    [self.view addSubview:self.flipView2];
    
    self.flipView2.textInset = CGPointMake(6.0, 0.0);
    //self.flipView.sublayerCornerRadius = 10;
    
    self.flipView2.font = @"AppleGothic";
    self.flipView2.textTruncationMode = kCATruncationEnd;
    
    self.flipView2.fontSize = 130;
    self.flipView2.fontAlignment = @"center";
    self.flipView2.textOffset = CGPointMake(6.0, 76.0);
    
    [self.flipView2 printText:@" " usingImage:[UIImage imageNamed:@"flipmin15"] backgroundColor:[UIColor  clearColor] textColor:[UIColor whiteColor]];
    
    [self.flipView2 printText:@" " usingImage:[UIImage imageNamed:@"flipmin30"] backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
    
    [self.flipView2 printText:@" " usingImage:[UIImage imageNamed:@"flipmin45"] backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
    
    
    self.flipView2.fontSize = 130;
    self.flipView2.fontAlignment = @"center";
    self.flipView2.textOffset = CGPointMake(6.0, 76.0);
    //self.flipView.sublayerCornerRadius = 10;
    [self.flipView2 printText:@" " usingImage:[UIImage imageNamed:@"flipmin0"] backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
    
    self.panRegion = [[UIView alloc] initWithFrame:CGRectMake(20, 270, 90, 200)];
    [self.view addSubview:self.panRegion];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    self.panRecognizer.delegate = self;
    self.panRecognizer.maximumNumberOfTouches = 1;
    self.panRecognizer.minimumNumberOfTouches = 1;
    [self.panRegion addGestureRecognizer:self.panRecognizer];
    
    
    self.panRegion2 = [[UIView alloc] initWithFrame:CGRectMake(120, 275, 190, 190)];
    [self.view addSubview:self.panRegion2];
    
    self.panRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned2:)];
    self.panRecognizer2.delegate = self;
    self.panRecognizer2.maximumNumberOfTouches = 1;
    self.panRecognizer2.minimumNumberOfTouches = 1;
    [self.panRegion2 addGestureRecognizer:self.panRecognizer2];
    
    
    
    
}



- (void)panned:(UIPanGestureRecognizer *)recognizer
{
    //NSLog(@"Gesture for hours");
    self.isMinutesFlip = NO;
    switch (recognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
            //        case UIGestureRecognizerStateRecognized: // for discrete recognizers
            //            break;
        case UIGestureRecognizerStateFailed: // cannot recognize for multi touch sequence
            break;
        case UIGestureRecognizerStateBegan: {
            // allow controlled flip only when touch begins within the pan region
            if (CGRectContainsPoint(self.panRegion.frame, [recognizer locationInView:self.view])) {
                if (animationDelegate.animationState == 0) {
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                    animationDelegate.sequenceType = kSequenceControlled;
                    animationDelegate.animationLock = YES;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (animationDelegate.animationLock) {
                switch (self.flipView.animationType) {
                    case kAnimationFlipVertical: {
                        float value = [recognizer translationInView:self.view].y;
                        [animationDelegate setTransformValue:value delegating:NO];
                    }
                        break;
                    case kAnimationFlipHorizontal: {
                        float value = [recognizer translationInView:self.view].x;
                        [animationDelegate setTransformValue:value delegating:NO];
                    }
                        break;
                    default:break;
                }
            }
        }
            break;
        case UIGestureRecognizerStateCancelled: // cancellation touch
            break;
        case UIGestureRecognizerStateEnded: {
            if (animationDelegate.animationLock) {
                // provide inertia to panning gesture
                float value = sqrtf(fabs([recognizer velocityInView:self.view].x))/10.0f;
                [animationDelegate endStateWithSpeed:value];
            }
        }
            break;
        default:
            break;
    }
    
    self.isHoursFlip = YES;
    //
}

- (void)panned2:(UIPanGestureRecognizer *)recognizer2
{
    //NSLog(@"Gesture for minutes");
    self.isHoursFlip = NO;

    switch (recognizer2.state) {
        case UIGestureRecognizerStatePossible:
            break;
            //        case UIGestureRecognizerStateRecognized: // for discrete recognizers
            //            break;
        case UIGestureRecognizerStateFailed: // cannot recognize for multi touch sequence
            break;
        case UIGestureRecognizerStateBegan: {
            // allow controlled flip only when touch begins within the pan region
            if (CGRectContainsPoint(self.panRegion2.frame, [recognizer2 locationInView:self.view])) {
                if (animationDelegate2.animationState == 0) {
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                    animationDelegate2.sequenceType = kSequenceControlled;
                    animationDelegate2.animationLock = YES;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (animationDelegate2.animationLock) {
                switch (self.flipView2.animationType) {
                    case kAnimationFlipVertical: {
                        float value = [recognizer2 translationInView:self.view].y;
                        [animationDelegate2 setTransformValue:value delegating:NO];
                    }
                        break;
                    case kAnimationFlipHorizontal: {
                        float value = [recognizer2 translationInView:self.view].x;
                        [animationDelegate2 setTransformValue:value delegating:NO];
                    }
                        break;
                    default:break;
                }
            }
        }
            break;
        case UIGestureRecognizerStateCancelled: // cancellation touch
            break;
        case UIGestureRecognizerStateEnded: {
            if (animationDelegate2.animationLock) {
                // provide inertia to panning gesture
                float value = sqrtf(fabs([recognizer2 velocityInView:self.view].x))/10.0f;
                [animationDelegate2 endStateWithSpeed:value];
            }
        }
            break;
        default:
            break;
    }
    
    
    self.isMinutesFlip = YES;
    
}


// use this to trigger events after specific interactions
- (void)animationDidFinish:(int)direction
{
    switch (step) {
        case 0:
            if (self.isMinutesFlip==YES) {
                if (direction==-1) {
                    if (self.minutesCounter == 45) {
                        self.minutesCounter =  00;
                    } else {
                        self.minutesCounter = self.minutesCounter + 15;
                    }
                    
                    NSLog(@"You did a forward minute flip");
                    NSLog(@"new minutes data - %d",self.minutesCounter);
                } else {
                    NSLog(@"You did a backward minute flip");
                    if (self.minutesCounter == 00) {
                        self.minutesCounter = 45;
                    } else {
                        self.minutesCounter = self.minutesCounter - 15;
                    }
                    NSLog(@"new minutes data - %d",self.minutesCounter);
                }
                
                
                
            }
            if (self.isHoursFlip==YES) {
                if (direction==-1) {
                    if (self.hoursCounter == 12) {
                        self.hoursCounter =  1;
                    } else {
                        self.hoursCounter = self.hoursCounter + 1;
                    }
                    
                    NSLog(@"You did a forward hour flip");
                    NSLog(@"New selected Hour - %d",self.hoursCounter);
                } else {
                    NSLog(@"You did a backward hour flip");
                    if (self.hoursCounter == 1) {
                        self.hoursCounter = 12;
                    } else {
                        self.hoursCounter = self.hoursCounter - 1;
                    }
                    NSLog(@"New selected Hour - %d",self.hoursCounter);
                }
                
            }
            
            
            
            break;
        case 1:
            NSLog(@"You did not do a flip");
            break;
        default:break;
    }
    
   
}


- (NSString *)dayPicker:(MZDayPicker *)dayPicker titleForCellDayNameLabelInDay:(MZDay *)day
{
    return [self.dateFormatter stringFromDate:day.date];
}


- (void)dayPicker:(MZDayPicker *)dayPicker didSelectDay:(MZDay *)day
{
    
    
    [self.tableData addObject:day];
    [self.tableView reloadData];
    self.selectedDay = day.day;
    self.selectedWeekDay = day.name;
    NSLog(@"Selected day %@ %@",self.selectedDay, self.selectedWeekDay);
}

- (void)dayPicker:(MZDayPicker *)dayPicker willSelectDay:(MZDay *)day
{
    NSLog(@"Will select day %@",day.day);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    
    MZDay *day = self.tableData[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",day.date];
    cell.detailTextLabel.text = day.name;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setDayPicker:nil];
    [super viewDidUnload];
}



- (IBAction)ampmChange:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    if ([buttonTitle  isEqual: @"AM"]) {
        [self.ampmButton setTitle:@"PM" forState:UIControlStateNormal];
        self.amOrPMString = @"PM";
        NSLog(@"Time set to PM");
    } else {
        [self.ampmButton setTitle:@"AM" forState:UIControlStateNormal];
        self.amOrPMString = @"AM";
        NSLog(@"Time set to AM");
    }
    
    
}
- (IBAction)confirmPressed:(id)sender {
    
     NSLog(@"%d %d %@ %@ %@",self.hoursCounter,self.minutesCounter,self.selectedDay,self.selectedWeekDay,self.amOrPMString);
    
    [self performSegueWithIdentifier:@"ConfirmedOrderDateTimeSegue" sender:sender];
    
    
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     ViewController *segueToViewController = [segue destinationViewController];
     self.currentOrderDateTimeObject = [[DateTime alloc]init];
     self.currentOrderDateTimeObject.selectedDay = self.selectedDay;
     self.currentOrderDateTimeObject.selectedWeekDay = self.selectedWeekDay;
     self.currentOrderDateTimeObject.hours = self.hoursCounter;
     self.currentOrderDateTimeObject.minutes = self.minutesCounter;
     self.currentOrderDateTimeObject.amPM = self.amOrPMString;

     [segueToViewController setCurrentOrderDateTime:self.currentOrderDateTimeObject];
     
     NSLog(@"%@", self.currentOrderDateTimeObject);
 
 }






@end



