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

#pragma mark - 设个方法用来坚挺连接,每次app创建一个新的连接就会执行一次,也就是说如果只有一个连接,那么就执行一次
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
