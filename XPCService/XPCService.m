//
//  XPCService.m
//  XPCService
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "XPCService.h"

@implementation XPCService


- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

- (void)sendToClient:(NSString *)info withReply:(void (^)(NSString *))reply
{
    reply(@"service 主动发送给app");
    
    
    
}

-(void)mytype:(Person *)person withReply:(void (^)(Person *))reply
{
    reply(person);
}


@end
