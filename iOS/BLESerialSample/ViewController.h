//
//  ViewController.h
//  BLESerialSample
//
//  Created by 川島 大地 on 2014/09/08.
//  Copyright (c) 2014年 川島 大地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLESerialManager.h"

@interface ViewController : UIViewController<BLESerialManagerDelegate>{
    
}
@property NSString *type;
@property NSString *number;
@property Boolean recMode;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UILabel *atmosLabel;

@end
