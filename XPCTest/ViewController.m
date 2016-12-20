//
//  ViewController.m
//  XPCTest
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "XPCServiceProtocol.h"
//第一步:引入头文件
#import "ClientManager.h"


@interface ViewController ()
//用于自定义类型
@property (nonatomic,strong) Person *person;
//用于白名单
@property (nonatomic,strong) NSArray *arrary;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.person = [[Person alloc] init];
    self.person.name = @"kobe-my";
    
    Person *person1 = [Person new];
    person1.name = @"person1";
    Person *person2 = [Person new];
    person2.name = @"person2";
    self.arrary = @[person1,person1];
    //如果不想连接断开,可以添加一个定时器一直保持连接
}

#pragma mark - 最简单的进程间通讯的传递,单向传递,app给Service发送消息,service反馈消息给app
- (IBAction)baseBtnClick:(NSButton *)sender
{
    //第二部:设置连接的信息
    /*
    [_service upperCaseString:@"hello" withReply:^(NSString *aString) {
        //获取到的反馈
        NSLog(@"Result string was: %@", aString);
    }];*/
    ClientManager *manager = [ClientManager manager];
    [manager addConnection:@"cn.personer.XPC"];
    [manager.service upperCaseString:@"hello" withReply:^(NSString *aString) {
        NSLog(@"Result string was: %@", aString);
    }];
    
}

#pragma mark - service主动向app发送信息
- (IBAction)mySelfBtnClick:(NSButton *)sender
{
    [[[ClientManager manager] service] sendToClient:@"kobe" withReply:^(NSString *reply) {
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
    [[[ClientManager manager] service] mytype:self.person withReply:^(Person *person) {
        NSLog(@"%@",person.name);
    }];

}


#pragma mark - 传递block的测试
- (IBAction)blockBtnClick:(NSButton *)sender
{
    [[[ClientManager manager] service] block:^(NSString *title) {
        NSLog(@"%@---",title);
    }];
    
}

#pragma mark - 白名单的方法
- (IBAction)whiteListBtnClick:(NSButton *)sender
{
    //添加白名单的操作在接收方的connection处进行设置,本示例中在ServiceDelegate的setWhiteList进行了添加上白名单的操作
    [[[ClientManager manager] service] whiteList:self.arrary];
    
}

#pragma mark - 通过代理传递对象的方法
- (IBAction)protocolBtnClick:(NSButton *)sender
{
    /*
     使用代理传递对象的时候需要做以下操作
     1.对象需要继承某个协议
     2.app端进行传递对象钱的配置
     3.service端进行传递对象前的配置
     */

    //XPC Service
    NSXPCConnection *connection = [[NSXPCConnection alloc] initWithServiceName:@"cn.personer.XPC"];

    //remote protocol:设置service端接收app发送消息的配置
    connection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    
    id<XPCServiceProtocol> service = [connection remoteObjectProxyWithErrorHandler:^(NSError * _Nonnull error) {
        //这里面是错误处理的代码
    }];
    [connection resume];
    
    NSXPCInterface *myServiceInterface = connection.remoteObjectInterface;
    NSXPCInterface *myPersonInterface = [NSXPCInterface interfaceWithProtocol:@protocol(PersonProtocol)];
    [myServiceInterface setInterface: myPersonInterface forSelector: @selector(protocolPerson:) argumentIndex: 0 ofReply: NO];
    
    Person *person = [Person new];
    person.name = @"protocolPerson";
    
    [service protocolPerson:person];
}




#pragma mark - 测试方法
- (IBAction)test:(NSButton *)sender
{
    /*
     1.测试调用的service的方法是否必须是void,经过测试远程方法的返回值必须是void类型
     2.默认远程的方法只能有一个反馈信息的block
     */
    [[[ClientManager manager] service] test:^(NSString *str) {
        
    }];
    
}




- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

-(void)dealloc
{
    
}
@end
