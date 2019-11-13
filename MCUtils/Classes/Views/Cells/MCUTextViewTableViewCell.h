//
//  MCUTextViewTableViewCell.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 17/06/19.
//

#import <UIKit/UIKit.h>
#import "MCUTextView.h"

NS_ASSUME_NONNULL_BEGIN

@class MCUTextViewTableViewCell;

@protocol MCUTextViewTableViewCellDelegate <NSObject>

@required
- (void)textViewTableViewCell:(MCUTextViewTableViewCell *)textViewTableViewCell didEndEditingText:(NSString *)text;

@end

@interface MCUTextViewTableViewCell : UITableViewCell

@property (nonatomic, readonly) MCUTextView *textView;
@property (weak) id<MCUTextViewTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
