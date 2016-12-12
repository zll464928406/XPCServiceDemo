//
//  XPCService.h
//  XPCService
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCServiceProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XPCService : NSObject <XPCServiceProtocol>
@end
