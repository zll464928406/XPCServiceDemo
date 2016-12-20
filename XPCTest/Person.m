/*
 传递自定义的类,需要类继承自NSSecureCoding协议
 然后实现下面的三个方法,不过引入AutoCoding.h和AutoCoding.m后会在运行时做相应的操作,如果不引入这两个文件的话就一定需要实现
 */

#import "Person.h"

@implementation Person

/*
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"name"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];

}
 */

#pragma mark - 实现代理的方法,这个是为了使用代理的方式来传递person
- (void)eat
{
    NSLog(@"person is eating!");
}

@end
