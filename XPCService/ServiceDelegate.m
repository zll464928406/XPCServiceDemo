//
//  ServiceDelegate.m
//  XPCTest
//
//  Created by sunny on 16/12/16.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ServiceDelegate.h"
#import "PersonProtocol.h"

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
    
        
    //设置添加白名单和使用代理传递参数的时候使用下面的方法
    [self setWhiteList:newConnection];
    
    
    return YES;
}

#pragma mark 设置白名单
- (void)setWhiteList:(NSXPCConnection *)connection
{
    /*************************设置白名单***********************************/
    NSSet *expectedClasses = [NSSet setWithObjects:[NSArray class],[Person class],nil];
    [connection.exportedInterface setClasses:expectedClasses forSelector:@selector(whiteList:)
                                  argumentIndex:0 //第一个参数
                                        ofReply:NO//在方法本身。
     ];
    
    /*************************使用代理传递参数***********************************/
    NSXPCInterface *myServiceInterface = connection.exportedInterface;
    NSXPCInterface *myPersonInterface = [NSXPCInterface interfaceWithProtocol:@protocol(PersonProtocol)];
    [myServiceInterface setInterface: myPersonInterface forSelector: @selector(protocolPerson:) argumentIndex: 0 ofReply: NO];
}

@end
