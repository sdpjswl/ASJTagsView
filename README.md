# ASJTagsView

`ASJTagsView` is a UI component that lets you create a view full of tags with a delete icon. These are usually used to show search queries. They can be found in apps like Flipkart and Pinterest.

# Installation

CocoaPods is the recommended way to install this library. Add this command to your `Podfile`:

```ruby
pod 'ASJTagsView'
```

# Usage

Setting up is incredibly easy. Simply drop a `UIScrollView` on your storyboard or xib and change the class to `ASJTagsView`.

![alt tag](Images/CustomClass.png)

There are a number of `IBInspectable` properties that you can use to do some quick customizations.

```objc
@property (nullable, strong, nonatomic) IBInspectable UIColor *tagColor;
@property (nullable, strong, nonatomic) IBInspectable UIColor *tagTextColor;
@property (nullable, strong, nonatomic) IBInspectable UIImage *crossImage;
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat tagSpacing;
@property (assign, nonatomic) IBInspectable TagColorTheme tagColorTheme;
```

The 'tagColorTheme' property lets you quickly skin your tags by choosing from a set of predefined themes. All colors except the default have been taken from [Ben Gordon's] (https://github.com/bennyguitar) [Colours](https://github.com/bennyguitar/Colours).

![alt tag](Images/ColorThemes.png)

To create one by code, you will need to import `ASJTagsView.h`. To work with the tags view, you have these options:

```objc
- (void)addTag:(NSString *)tag;
```
Adds a single tag to the tags view.

```objc
- (void)appendTags:(NSArray<NSString *> *)tags;
```
Append an array of `NSString`s to the tag view. They will be added **after** the tags already visible.

```objc
- (void)replaceTags:(NSArray<NSString *> *)tags;
```
Replace all visible tags with new ones.

```objc
- (void)deleteTag:(NSString *)tag;
```
Delete all similarly named tags according to the string provided.

```objc
- (void)deleteTagAtIndex:(NSInteger)idx;
```
Delete tag at the specified array index.

```objc
- (void)deleteAllTags;
```
Empty the tags view.

```objc
- (void)reloadTagsView;
```
Manual reload. Note that whenever you add or remove tags, the view will reload itself.

There are two blocks that you can handle to get certain events:

```objc
- (void)setTapBlock:(TagBlock _Nullable)tapBlock;
```
Called when a tag is tapped. Inside the block, you will receive the tag string and the index at which it is present in the view.

```objc
- (void)setDeleteBlock:(TagBlock _Nullable)deleteBlock;
```
Called when a cross (delete button) is tapped. Inside the block, you will receive the tag string and the index at which it is present in the view.

![alt tag](Images/Screenshot.png)

# Credits

- Cross icon taken from Google [Material Icons](https://design.google.com/icons/#ic_clear).
- All tag color themes except the default taken from [Ben Gordon's] (https://github.com/bennyguitar) [Colours](https://github.com/bennyguitar/Colours).

# To-do

- ~~Add landscape support~~
- ~~Add customisation options for tag view~~
- Add support for adding custom view
- Add option to disable cross
- Add option to show tags of random colors
- Use `UICollectionView` instead of stock `UIScrollView`
- Add option to make tags scroll horizontally

# License

`ASJTagsView` is available under the MIT license. See the LICENSE file for more info.
