//
//  ASJTags.m
//  TagsExample
//
//  Created by ABS_MAC02 on 2/1/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import "ASJTags.h"
#import "TagView.h"

@interface ASJTags ()

@property (weak, nonatomic) TagView *tagView;
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
    if (![view isKindOfClass:[TagView class]]) {
      continue;
    }
    [view removeFromSuperview];
  }
}

- (void)addTags
{
  CGFloat padding = 5.0;
  CGFloat x = padding;
  CGFloat y = padding;
  CGFloat containerWidth = self.bounds.size.width;
  
  for (NSString *tag in _tags)
  {
    NSInteger idx = [_tags indexOfObject:tag];
    TagView *tagView = self.tagView;
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
    if (x >= containerWidth - padding)
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
  }
}

- (TagView *)tagView
{
  TagView *tagView = (TagView *)[[NSBundle mainBundle] loadNibNamed:@"TagView" owner:self options:nil][0];
  
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

@end
