
<p>
<a href="https://shengpan.net"><img alt="Logo" width="36px" src="https://www.gravatar.com/avatar/8fb2fa79ab3955307b074b65c3efc992">
</p></a>
<p align="center">
    <img alt="PSCarouselView Logo" src="https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/logo.png">
</p>


# PSCarouselView 

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/cf2dd4cfa809491e9513a69d538157c4)](https://app.codacy.com/app/DeveloperPans/PSCarouselView?utm_source=github.com&utm_medium=referral&utm_content=DeveloperPans/PSCarouselView&utm_campaign=Badge_Grade_Dashboard)

[![Build Status][status]][travis]
[![docs][docs]][CocoaPods]
[![Pod Version][version]][CocoaPods]
[![License][license]][CocoaPods]
[![Platform][platform]][CocoaPods]
![SwiftCompatible][SwiftCompatible]

A drop-in carousel view. Most Applications put it in their first screen. [中文](https://github.com/DeveloperPans/PSCarouselView/blob/master/README_CN.md)

---

### Preview 
![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/PSCarouselView.gif)

#### **Enhancement**

Storyboard inspector supported since version **1.1.0**

![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/Inspector.png)


### Installation with CocoaPods

Specify it in your `podfile`:

```ruby
pod 'PSCarouselView'
```

Then, run the following command:

```bash
$ pod install
```

### Install manually

Clone project, add `PSCarouselView` folder to your project and don't forget check the *copy item if needed* box. 

`SDWebImage` framework **required**. Make sure you had imported `SDWebImage` when install `PSCarouselView` manually. 

### Getting Start

1.Drag a `UICollectionView` into your Storyboard and make sure your constraints has been set.

2.Set `PSCarouselView` as a custom class for this collectionView in Storyboard Inspector.

![custom class](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/customclass.png)

3.Connect `IBOutlet` to Your ViewController.
    
```objc
@interface ViewController ()<PSCarouselDelegate>

@property (weak, nonatomic) IBOutlet PSCarouselView *carouselView;
```

4.Set value for PSCarouselView's `imageURL` property.

5.Implement `PSCarouselDelegate` if you want to make a pageControl.

```objc
- (void)carousel:(PSCarouselView *)carousel didMoveToPage:(NSUInteger)page
{
    self.pageControl.currentPage = page;
}

- (void)carousel:(PSCarouselView *)carousel didTouchPage:(NSUInteger)page
{
    NSLog(@"PSCarouselView did TOUCH No.%ld page",page);
}
```

### API Reference

[shengpan.net](http://doc.shengpan.net/Classes/PSCarouselView.html) or [CocoaPods Doc](http://cocoadocs.org/docsets/PSCarouselView/1.3.0)

For more，download and see the demo。

## LICENSE

[MIT](https://zh.wikipedia.org/wiki/MIT%E8%A8%B1%E5%8F%AF%E8%AD%89)

[CocoaPods]: http://cocoapods.org/pods/PSCarouselView

[travis]: (https://travis-ci.org/DeveloperPans/PSCarouselView)

[docs]: https://img.shields.io/cocoapods/metrics/doc-percent/PSCarouselView.svg

[version]: https://img.shields.io/cocoapods/v/PSCarouselView.svg?style=flat

[status]: https://travis-ci.org/DeveloperPans/PSCarouselView.svg?branch=master

[license]: https://img.shields.io/cocoapods/l/PSCarouselView.svg?style=flat

[platform]: https://img.shields.io/cocoapods/p/PSCarouselView.svg?style=flat

[SwiftCompatible]: https://img.shields.io/badge/Swift-compatible-orange.svg

[blog]: http://shengpan.net


