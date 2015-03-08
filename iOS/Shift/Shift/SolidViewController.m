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
    UIImageView *backImage;
    UIImageView *baloon;
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

@synthesize label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"SolidViewController");
    
    // そのまま画像表示
    //    UIImage *backgroundImage=[UIImage imageNamed:@"midtown.png"];
    //    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //iPhone/iPadの画面サイズに合わせて画像を拡大・縮小する
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"page2_bg"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    frame_w = self.view.bounds.size.width;
    frame_h = self.view.bounds.size.height;
    mode = 0;
    [self initUser];
    //[self startTimer];
    self.navigationController.delegate = self;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    // Network
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0;
    
    //[self getHeight:20.0 pressure:1019.0];
    
    //UIView *v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //
    //UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"other.png"]];
    //imgView.backgroundColor = [UIColor redColor];
    //[self.view addSubview:imgView];
    baloon = [[UIImageView alloc] init];
    baloon.frame = CGRectMake(0, 0, 133, 73);
    baloon.image = [UIImage imageNamed:@"balloon_bg"];
    [self.view addSubview:backImage];
    
    backImage = [[UIImageView alloc] init];
    backImage.frame = CGRectMake(0, 0, 22, 22);
    backImage.image = [UIImage imageNamed:@"my_position"];
    [self.view addSubview:backImage];
    
    //imgView.frame = CGRectMake(30, 100, 30, 30);
    //[self.view addSubview:imgView];
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [testTiemr invalidate];
}

- (void) viewWillAppear:(BOOL)animated {
    testTiemr = [NSTimer scheduledTimerWithTimeInterval:3.0f
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
    own_y = [self getOwnHeight];
    // 自分自身のオブジェクト
    //UIImage *own_img = [UIImage imageNamed:@"pin.png"];
    //own = [[UIImageView alloc] initWithImage:own_img];
    //own.frame = CGRectMake(0, 0, 13, 13);
    //own.center = CGPointMake(own_x, own_y);
    //[self.view addSubview:own];
    NSArray *groupData = [NSArray arrayWithObjects:
                          [NSArray arrayWithObjects:@150.0, @400.0, @"たっくん", nil],
                          [NSArray arrayWithObjects:@200.0, @300.0, @"かわしー", nil],
                          [NSArray arrayWithObjects:@150.0, @200.0, @"かわしー", nil],
                          [NSArray arrayWithObjects:@200.0, @300.0, @"かわしー", nil],
                          [NSArray arrayWithObjects:@170.0, @400.0, @"ぴかし", nil], nil];
    
    NSArray *allData = [NSArray arrayWithObjects:
                        [NSArray arrayWithObjects:@150.0, @250.0, @"たっくん", nil],
                        [NSArray arrayWithObjects:@170.0, @400.0, @"たっくん", nil],
                        [NSArray arrayWithObjects:@150.0, @290.0, @"たっくん", nil],
                        [NSArray arrayWithObjects:@150.0, @270.0, @"たっくん", nil],
                        [NSArray arrayWithObjects:@120.0, @400.0, @"かわしー", nil],
                        [NSArray arrayWithObjects:@200.0, @200.0, @"たろう", nil],
                        [NSArray arrayWithObjects:@150.0, @400.0, @"はなこ", nil],
                        [NSArray arrayWithObjects:@130.0, @300.0, @"なこ", nil],
                        [NSArray arrayWithObjects:@180.0, @230.0, @"はこ", nil],
                        [NSArray arrayWithObjects:@185.0, @400.0, @"はこ", nil],
                        [NSArray arrayWithObjects:@120.0, @230.0, @"はこ", nil],
                        [NSArray arrayWithObjects:@195.0, @210.0, @"はこ", nil],
                        [NSArray arrayWithObjects:@200.0, @330.0, @"はこ", nil],
                        [NSArray arrayWithObjects:@205.0, @430.0, @"はこ", nil],
                        [NSArray arrayWithObjects:@210.0, @430.0, @"はな", nil],
                        [NSArray arrayWithObjects:@170.0, @220.0, @"ぴか", nil],
                        [NSArray arrayWithObjects:@190.0, @330.0, @"ぴし", nil],
                        [NSArray arrayWithObjects:@190.0, @290.0, @"かし", nil], nil];
    
    group = [NSMutableArray array];
    int i = 0;
    for(NSArray* user in groupData) {
        UIImage  *img;
        if (i%3==0){
            img = [UIImage imageNamed:@"mini_person1"];
        } else if(i%3==1) {
            img = [UIImage imageNamed:@"mini_person2"];
        } else {
            img = [UIImage imageNamed:@"mini_person3"];
        }
        UIImageView *member = [[UIImageView alloc] initWithImage:img];
        member.frame = CGRectMake(0, 0, 13, 13);
        member.center = CGPointMake([[user objectAtIndex:0] floatValue], [[user objectAtIndex:1] floatValue]);
        [group addObject:member];
        i++;
    }
    all = [NSMutableArray array];
    i = 0;
    for(NSArray* user in allData) {
        UIImage  *img;
        if (i%3==0){
            img = [UIImage imageNamed:@"mini_person1"];
        } else if(i%3==1) {
            img = [UIImage imageNamed:@"mini_person2"];
        } else {
            img = [UIImage imageNamed:@"mini_person3"];
        }
        UIImageView *member = [[UIImageView alloc] initWithImage:img];
        member.frame = CGRectMake(0, 0, 13, 13);
        member.center = CGPointMake([[user objectAtIndex:0] floatValue], [[user objectAtIndex:1] floatValue]);
        [all addObject:member];
        i++;
    }
    NSLog(@"%d", i);
    
}
/*
- (void)startTimer{
    // タイマーを作成してスタート
    NSTimer *timer =
    [NSTimer scheduledTimerWithTimeInterval:0.9f
                                     target:self
                                   selector:@selector(plotUser:)
                                   userInfo:nil
                                    repeats:YES];
    [timer fire];
}
 */

- (void)plotUser:(NSTimer*)timer{
    // 高さを取得して表示
    own_y = [self getOwnHeight];
    own.center = CGPointMake(own_x, own_y);
    //[self setUI:_altitude];
}

int scale = 1.0;

- (double)getOwnHeight {
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

/*
- (IBAction)mainButton:(id)sender {
    NSLog(@"main");
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
*/
- (IBAction)myButton:(id)sender {
    [self changeMode:0];
}
- (IBAction)friendButton:(id)sender {
    [self changeMode:1];
}
- (IBAction)allButton:(id)sender {
    [self changeMode:2];
}

- (void)setUI:(float)altitude{
    float weight = 5;
    //[label setText:[NSString stringWithFormat:@"%lf",altitude]];
    //backImage.frame = CGRectMake(149, (480 - altitude*weight), 22, 22);
    //baloon.frame = CGRectMake(149, (480 - altitude*weight), 133, 73);
    //label.frame = CGRectMake(149, (480 - altitude*weight), 200, 50);
}

- (void) getHeight:(float)temperature pressure:(float)pressure
{
    NSString *URL = [[NSString alloc] initWithFormat:
                     @"http://pikashi.tokyo/shift/getheight?temperature=%f&pressure=%f",
                     temperature, pressure];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:URL parameters:nil success:^(NSURLSessionDataTask *task, NSString *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
        NSString *resStr = [response.description componentsSeparatedByString:@"\""][1];
            //[self setUI:_altitude];
        _altitude = [resStr floatValue] - 20.0;
        float weight = 5;
        [label setText:[NSString stringWithFormat:@"%lf",_altitude]];
        backImage.frame = CGRectMake(149, (450 - _altitude*weight), 22, 22);
        //baloon.frame = CGRectMake(149, (480 - _altitude*weight), 133, 73);
        //label.frame = CGRectMake(149, (480 - _altitude*weight), 200, 50);
        });
        //label.text =[NSString stringWithFormat:@"%lf",altitude];
        /*
        if (isButtonOpen) {
            _friendButton.frame = CGRectMake(260, 450, 40, 40);
            _allButton.frame = CGRectMake(260, 400, 40, 40);
            _myButton.frame = CGRectMake(260, 350, 40, 40);
        } else {
            _friendButton.frame = CGRectMake(260, 500, 40, 40);
            _allButton.frame = CGRectMake(260, 500, 40, 40);
            _myButton.frame = CGRectMake(260, 500, 40, 40);
        }
         */
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"failure: %ld", (long)response.statusCode);
    }];
    
}

@end