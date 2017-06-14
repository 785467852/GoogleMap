//
//  LocationModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

/**
 纬度
 */
@property (nonatomic,strong)NSString    *lat;
/**
 经度
 */
@property (nonatomic,strong)NSString    *lng;

@end
