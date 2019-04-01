//
//  MCUTextView.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 01/04/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCUTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, copy) BOOL(^textViewShouldBeginEditing)(MCUTextView *textView);
@property (nonatomic, copy) BOOL(^textViewShouldEndEditing)(MCUTextView *textView);
@property (nonatomic, copy) void(^textViewDidBeginEditing)(MCUTextView *textView);
@property (nonatomic, copy) void(^textViewDidEndEditing)(MCUTextView *textView);
@property (nonatomic, copy) BOOL(^textViewShouldChangeTextInRangeReplacementText)(MCUTextView *textView, NSRange range, NSString *text);
@property (nonatomic, copy) void(^textViewDidChange)(MCUTextView *textView);
@property (nonatomic, copy) void(^textViewDidChangeSelection)(MCUTextView *textView);

@end

NS_ASSUME_NONNULL_END
