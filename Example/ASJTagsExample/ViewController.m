//
//  ViewController.m
//  ASJTagsExample
//
//  Created by sudeep on 07/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "ASJTags.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ASJTags *tagsView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (readonly, weak, nonatomic) NSNotificationCenter *notificationCenter;

- (void)setup;
- (void)listenForOrientationChanges;
- (void)orientationDidChange:(NSNotification *)note;
- (void)handleTagBlocks;
- (IBAction)addTapped:(id)sender;
- (void)showAlertMessage:(NSString *)message;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self setup];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup
{
  [self listenForOrientationChanges];
  [self handleTagBlocks];
  [_inputTextField becomeFirstResponder];
}

#pragma mark - Orientation

- (void)listenForOrientationChanges
{
  [self.notificationCenter addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientationDidChange:(NSNotification *)note
{
  [_tagsView reloadTagsView];
}

- (void)dealloc
{
  [self.notificationCenter removeObserver:self];
}

- (NSNotificationCenter *)notificationCenter
{
  return [NSNotificationCenter defaultCenter];
}

#pragma mark - Tag blocks

- (void)handleTagBlocks
{
  __weak typeof(self) weakSelf = self;
  [_tagsView setTapBlock:^(NSString *tagText, NSInteger idx)
   {
     NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
     [weakSelf showAlertMessage:message];
   }];
  
  [_tagsView setDeleteBlock:^(NSString *tagText, NSInteger idx)
   {
     [weakSelf.tagsView deleteTagAtIndex:idx];
   }];
}

- (void)showAlertMessage:(NSString *)message
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tap!" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:action];
  
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - IBAction

- (IBAction)addTapped:(id)sender
{
  NSString *tagText = _inputTextField.text;
  if (!tagText.length) {
    return;
  }
  
  [_tagsView addTag:tagText];
  _inputTextField.text = nil;
}

@end
