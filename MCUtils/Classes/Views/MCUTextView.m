//
//  MCUTextView.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/04/19.
//

#import "MCUTextView.h"

@interface MCUTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation MCUTextView

@dynamic placeholder;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) [self initialize];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) [self initialize];
    
    return self;
}

- (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    
    self.delegate = self;
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    placeHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    placeHolderLabel.backgroundColor = [UIColor clearColor];
    placeHolderLabel.hidden = self.text.length != 0;
    placeHolderLabel.font = self.font;
    [self addSubview:placeHolderLabel];
    
    _placeHolderLabel = placeHolderLabel;
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7-[placeHolderLabel]-7-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(placeHolderLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[placeHolderLabel]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(placeHolderLabel)]];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [_placeHolderLabel setFont:font];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [_placeHolderLabel setText:placeholder];
}

- (NSString *)placeholder
{
    return [_placeHolderLabel text];
}

- (void)textChanged:(NSNotification *)notification
{
    _placeHolderLabel.hidden = self.text.length != 0;
}

@end
