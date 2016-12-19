//
//  XPCService.m
//  XPCService
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "XPCService.h"
#import "ServiceDelegate.h"

@implementation XPCService


- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

- (void)sendToClient:(NSString *)info withReply:(void (^)(NSString *))reply
{
    reply(@"service 主动发送给app");
    [[[ServiceDelegate manager] service] acceptMessageFromService:@"111111111111111111"];
    
    
    
}

-(void)mytype:(Person *)person withReply:(void (^)(Person *))reply
{
    reply(person);
}


- (void)block:(void(^)(NSString *title))block
{
    NSString *str = @"block";
    block(str);
}

@end
