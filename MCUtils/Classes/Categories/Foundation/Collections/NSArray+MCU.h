//
//  NSArray+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/03/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (MCU)

@property (nonatomic, readonly, getter=isEmpty) BOOL empty;
@property (nonatomic, readonly, getter=isPresent) BOOL present;

- (NSArray<ObjectType> *)compact;
- (nullable ObjectType)findObject:(BOOL(^)(ObjectType object))handler;
- (NSUInteger)findIndex:(BOOL(^)(ObjectType object))handler;
- (void)each:(void(^)(ObjectType object, NSUInteger index))handler;

@end

NS_ASSUME_NONNULL_END
