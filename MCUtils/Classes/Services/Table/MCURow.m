//
//  MCURow.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 31/03/11.
//

#import "MCURow.h"

@interface MCURow ()

@property (nonatomic, strong) MCUSection *section;

@end

@implementation MCURow

- (instancetype)initWithType:(short)type
{
    return [self initWithType:type identifier:nil];
}

- (instancetype)initWithType:(short)type identifier:(NSString *)identifier
{
    return [self initWithType:type identifier:identifier size:CGSizeZero];
}

- (instancetype)initWithType:(short)type identifier:(NSString *)identifier size:(CGSize)size
{
    self = [super init];
    
    if (self)
    {
        _identifier = identifier;
        _size = size;
        _type = type;
    }
    
    return self;
}

@end
