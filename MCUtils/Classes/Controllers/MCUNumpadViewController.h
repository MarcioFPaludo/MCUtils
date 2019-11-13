//
//  MCUNumpadViewController.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 06/12/13.
//
//

#import <UIKit/UIKit.h>

@interface MCUNumpadViewController : UIViewController <UIPopoverPresentationControllerDelegate>

#pragma mark - Properties
@property (nonatomic, assign) NSUInteger maximumFractionDigits;
@property (nonatomic, assign) NSUInteger minimumFractionDigits;
@property (nonatomic, strong) NSDecimalNumber *value;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *suffix;
#pragma mark Copy
@property (nonatomic, copy) void (^didCancel)(void);
@property (nonatomic, copy) void (^didChangeValue)(NSDecimalNumber *value);
#pragma mark Flags
@property (nonatomic, assign) BOOL showFractionDigits;

#pragma mark - Methods
#pragma mark Instance
- (instancetype)initWithNumber:(NSNumber *)number;
- (instancetype)initWithDecimalNumber:(NSDecimalNumber *)value;

@end
