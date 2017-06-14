//
//  SearchViewController.h
//  GoogleMap
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GooglePlacePicker;

typedef void(^searchResultBlock)(GMSPlace *place);

@interface SearchViewController : UIViewController

/**
 声明block
 */
@property (nonatomic,copy)searchResultBlock searchResultBlock;

@end
