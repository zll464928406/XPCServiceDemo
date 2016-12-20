//
//  XPCServiceProtocol.h
//  XPCService
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"


@protocol XPCServiceProtocol

//第一种方式:单向传值,然后反馈信息
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply;

//第二种方式:service主动向app发送信息
- (void)sendToClient:(NSString *)info withReply:(void (^)(NSString *))reply;

//第三种:接收自定义类型的方法
- (void)mytype:(Person *)person withReply:(void(^)(Person *))reply;


//第四种:接收block的传递
- (void)block:(void(^)(NSString *title))block;

//第五种:白名单类型的传递
- (void)whiteList:(NSArray *)array;

//第六种:通过代理传递对象
- (void)protocolPerson:(id <PersonProtocol>)person;

/******************************************以下是测试数据****************************************/
- (void)test:(void (^)(NSString *))reply;

@end


