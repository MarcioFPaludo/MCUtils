//
//  NSDecimalNumber+MCU.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 24/05/19.
//

#import "NSDecimalNumber+MCU.h"

@implementation NSDecimalNumber (MCU)

+ (NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number
{
    return [NSDecimalNumber decimalNumberWithDecimal:number.decimalValue];
}


@end
