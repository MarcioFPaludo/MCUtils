//
//  UIBarButtonItem+MCU.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 07/06/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UIBarAddItem(Target, Action)                        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:Target action:Action]
#define UIBarButtonItemPlainStyle(Title, Target, Action)    [[UIBarButtonItem alloc] initWithTitle:Title style:UIBarButtonItemStylePlain target:Target action:Action]
#define UIBarFixedSpace(Width)                              [UIBarButtonItem barFixedSpaceItemWithWidth:Width]
#define UIBarFlexibleSpace                                  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]
#define UIBarSystemItem(SystemItem, Target, Action)         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:SystemItem target:Target action:Action]
#define UIBarImageButtonItem(Image, Target, Action)         [[UIBarButtonItem alloc] initWithImage:Image style:UIBarButtonItemStyleDone target:Target action:Action]
#define UIBarSegmentItem(Itens, Target, Action)             [UIBarButtonItem barSegmentItemWithItens:Itens target:Target action:Action]
#define UIBarTitleItem(Title)                               [UIBarButtonItem barTitleItemWithTitle:Title]

@interface UIBarButtonItem (MCU)

+ (instancetype)barFixedSpaceItemWithWidth:(CGFloat)width;
+ (instancetype)barTitleItemWithTitle:(NSString *)title;
+ (instancetype)barSegmentItemWithItens:(NSArray *)itens target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
