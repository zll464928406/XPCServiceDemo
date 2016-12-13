//
//  Person.m
//  XPCTest
//
//  Created by 张令林 on 2016/12/13.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "Person.h"

@implementation Person

+(BOOL)supportsSecureCoding
{
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self)
    {
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
    }
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
}

@end
