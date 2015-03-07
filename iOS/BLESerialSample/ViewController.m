//
//  ViewController.m
//  BLESerialSample
//
//  Created by 川島 大地 on 2014/09/08.
//  Copyright (c) 2014年 川島 大地. All rights reserved.
//

#import "ViewController.h"
#import "BLESerialManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[BLESerialManager sharedManager] initBLE];
    [BLESerialManager sharedManager].delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTouchConnectBtn:(id)sender {
    [[BLESerialManager sharedManager] connect];
    [[BLESerialManager sharedManager] sendStr:[NSString stringWithFormat:@"~"]];
}
- (IBAction)onTouchDisconnectBtn:(id)sender {
    [[BLESerialManager sharedManager] disconnect];
}

- (void) onReceiveData:(NSString *)data {
    NSLog(@"on Receive data : %@", data);
    self.atmosLabel.text = data;
}

@end
