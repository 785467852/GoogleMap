//
//  RouteInfoModel.m
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import "RouteInfoModel.h"
#import "GeocodedWayPointModel.h"
#import "RouteModel.h"

@implementation RouteInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"geocoded_waypoints":[GeocodedWayPointModel class],
             @"routes":[RouteModel class]
             };
}
@end
