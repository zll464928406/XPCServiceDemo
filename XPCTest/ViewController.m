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
#import "EatProtocol.h"
#import "Dog.h"

@interface ViewController ()

@property (nonatomic,strong) NSXPCConnection *connectionToService;

@property (nonatomic,strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"cn.personer.XPC"];
    [self.connectionToService resume];
    
    
    self.person = [[Person alloc] init];
    self.person.name = @"kobe-my";
    
}
//传递基本的数据类型
- (IBAction)baseBtnClick:(NSButton *)sender
{
    NSXPCInterface *myCookieInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    self.connectionToService.remoteObjectInterface = myCookieInterface;
    
    
    [[self.connectionToService remoteObjectProxy] upperCaseString:@"hello" withReply:^(NSString *aString) {
        // We have received a response. Update our text field, but do it on the main thread.
        NSLog(@"Result string was: %@", aString);
    }];
}
//传递自定义的数据类型
- (IBAction)mySelfBtnClick:(NSButton *)sender
{
    NSXPCInterface *myBurgerInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    // Create a set containing the allowed
    // classes.
    NSSet *expectedClasses = [NSSet setWithObjects:[Person class], [NSArray class], nil];
    
    [myBurgerInterface setClasses: expectedClasses forSelector: @selector(myType:withReply:)
     argumentIndex: 0  // the first parameter
     ofReply: NO // in the method itself.
     ];
    
    self.connectionToService.remoteObjectInterface = myBurgerInterface;
    
    
    
    [[self.connectionToService remoteObjectProxy] myType:@[self.person,self.person] withReply:^(NSString *reply) {
        NSLog(@"%@",reply);
    }];
    
    
}

- (IBAction)protocolBtn:(NSButton *)sender
{
    NSXPCInterface *myFeedingInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];
    
    // Create an interface object that describes
    // the protocol for the object you want to
    // pass by proxy.
    NSXPCInterface *myCookieInterface = [NSXPCInterface interfaceWithProtocol:@protocol(EatProtocol)];
    
    // Create an object of a class that
    // conforms to the FeedMeACookie protocol
    Dog *dog = [Dog new];
    
    [myFeedingInterface
     setInterface: myCookieInterface
     forSelector: @selector(feedSomeone:)
     argumentIndex: 0  // the first parameter of
     ofReply: NO // the feedSomeone: method
     ];
    
    self.connectionToService.remoteObjectInterface = myFeedingInterface;
    
    [[self.connectionToService remoteObjectProxy] feedSomeone:dog];
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
