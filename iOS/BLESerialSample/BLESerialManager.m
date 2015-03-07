//
//  BLESerialManager.m
//  BLESerial_test_iPhone5
//
//  Created by 川島 大地 on 2014/09/08.
//  Copyright (c) 2014年 石井 孝佳. All rights reserved.
//

#import "BLESerialManager.h"
#import "BLEBaseClass.h"
#import <CoreBluetooth/CoreBluetooth.h>

static BLESerialManager *manager = nil;

@interface BLESerialManager()<BLEDeviceClassDelegate>
@property (strong)		BLEBaseClass*	BaseClass;
@property (readwrite)	BLEDeviceClass*	Device;
@end

@implementation BLESerialManager
@synthesize delegate;
@synthesize all_buff;

+ (BLESerialManager *) sharedManager{
    if (manager == nil) {
        manager = [[self alloc] init];
    }
    return manager;
}

- (void) initBLE{
    //	BLEBaseClassの初期化
    _BaseClass = [[BLEBaseClass alloc] init];
    //	周りのBLEデバイスからのadvertise情報のスキャンを開始する
    [_BaseClass scanDevices:nil];
    _Device = 0;
    self.all_buff = @"";
}
//------------------------------------------------------------------------------------------
//	readもしくはindicateもしくはnotifyにてキャラクタリスティックの値を読み込んだ時に呼ばれる
//------------------------------------------------------------------------------------------
- (void) didUpdateValueForCharacteristic:(BLEDeviceClass *)device Characteristic:(CBCharacteristic *)characteristic
{
    if (device == _Device)	{
        //	キャラクタリスティックを扱う為のクラスを取得し
        //	通知されたキャラクタリスティックと比較し同じであれば
        //	bufに結果を格納
        //iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        if (characteristic == rx)	{
            //			uint8_t*	buf = (uint8_t*)[characteristic.value bytes]; //bufに結果が入る
            //            NSLog(@"value=%@",characteristic.value);
            return;
        }
        
        //Device->iPhone
        CBCharacteristic*	tx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_TX];
        if (characteristic == tx)	{
            //NSLog(@"Receive value=%@",characteristic.value);
            uint8_t*	buf = (uint8_t*)[characteristic.value bytes]; //bufに結果が入る
            NSString *str = [NSString stringWithUTF8String:(char *)buf];
            str = [(NSString*)str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *substr;
            if (str.length > 0){
                substr = [str substringFromIndex:str.length - 1];
            } else {
                substr = @"a";
            }
            if (str != nil) {
                //self.all_buff = [self.all_buff stringByAppendingString:str];
            } else {
                //self.all_buff = str;
            }
            //NSLog(@"str : %@", str);
            if ([self.delegate respondsToSelector:@selector(onReceiveData:)]) {
                [self.delegate onReceiveData:str];
            }
            /*
            if ([substr isEqualToString:@"b"]) {
                if ([self.delegate respondsToSelector:@selector(onReceiveData:)]) {
                    self.all_buff = [self.all_buff stringByReplacingOccurrencesOfString:@"b" withString:@""];
                    [self.delegate onReceiveData:self.all_buff];
                }
                self.all_buff = @"";
            }
             */
            //NSLog(@"buff : %@", self.all_buff);
            /*
            if ([self.delegate respondsToSelector:@selector(onReceiveData:)]) {
                //self.all_buff = [self.all_buff stringByReplacingOccurrencesOfString:@"#" withString:@""];
                [self.delegate onReceiveData:self.all_buff];
                self.all_buff = @"";
            }
             */
            
            //_textField.text = [NSString stringWithFormat:@"%d", buf[0]];
            //}
            
            return;
        }
        
    }
}

//////////////////////////////////////////////////////////////
//  connect
//////////////////////////////////////////////////////////////
-(void) connect{
    //	UUID_DEMO_SERVICEサービスを持っているデバイスに接続する
    _Device = [_BaseClass connectService:UUID_VSP_SERVICE];
    if (_Device)	{
        //	接続されたのでスキャンを停止する
        [_BaseClass scanStop];
        //	キャラクタリスティックの値を読み込んだときに自身をデリゲートに指定
        _Device.delegate = self;
        
        //[_BaseClass printDevices];
        
        //tx(Device->iPhone)のnotifyをセット
        CBCharacteristic*	tx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_TX];
        if (tx)	{
            //[_Device readRequest:tx];
            [_Device notifyRequest:tx];
        }
    } else {
        NSLog(@"no device");
    }
}

//------------------------------------------------------------------------------------------
//	disconnectボタンを押したとき
//------------------------------------------------------------------------------------------
- (void) disconnect {
    if (_Device)	{
        //	UUID_DEMO_SERVICEサービスを持っているデバイスから切断する
        [_BaseClass disconnectService:UUID_VSP_SERVICE];
        _Device = 0;
        //	周りのBLEデバイスからのadvertise情報のスキャンを開始する
        [_BaseClass scanDevices:nil];
    }
}

- (void) sendChar:(unsigned char)c {
    if (_Device)	{
        //	iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        NSData*	data = [NSData dataWithBytes:&c length:1];
        [_Device writeWithoutResponse:rx value:data];
    }
}

- (void) sendStr:(NSString *)c {
    if (_Device)	{
        //	iPhone->Device
        CBCharacteristic*	rx = [_Device getCharacteristic:UUID_VSP_SERVICE characteristic:UUID_RX];
        NSData *data = [c dataUsingEncoding:NSUTF8StringEncoding];
        [_Device writeWithoutResponse:rx value:data];
    }
}

@end
