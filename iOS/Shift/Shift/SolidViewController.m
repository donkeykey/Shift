//
//  SolidViewController.m
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

#import "SolidViewController.h"
#import "SensorController.h"

@interface SolidViewController (){
    UIImageView *own;
    double own_x;
    double own_y;
    NSMutableArray *group;
    NSMutableArray *all;
    int frame_w;
    int frame_h;
    bool isButtonOpen;
    AFHTTPSessionManager *manager;
    NSTimer *testTiemr;
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


@implementation SolidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"SolidViewController");
    
    // そのまま画像表示
    //    UIImage *backgroundImage=[UIImage imageNamed:@"midtown.png"];
    //    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //iPhone/iPadの画面サイズに合わせて画像を拡大・縮小する
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"midtown.png"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    frame_w = self.view.bounds.size.width;
    frame_h = self.view.bounds.size.height;
    mode = 0;
    [self initUser];
    [self startTimer];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    // Network
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0;
    
    //[self getHeight:20.0 pressure:1019.0];
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [testTiemr invalidate];
}

- (void) viewWillAppear:(BOOL)animated {
    testTiemr = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                          target:self
                                                        selector:@selector(startGetSensorValue:)
                                                        userInfo:nil
                                                         repeats:YES];
    [testTiemr fire];
}

- (void) startGetSensorValue:(NSTimer*)timer {
    NSLog(@"temp:%lf", [SensorController sharedManager].temp);
    NSLog(@"ps:%lf", [SensorController sharedManager].ps);
    [self getHeight:[SensorController sharedManager].temp pressure:[SensorController sharedManager].ps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUser{
    own_x = frame_w/2;
    own_y = frame_h/2;
    own_y = [self getHeight];
    // 自分自身のオブジェクト
    UIImage *own_img = [UIImage imageNamed:@"pin.png"];
    own = [[UIImageView alloc] initWithImage:own_img];
    own.frame = CGRectMake(0, 0, 13, 15);
    own.center = CGPointMake(own_x, own_y);
    [self.view addSubview:own];
    NSArray *groupData = [NSArray arrayWithObjects:
                          [NSArray arrayWithObjects:@150, @400, @"たっくん", nil],
                          [NSArray arrayWithObjects:@200, @300, @"かわしー", nil],
                          [NSArray arrayWithObjects:@170, @400, @"ぴかし", nil], nil];
    
    NSArray *allData = [NSArray arrayWithObjects:
                        [NSArray arrayWithObjects:@150, @400, @"たっくん", nil],
                        [NSArray arrayWithObjects:@200, @300, @"かわしー", nil],
                        [NSArray arrayWithObjects:@200, @200, @"たろう", nil],
                        [NSArray arrayWithObjects:@150, @300, @"はなこ", nil],
                        [NSArray arrayWithObjects:@170, @400, @"ぴかし", nil], nil];
    
    group = [NSMutableArray array];
    for(NSArray* user in groupData) {
        UIImage *img = [UIImage imageNamed:@"group.png"];
        UIImageView *member = [[UIImageView alloc] initWithImage:img];
        member.frame = CGRectMake(0, 0, 13, 15);
        member.center = CGPointMake([[user objectAtIndex:0] floatValue], [[user objectAtIndex:1] floatValue]);
        [group addObject:member];
    }
    all = [NSMutableArray array];
    for(NSArray* user in allData) {
        UIImage *img = [UIImage imageNamed:@"other.png"];
        UIImageView *member = [[UIImageView alloc] initWithImage:img];
        member.frame = CGRectMake(0, 0, 13, 15);
        member.center = CGPointMake([[user objectAtIndex:0] floatValue], [[user objectAtIndex:1] floatValue]);
        [all addObject:member];
    }
    
}
- (void)startTimer{
    // タイマーを作成してスタート
    NSTimer *timer =
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(plotUser:)
                                   userInfo:nil
                                    repeats:YES];
    [timer fire];
}

- (void)plotUser:(NSTimer*)timer{
    // 高さを取得して表示
    own_y = [self getHeight];
    own.center = CGPointMake(own_x, own_y);
    
}

int scale = 1.0;
- (double)getHeight{
    // 高さを取得して返す
    return own_y; // 今ここ適当
}

- (void)changeMode:(int)i{
    switch (i) {
        case 0:
            if(mode == 1){
                for (UIImageView* user in group) {
                    [user removeFromSuperview];
                }
            }else if(mode == 2){
                for (UIImageView* user in all) {
                    [user removeFromSuperview];
                }
            }
            break;
        case 1:
            if(mode == 0){
                for (UIImageView* user in group) {
                    [self.view addSubview:user];
                }
            }else if(mode == 2){
                for (UIImageView* user in all) {
                    [user removeFromSuperview];
                }
                for (UIImageView* user in group) {
                    [self.view addSubview:user];
                }
            }
            break;
        case 2:
            if(mode == 0){
                for (UIImageView* user in all) {
                    [self.view addSubview:user];
                }
            }else if(mode == 1){
                for (UIImageView* user in group) {
                    [user removeFromSuperview];
                }
                for (UIImageView* user in all) {
                    [self.view addSubview:user];
                }
            }
            break;
        default:
            break;
    }
    mode = i;
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
    [self changeMode:0];
}
- (IBAction)friendButton:(id)sender {
    [self changeMode:1];
}
- (IBAction)allButton:(id)sender {
    [self changeMode:2];
}

- (void) getHeight:(float)temperature pressure:(float)pressure
{
    NSString *URL = [[NSString alloc] initWithFormat:
                     @"http://pikashi.tokyo/shift/getheight?temperature=%f&pressure=%f",
                     temperature, pressure];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, NSString *response) {
        NSString *resStr = [response.description componentsSeparatedByString:@"\""][1];
        float altitude = [resStr floatValue] - 20.0;
        if (altitude < 0 || altitude > 300) {
            altitude = 0.0;
        }
        //NSLog(@"%lf", [resStr floatValue]);
        _label.text = [NSString stringWithFormat:@"%lf",altitude];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"failure: %ld", (long)response.statusCode);
    }];
    
}

@end