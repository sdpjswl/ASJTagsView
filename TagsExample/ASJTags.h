//
//  ASJTags.h
//  TagsExample
//
//  Created by sudeep on 2/1/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagView;

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

@interface ASJTags : UIScrollView

@property (copy) TagBlock tapBlock;
@property (copy) TagBlock deleteBlock;

- (void)addTag:(NSString *)tag;
- (void)deleteTag:(NSString *)tag;
- (void)deleteTagAtIndex:(NSInteger)idx;
- (void)reloadTagsView;

- (void)setTapBlock:(TagBlock)tapBlock;
- (void)setDeleteBlock:(TagBlock)deleteBlock;

@end

#warning add horizontal and vertical support!
#warning add support for adding custom view
#warning add customisation options for tag view
