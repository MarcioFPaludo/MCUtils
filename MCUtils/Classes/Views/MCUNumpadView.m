//
//  MCUNumpadView.m
//  Utils
//
//  Created by Rodolfo Dani on 06/12/13.
//
//

#import <AudioToolbox/AudioToolbox.h>
#import "MCUBundleManager.h"
#import "MCUNumpadView.h"
#import "UIColor+MCU.h"

#define kButtonMinimumWidth					106
#define kButtonMinimumHeight				48
#define kButtonSpacing						1
#define kButtonFontSize						22

@interface MCUNumpadView ()

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *buttonLeft;

@end

@implementation MCUNumpadView

- (instancetype)initWithTextField:(UITextField *)textField
{
	self = [super init];
	if (self)
	{
		_textField = textField;
		[self initialize];
	}
	
	return self;
}

- (void)initialize
{
	[self setBackgroundColor:UIColorWithRGB(180, 180, 185)];

	UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonLeft addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
	[buttonLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	buttonLeft.titleLabel.font = [UIFont systemFontOfSize:kButtonFontSize];
	buttonLeft.backgroundColor = UIColorWithPercentScale(86, 100);
	buttonLeft.translatesAutoresizingMaskIntoConstraints = NO;
	[buttonLeft setEnabled:NO];
	
	_buttonLeft = buttonLeft;
	
    NSBundle *bundle = MCUBundleManager.bundle;
    UIImage *image = [UIImage imageNamed:@"Backspace" inBundle:bundle compatibleWithTraitCollection:nil];
	UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonRight addTarget:self action:@selector(deleteNumber:) forControlEvents:UIControlEventTouchUpInside];
    buttonRight.backgroundColor = UIColorWithPercentScale(86, 1);
    [buttonRight setImage:image  forState:UIControlStateNormal];
    buttonRight.translatesAutoresizingMaskIntoConstraints = NO;

	[self addSubview:buttonLeft];
	[self addSubview:buttonRight];

	NSMutableDictionary *views = [[NSMutableDictionary alloc] initWithCapacity:12];
	[views setObject:buttonRight forKey:@"ButtonRight"];
	[views setObject:buttonLeft forKey:@"ButtonLeft"];

	NSMutableArray *constraints = [[NSMutableArray alloc] init];
	[constraints addObject:[buttonRight.heightAnchor constraintGreaterThanOrEqualToConstant:kButtonMinimumHeight]];
	[constraints addObject:[buttonLeft.heightAnchor constraintGreaterThanOrEqualToConstant:kButtonMinimumHeight]];
	[constraints addObject:[buttonRight.widthAnchor constraintGreaterThanOrEqualToConstant:kButtonMinimumWidth]];
	[constraints addObject:[buttonLeft.widthAnchor constraintGreaterThanOrEqualToConstant:kButtonMinimumWidth]];

	for (int i = 0; i <= 9; i++)
	{
		UIButton *button = [self buttonWithTitle:[NSString stringWithFormat:@"%d", i]];
		[constraints addObject:[button.heightAnchor constraintGreaterThanOrEqualToConstant:kButtonMinimumHeight]];
		[constraints addObject:[button.widthAnchor constraintGreaterThanOrEqualToConstant:kButtonMinimumWidth]];
		[views setObject:button forKey:[NSString stringWithFormat:@"Button%d", i]];
		[self addSubview:button];
	}

	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Button1]-1-[Button2]-1-[Button3]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Button4]-1-[Button5]-1-[Button6]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Button7]-1-[Button8]-1-[Button9]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ButtonLeft]-1-[Button0]-1-[ButtonRight]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Button2]-1-[Button5]-1-[Button8]-1-[Button0]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Button1]-1-[Button4]-1-[Button7]-1-[ButtonLeft]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[Button3]-1-[Button6]-1-[Button9]-1-[ButtonRight]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];

	[self addConstraints:constraints];
	[NSLayoutConstraint activateConstraints:constraints];
}

- (CGSize)intrinsicContentSize
{
	return CGSizeMake((kButtonMinimumWidth * 3) + (kButtonSpacing * 2), (kButtonMinimumHeight * 4) + (kButtonSpacing * 3));
}

- (UIButton *)buttonWithTitle:(NSString *)title
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.titleLabel.font = [UIFont systemFontOfSize:kButtonFontSize];
	button.backgroundColor = UIColorWithPercentScale(98, 100);
	button.translatesAutoresizingMaskIntoConstraints = NO;
	[button setTitle:title forState:UIControlStateNormal];

	return button;
}

- (void)setDecimalSeparatorEnabled:(BOOL)decimalSeparatorEnabled
{
	_decimalSeparatorEnabled = decimalSeparatorEnabled;
	
	[_buttonLeft setEnabled:decimalSeparatorEnabled];
	[_buttonLeft setTitle:decimalSeparatorEnabled ? [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator] : nil forState:UIControlStateNormal];
}

- (void)deleteNumber:(id)sender
{
	if (![_textField isFirstResponder])
	{
		[_textField setText:nil];
		[_textField becomeFirstResponder];
	}
	
    NSInteger offset = [_textField offsetFromPosition:_textField.beginningOfDocument toPosition:_textField.selectedTextRange.end];
    
	if (offset > 0)
		_textField.text = [_textField.text stringByReplacingCharactersInRange:(NSRange){offset - 1, 1} withString:@""];
	
	if (offset <= _textField.text.length)
	{
		UITextPosition *newPosition = [_textField positionFromPosition:_textField.beginningOfDocument offset:offset - 1];
		UITextRange *newRange = [_textField textRangeFromPosition:newPosition toPosition:newPosition];
		
		_textField.selectedTextRange = newRange;
	}
	
	[_textField sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)write:(id)sender
{
	if (![_textField isFirstResponder])
	{
		[_textField setText:nil];
		[_textField becomeFirstResponder];
	}
	
	NSString *text = [sender titleLabel].text;
    NSInteger offset = [_textField offsetFromPosition:_textField.beginningOfDocument toPosition:_textField.selectedTextRange.end];
    
	_textField.text = [_textField.text stringByReplacingCharactersInRange:(NSRange){offset, 0} withString:text];
	
	if (offset < _textField.text.length - 1)
	{
		UITextPosition *newPosition = [_textField positionFromPosition:_textField.beginningOfDocument offset:offset + 1];
		UITextRange *newRange = [_textField textRangeFromPosition:newPosition toPosition:newPosition];
		
		_textField.selectedTextRange = newRange;
	}
	
    AudioServicesPlaySystemSound(0x450);
    
	[_textField sendActionsForControlEvents:UIControlEventEditingChanged];
}

@end
