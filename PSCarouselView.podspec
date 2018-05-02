
Pod::Spec.new do |s|

  s.name         = "PSCarouselView"
  s.version      = "1.6.1"
  s.summary      = "A drop-in carousel view. Most of Apps put it in their first screen."
  s.description  = <<-DESC
                    A drop-in carousel view. Most of Apps put it in their first screen.Ease use and quick compose.
                   DESC
  s.homepage     = "http://shengpan.net/pscarouselview/"
  s.screenshots  = "https://raw.githubusercontent.com/DeveloperPans/PSCarouselView/master/PSCarouselView.gif"
  s.license      = "MIT"
  s.author             = { "Pan" => "developerpans@163.com" }
  s.social_media_url = 'http://shengpan.net'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/DeveloperPans/PSCarouselView.git", :tag => s.version.to_s }
  s.source_files = 'CarouselDemo/PSCarouselView/**/*.{h,m}'
  s.resource_bundle = { 'PSCarouselView' => 'CarouselDemo/PSCarouselView/*.xib' }
  s.frameworks = 'UIKit'
  s.dependency 'SDWebImage'

end
