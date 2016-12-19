//
//  Person.h
//  XPCTest
//
//  Created by 张令林 on 2016/12/13.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject<NSSecureCoding>

@property (nonatomic,strong) NSString *name;

@end
