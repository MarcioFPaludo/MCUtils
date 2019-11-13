//
//  MCUSection.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 31/03/11.
//

#import "MCUSection.h"
#import "NSArray+MCU.h"

@interface MCURow (Section)

@property (nonatomic, strong) MCUSection *section;

@end

@interface MCUSection ()

@property (nonatomic, strong) NSMutableArray<MCURow *> *rows;
@property (nonatomic, strong) MCUTable *table;

@end

@implementation MCUSection

- (instancetype)init
{
    return [self initWithIdentifier:nil rows:nil];
}

- (instancetype)initWithRow:(MCURow *)row
{
    return [self initWithIdentifier:nil row:row];
}

- (instancetype)initWithRows:(NSArray<MCURow *> *)rows
{
    return [self initWithIdentifier:nil rows:rows];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    return [self initWithIdentifier:identifier rows:nil];
}

- (instancetype)initWithIdentifier:(NSString *)identifier size:(CGSize)size
{
    return [self initWithIdentifier:identifier size:size rows:nil];
}

- (instancetype)initWithIdentifier:(NSString *)title row:(MCURow *)row
{
    return [self initWithIdentifier:title rows:@[row]];
}

- (instancetype)initWithIdentifier:(NSString *)identifier rows:(nullable NSArray<MCURow *> *)rows
{
    return [self initWithIdentifier:identifier size:CGSizeZero rows:rows];
}

- (instancetype)initWithIdentifier:(NSString *)identifier size:(CGSize)size rows:(NSArray<MCURow *> *)rows
{
    self = [super init];
    
    if (self)
    {
        _size = size;
        _identifier = identifier;
        self.rows = rows ? [[NSMutableArray<MCURow *> alloc] initWithArray:rows] : [[NSMutableArray<MCURow *> alloc] init];
    }
    
    return self;
}

#pragma mark - Adding

- (void)addRow:(MCURow *)row
{
    [self insertRow:row atIndex:_rows.count];
}

- (void)addRowWithType:(short)type identifier:(NSString *)identifier
{
    MCURow *row = [[MCURow alloc] initWithType:type identifier:identifier];
    [self addRow:row];
}

- (void)addRowWithType:(short)type identifier:(NSString *)identifier size:(CGSize)size
{
    MCURow *row = [[MCURow alloc] initWithType:type identifier:identifier];
    [self addRow:row];
}

- (void)addRowsFromArray:(NSArray<MCURow *> *)array
{
    for (MCURow *row in array)
        [self addRow:row];
}

- (void)insertRow:(MCURow *)row atIndex:(NSUInteger)index
{
    row.section = self;
    [_rows insertObject:row atIndex:index];
}

#pragma mark - Removing

- (MCURow *)removeFirstRowWithType:(short)type
{
    MCURow *row = [self firstRowWithType:type];
    [self removeRow:row];
    
    return row;
}

- (MCURow *)removeRowAtIndex:(NSUInteger)index
{
    MCURow *row = _rows[index];
    [self removeRow:row];
    
    return row;
}

- (void)removeRow:(MCURow *)row
{
    [_rows removeObject:row];
    row.section = nil;
}

#pragma mark - Getters

- (MCURow *)firstRowWithType:(short)rowType
{
    return [_rows findObject:^BOOL(MCURow *row) {
        return row.type == rowType;
    }];
}

- (MCURow *)lastRow
{
    return _rows.lastObject;
}

- (MCURow *)rowAtIndex:(NSUInteger)index
{
    return [_rows count] > index ? [_rows objectAtIndex:index] : nil;
}

- (NSUInteger)indexForRow:(MCURow *)row
{
    return [_rows indexOfObject:row];
}

- (NSUInteger)indexForRowType:(short)type
{
    return [_rows findIndex:^BOOL(MCURow *row) {
        return row.type == type;
    }];
}

- (NSUInteger)rowsCount
{
    return _rows.count;
}

#pragma mark - Setters

- (void)setRows:(NSMutableArray<MCURow *> *)rows
{
    for (MCURow *row in rows)
        row.section = self;
    
    _rows = rows;
}

#pragma mark - Fast enumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [_rows countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark - Literals

- (MCURow *)objectAtIndexedSubscript:(NSUInteger)index
{
    return _rows[index];
}

- (void)setObject:(MCURow *)obj atIndexedSubscript:(NSUInteger)index
{
    [_rows removeObjectAtIndex:index];
    
    [self insertRow:obj atIndex:index];
}

@end
