//
//  XPCClient.m
//  XPCTest
//
//  Created by sunny on 16/12/15.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "XPCClient.h"

@implementation XPCClient

-(void)acceptMessageFromService:(NSString *)message
{
    
    NSLog(@"-------------%@",message);
}


@end
