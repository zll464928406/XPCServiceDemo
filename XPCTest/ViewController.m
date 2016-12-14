//
//  ViewController.m
//  XPCTest
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ViewController.h"
#import "XPCServiceProtocol.h"
#import "Person.h"


@interface ViewController ()
{
    id<XPCServiceProtocol> _service;
}

@property (nonatomic,strong) NSXPCConnection *connectionToService;

@property (nonatomic,strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //方式1:XPC Service的方式
    self.connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"cn.personer.XPC"];
    //方式2:Mach Service的方式
//    self.connectionToService = [[NSXPCConnection alloc] initWithMachServiceName:@"cn.personer.XPC" options:0];
    self.connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    _service = [self.connectionToService remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        
    }];
    [self.connectionToService resume];
    
    
    self.person = [[Person alloc] init];
    self.person.name = @"kobe-my";
    
}
//最简单的进程间通讯的传递,单向传递,app给Service发送消息,service反馈消息给app
- (IBAction)baseBtnClick:(NSButton *)sender
{
    
    [[self.connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
        // We have received a response. Update our text field, but do it on the main thread.
        NSLog(@"Result string was: %@", aString);
    }];
}

//
- (IBAction)mySelfBtnClick:(NSButton *)sender
{
    //如果 XPC service crash 了，它也会被透明地重启，并且其对应的 connection 也会一直有效。但是如果 XPC service 是在接收消息时 crash 了的话，App 需用重新发送该消息才能接受到对应的响应。这就是为什么要调用remoteObjectProxyWithErrorHandler 方法来设置错误处理函数了。
    //这个方法接受一个闭包作为参数，在发生错误的时候被执行。XPC API 保证在错误处理里的闭包或者是消息响应里的闭包之中，只有一个会被执行；如果消息消息响应里的闭包被执行了，那么错误处理的就不会被执行，反之亦然。这样就使得资源清理变得容易了
    [self.connectionToService remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        //这里面是错误处理的代码
    }];
    
//    self.connectionToService.remoteObjectInterface = myBurgerInterface;
    
//    NSXPCConnection *connection = [NSXPCConnection alloc] initWithMachServiceName:<#(nonnull NSString *)#> options:(NSXPCConnectionOptions);
    
    [[self.connectionToService remoteObjectProxy] hello:@"kobe"];
    
    
}

- (IBAction)protocolBtn:(NSButton *)sender
{
    
    [_service mytype:self.person withReply:^(Person *person) {
        NSLog(@"%@",person.name);
    }];

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

-(void)dealloc
{
    [self.connectionToService invalidate];
}
@end
