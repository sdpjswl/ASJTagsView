//
// ASJTag.m
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

#import "ASJTag.h"

@interface ASJTag ()

@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (readonly, nonatomic) UIImage *defaultCrossImage;
@property (readonly, weak, nonatomic) NSBundle *tagsBundle;

- (IBAction)tagTapped:(UIButton *)sender;
- (IBAction)deleteTapped:(UIButton *)sender;

@end

@implementation ASJTag

- (void)awakeFromNib
{
  self.crossImage = self.defaultCrossImage;
}

- (UIImage *)defaultCrossImage
{
  NSString *resourcesBundlePath = [self.tagsBundle pathForResource:@"Resources" ofType:@"bundle"];
  NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcesBundlePath];
  return [UIImage imageNamed:@"cross" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
}

- (NSBundle *)tagsBundle
{
  return [NSBundle bundleForClass:[self class]];
}

#pragma mark - IBActions

- (IBAction)tagTapped:(UIButton *)sender
{
  if (_tapBlock) {
    _tapBlock(sender.titleLabel.text, self.tag);
  }
}

- (IBAction)deleteTapped:(UIButton *)sender
{
  if (_deleteBlock) {
    _deleteBlock(_tagButton.titleLabel.text, self.tag);
  }
}

#pragma mark - Property setters

- (void)setTagText:(NSString *)tagText
{
  if (!tagText) {
    return;
  }
  _tagText = tagText;
  
  [UIView performWithoutAnimation:^{
    [_tagButton setTitle:tagText forState:UIControlStateNormal];
    [_tagButton layoutIfNeeded];
  }];
}

- (void)setTagTextColor:(UIColor *)tagTextColor
{
  if (!tagTextColor) {
    return;
  }
  _tagTextColor = tagTextColor;
  [_tagButton setTitleColor:tagTextColor forState:UIControlStateNormal];
}

- (void)setCrossImage:(UIImage *)crossImage
{
  if (!crossImage) {
    return;
  }
  _crossImage = crossImage;
  [_deleteButton setImage:crossImage forState:UIControlStateNormal];
}

- (void)setTagFont:(UIFont *)tagFont
{
  if (!tagFont) {
    return;
  }
  _tagFont = tagFont;
  _tagButton.titleLabel.font = tagFont;
}

@end
