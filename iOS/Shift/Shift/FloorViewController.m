//
//  FloorViewController.m
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

#import "FloorViewController.h"

@interface FloorViewController ()
{
    bool isButtonOpen;
}
- (IBAction)mainButton:(id)sender;
- (IBAction)friendButton:(id)sender;
- (IBAction)allButton:(id)sender;
- (IBAction)myButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@end

@implementation FloorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"FloorViewController");
}

- (void)viewWillAppear:(BOOL)animated {
    isButtonOpen = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mainButton:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationRepeatAutoreverses:NO];
    if (isButtonOpen) {
        _friendButton.frame = CGRectMake(260, 500, 40, 40);
        _allButton.frame = CGRectMake(260, 500, 40, 40);
        _myButton.frame = CGRectMake(260, 500, 40, 40);
        isButtonOpen = NO;
    } else {
        _friendButton.frame = CGRectMake(260, 450, 40, 40);
        _allButton.frame = CGRectMake(260, 400, 40, 40);
        _myButton.frame = CGRectMake(260, 350, 40, 40);
        isButtonOpen = YES;
    }
    [UIView commitAnimations];
}

- (IBAction)friendButton:(id)sender {
}

- (IBAction)allButton:(id)sender {
}

- (IBAction)myButton:(id)sender {
    
}
@end
