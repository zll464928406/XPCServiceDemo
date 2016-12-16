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
#import "XPCClient.h"


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
    
    self.person = [[Person alloc] init];
    self.person.name = @"kobe-my";

    [self setConnection];
}

#pragma mark 设置连接的代码
- (void)setConnection
{
    
    //XPC Service的方式
    self.connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"cn.personer.XPC"];
    
    //设置响应server端信息的配置
    self.connectionToService.exportedObject = [XPCClient new];
    self.connectionToService.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCClientProtocol)];
    
    //设置远程连接的协议
    self.connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    /*
     设置连接错误的处理代码,创建一个远程对象代理:
        如果 XPC service crash 了，它也会被透明地重启，并且其对应的 connection 也会一直有效。但是如果 XPC service 是在接收消息时 crash 了的话，App 需用重新发送该消息才能接受到对应的响应。这就是为什么要调用remoteObjectProxyWithErrorHandler 方法来设置错误处理函数了。
        这个方法接受一个闭包作为参数，在发生错误的时候被执行。XPC API 保证在错误处理里的闭包或者是消息响应里的闭包之中，只有一个会被执行；如果消息消息响应里的闭包被执行了，那么错误处理的就不会被执行，反之亦然。这样就使得资源清理变得容易了
     */
    _service = [self.connectionToService remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        //这里面是错误处理的代码
    }];
    
    [self.connectionToService resume];
}
#pragma mark - 最简单的进程间通讯的传递,单向传递,app给Service发送消息,service反馈消息给app
- (IBAction)baseBtnClick:(NSButton *)sender
{
    
    [_service upperCaseString:@"hello" withReply:^(NSString *aString) {
        //获取到的反馈
        NSLog(@"Result string was: %@", aString);
    }];
}

#pragma mark - service主动向app发送信息
- (IBAction)mySelfBtnClick:(NSButton *)sender
{
    
    [_service sendToClient:@"kobe" withReply:^(NSString *reply) {
        NSLog(@"-----------%@",reply);
    }];

}

#pragma mark - 传递自定义类型
/*
 传递自定义类型需要做的事情
 1.自定义的类必须继承NSSecureCoding协议
 2.自定义的类需要实现方法
    - (id)initWithCoder:(NSCoder *)aDecoder
        方法中需要使用decodeObjectOfClass: forKey:或者decodeObjectOfClasses: forKey:解档
    + (BOOL)supportsSecureCoding
        需要返回YES
    - (void)encodeWithCoder:(NSCoder *)aCoder
 */
- (IBAction)protocolBtn:(NSButton *)sender
{
    //传递自定义按钮需要在client和service里面添加上自定义的类,即在Bulid phasea--compile sources里面依次添加上
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
