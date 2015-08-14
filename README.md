# PSCarouselView
扔进你的项目就可以用了！实现了很多app都需要的首页广告轮播功能。

A drop-in carousel view. Most of Apps put it in their first screen.

###效果图 
![image](https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/PSCarouselView.gif)

###开始使用 Getting Start
1. Storyboard拖拽一个`UICollectionView`到你要放轮播的位置，约束好大小
2. Storyboard中将这个`CollectionView`的类设置为`PSCarouselView`
3. 连接`IBOutlet`到`ViewController`
4. 给carouselView的*`imageURL`*赋值。

###注意：
1. 如果你想做个pageControl，请实现代理方法。
2. 控件需要使用SDWebImage，请确保你的工程中导入了SDWebImage。

详情请参阅Demo

For more，download and see in demo。
