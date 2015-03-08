//
//  MapViewController.m
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//


#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SolidViewController.h"

@implementation MapViewController {
    GMSMapView *mapView_;
    GMSMarker *marker[400];
}

- (void)viewDidLoad {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:MIDLAT
                                                            longitude:MIDLON
                                                                 zoom:17.8];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    UISearchBar *sb = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 22, 300, 44.0f)];
    sb.showsCancelButton = YES;
    sb.delegate = self;
    sb.placeholder = @"目的地を入力してください";
    sb.backgroundImage = [[UIImage alloc] init];
    [sb setBackgroundColor:[UIColor whiteColor]];
    sb.layer.shadowOpacity = 0.3f;
    sb.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    //[sb sizeToFit];
    for (UIView *subview in sb.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    [self.view addSubview:sb];
    
    //[self protMakerAtRandom];
    
        GMSMarker *my_marker = [[GMSMarker alloc] init];
    my_marker.position = CLLocationCoordinate2DMake(MIDLAT, MIDLON);
    my_marker.icon = [UIImage imageNamed:@"mini_my_position"];
    my_marker.map = mapView_;
 
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(264, 412, 40, 40)];
    btn1.tag = 0;
    UIImage *img = [UIImage imageNamed:@"btn_me"];
    [btn1 setBackgroundImage:img forState:UIControlStateNormal];
    [btn1 addTarget:self
                action:@selector(me_tapped:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(264, 460, 40, 40)];
    img = [UIImage imageNamed:@"btn_all"];
    [btn1 setBackgroundImage:img forState:UIControlStateNormal];
    [btn1 addTarget:self
               action:@selector(all_tapped:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(264, 508, 40, 40)];
    img = [UIImage imageNamed:@"unnameda"];
    [btn1 setBackgroundImage:img forState:UIControlStateNormal];
    btn1.tag = 2;
    [self.view addSubview:btn1];
}


- (void)all_tapped:(id)sender {
    [self protMakerAtRandom];
}


- (void)me_tapped:(id)sender {
    for (int i = 0; i < 400; i++) {
        marker[i].map = nil;
    }
}


- (void) protMakerAtRandom {
   
    for (int i = 0; i < 400; i++) {
        float weight = 100;
        float randLat = arc4random_uniform(1000000)/(weight*1000000.0) - 1/(weight*2);
        float randLon = arc4random_uniform(1000000)/(weight*1000000.0) - 1/(weight*2);
        // Creates a marker in the center of the map.
        marker[i] = [[GMSMarker alloc] init];
        marker[i].position = CLLocationCoordinate2DMake(MIDLAT + randLat, MIDLON + randLon);
        //marker.title = @"Sydney";
        //marker.snippet = @"Australia";
        marker[i].icon = [UIImage imageNamed:@"mini_person1"];
        marker[i].map = mapView_;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"tap");
    SolidViewController *solidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"solid_view"];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 例えば
    transition.type = kCATransitionMoveIn;
    // 例えば
    transition.subtype = kCATransitionFromTop;
    
    // NavigationController のアニメーションを変更する
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    // NavigationController を使って画面遷移する
    [self.navigationController pushViewController:solidViewController animated:NO];

}

- (BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    SolidViewController *solidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"solid_view"];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 例えば
    transition.type = kCATransitionMoveIn;
    // 例えば
    transition.subtype = kCATransitionFromTop;
    
    // NavigationController のアニメーションを変更する
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    // NavigationController を使って画面遷移する
    [self.navigationController pushViewController:solidViewController animated:NO];
    return true;
}



@end
