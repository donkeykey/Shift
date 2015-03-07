//
//  FloorDetailViewController.m
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

#import "FloorDetailViewController.h"

@interface FloorDetailViewController ()
{
    bool isButtonOpen;
}
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
- (IBAction)mainButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
- (IBAction)myButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
- (IBAction)friendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
- (IBAction)allButton:(id)sender;
@end

@implementation FloorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"FloorDetailViewController");
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
- (IBAction)myButton:(id)sender {
}
- (IBAction)friendButton:(id)sender {
}
- (IBAction)allButton:(id)sender {
}
@end
