//
//  TagView.m
//  TagsExample
//
//  Created by sudeep on 1/30/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import "ASJTagView.h"

@interface ASJTagView ()

@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)tagTapped:(UIButton *)sender;
- (IBAction)deleteTapped:(UIButton *)sender;

@end

@implementation ASJTagView

- (void)setTagText:(NSString *)tagText
{
  [_tagButton setTitle:tagText forState:UIControlStateNormal];
}

- (IBAction)tagTapped:(UIButton *)sender
{
  if (_tapBlock) {
    _tapBlock(sender.titleLabel.text, self.tag);
  }
}

- (IBAction)deleteTapped:(UIButton *)sender
{
  if (_deleteBlock) {
    _deleteBlock(sender.titleLabel.text, self.tag);
  }
}

#pragma mark - Property setters

- (void)setTagTextColor:(UIColor *)tagTextColor
{
  _tagTextColor = tagTextColor;
  [_tagButton setTitleColor:tagTextColor forState:UIControlStateNormal];
}

- (void)setCrossColor:(UIColor *)crossColor
{
  _crossColor = crossColor;
  [_deleteButton setTitleColor:crossColor forState:UIControlStateNormal];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
  _cornerRadius = cornerRadius;
  self.layer.cornerRadius = cornerRadius;
}

@end
