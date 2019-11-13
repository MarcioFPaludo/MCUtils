//
//  MCURow.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 31/03/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define MCURowWith(Type, Identifier, Size)      ([[MCURow alloc] initWithType:Type identifier:Identifier size:Size])
#define MCURowWithIdentifier(Identifier)        ([[MCURow alloc] initWithType:0 identifier:Identifier])
#define MCURowWithoutSize(Type, Identifier)     ([[MCURow alloc] initWithType:Type identifier:Identifier])
#define MCURowWithoutType(Identifier, Size)     ([[MCURow alloc] initWithType:0 identifier:Identifier size:Size])

@class MCUSection, MCUTable;

@interface MCURow : NSObject

@property (nonatomic, nullable, readonly) MCUSection *section;
@property (nonatomic, nullable, readonly) NSString *identifier;
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly) short type;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(short)type;
- (instancetype)initWithType:(short)type identifier:(nullable NSString *)identifier;
- (instancetype)initWithType:(short)type identifier:(nullable NSString *)identifier size:(CGSize)size NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
