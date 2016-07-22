//
//  TestCell.h
//  ASJTagsViewExample
//
//  Created by sudeep on 22/07/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

@interface TestCell : UICollectionViewCell

/**
 *  The tag's text.
 */
@property (nullable, copy, nonatomic) NSString *tagText;

/**
 *  Text color for tags' strings.
 */
@property (nullable, strong, nonatomic) UIColor *tagTextColor;

/**
 *  Set a custom image for the delete button.
 */
@property (nullable, strong, nonatomic) UIImage *crossImage;

/**
 *  Font for the tags' text.
 */
@property (nullable, assign, nonatomic) UIFont *tagFont;

/**
 *  A block to handle taps on the tags.
 */
@property (nullable, copy) TagBlock tapBlock;

/**
 *  A block that executes when the 'cross' is tapped to delete a tag.
 */
@property (nullable, copy) TagBlock deleteBlock;

- (void)setTapBlock:(TagBlock _Nullable)tapBlock;
- (void)setDeleteBlock:(TagBlock _Nullable)deleteBlock;

@end

NS_ASSUME_NONNULL_END
