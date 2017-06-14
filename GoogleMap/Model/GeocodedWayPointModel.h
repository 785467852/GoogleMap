//
//  GeocodedWayPointModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeocodedWayPointModel : NSObject

/**
 地理编码状态
 */
@property (nonatomic,strong)NSString    *geocoder_status;

/**
 placeid
 */
@property (nonatomic,strong)NSString    *place_id;

/**
 地图类型：街道、.....
 */
@property (nonatomic,strong)NSArray     *types;

@end
