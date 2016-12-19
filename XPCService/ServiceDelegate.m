//
//  ServiceDelegate.m
//  XPCTest
//
//  Created by sunny on 16/12/16.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ServiceDelegate.h"

@interface ServiceDelegate ()


@end

@implementation ServiceDelegate

+ (instancetype)manager
{
    static ServiceDelegate *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ServiceDelegate alloc] init];
    });
    return instance;
}


- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
{
    //设置service端接收消息的配置
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    newConnection.exportedObject = [XPCService new];
    [newConnection resume];
    
    
    //设置app端接收消息的配置
    newConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCClientProtocol)];
    _service = [newConnection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        
    }];
    
    
    return YES;
}

@end
