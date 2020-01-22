//
//  MCUTable.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 31/03/11.
//

#import "MCUSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCUTable : NSObject <NSFastEnumeration>

@property (nonatomic, readonly) NSUInteger rowsCount;
@property (nonatomic, readonly) NSUInteger sectionsCount;

+ (instancetype)tableWithRows:(NSArray<MCURow *> *)rows;

- (MCURow *)lastRow;
- (MCURow *)rowWithIndexPath:(NSIndexPath *)indexPath;
- (MCUSection *)removeSectionAtIndex:(NSUInteger)index;
- (void)removeSection:(MCUSection *)section;
- (MCUSection *)sectionAtIndex:(NSUInteger)index;
- (NSIndexPath *)indexPathForRow:(MCURow *)row;
- (NSIndexPath *)indexPathForFirstRowWithType:(short)type;
- (NSUInteger)indexOfSection:(MCUSection *)section;
- (void)addSection:(MCUSection *)section;
- (void)addSectionWithRow:(MCURow *)row;
- (void)addSectionWithIdentifier:(nullable NSString *)identifier row:(MCURow *)row;
- (void)insertSection:(MCUSection *)section atIndex:(NSUInteger)index;

- (MCUSection *)objectAtIndexedSubscript:(NSUInteger)index;
- (MCURow *)objectForKeyedSubscript:(NSIndexPath *)key;
- (void)setObject:(MCUSection *)obj atIndexedSubscript:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
