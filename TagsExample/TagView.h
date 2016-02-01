//
//  TagView.h
//  TagsExample
//
//  Created by ABS_MAC02 on 1/30/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagView;

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

@interface TagView : UIView

@property (copy, nonatomic) NSString *tagText;
@property (copy) TagBlock tapBlock;
@property (copy) TagBlock deleteBlock;

- (void)setTapBlock:(TagBlock)tapBlock;
- (void)setDeleteBlock:(TagBlock)deleteBlock;

@end
