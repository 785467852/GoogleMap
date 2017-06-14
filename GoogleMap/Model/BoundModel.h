//
//  BoundModel.h
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"

@interface BoundModel : NSObject
/**
 东北
 */
@property (nonatomic,strong)LocationModel*  northeast;
/**
 西南
 */
@property (nonatomic,strong)LocationModel*  southwest;
@end
