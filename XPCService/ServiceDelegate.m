//
//  ServiceDelegate.m
//  XPCTest
//
//  Created by sunny on 16/12/16.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ServiceDelegate.h"

@implementation ServiceDelegate


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
    
    //向app发送信息
    [_service acceptMessageFromService:@"nihaoaaaa"];
    
    
    
    return YES;
}

@end
