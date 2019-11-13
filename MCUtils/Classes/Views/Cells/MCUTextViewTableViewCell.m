//
//  MCUTextViewTableViewCell.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 17/06/19.
//

#import "MCUTextViewTableViewCell.h"

@interface MCUTextViewTableViewCell () <UITextViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet MCUTextView *textView;

@end

@implementation MCUTextViewTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _textView.delegate = self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_textView resignFirstResponder];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

#pragma mark - Getters

- (MCUTextView *)textView
{
    return _textView;
}

#pragma mark - Responder

- (BOOL)canBecomeFirstResponder
{
    return _textView.canBecomeFirstResponder;
}

- (BOOL)canResignFirstResponder
{
    return _textView.canResignFirstResponder;
}

- (BOOL)becomeFirstResponder
{
    return _textView.becomeFirstResponder;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return _textView.resignFirstResponder;
}

#pragma mark - TextField
#pragma mark Delegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [_delegate textViewTableViewCell:self didEndEditingText:textView.text];
}

@end
