//
//  ClientListenerDelegate.m
//  XPCTest
//
//  Created by sunny on 16/12/15.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ClientListenerDelegate.h"
#import "XPCClient.h"

@implementation ClientListenerDelegate

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {

    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCClientProtocol)];
    
    XPCClient *exportedObject = [XPCClient new];
    newConnection.exportedObject = exportedObject;
    
    [newConnection resume];
    
    return YES;
}


@end
