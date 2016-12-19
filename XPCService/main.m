//
//  main.m
//  XPCService
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceDelegate.h"


int main(int argc, const char *argv[])
{
    //ServiceDelegate *delegate = [ServiceDelegate new];
    ServiceDelegate *delegate = [ServiceDelegate manager];
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = delegate;
    [listener resume];
    
    return 0;
}
