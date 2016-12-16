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


@end


