//
//  TagView.h
//  TagsExample
//
//  Created by sudeep on 1/30/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

@import UIKit;

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

@interface ASJTagView : UIView

@property (copy, nonatomic) NSString *tagText;
@property (strong, nonatomic) UIColor *tagTextColor;
@property (strong, nonatomic) UIColor *crossColor;
@property (assign, nonatomic) CGFloat cornerRadius;

@property (copy) TagBlock tapBlock;
@property (copy) TagBlock deleteBlock;

- (void)setTapBlock:(TagBlock)tapBlock;
- (void)setDeleteBlock:(TagBlock)deleteBlock;

@end
