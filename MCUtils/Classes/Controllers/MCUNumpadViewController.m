//
//  MCUNumpadViewController.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 06/12/13.
//
//

#import "MCUNumpadViewController.h"
#import "MCUNumpadView.h"
#import "NSDecimalNumber+MCU.h"
#import "UIColor+MCU.h"

#define kLineHeight									1
#define kTraitCollectionIsCompact(tc)				(tc.verticalSizeClass == UIUserInterfaceSizeClassCompact || tc.horizontalSizeClass == UIUserInterfaceSizeClassCompact)

@interface MCUNumpadViewController () <UIAdaptivePresentationControllerDelegate>

@property (nonatomic, assign) BOOL isCompact;
@property (nonatomic, weak) MCUNumpadView *numpad;
@property (nonatomic, weak) UILabel *prefixLabel;
@property (nonatomic, weak) UILabel *suffixLabel;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIToolbar *toolbar;
@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIView *keyboardTopLine;
@property (nonatomic, weak) UIView *toolbarBottomLine;

@end

@implementation MCUNumpadViewController

- (instancetype)initWithNumber:(NSNumber *)number
{
    return [self initWithDecimalNumber:NSDecimalNumberWithNumber(number)];
}

- (instancetype)initWithDecimalNumber:(NSDecimalNumber *)value
{
	self = [super init];
	if (self)
	{
		_value = value;
		_minimumFractionDigits = 0;
		_maximumFractionDigits = INT8_MAX;
	}

	return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.modalPresentationCapturesStatusBarAppearance = YES;

	UIView *containerView = [[UIView alloc] init];
	containerView.translatesAutoresizingMaskIntoConstraints = NO;
	containerView.backgroundColor = [UIColor whiteColor];
	_containerView = containerView;

	UIView *keyboardTopLine = [[UIView alloc] init];
	keyboardTopLine.translatesAutoresizingMaskIntoConstraints = NO;
	keyboardTopLine.backgroundColor = UIColorWithRGB(180, 180, 185);
	_keyboardTopLine = keyboardTopLine;

	UIView *toolbarBottomLine = [[UIView alloc] init];
	toolbarBottomLine.translatesAutoresizingMaskIntoConstraints = NO;
	toolbarBottomLine.backgroundColor = UIColorWithRGB(180, 180, 185);
	_toolbarBottomLine = toolbarBottomLine;

	UILabel *prefixLabel = [[UILabel alloc] init];
	prefixLabel.translatesAutoresizingMaskIntoConstraints = NO;
	prefixLabel.textColor = UIColorWithRGB(96, 107, 114);
	prefixLabel.font = [UIFont systemFontOfSize:19];
	prefixLabel.minimumScaleFactor = 0.8;
	prefixLabel.text = _label;
	_prefixLabel = prefixLabel;

	UILabel *suffixLabel = [[UILabel alloc] init];
	suffixLabel.translatesAutoresizingMaskIntoConstraints = NO;
	suffixLabel.textColor = UIColorWithRGB(96, 107, 114);
	suffixLabel.font = [UIFont systemFontOfSize:16];
	suffixLabel.text = _suffix;
	_suffixLabel = suffixLabel;

	NSNumberFormatter *numberFormatter = [self numberFormatter];

	UITextField *textField = [[UITextField alloc] init];
	textField.text = [numberFormatter stringFromNumber:_value];
	textField.translatesAutoresizingMaskIntoConstraints = NO;
	textField.textColor = UIColorWithRGB(96, 107, 114);
	textField.textAlignment = NSTextAlignmentRight;
	textField.font = [UIFont systemFontOfSize:34];
	textField.borderStyle = UITextBorderStyleNone;
	textField.inputView = [[UIView alloc] init];
	textField.adjustsFontSizeToFitWidth = YES;
	textField.minimumFontSize = 30;
	_textField = textField;

	if ([textField respondsToSelector:@selector(inputAssistantItem)])
	{
		UITextInputAssistantItem *assistantItem = [textField inputAssistantItem];
		assistantItem.leadingBarButtonGroups = @[];
		assistantItem.trailingBarButtonGroups = @[];
	}

	MCUNumpadView *numpad = [[MCUNumpadView alloc] initWithTextField:textField];
	numpad.translatesAutoresizingMaskIntoConstraints = NO;
	numpad.decimalSeparatorEnabled = _showFractionDigits;
	_numpad = numpad;

	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
	UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *leftFixedSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	UIBarButtonItem *rightFixedSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	leftFixedSpaceItem.width = rightFixedSpaceItem.width = 8;

	UIToolbar *toolbar = [[UIToolbar alloc] init];
	toolbar.items = @[leftFixedSpaceItem, cancelButton, flexibleSpaceItem, doneButton, rightFixedSpaceItem];
	toolbar.tintColor = [UIStepper appearance].tintColor;
	toolbar.translatesAutoresizingMaskIntoConstraints = NO;
	_toolbar = toolbar;

	[containerView addSubview:numpad];
	[containerView addSubview:toolbar];
	[containerView addSubview:textField];
	[containerView addSubview:prefixLabel];
	[containerView addSubview:suffixLabel];
	[containerView addSubview:keyboardTopLine];
	[containerView addSubview:toolbarBottomLine];
	[self.view addSubview:containerView];

	[self buildConstraints];
}

#pragma mark - Super actions

- (void)done:(id)sender
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];

	if (_didChangeValue)
		_didChangeValue([NSDecimalNumber decimalNumberWithDecimal:[numberFormatter numberFromString:_textField.text].decimalValue]);
}

- (void)cancel:(id)sender
{
	if (_didCancel)
		_didCancel();
}

#pragma mark - Setter

- (void)setMinimumFractionDigits:(NSUInteger)minimumFractionDigits
{
	_minimumFractionDigits = minimumFractionDigits;
	self.showFractionDigits = minimumFractionDigits != 0;
}

#pragma mark - Getter

- (NSNumberFormatter *)numberFormatter
{
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];

	numberFormatter.maximumFractionDigits = _maximumFractionDigits;
	numberFormatter.minimumFractionDigits = _minimumFractionDigits;

	numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

	return numberFormatter;
}

- (CGSize)preferredContentSize
{
	return CGSizeMake(320, _label.length > 0 ? 320 : 297);
}

#pragma mark - Layout

- (void)buildConstraints
{
	[_numpad setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
	[_numpad setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[_numpad setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
	[_numpad setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[_prefixLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_prefixLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
	[_prefixLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_prefixLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
	[_suffixLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
	[_suffixLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
	[_suffixLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
	[_suffixLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
	[_textField setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_textField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
	[_textField setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_textField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
	[_toolbar setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_toolbar setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
	[_toolbar setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
	[_toolbar setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

	NSDictionary *views = @{ @"Numpad" : _numpad, @"KeyboardLine" : _keyboardTopLine, @"Prefix" : _prefixLabel, @"Suffix" : _suffixLabel, @"TextField" : _textField, @"Toolbar" : _toolbar, @"ToolbarLine" : _toolbarBottomLine};
	NSMutableArray *constraints = [[NSMutableArray alloc] init];

	[constraints addObject:[_keyboardTopLine.heightAnchor constraintEqualToConstant:kLineHeight]];
	[constraints addObject:[_toolbarBottomLine.heightAnchor constraintEqualToConstant:kLineHeight]];
	[constraints addObject:[_containerView.topAnchor constraintEqualToAnchor:_toolbar.topAnchor]];
	[constraints addObject:[_numpad.bottomAnchor constraintEqualToAnchor:_containerView.bottomAnchor]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Numpad]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Toolbar]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[Prefix]-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[TextField]-[Suffix]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ToolbarLine]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[KeyboardLine]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[Toolbar][ToolbarLine]-9-[Prefix][TextField]-6-[KeyboardLine][Numpad]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];

	[_containerView addConstraints:constraints];
	[NSLayoutConstraint activateConstraints:constraints];

	views = @{ @"Container" : _containerView};
	constraints = [[NSMutableArray alloc] init];

	[constraints addObject:[_containerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]];
	[constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Container]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];

	[self.view addConstraints:constraints];
	[NSLayoutConstraint activateConstraints:constraints];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

- (UIModalPresentationStyle)modalPresentationStyle
{
	return UIModalPresentationPopover;
}

- (UIModalTransitionStyle)modalTransitionStyle
{
	return UIModalTransitionStyleCoverVertical;
}

- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated
{
	self.view.backgroundColor = [UIColor clearColor];
	if (isAppearing && _isCompact)
	{
		UIView *backgroundView = [[UIView alloc] initWithFrame:self.presentingViewController.view.bounds];
		backgroundView.backgroundColor = UIColorWithPercentScale(0, 40);
		_backgroundView = backgroundView;

		[self.presentingViewController.view addSubview:backgroundView];
	}
}

- (void)endAppearanceTransition
{
	[_backgroundView removeFromSuperview];
	self.view.backgroundColor = UIColorWithPercentScale(0, 40);
}

- (UIPopoverPresentationController *)popoverPresentationController
{
	UIPopoverPresentationController *controller = [super popoverPresentationController];
	controller.delegate = self;
	return controller;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
	_isCompact = kTraitCollectionIsCompact(traitCollection);
	return _isCompact ? UIModalPresentationOverFullScreen : UIModalPresentationPopover;
}

#pragma mark - NavigationController
#pragma mark Delegate

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
	return NO;
}

@end
