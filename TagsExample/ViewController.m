//
//  ViewController.m
//  TagsExample
//
//  Created by ABS_MAC02 on 1/30/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "ASJTags.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ASJTags *tagsView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) NSNotificationCenter *notificationCenter;

- (void)setup;
- (void)listenForOrientationChanges;
- (void)handleTagBlocks;
- (IBAction)addTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self setup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup
{
  [self listenForOrientationChanges];
  [self handleTagBlocks];
}

#pragma mark - Orientation

- (void)listenForOrientationChanges
{
  [self.notificationCenter addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note)
   {
     [_tagsView reloadTagsView];
   }];
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
  [_tagsView setTapBlock:^(NSString *tagText, NSInteger idx)
   {
     NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tap!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alert show];
   }];
  
  [_tagsView setDeleteBlock:^(NSString *tagText, NSInteger idx)
  {
    [_tagsView deleteTagAtIndex:idx];
  }];
}

#pragma mark - IBAction

- (IBAction)addTapped:(id)sender
{
  NSString *tagText = _inputTextField.text;
  [_tagsView addTag:tagText];
}

@end
