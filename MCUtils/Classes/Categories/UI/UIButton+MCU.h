//
//  UIButton+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/06/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MCU)

@property (nonatomic) NSString *normalStateTitle;
@property (nonatomic) NSString *selectedStateTitle;
@property (nonatomic) UIColor *normalStateTitleColor;
@property (nonatomic) UIColor *selectedStateTitleColor;
@property (nonatomic) UIImage *normalStateImage;
@property (nonatomic) UIImage *selectedStateImage;

@end

NS_ASSUME_NONNULL_END
