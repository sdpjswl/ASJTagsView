//
//  ASJTags.h
//  TagsExample
//
//  Created by sudeep on 2/1/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

@import UIKit;

@class ASJTagView;

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

@interface ASJTags : UIScrollView

/**
 *  Background color of tags.
 */
@property (strong, nonatomic) UIColor *tagColor;

/**
 *  Text color for tags' strings.
 */
@property (strong, nonatomic) UIColor *tagTextColor;

/**
 *  Text color for the cross (delete button).
 */
@property (strong, nonatomic) UIColor *crossColor;

/**
 *  Round the tags using this property.
 */
@property (assign, nonatomic) CGFloat cornerRadius;

/**
 *  Sets the spacing between the tags and between tags and the edges.
 */
@property (assign, nonatomic) CGFloat tagSpacing;

@property (copy) TagBlock tapBlock;
@property (copy) TagBlock deleteBlock;

/**
 *  Add a tag to the tags view.
 */
- (void)addTag:(NSString *)tag;

/**
 *  Delete all tags matching the given string.
 */
- (void)deleteTag:(NSString *)tag;

/**
 *  Delete the tag at the specified index.
 */
- (void)deleteTagAtIndex:(NSInteger)idx;

/**
 *  Reload the tags view.
 */
- (void)reloadTagsView;

- (void)setTapBlock:(TagBlock)tapBlock;
- (void)setDeleteBlock:(TagBlock)deleteBlock;

@end
