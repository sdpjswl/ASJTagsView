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

@property (strong, nonatomic) UIColor *tagColor;
@property (strong, nonatomic) UIColor *tagTextColor;
@property (strong, nonatomic) UIColor *crossColor;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) CGFloat tagSpacing;

@property (copy) TagBlock tapBlock;
@property (copy) TagBlock deleteBlock;

- (void)addTag:(NSString *)tag;
- (void)deleteTag:(NSString *)tag;
- (void)deleteTagAtIndex:(NSInteger)idx;
- (void)reloadTagsView;

- (void)setTapBlock:(TagBlock)tapBlock;
- (void)setDeleteBlock:(TagBlock)deleteBlock;

@end
