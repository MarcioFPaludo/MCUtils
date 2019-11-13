//
//  MCUSection.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 31/03/11.
//

#import "MCURow.h"

NS_ASSUME_NONNULL_BEGIN

@class MCUTable;

@interface MCUSection : NSObject <NSFastEnumeration>

@property (nonatomic, nullable, readonly) MCUTable *table;
@property (nonatomic, nullable, readonly) NSString *identifier;
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly) NSUInteger rowsCount;

- (instancetype)initWithRow:(MCURow *)row;
- (instancetype)initWithRows:(NSArray<MCURow *> *)rows;
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(nullable NSString *)identifier size:(CGSize)size;
- (instancetype)initWithIdentifier:(nullable NSString *)identifier row:(MCURow *)row;
- (instancetype)initWithIdentifier:(nullable NSString *)identifier rows:(nullable NSArray<MCURow *> *)rows;
- (instancetype)initWithIdentifier:(nullable NSString *)identifier size:(CGSize)size rows:(nullable NSArray<MCURow *> *)rows NS_DESIGNATED_INITIALIZER;

- (MCURow *)firstRowWithType:(short)rowType;
- (MCURow *)lastRow;
- (MCURow *)removeFirstRowWithType:(short)row;
- (MCURow *)removeRowAtIndex:(NSUInteger)index;
- (MCURow *)rowAtIndex:(NSUInteger)index;
- (NSUInteger)indexForRow:(MCURow *)row;
- (NSUInteger)indexForRowType:(short)type;
- (void)addRow:(MCURow *)row;
- (void)addRowWithType:(short)type identifier:(nullable NSString *)identifier;
- (void)addRowWithType:(short)type identifier:(nullable NSString *)identifier size:(CGSize)size;
- (void)addRowsFromArray:(NSArray<MCURow *> *)array;
- (void)insertRow:(MCURow *)row atIndex:(NSUInteger)index;
- (void)removeRow:(MCURow *)row;

- (MCURow *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(MCURow *)obj atIndexedSubscript:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
