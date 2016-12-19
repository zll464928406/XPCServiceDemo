//
//  ClientManager.h
//  XPCTest
//
//  Created by sunny on 16/12/19.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCClient.h"
#import "XPCServiceProtocol.h"

@interface ClientManager : NSObject

@property (nonatomic,strong) NSXPCConnection *connectionToService;
@property (nonatomic,strong) id<XPCServiceProtocol> service;;

+ (instancetype)manager;
- (void)addConnection:(NSString *)serviceName;

@end
