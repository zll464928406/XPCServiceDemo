//
//  ClientManager.m
//  XPCTest
//
//  Created by sunny on 16/12/19.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ClientManager.h"


@implementation ClientManager

+ (instancetype)manager
{
    static ClientManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ClientManager alloc] init];
    });
    
    if (!instance.connectionToService)
    {
        [instance addConnection:@"cn.personer.XPC"];
    }
    return instance;
}


- (void)addConnection:(NSString *)serviceName
{
    //XPC Service
    self.connectionToService = [[NSXPCConnection alloc] initWithServiceName:serviceName];
    
    //app protocol:设置app端接收service发送过来消息的配置
    self.connectionToService.exportedObject = [XPCClient new];
    self.connectionToService.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCClientProtocol)];
    
    //remote protocol:设置service端接收app发送消息的配置
    self.connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    
    /*
     设置连接错误的处理代码,创建一个远程对象代理:
     如果 XPC service crash 了，它也会被透明地重启，并且其对应的 connection 也会一直有效。但是如果 XPC service 是在接收消息时 crash 了的话，App 需用重新发送该消息才能接受到对应的响应。这就是为什么要调用remoteObjectProxyWithErrorHandler 方法来设置错误处理函数了。
     这个方法接受一个闭包作为参数，在发生错误的时候被执行。XPC API 保证在错误处理里的闭包或者是消息响应里的闭包之中，只有一个会被执行；如果消息消息响应里的闭包被执行了，那么错误处理的就不会被执行，反之亦然。这样就使得资源清理变得容易了
     */
    _service = [self.connectionToService remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        //这里面是错误处理的代码
    }];
    
    [self.connectionToService resume];
}


@end
