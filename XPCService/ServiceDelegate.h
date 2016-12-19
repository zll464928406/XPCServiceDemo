//
//  ServiceDelegate.h
//  XPCTest
//
//  Created by sunny on 16/12/16.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCService.h"
#import "XPCClient.h"

@interface ServiceDelegate : NSObject<NSXPCListenerDelegate>

@property(nonatomic,strong) id<XPCClientProtocol> service;

+ (instancetype)manager;

@end
