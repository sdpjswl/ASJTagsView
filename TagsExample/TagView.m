//
//  TagView.m
//  TagsExample
//
//  Created by sudeep on 1/30/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import "TagView.h"

@interface TagView ()

@property (weak, nonatomic) IBOutlet UIButton *tagButton;

- (IBAction)tagTapped:(UIButton *)sender;
- (IBAction)deleteTapped:(id)sender;

@end

@implementation TagView

- (void)setTagText:(NSString *)tagText
{
  [_tagButton setTitle:tagText forState:UIControlStateNormal];
}

- (IBAction)tagTapped:(UIButton *)sender
{
  if (_tapBlock) {
    _tapBlock(_tagButton.titleLabel.text, self.tag);
  }
}

- (IBAction)deleteTapped:(id)sender
{
  if (_deleteBlock) {
    _deleteBlock(_tagButton.titleLabel.text, self.tag);
  }
}

@end
