//
//  XPCClientProtocol.h
//  XPCTest
//
//  Created by sunny on 16/12/15.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XPCClientProtocol <NSObject>


- (void)acceptMessageFromService:(NSString *)message;


@end
