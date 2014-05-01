//
//  ViewController.m
//  Example
//
//  Created by Alan Skipp on 16/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "ViewController.h"
#import "ASProgressPopUpView.h"

@interface ViewController () <ASProgressPopUpViewDataSource>
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *progressView1;
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *progressView2;
@property (weak, nonatomic) IBOutlet UIButton *progressButton;
@end

@implementation ViewController
{
    NSTimer *_timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.progressView1.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
    self.progressView1.popUpViewAnimatedColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor]];
    self.progressView1.dataSource = self;
}

- (NSString *)progressView:(ASProgressPopUpView *)progressView stringForProgress:(float)progress
{
    int i = 170.0 * progress;
    return [NSString stringWithFormat:@"%d/170", i];
}

- (IBAction)startProgress:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        if (self.progressView1.progress >= 1.0) {
            self.progressView1.progress = 0.0;
            self.progressView2.progress = 0.0;
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(increaseProgress:)
                                                userInfo:NULL repeats:YES];
    } else {
        [_timer invalidate];
    }
}

- (IBAction)toggleShowHide:(UISwitch *)sender
{
    self.progressView1.alwaysShowPopUpView = sender.on ?: NO;
    self.progressView2.alwaysShowPopUpView = sender.on ?: NO;
}

- (void)increaseProgress:(NSTimer *)timer
{
    self.progressView1.progress += 0.01;
    self.progressView2.progress += 0.01;
    if (self.progressView1.progress >= 1.0) {
        [timer invalidate];
        self.progressButton.selected = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
