//
//  NSDictionary+MCU.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 26/11/10.
//

#import "NSDictionary+MCU.h"
#import "NSArray+MCU.h"

@implementation NSDictionary (MCU)

- (BOOL)hasKey:(id)key
{
    return [self.allKeys findObject:^BOOL(id  _Nonnull object) {
        return [object isEqual:key];
    }] != nil;
}

- (void)eachKey:(void (^)(id _Nonnull))handler
{
    for (id key in self)
        handler(key);
}

- (void)eachValue:(void (^)(id _Nonnull))handler
{
    for (id value in self.allValues)
        handler(value);
}

- (void)eachKeyWithValue:(void (^)(id _Nonnull, id _Nonnull))handler
{
    NSArray *keys = self.allKeys, *values = self.allValues;
    
    for (NSInteger i = 0; i < self.count; i++)
        handler(keys[i], values[i]);
}

@end
