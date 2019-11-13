//
//  NSArray+MCU.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/03/11.
//

#import "NSArray+MCU.h"

@implementation NSArray (MCU)

- (void)each:(void (^)(id _Nonnull, NSUInteger))handler
{
    for (NSUInteger index = 0; index < self.count; index++)
        handler(self[index], index);
}

#pragma mark - Getters

- (BOOL)isPresent
{
	return self.count > 0;
}

- (BOOL)isEmpty
{
	return ![self isPresent];
}

- (NSArray *)compact
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id object in self)
        if (object != [NSNull null])
            [array addObject:object];
    
    return [NSArray arrayWithArray:array];
}

- (id)findObject:(BOOL (^)(id _Nonnull))handler
{
    id object = nil;
    
    for (id searchObject in self)
    {
        if (handler(searchObject))
        {
            object = searchObject;
            break;
        }
    }
    
    return object;
}

- (NSUInteger)findIndex:(BOOL (^)(id _Nonnull))handler
{
    NSUInteger objIndex = NSNotFound;
    
    for (NSUInteger index = 0; objIndex == NSNotFound && index < self.count; index++)
        if (handler(self[index]))
            objIndex = index;
    
    return objIndex;
}

@end
