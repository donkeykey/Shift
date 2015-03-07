//
//  SolidViewController.h
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface SolidViewController : UIViewController {
    double latitude;    // 緯度
    double longitude;   // 軽度
    int mode; // モード
}
@property double latitude;
@property double longitude;
@property double mode;

@end
