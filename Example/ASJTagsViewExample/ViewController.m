//
//  ViewController.m
//  ASJTagsViewExample
//
//  Created by sudeep on 11/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
//#import "ASJTagsView.h"
#import "TestView.h"

@interface ViewController ()

//@property (weak, nonatomic) IBOutlet ASJTagsView *tagsView;
@property (weak, nonatomic) IBOutlet TestView *testView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

- (void)setup;
- (void)handleTagBlocks;
- (void)showAlertMessage:(NSString *)message;
- (IBAction)addTapped:(id)sender;
- (IBAction)clearAllTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setup];
}

#pragma mark - Setup

- (void)setup
{
  _testView.tagColorTheme = TagColorThemeStrawberry;
  [self handleTagBlocks];
  [_inputTextField becomeFirstResponder];
}

#pragma mark - Tag blocks

- (void)handleTagBlocks
{
  __weak typeof(self) weakSelf = self;
  [_testView setTapBlock:^(NSString *tagText, NSInteger idx)
   {
     NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
     [weakSelf showAlertMessage:message];
   }];
  
  [_testView setDeleteBlock:^(NSString *tagText, NSInteger idx)
   {
     NSString *message = [NSString stringWithFormat:@"You deleted: %@", tagText];
     [weakSelf showAlertMessage:message];
     [weakSelf.testView deleteTagAtIndex:idx];
   }];
}

- (void)showAlertMessage:(NSString *)message
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tap!" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:action];
  
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - IBActions

- (IBAction)addTapped:(id)sender
{
  [_testView addTag:_inputTextField.text];
  _inputTextField.text = nil;
}

- (IBAction)clearAllTapped:(id)sender
{
  [_testView deleteAllTags];
}

@end
