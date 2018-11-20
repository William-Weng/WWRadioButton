Pod::Spec.new do |s|

  s.name         				= "WWRadioButton"
  s.version      				= "0.1.0"
  s.summary      				= "WWRadioButton is like a html radio button. (一個自訂的單選按鈕)"
  s.homepage     				= "https://github.com/William-Weng/WWRadioButton"
  s.license      				= { :type => "MIT", :file => "LICENSE" }
  s.author             			= { "翁禹斌(William.Weng)" => "linuxice0609@gmail.com" }
  s.platform 					= :ios, "10.0"
  s.ios.vendored_frameworks 	= "WWRadioButton.framework"
  s.source 						= { :git => "https://github.com/William-Weng/WWRadioButton.git", :tag => "#{s.version}" }
  s.frameworks 					= 'UIKit'
  
end
