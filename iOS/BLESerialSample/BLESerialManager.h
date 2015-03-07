//
//  BLESerialManager.h
//  BLESerial_test_iPhone5
//
//  Created by 川島 大地 on 2014/09/08.
//  Copyright (c) 2014年 石井 孝佳. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UUID_VSP_SERVICE					@"569a1101-b87f-490c-92cb-11ba5ea5167c" //VSP
#define UUID_RX                             @"569a2001-b87f-490c-92cb-11ba5ea5167c" //RX
#define UUID_TX								@"569a2000-b87f-490c-92cb-11ba5ea5167c" //TX

@protocol BLESerialManagerDelegate <NSObject>

- (void) onReceiveData:(NSString *)data;

@end

@interface BLESerialManager : NSObject

+ (BLESerialManager *) sharedManager;
- (void) initBLE;
- (void) connect;
- (void) disconnect;
- (void) sendChar:(unsigned char) c;
- (void) sendStr:(NSString *) c;

@property (nonatomic,assign) id<BLESerialManagerDelegate> delegate;
@property (nonatomic,retain) NSString *all_buff;

@end
