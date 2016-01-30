//
//  ViewController.m
//  TagsExample
//
//  Created by ABS_MAC02 on 1/30/16.
//  Copyright (c) 2016 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "TagView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *tagsScrollView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) TagView *tagView;
@property (copy, nonatomic) NSArray *tags;

- (void)setup;
- (IBAction)addTapped:(id)sender;
- (void)reloadTagsView;

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
  _tags = [[NSArray alloc] init];
}

- (IBAction)addTapped:(id)sender
{
  NSMutableArray *temp = _tags.mutableCopy;
  [temp addObject:_inputTextField.text];
  _tags = [NSArray arrayWithArray:temp];
  [self reloadTagsView];
}

#pragma mark - Tags view

- (void)reloadTagsView
{
  CGFloat padding = 5.0;
  CGFloat x = padding;
  CGFloat y = padding;
  CGFloat containerWidth = _tagsScrollView.bounds.size.width;
  
  for (NSString *tag in _tags)
  {
    TagView *tagView = self.tagView;
    tagView.taglabel.text = tag;
    CGSize size = [tagView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize
                         withHorizontalFittingPriority:UILayoutPriorityDefaultHigh
                               verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
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
    [_tagsScrollView addSubview:tagView];
  }
}

- (TagView *)tagView
{
  return (TagView *)[[NSBundle mainBundle] loadNibNamed:@"TagView" owner:self options:nil][0];
}

@end
