//
//  RouteModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LegModel.h"
#import "OverViewPolyLineModel.h"
#import "BoundModel.h"

@interface RouteModel : NSObject
/**
 BoundModel
 */
@property (nonatomic,strong)BoundModel *bounds;
/**
 版权
 */
@property (nonatomic,strong)NSString    *copyrights;
/**
 legmodel
 */
@property (nonatomic,strong)NSArray     *legs;
/**
 OverViewPolyLineModel
 */
@property (nonatomic,strong)OverViewPolyLineModel* overview_polyline;
/**
 描述
 */
@property (nonatomic,strong)NSString    *summary;
/**
 warnings数组
 */
@property (nonatomic,strong)NSArray     *warnings;
/**
 waypoint_order数组
 */
@property (nonatomic,strong)NSArray     *waypoint_order;
@end
