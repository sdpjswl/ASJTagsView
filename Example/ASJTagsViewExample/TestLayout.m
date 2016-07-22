//
//  TestLayout.m
//  ASJTagsViewExample
//
//  Created by ABS_MAC02 on 22/07/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "TestLayout.h"

@interface TestLayout ()

@property (assign, nonatomic) CGSize contentSize;
@property (copy, nonatomic) NSArray *itemAttributes;

@end

@implementation TestLayout

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self setupDefaults];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setupDefaults];
  }
  return self;
}

- (void)setupDefaults
{
   
}

#pragma mark - Overrides

- (void)prepareLayout
{
  [super prepareLayout];
  
  __block CGFloat padding = _itemSpacing;
  __block CGFloat x = padding;
  __block CGFloat y = padding;
  __block CGFloat containerWidth = self.collectionView.bounds.size.width;
  
  NSMutableArray *tempAttributes = [[NSMutableArray alloc] init];
  NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
  for (int i = 0; i < numberOfItems; i++)
  {
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:i inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:idxPath];
    
    CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat maxWidth = containerWidth - (2 * padding);
    if (size.width > maxWidth) {
      size = CGSizeMake(maxWidth, size.height);
    }
    
    CGRect rect = cell.frame;
    rect.origin = CGPointMake(x, y);
    rect.size = size;
    cell.frame = rect;
    x += (size.width + padding);
    
    if ((x >= containerWidth - padding) && (i > 0))
    {
      x = padding;
      y += size.height + padding;
      
      CGRect rect = cell.frame;
      rect.origin = CGPointMake(x, y);
      rect.size = size;
      cell.frame = rect;
      
      x += (size.width + padding);
    }
    
    // create layout attributes objects
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:idxPath];
    attributes.frame = cell.frame;
    [tempAttributes addObject:attributes];
    
    // content size
    CGFloat bottom = cell.frame.origin.y + cell.frame.size.height + padding;
    _contentSize = CGSizeMake(containerWidth, bottom);
    
    _itemAttributes = [NSArray arrayWithArray:tempAttributes];
  }
}

- (CGSize)collectionViewContentSize
{
  return _contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return _itemAttributes[indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
  NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
    return CGRectIntersectsRect(rect, evaluatedObject.frame);
  }];
  
  return [_itemAttributes filteredArrayUsingPredicate:predicate];
}

#pragma mark - Property setters

- (void)setItemSpacing:(CGFloat)itemSpacing
{
  if (_itemSpacing != itemSpacing)
  {
    _itemSpacing = itemSpacing;
    [self invalidateLayout];
  }
}

@end
