//
//  TestView.m
//  ASJTagsViewExample
//
//  Created by sudeep on 22/07/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "TestView.h"
#import "TestCell.h"

#pragma mark - UIColor

@interface UIColor (Tags)

+ (UIColor *)asj_defaultColor;
+ (UIColor *)asj_chartreuseColor;
+ (UIColor *)asj_coolGrayColor;
+ (UIColor *)asj_indigoColor;
+ (UIColor *)asj_plumColor;
+ (UIColor *)asj_raspberryColor;
+ (UIColor *)asj_strawberryColor;
+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;

@end

@implementation UIColor (Tags)

+ (UIColor *)asj_defaultColor
{
  return [UIColor colorWithR:60 G:130 B:170];
}

+ (UIColor *)asj_chartreuseColor
{
  return [UIColor colorWithR:69 G:139 B:0];
}

+ (UIColor *)asj_coolGrayColor
{
  return [UIColor colorWithR:118 G:122 B:133];
}

+ (UIColor *)asj_indigoColor
{
  return [UIColor colorWithR:13 G:79 B:139];
}

+ (UIColor *)asj_plumColor
{
  return [UIColor colorWithR:139 G:102 B:139];
}

+ (UIColor *)asj_raspberryColor
{
  return [UIColor colorWithR:135 G:38 B:87];
}

+ (UIColor *)asj_strawberryColor
{
  return [UIColor colorWithR:190 G:38 B:37];
}

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b
{
  return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}

@end

#pragma mark - ASJTagsView

@interface TestView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) ASJTag *tagView;
@property (copy, nonatomic) NSArray *tags;
@property (readonly, copy, nonatomic) NSArray *colors;
@property (readonly, copy, nonatomic) NSString *cellIdentifier;
@property (readonly, weak, nonatomic) NSNotificationCenter *notificationCenter;

- (void)setup;
- (void)setupDefaults;
- (void)setupLayout;
- (void)setupCollectionView;
- (void)listenForOrientationChanges;
- (void)orientationDidChange:(NSNotification *)note;

@end

@implementation TestView

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
  [self setupDefaults];
  [self setupLayout];
  [self setupCollectionView];
  [self listenForOrientationChanges];
}

- (void)setupDefaults
{
  _tags = [[NSArray alloc] init];
  _tagColorTheme = TagColorThemeDefault;
  _tagTextColor = [UIColor whiteColor];
  _tagFont = [UIFont systemFontOfSize:15.0f];
  _cornerRadius = 4.0f;
  _tagSpacing = 8.0f;
}

- (void)setupLayout
{
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.sectionInset = UIEdgeInsetsMake(_tagSpacing, _tagSpacing, _tagSpacing, _tagSpacing);
  layout.minimumInteritemSpacing = _tagSpacing;
  self.collectionViewLayout = layout;
}

- (void)setupCollectionView
{
  UINib *nib = [UINib nibWithNibName:self.cellIdentifier bundle:nil];
  [self registerNib:nib forCellWithReuseIdentifier:self.cellIdentifier];
  
  self.dataSource = self;
  self.delegate = self;
}

#pragma mark - Orientation

- (void)listenForOrientationChanges
{
  [self.notificationCenter addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientationDidChange:(NSNotification *)note
{
  [self reloadTagsView];
}

- (void)dealloc
{
  [self.notificationCenter removeObserver:self];
}

- (NSNotificationCenter *)notificationCenter
{
  return [NSNotificationCenter defaultCenter];
}

#pragma mark - Public

- (void)addTag:(NSString *)tag
{
  if (!tag.length) {
    return;
  }
  
  NSMutableArray *temp = _tags.mutableCopy;
  [temp addObject:tag];
  _tags = [NSArray arrayWithArray:temp];
  [self reloadTagsView];
}

- (void)appendTags:(NSArray<NSString *> *)tags
{
  if (!tags.count) {
    return;
  }
  
  for (id object in tags) {
    NSAssert([object isKindOfClass:[NSString class]], @"Tags must be of type NSString.");
  }
  
  NSMutableArray *temp = _tags.mutableCopy;
  [temp addObjectsFromArray:tags];
  _tags = [NSArray arrayWithArray:temp];
  [self reloadTagsView];
}

- (void)replaceTags:(NSArray<NSString *> *)tags
{
  if (!tags.count) {
    return;
  }
  
  for (id object in tags) {
    NSAssert([object isKindOfClass:[NSString class]], @"Tags must be of type NSString.");
  }
  
  NSMutableArray *temp = _tags.mutableCopy;
  [temp removeAllObjects];
  [temp addObjectsFromArray:tags];
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

- (void)deleteAllTags
{
  _tags = nil;
  [self reloadTagsView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return _tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  TestCell *cell = (TestCell *)[collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
  
  cell.tagText = _tags[indexPath.row];
  cell.layer.borderColor = _borderColor.CGColor;
  cell.layer.borderWidth = _borderWidth;
  cell.layer.cornerRadius = _cornerRadius;
  
  // use the default theme if tag color is not set
  if (!_tagColor) {
    self.tagColorTheme = TagColorThemeDefault;
  }
  
  if (_useRandomColors == NO) {
    cell.backgroundColor = _tagColor;
  }
  else
  {
    NSInteger randomIdx = arc4random() % self.colors.count;
    cell.backgroundColor = self.colors[randomIdx];
  }
  
  cell.tagTextColor = _tagTextColor;
  cell.crossImage = _crossImage;
  cell.tagFont = _tagFont;
  
  [cell setTapBlock:^(NSString *tagText, NSInteger idx)
   {
     if (_tapBlock) {
       _tapBlock(tagText, idx);
     }
   }];
  
  [cell setDeleteBlock:^(NSString *tagText, NSInteger idx)
   {
     if (_deleteBlock) {
       _deleteBlock(tagText, idx);
     }
   }];
  
  [self.collectionViewLayout invalidateLayout];
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  TestCell *cell = (TestCell *)[collectionView cellForItemAtIndexPath:indexPath];
  if (!cell) {
    return CGSizeZero;
  }
  return [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

#pragma mark - Creation

- (void)reloadTagsView
{
  [self reloadData];
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

- (void)setBorderColor:(UIColor *)borderColor
{
  _borderColor = borderColor;
  [self reloadTagsView];
}

- (void)setCrossImage:(UIImage *)crossImage
{
  _crossImage = crossImage;
  [self reloadTagsView];
}

- (void)setTagFont:(UIFont *)tagFont
{
  _tagFont = tagFont;
  [self reloadTagsView];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
  _borderWidth = borderWidth;
  [self reloadTagsView];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
  _cornerRadius = cornerRadius;
  [self reloadTagsView];
}

- (void)setTagSpacing:(CGFloat)tagSpacing
{
  _tagSpacing = tagSpacing;
  [self reloadTagsView];
}

- (void)setTagColorTheme:(TagColorTheme)tagColorTheme
{
  _tagColorTheme = tagColorTheme;
  
  switch (tagColorTheme)
  {
    case TagColorThemeDefault:
      _tagColor = [UIColor asj_defaultColor];
      break;
      
    case TagColorThemeChartreuse:
      _tagColor = [UIColor asj_chartreuseColor];
      break;
      
    case TagColorThemeCoolGray:
      _tagColor = [UIColor asj_coolGrayColor];
      break;
      
    case TagColorThemeIndigo:
      _tagColor = [UIColor asj_indigoColor];
      break;
      
    case TagColorThemePlum:
      _tagColor = [UIColor asj_plumColor];
      break;
      
    case TagColorThemeRaspberry:
      _tagColor = [UIColor asj_raspberryColor];
      break;
      
    case TagColorThemeStrawberry:
      _tagColor = [UIColor asj_strawberryColor];
      break;
      
    default:
      break;
  }
  [self reloadTagsView];
}

#pragma mark - Property getter

- (NSString *)cellIdentifier
{
  return NSStringFromClass([TestCell class]);
}

- (NSArray *)colors
{
  return @[[UIColor asj_defaultColor],
           [UIColor asj_chartreuseColor],
           [UIColor asj_coolGrayColor],
           [UIColor asj_indigoColor],
           [UIColor asj_plumColor],
           [UIColor asj_raspberryColor],
           [UIColor asj_strawberryColor]];
}

@end
