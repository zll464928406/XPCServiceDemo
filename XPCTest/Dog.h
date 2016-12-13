//
//  Dog.h
//  XPCTest
//
//  Created by 张令林 on 2016/12/14.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EatProtocol.h"

@interface Dog : NSObject <EatProtocol>

@property (nonatomic,strong) NSString *name;


@end
