//
//  ASJTags.m
//  TagsExample
//
//  Created by sudeep on 2/1/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import "ASJTags.h"
#import "ASJTagView.h"

#define kDefaultTagsColor [UIColor colorWithRed:60.0f/255.0 green:130.0f/255.0 blue:170.0f/255.0 alpha:1.0f]

@interface ASJTags ()

@property (weak, nonatomic) ASJTagView *tagView;
@property (copy, nonatomic) NSArray *tags;

- (void)setup;
- (void)empty;
- (void)addTags;

@end

@implementation ASJTags

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setup];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

#pragma mark - Setup

- (void)setup
{
  _tags = [[NSArray alloc] init];
  _tagColor = kDefaultTagsColor;
  _tagTextColor = [UIColor whiteColor];
  _crossColor = [UIColor whiteColor];
  _cornerRadius = 4.0f;
  _tagSpacing = 8.0f;
}

#pragma mark - Public

- (void)addTag:(NSString *)tag
{
  NSMutableArray *temp = _tags.mutableCopy;
  [temp addObject:tag];
  _tags = [NSArray arrayWithArray:temp];
  [self reloadTagsView];
}

- (void)deleteTag:(NSString *)tag
{
  NSMutableArray *temp = _tags.mutableCopy;
  [temp removeObject:tag];
  _tags = [NSArray arrayWithArray:temp];
  [self reloadTagsView];
}

- (void)deleteTagAtIndex:(NSInteger)idx
{
  NSMutableArray *temp = _tags.mutableCopy;
  [temp removeObjectAtIndex:idx];
  _tags = [NSArray arrayWithArray:temp];
  [self reloadTagsView];
}

#pragma mark - Creation

- (void)reloadTagsView
{
  [self empty];
  [self addTags];
}

- (void)empty
{
  for (id view in self.subviews)
  {
    if (![view isKindOfClass:[ASJTagView class]]) {
      continue;
    }
    [view removeFromSuperview];
  }
}

- (void)addTags
{
  __block CGFloat padding = _tagSpacing;
  __block CGFloat x = padding;
  __block CGFloat y = padding;
  __block CGFloat containerWidth = self.bounds.size.width;
  
  [_tags enumerateObjectsUsingBlock:^(NSString *tag, NSUInteger idx, BOOL *stop)
   {
     ASJTagView *tagView = self.tagView;
     tagView.tagText = tag;
     tagView.tag = idx;
     
     CGSize size = [tagView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize
                          withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel
                                verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
     
     CGFloat maxWidth = containerWidth - (2 * padding);
     if (size.width > maxWidth) {
       size = CGSizeMake(maxWidth, size.height);
     }
     
     CGRect rect = tagView.frame;
     rect.origin = CGPointMake(x, y);
     rect.size = size;
     tagView.frame = rect;
     x += (size.width + padding);
     
     if ((x >= containerWidth - padding) && (idx > 0))
     {
       x = padding;
       y += size.height + padding;
       
       CGRect rect = tagView.frame;
       rect.origin = CGPointMake(x, y);
       rect.size = size;
       tagView.frame = rect;
       
       x += (size.width + padding);
     }
     
     [self addSubview:tagView];
     
     // content size
     CGFloat bottom = tagView.frame.origin.y + tagView.frame.size.height + padding;
     self.contentSize = CGSizeMake(containerWidth, bottom);
   }];
}

- (ASJTagView *)tagView
{
  ASJTagView *tagView = (ASJTagView *)[[NSBundle mainBundle] loadNibNamed:@"ASJTagView" owner:self options:nil][0];
  
  tagView.backgroundColor = _tagColor;
  tagView.tagTextColor = _tagTextColor;
  tagView.crossColor = _crossColor;
  tagView.cornerRadius = _cornerRadius;
  
  
  [tagView setTapBlock:^(NSString *tagText, NSInteger idx)
   {
     if (_tapBlock) {
       _tapBlock(tagText, idx);
     }
   }];
  
  [tagView setDeleteBlock:^(NSString *tagText, NSInteger idx)
   {
     if (_deleteBlock) {
       _deleteBlock(tagText, idx);
     }
   }];
  
  return tagView;
}

#pragma mark - Property setters

- (void)setTagColor:(UIColor *)tagColor
{
  _tagColor = tagColor;
  [self reloadTagsView];
}

- (void)setTagTextColor:(UIColor *)tagTextColor
{
  _tagTextColor = tagTextColor;
  [self reloadTagsView];
}

- (void)setCrossColor:(UIColor *)crossColor
{
  _crossColor = crossColor;
  [self reloadTagsView];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
  _cornerRadius = cornerRadius;
  [self reloadTagsView];
}

@end
