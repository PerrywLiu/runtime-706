//
//  TestUnion.m
//  debug-objc
//
//  Created by LiuPW on 2019/6/29.
//

#import "TestUnion.h"

union U1 {
    int n;
    char s[11];
    double d;
};

union U2{
    int n;
    char s[5];
    double d;
};

@implementation TestUnion

- (NSString *)description
{
    union U1 u1;
    union U2 u2;
    
    u1.d = 10.9;
    u1.n = 20;
    
    NSString *sizeofU = [NSString stringWithFormat:@"sizeof(u1) = %lu---------sizeof(u2)=%lu \n",sizeof(u1),sizeof(u2)];
    NSString *offsetU1 = [NSString stringWithFormat:@"u1各数据地址：u-%p---------u.n%p----------u.s%p------------u.d%p\n",&u1,&u1.n,&u1.s,&u1.d];
    NSString *offsetU2 = [NSString stringWithFormat:@"u2各数据地址：u-%p---------u.n%p----------u.s%p------------u.d%p",&u2,&u2.n,&u2.s,&u2.d];
    
    NSString *valueOfu1 = [NSString stringWithFormat:@"u1.d=%f--------u1.n=%d",u1.d,u1.n];
    
    return [NSString stringWithFormat:@"%@%@%@%@",sizeofU,offsetU1,offsetU2,valueOfu1];
}
@end
