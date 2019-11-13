//
//  UIBarButtonItem+MCU.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 07/06/19.
//

#import "UIBarButtonItem+MCU.h"

@implementation UIBarButtonItem (MCU)

+ (instancetype)barTitleItemWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.text = title;
    [titleLabel sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
}

+ (instancetype)barFixedSpaceItemWithWidth:(CGFloat)width
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item.width = width;
    return item;
}

+ (instancetype)barSegmentItemWithItens:(NSArray *)itens target:(nullable id)target action:(nullable SEL)action
{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:itens];
    [segmentControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    [segmentControl sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:segmentControl];
}

@end
