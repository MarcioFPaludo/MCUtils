//
//  MCUTextFieldTableViewCell.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 17/06/19.
//

#import "MCUTextFieldTableViewCell.h"

@interface MCUTextFieldTableViewCell () <UITextFieldDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MCUTextFieldTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _textField.delegate = self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_textField resignFirstResponder];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

#pragma mark - Getters

- (UITextField *)textField
{
    return _textField;
}

- (UILabel *)textLabel
{
    return _titleLabel;
}

#pragma mark - Responder

- (BOOL)canBecomeFirstResponder
{
    return _textField.canBecomeFirstResponder;
}

- (BOOL)canResignFirstResponder
{
    return _textField.canResignFirstResponder;
}

- (BOOL)becomeFirstResponder
{
    return _textField.becomeFirstResponder;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [_textField resignFirstResponder];
}

#pragma mark - TextField
#pragma mark Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_delegate textFieldTableViewCell:self didEndEditingText:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
