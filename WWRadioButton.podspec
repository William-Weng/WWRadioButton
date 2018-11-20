Pod::Spec.new do |s|

  s.name         				= "WWSegmentControl"
  s.version      				= "0.2.0"
  s.summary      				= "WWSegmentControl is a like UISegmentedControl's view with jelly animation. (一個自訂有QQ動畫的SegmentControl)"
  s.homepage     				= "https://github.com/William-Weng/WWSegmentControl"
  s.license      				= { :type => "MIT", :file => "LICENSE" }
  s.author             			= { "翁禹斌(William.Weng)" => "linuxice0609@gmail.com" }
  s.platform 					= :ios, "10.0"
  s.ios.vendored_frameworks 	= "WWSegmentControl.framework"
  s.source 						= { :git => "https://github.com/William-Weng/WWSegmentControl.git", :tag => "#{s.version}" }
  s.frameworks 					= 'UIKit'
  
end
