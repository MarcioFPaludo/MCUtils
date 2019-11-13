//
//  NSDictionary+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 26/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (MCU)

- (BOOL)hasKey:(KeyType)key;
- (void)eachKey:(void(^)(KeyType key))handler;
- (void)eachValue:(void(^)(ObjectType value))handler;
- (void)eachKeyWithValue:(void(^)(KeyType key, ObjectType value))handler;


@end

NS_ASSUME_NONNULL_END
