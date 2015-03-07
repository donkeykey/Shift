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
    GMSMarker *marker[100];
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
    
    [self protMakerAtRandom];
}

- (void) protMakerAtRandom {
    for (int i = 0; i < 20; i++) {
        float weight = 600;
        float randLat = arc4random_uniform(1000000)/(weight*1000000.0) - 1/(weight*2);
        float randLon = arc4random_uniform(1000000)/(weight*1000000.0) - 1/(weight*2);
        // Creates a marker in the center of the map.
        marker[i] = [[GMSMarker alloc] init];
        marker[i].position = CLLocationCoordinate2DMake(MIDLAT + randLat, MIDLON + randLon);
        //marker.title = @"Sydney";
        //marker.snippet = @"Australia";
        marker[i].map = mapView_;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"tap");
    SolidViewController *solidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"solid_view"];
    [self.navigationController showViewController:solidViewController sender:nil];
}

- (BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    SolidViewController *solidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"solid_view"];
    [self.navigationController showViewController:solidViewController sender:nil];
    return true;
}

@end
