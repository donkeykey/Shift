//
//  SolidViewController.m
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

#import "SolidViewController.h"

@interface SolidViewController (){
    UIImageView *own;
    double own_x;
    double own_y;
    NSArray *group;
    NSArray *all;
    int frame_w;
    int frame_h;
}

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
    frame_h = self.view.bounds.size.width;
    mode = 1;
    [self initUser];
    [self startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUser{
    own_x = frame_w/2;
    own_y = 0;
    own_y = [self getHeight];
    // 自分自身のオブジェクト
    UIImage *own_img = [UIImage imageNamed:@"pin.png"];
    own = [[UIImageView alloc] initWithImage:own_img];
    own.frame = CGRectMake(0, 0, 13, 15);
    own.center = CGPointMake(own_x, own_y);
    [self.view addSubview:own];
    
    switch (mode) {
        case 1:
            // グループ
            group = [NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:@100, @500, @"たっくん", nil],
                     [NSArray arrayWithObjects:@200, @300, @"かわしー", nil],
                     [NSArray arrayWithObjects:@300, @400, @"ぴかし", nil], nil];
            break;
        case 2:
            // 全ユーザ
            all = [NSArray arrayWithObjects:
                   [NSArray arrayWithObjects:@100, @500, @"たっくん", nil],
                   [NSArray arrayWithObjects:@200, @300, @"かわしー", nil],
                   [NSArray arrayWithObjects:@200, @200, @"たろう", nil],
                   [NSArray arrayWithObjects:@300, @400, @"はなこ", nil],
                   [NSArray arrayWithObjects:@300, @300, @"ぴかし", nil], nil];
        default:
            break;
    }
    for(NSArray* user in group) {
        UIImage *img = [UIImage imageNamed:@"group.png"];
        UIImageView *member = [[UIImageView alloc] initWithImage:img];
        member.frame = CGRectMake(0, 0, 13, 15);
        member.center = CGPointMake([[user objectAtIndex:0] floatValue], [[user objectAtIndex:1] floatValue]);
        [self.view addSubview:member];
    }
    for(NSArray* user in all) {
        UIImage *img = [UIImage imageNamed:@"other.png"];
        UIImageView *member = [[UIImageView alloc] initWithImage:img];
        member.frame = CGRectMake(0, 0, 13, 15);
        member.center = CGPointMake([[user objectAtIndex:0] floatValue], [[user objectAtIndex:1] floatValue]);
        [self.view addSubview:member];
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
    return own_y + 100;// 今ここ適当
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
