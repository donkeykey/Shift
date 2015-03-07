//
//  MapViewController.m
//  Shift
//
//  Created by 川島 大地 on 2015/03/07.
//  Copyright (c) 2015年 川島 大地. All rights reserved.
//

/*
#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"MapViewController");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

*/

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SolidViewController.h"

@implementation MapViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.6656277
                                                            longitude:139.730963
                                                                 zoom:18];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(35.6656277, 139.730963);
    //marker.title = @"Sydney";
    //marker.snippet = @"Australia";
    marker.map = mapView_;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"tap");
    SolidViewController *solidViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"solid_view"];
    [self.navigationController showViewController:solidViewController sender:nil];
    //[self presentViewController:solidViewController animated:YES completion:nil];
}

@end
