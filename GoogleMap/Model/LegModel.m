//
//  LegModel.m
//  TestApi
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import "LegModel.h"

@implementation LegModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"steps":[StepModel class]};
}
@end
