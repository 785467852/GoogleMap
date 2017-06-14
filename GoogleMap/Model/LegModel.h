//
//  LegModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"
#import "ValueTextModel.h"
#import "StepModel.h"

@interface LegModel : NSObject

/**
 距离
 */
@property (nonatomic,strong)ValueTextModel* distance;

/**
 时间
 */
@property (nonatomic,strong)ValueTextModel* duration;

/**
 终点地址
 */
@property (nonatomic,strong)NSString    *end_address;
/**
 终点经纬度
 */
@property (nonatomic,strong)LocationModel*  end_location;
/**
 开始地址
 */
@property (nonatomic,strong)NSString    *start_address;
/**
 开始经纬度
 */
@property (nonatomic,strong)LocationModel*  start_location;
/**
 warnings数组
 */
@property (nonatomic,strong)NSArray     *steps;
/**
 traffic_speed_entry数组
 */
@property (nonatomic,strong)NSArray     *traffic_speed_entry;

/**
 via_waypoint数组
 */
@property (nonatomic,strong)NSArray     *via_waypoint;
@end
