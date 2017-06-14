//
//  RouteModel.m
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import "RouteModel.h"
#import "LegModel.h"

@implementation RouteModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"legs":[LegModel class],@"warnings":[NSString class]};
}
@end
