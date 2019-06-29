//
//  PM_TestObject.h
//  debug-objc
//
//  Created by LiuPW on 2019/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PM_TestObject : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)hello;
@end

NS_ASSUME_NONNULL_END
