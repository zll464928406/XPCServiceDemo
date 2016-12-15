//
//  XPCServiceProtocol.h
//  XPCService
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol XPCServiceProtocol

//第一种方式,单向传值,然后反馈信息
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply;

//第二种方式,通过设置代理的方式
- (void)hello:(NSString *)name;

//接收自定义类型的方法
- (void)mytype:(Person *)person withReply:(void(^)(Person *))reply;


@end

/*
 To use the service from an application or other process, use NSXPCConnection to establish a connection to the service by doing something like this:

     _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"cn.personer.XPCService"];
     _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
     [_connectionToService resume];

Once you have a connection to the service, you can use it like this:

     [[_connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
         // We have received a response. Update our text field, but do it on the main thread.
         NSLog(@"Result string was: %@", aString);
     }];

 And, when you are finished with the service, clean up the connection like this:

     [_connectionToService invalidate];
*/
