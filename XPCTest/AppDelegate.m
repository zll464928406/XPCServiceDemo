//
//  AppDelegate.m
//  XPCTest
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "AppDelegate.h"
#import "XPCServiceProtocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    
    //cn.personer.XPCService
    
    NSXPCInterface *myCookieInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    NSXPCConnection *connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"cn.personer.XPC"];
    connectionToService.remoteObjectInterface = myCookieInterface;
    [connectionToService resume];
    
    
    
    [[connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
        // We have received a response. Update our text field, but do it on the main thread.
        NSLog(@"Result string was: %@", aString);
    }];

    
//    [connectionToService invalidate];
    
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
