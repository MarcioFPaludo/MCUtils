//
//  MCUNumpadView.h
//  Utils
//
//  Created by Rodolfo Dani on 06/12/13.
//
//

#import <UIKit/UIKit.h>

@interface MCUNumpadView : UIView

@property (nonatomic, assign, getter = isDecimalSeparatorEnabled) BOOL decimalSeparatorEnabled;

- (instancetype)initWithTextField:(UITextField *)textField;

@end
