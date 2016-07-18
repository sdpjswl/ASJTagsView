//
// ASJTagsView.h
//
// Copyright (c) 2016 Sudeep Jaiswal
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

@class ASJTag;

NS_ASSUME_NONNULL_BEGIN

typedef void (^TagBlock)(NSString *tagText, NSInteger idx);

/**
 *  These are a few predefined color themes you can use instead of the 'tagColor' property. All colors except the default taken from: https://github.com/bennyguitar/Colours
 */
typedef NS_ENUM(NSInteger, TagColorTheme)
{
  TagColorThemeDefault,
  TagColorThemeChartreuse,
  TagColorThemeCoolGray,
  TagColorThemeIndigo,
  TagColorThemePlum,
  TagColorThemeRaspberry,
  TagColorThemeStrawberry
};

@interface ASJTagsView : UIScrollView

/**
 *  Background color of tags.
 */
@property (nullable, strong, nonatomic) IBInspectable UIColor *tagColor;

/**
 *  Text color for tags' strings.
 */
@property (nullable, strong, nonatomic) IBInspectable UIColor *tagTextColor;

/**
 *  Border color for individual tags.
 */
@property (nullable, strong, nonatomic) IBInspectable UIColor *borderColor;

/**
 *  Set a custom image for the delete button.
 */
@property (nullable, strong, nonatomic) IBInspectable UIImage *crossImage;

/**
 *  Font for the tags' text.
 */
@property (nullable, assign, nonatomic) UIFont *tagFont;

/**
 *  Set the border width for individual tags.
 */
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

/**
 *  Round the tags using this property.
 */
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

/**
 *  Sets the spacing between the tags and between tags and the edges.
 */
@property (assign, nonatomic) IBInspectable CGFloat tagSpacing;

/**
 *  A few predefined color themes you can use apart from setting a color of your own. Note that setting the 'tagColor' property will override any theme you have set. 'tagColor' needs to be 'nil' in order for color themes to work.
 */
@property (assign, nonatomic) IBInspectable TagColorTheme tagColorTheme;

/**
 *  A block to handle taps on the tags.
 */
@property (nullable, copy) TagBlock tapBlock;

/**
 *  A block that executes when the "cross" is tapped to delete a tag.
 */
@property (nullable, copy) TagBlock deleteBlock;

/**
 *  Add a tag to the tags view.
 */
- (void)addTag:(NSString *)tag;

/**
 *  Appends multiple tags AFTER any tags already present.
 *
 *  @param tags An array of NSStrings.
 */
- (void)appendTags:(NSArray<NSString *> *)tags;

/**
 *  Replace ALL existing tags on the tags view.
 *
 *  @param tags An array of NSStrings.
 */
- (void)replaceTags:(NSArray<NSString *> *)tags;

/**
 *  Delete all tags matching the given string.
 */
- (void)deleteTag:(NSString *)tag;

/**
 *  Delete the tag at the specified index.
 */
- (void)deleteTagAtIndex:(NSInteger)idx;

/**
 *  Clears the tags view.
 */
- (void)deleteAllTags;

/**
 *  Reload the tags view.
 */
- (void)reloadTagsView;

- (void)setTapBlock:(TagBlock _Nullable)tapBlock;
- (void)setDeleteBlock:(TagBlock _Nullable)deleteBlock;

@end

NS_ASSUME_NONNULL_END
