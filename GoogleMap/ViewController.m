//
//  ViewController.m
//  GoogleMap
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import "RouteInfoModel.h"
@import GooglePlacePicker;
#import "SearchViewController.h"

@interface ViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate>

/** 定位 */
@property (nonatomic, strong)CLLocationManager *locationManager;
/** 谷歌地图 */
@property (nonatomic, strong) GMSMapView *GoogleMap;
/** 地点选择器 */
@property (nonatomic, strong) GMSPlacesClient *placesClient;
/** 当前的经纬度坐标 */
@property (nonatomic, assign) CLLocationCoordinate2D currentCoor;

/** 点击显示 */
@property (nonatomic, strong)GMSMarker *infoMarker;

/** 自定义位置 */
@property (nonatomic, strong)GMSMarker         *locationMarker;

/**
 路线规划model
 */
@property (nonatomic,strong)RouteInfoModel      *routeInfoModel;

/**
 路线
 */
@property (nonatomic,strong)GMSPolyline *polyline;

/**
 搜索
 */
@property (nonatomic,strong)GMSPlacePicker *placePicker;

/**
 中心点CenterView
 */
@property (nonatomic,strong)UIImageView     *centerView;

/**
 最后一次的location
 */
@property (nonatomic,strong)CLLocation      *lastDragLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"谷歌地图";
    
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    locationManager.distanceFilter = 100;
    [locationManager startUpdatingLocation];
    locationManager.delegate = self;
    self.locationManager=locationManager;
    
    CLLocation *location=locationManager.location;
    //保存最后一次位置
    self.lastDragLocation=location;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:12];
    
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled=YES;
    mapView.indoorEnabled = NO;
    mapView.settings.rotateGestures = NO;
    mapView.settings.tiltGestures = NO;
    mapView.settings.myLocationButton = NO;
    mapView.settings.compassButton = YES;
    mapView.settings.allowScrollGesturesDuringRotateOrZoom=NO;
    mapView.delegate=self;
    self.view = mapView;
    self.GoogleMap=mapView;
    
    
    _centerView = [[UIImageView alloc]init];
    UIImage *image=[UIImage imageNamed:@"location_icon"];
    _centerView.image=image;
    float x=(screenW-image.size.width)/2;
    float y=(screenH-image.size.height)/2-image.size.height/2;
    _centerView.frame=CGRectMake(x, y, image.size.width,image.size.height);
    [self.view addSubview:_centerView];
    
    
    static float add_x=0.01;
    for (int j=0; j<10; j++) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(31.21, 121.56+add_x);
        add_x+=0.01;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 1; i < 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
            [imageArray addObject:image];
        }
        if ([imageView isAnimating]) {
            [imageView stopAnimating];
        }
        imageView.animationImages = imageArray;
        imageView.animationDuration = 0.5 * imageArray.count;
        imageView.animationRepeatCount = 0;
        [imageView startAnimating];
        
        imageView.frame = CGRectMake(0, 0, 36.f, 36.f);
        marker.iconView = imageView;
        marker.title = @"标注";
        marker.map = self.GoogleMap;
    }
    
    static float add_y=0.01;
    for (int j=0; j<10; j++) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(31.21+add_y, 121.56);
        add_y+=0.01;
        marker.icon = [UIImage imageNamed:@"location_icon"];
        marker.title = @"标注";
        marker.map = self.GoogleMap;
    }
    
    UIButton *clearLineBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [clearLineBtn setTitle:@"清除路线" forState:UIControlStateNormal];
    [clearLineBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    clearLineBtn.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.5];
    clearLineBtn.frame=CGRectMake(10, 70, 90, 40);
    clearLineBtn.layer.cornerRadius=20;
    [clearLineBtn addTarget:self action:@selector(clearLine) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearLineBtn];
    
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.5];
    searchBtn.frame=CGRectMake(120, 70, 90, 40);
    searchBtn.layer.cornerRadius=20;
    [searchBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    
    //中心点
    
    self.placesClient = [GMSPlacesClient sharedClient];
}

//清除规划的路线  [self.GoogleMap clear];清除地图上所有的覆盖层
- (void)clearLine {
    self.polyline.map=nil;
}

//搜索
- (void)searchBtn {
    SearchViewController *searchVC=[[SearchViewController alloc]init];
    
    __weak typeof(self) weakSelf=self;
    searchVC.searchResultBlock = ^(GMSPlace *place) {
        
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude);
//
//        marker.icon = [UIImage imageNamed:@""];
//        marker.title = place.name;
//        marker.map = self.GoogleMap;

        dispatch_async(dispatch_get_main_queue(), ^{
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.1f];
            
            GMSCameraPosition *camera =
            [[GMSCameraPosition alloc] initWithTarget:place.coordinate
                                                 zoom:12
                                              bearing:0
                                         viewingAngle:0];
            [weakSelf.GoogleMap animateToCameraPosition:camera];
            [CATransaction commit];
        });
        
    };
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

//请求谷歌返回路线规划数据
- (void)getLineOverlayDataWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation {
    NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false&mode=walking",startLocation.coordinate.latitude,startLocation.coordinate.longitude,endLocation.coordinate.latitude,endLocation.coordinate.longitude];
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    [SVProgressHUD show];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         [SVProgressHUD dismiss];
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         RouteInfoModel *routeInfoModel=[RouteInfoModel mj_objectWithKeyValues:tempDic];
         self.routeInfoModel=routeInfoModel;
         
         [self dreawLineWithRouteInfoModel:routeInfoModel withStartLocation:startLocation withEndLocation:endLocation];
     }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [SVProgressHUD showInfoWithStatus:@"网络异常，请稍后重试"];
     }];
}

- (void)dreawLineWithRouteInfoModel:(RouteInfoModel *)routeInfoModel withStartLocation:(CLLocation *)startLocation withEndLocation:(CLLocation *)endLocation {
    
    RouteModel *routeModel=routeInfoModel.routes[0];
    LegModel *legModel=routeModel.legs[0];
    
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    //添加起点
    [path addLatitude:startLocation.coordinate.latitude longitude:startLocation.coordinate.longitude];
    for (StepModel *stepModel in legModel.steps) {
        [path addLatitude:stepModel.start_location.lat.doubleValue longitude:stepModel.start_location.lng.doubleValue];
        [path addLatitude:stepModel.end_location.lat.doubleValue longitude:stepModel.end_location.lng.doubleValue];
    }
    //添加终点
    [path addLatitude:endLocation.coordinate.latitude longitude:endLocation.coordinate.longitude];
    
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 2.f;
    polyline.geodesic=YES;
    polyline.map = self.GoogleMap;
    self.polyline=polyline;
}

#warning 应用第一次运行，没有获取到定位时，地图不显示，需要处理
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /*
     CLLocation *location=locations.lastObject;
     
     GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
     longitude:location.coordinate.longitude
     zoom:12];
     GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
     mapView.myLocationEnabled=YES;
     mapView.delegate=self;
     self.view = mapView;
     
     [self.locationManager stopUpdatingLocation];
     */
}

#pragma mark -GMSMapViewDelegate
#pragma mark -停止拖动地图时调用
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
    //拖动结束清除所有的覆盖层
//    [mapView clear];
    
    CLLocation *endLocation=[[CLLocation alloc]initWithLatitude:position.target.latitude longitude:position.target.longitude];
    double distance=[self.lastDragLocation distanceFromLocation:endLocation];
    self.lastDragLocation=endLocation;
    
    NSLog(@"distance===%f",distance);//大于2000时再次请求;
}

#pragma mark -点击了地图
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if (self.polyline!=nil) {
        self.polyline.map=nil;
    }
}

#pragma mark -点击了标注
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    
    if (self.polyline!=nil) {
        self.polyline.map=nil;
    }
    
    CLLocationDegrees latitude=marker.position.latitude;
    CLLocationDegrees longitude=marker.position.longitude;
    CLLocation *endLocation=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [self getLineOverlayDataWithStartLocation:self.GoogleMap.myLocation endLocation:endLocation];
    
    return YES;
}

#pragma mark -点击了气泡
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    
    NSLog(@"点击了marker..latitude=%f,longitude=%f",marker.position.latitude,marker.position.longitude);
}

#pragma mark -点击景点点击事件
//- (void)mapView:(GMSMapView *)mapView
//didTapPOIWithPlaceID:(NSString *)placeID
//           name:(NSString *)name
//       location:(CLLocationCoordinate2D)location {
//    self.infoMarker = [GMSMarker markerWithPosition:location];
//    self.infoMarker.snippet = placeID;
//    self.infoMarker.title = name;
//    self.infoMarker.opacity = 0;
//    CGPoint pos = self.infoMarker.infoWindowAnchor;
//    pos.y = 1;
//    self.infoMarker.infoWindowAnchor = pos;
//    self.infoMarker.map = mapView;
//    mapView.selectedMarker = self.infoMarker;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
