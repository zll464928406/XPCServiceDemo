//
//  ViewController.m
//  XPCTest
//
//  Created by 张令林 on 2016/12/12.
//  Copyright © 2016年 personer. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
//第一步:引入头文件
#import "ClientManager.h"


@interface ViewController ()


@property (nonatomic,strong) NSXPCConnection *connectionToService;

@property (nonatomic,strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[Person alloc] init];
    self.person.name = @"kobe-my";
    
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







- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

-(void)dealloc
{
    [self.connectionToService invalidate];
}
@end
