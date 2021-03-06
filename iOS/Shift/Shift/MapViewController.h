//
//  MapViewController.h
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController <GMSMapViewDelegate, UINavigationBarDelegate, UISearchBarDelegate> {
}

@end

const float MIDLAT = 35.6656277;
const float MIDLON = 139.730963;
