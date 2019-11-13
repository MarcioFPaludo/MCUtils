//
//  NSDecimalNumber+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 24/05/19.
//

#import <Foundation/Foundation.h>

#define NSDecimalNumberWithNumber(number)       [NSDecimalNumber decimalNumberWithNumber:(NSNumber *)number]

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (MCU)

+ (NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number;

@end

NS_ASSUME_NONNULL_END
