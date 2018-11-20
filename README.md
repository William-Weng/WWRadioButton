# WWRadioButton
一個自訂的單選按鈕 (上傳至Cocoapods)

[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/) [![Version](https://img.shields.io/cocoapods/v/WWRadioButton.svg?style=flat)](http://cocoapods.org/pods/WWRadioButton) [![Platform](https://img.shields.io/cocoapods/p/WWRadioButton.svg?style=flat)](http://cocoapods.org/pods/WWRadioButton) [![License](https://img.shields.io/cocoapods/l/WWRadioButton.svg?style=flat)](http://cocoapods.org/pods/WWRadioButton)

![一個自訂的單選按鈕 (上傳至Cocoapods)](https://raw.githubusercontent.com/William-Weng/WWRadioButton/master/WWRadioButton.gif)

# 使用範例
![IBOutlet](https://raw.githubusercontent.com/William-Weng/WWRadioButton/master/IBOutlet.gif)
![IBOutlet](https://raw.githubusercontent.com/William-Weng/WWRadioButton/master/IBOutlet.png)

```swift
import UIKit
import WWRadioButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showButton(_ sender: WWRadioButton) {
        
        sender.isTouched = true
        
        guard let selectedButton = WWRadioButton.selectedButtonList[sender.groupIdentifier],
              let nowSelectedButton = selectedButton
        else {
            return
        }
        
        print(nowSelectedButton.tag)
    }
}
```