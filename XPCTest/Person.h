

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"



@interface Person : NSObject <PersonProtocol>
//NSSecureCoding
@property (nonatomic,strong) NSString *name;

@end
