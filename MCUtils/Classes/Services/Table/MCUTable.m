//
//  MCUTable.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 31/03/11.
//

#import "MCUTable.h"
#import "NSArray+MCU.h"

@interface MCUSection (Table)

@property (nonatomic, strong) MCUTable *table;

@end

@interface MCUTable ()

@property (nonatomic, strong) NSMutableArray<MCUSection *> *sections;

@end

@implementation MCUTable

- (instancetype)init
{
    self = [super init];
    
    if (self)
        _sections = [[NSMutableArray alloc] init];
    
    return self;
}


+ (instancetype)tableWithRows:(NSArray<MCURow *> *)rows
{
    MCUTable *table = [[MCUTable alloc] init];
    [table addSection:[[MCUSection alloc] initWithRows:rows]];
    
    return table;
}

- (void)addSection:(MCUSection *)section;
{
    [self insertSection:section atIndex:_sections.count];
}

- (void)addSectionWithRow:(MCURow *)row;
{
    [self addSectionWithIdentifier:nil row:row];
}

- (void)addSectionWithIdentifier:(NSString *)identifier row:(MCURow *)row;
{
    [self addSection:[[MCUSection alloc] initWithIdentifier:identifier row:row]];
}

- (void)insertSection:(MCUSection *)section atIndex:(NSUInteger)index;
{
    section.table = self;
    [_sections insertObject:section atIndex:index];
}

#pragma mark - Removing methods

- (MCUSection *)removeSectionAtIndex:(NSUInteger)index;
{
    MCUSection *section = _sections[index];
    [self removeSection:section];
    
    return section;
}

- (void)removeSection:(MCUSection *)section
{
    [_sections removeObject:section];
    section.table = nil;
}

#pragma mark - Getters

- (MCURow *)lastRow
{
    return _sections.lastObject.lastRow;
}

- (MCURow *)rowWithIndexPath:(NSIndexPath *)indexPath;
{
    return _sections[indexPath.section][indexPath.row];
}

- (MCUSection *)sectionAtIndex:(NSUInteger)index;
{
    return [_sections count] > index ? [_sections objectAtIndex:index] : nil;
}

- (NSIndexPath *)indexPathForRow:(MCURow *)row
{
    MCUSection *section = row.section;
    return [NSIndexPath indexPathForRow:[section indexForRow:row] inSection:[self indexOfSection:section]];
}

- (NSIndexPath *)indexPathForFirstRowWithType:(short)type
{
    MCURow *row;
    
    for (MCUSection *section in _sections)
        if ((row = [section firstRowWithType:type]))
            break;
            
    return row ? [self indexPathForRow:row] : nil;
}

- (NSUInteger)indexOfSection:(MCUSection *)section
{
    return [_sections indexOfObject:section];
}

- (NSUInteger)rowsCount
{
    NSUInteger i = 0;
    
    for (MCUSection *section in _sections)
        i += section.rowsCount;
    
    return i;
}

- (NSUInteger)sectionsCount
{
    return _sections.count;
}

#pragma mark - Fast enumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [_sections countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark - Literals

- (MCUSection *)objectAtIndexedSubscript:(NSUInteger)index
{
    return _sections.count > 0 ? _sections[index] : nil;
}

- (MCURow *)objectForKeyedSubscript:(NSIndexPath *)key
{
    return [self rowWithIndexPath:key];
}

- (void)setObject:(MCUSection *)obj atIndexedSubscript:(NSUInteger)index
{
    [_sections removeObjectAtIndex:index];
    
    [self insertSection:obj atIndex:index];
}

@end
