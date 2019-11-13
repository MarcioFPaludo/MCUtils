//
//  MCUTextFieldTableViewCell.h
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 17/06/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MCUTextFieldTableViewCell;

@protocol MCUTextFieldTableViewCellDelegate <NSObject>

@required
- (void)textFieldTableViewCell:(MCUTextFieldTableViewCell *)textFieldTableViewCell didEndEditingText:(NSString *)text;

@end

@interface MCUTextFieldTableViewCell : UITableViewCell

@property (nonatomic, readonly) UITextField *textField;
@property (weak) id<MCUTextFieldTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
