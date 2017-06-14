//
//  RouteInfoModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouteModel.h"

@interface RouteInfoModel : NSObject

/**
 地理编码点数组
 */
@property (nonatomic,strong)NSArray     *geocoded_waypoints;

/**
 路线数组
 */
@property (nonatomic,strong)NSArray     *routes;

/**
 请求状态
 */
@property (nonatomic,strong)NSString    *status;

@end
