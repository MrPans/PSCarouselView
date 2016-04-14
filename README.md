# PSCarouselView (中文在后)

[![Build Status](https://travis-ci.org/DeveloperPans/PSCarouselView.svg?branch=master)](https://travis-ci.org/DeveloperPans/PSCarouselView)
[![Pod Version](https://img.shields.io/cocoapods/v/PSCarouselView.svg?style=flat)](http://cocoapods.org/pods/PSCarouselView)
[![License](https://img.shields.io/cocoapods/l/PSCarouselView.svg?style=flat)](http://cocoapods.org/pods/PSCarouselView) 
[![Platform](https://img.shields.io/cocoapods/p/PSCarouselView.svg?style=flat)](http://cocoapods.org/pods/PSCarouselView)

A drop-in carousel view. Most of Apps put it in their first screen.

---

#### **update**

`enhancement` Storyboard inspector Spported at version `1.1.0`

![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/Inspector.png)
 

### Preview 
![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/PSCarouselView.gif)

### Getting Start

#####`Recommend` Import with Cocoapods
add follow line into your podfile:

    pod 'PSCarouselView'
    
#####Import manually
Download zip and unarchiver.Drag 'PSCarouselView' folder into your project.


### Usage
1. Drag A `UICollectionView` into your Storyboard and make sure your constraints has been settled.
2. Set `PSCarouselView` as a custom class for this collectionView in Storyboard Inspector.
3. connect `IBOutlet` to Your ViewController.
4. set PSCarouselView's `imageURL` property.

###Tips：
1. Implement `PSCarouselViewDelegate` if you want to make a pageControl.
2. `SDWebImage` framework is necessary.Make sure you had imported `SDWebImage` when import `PSCarouselView` manually.if you import with cocoapods,don't worry abount that.

For more，download and see the demo。

===============

# PSCarouselView 
扔进你的项目就可以用了！实现了很多app都需要的首页广告轮播功能。

#### **版本更新**

`enhancement` 从`1.1.0`版本开始，支持故事板直接编辑属性，不用再写那么多初始化代码啦！

![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/Inspector.png)

###预览图 
![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/PSCarouselView.gif)

### 导入库
#####`推荐`使用CocoaPods导入
在你的podfile文件中加入如下一行

    pod 'PSCarouselView'
    
#####下载并手动导入
下载zip，解压并把`PSCarouselView`文件夹以及里面的文件添加到你的工程。


### 使用方法
1. Storyboard拖拽一个`UICollectionView`到你要放轮播的位置，约束好大小
2. Storyboard中将这个`CollectionView`的类设置为`PSCarouselView`
3. 连接`IBOutlet`到`ViewController`
4. 给carouselView的*`imageURL`*赋值。

###注意：
1. 如果你想做个pageControl，请实现代理方法。
2. 控件需要使用SDWebImage，不使用CocoaPods的情况下，请确保你的工程中导入了SDWebImage。

详情请参阅Demo

