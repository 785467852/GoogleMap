//
//  StepModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValueTextModel.h"
#import "LocationModel.h"
#import "PointsModel.h"

@interface StepModel : NSObject

/**
 距离
 */
@property (nonatomic,strong)ValueTextModel* distance;
/**
 时间
 */
@property (nonatomic,strong)ValueTextModel* duration;
/**
 终点经纬度
 */
@property (nonatomic,strong)LocationModel*  end_location;

/**
 HTML显示
 */
@property (nonatomic,strong)NSString    *html_instructions;

/**
 polyline
 */
@property (nonatomic,strong)PointsModel*    polyline;
/**
 开始经纬度
 */
@property (nonatomic,strong)LocationModel*  start_location;

/**
 方式：步行-WALKING、骑车、开车-DRIVEING
 */
@property (nonatomic,strong)NSString    *travel_mode;

@end
