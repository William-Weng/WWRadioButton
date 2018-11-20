//
//  WWRadioButton.swift
//  WWRadioButton
//
//  Created by William-Weng on 2018/11/20.
//  Copyright © 2018年 William-Weng. All rights reserved.
//

/// [Swift - 自由調整圖標按鈕中的圖標和文字位置（擴展UIButton）](http://www.hangge.com/blog/cache/detail_960.html)
/// [iOS中UIButton實現各種圖文結合的效果以及原理](https://segmentfault.com/a/1190000004958454)

import UIKit

@IBDesignable open class WWRadioButton: UIButton {
    
    public typealias ButtonsList = [String: [WWRadioButton]?]
    public typealias SelectedButtonList = [String: WWRadioButton?]
    
    typealias SelectedIndexList = [String: Int?]
    typealias EdgeInsetsInfo = (title: UIEdgeInsets, image: UIEdgeInsets)
    
    /* 文字的位置 */
    enum TitlePosition: UInt {
        case none
        case top
        case bottom
        case left
        case right
    }
    
    @IBInspectable public var groupIdentifier: String = String()
    @IBInspectable var selectedImage: UIImage = UIImage()
    @IBInspectable var noneSelectedImage: UIImage = UIImage()
    @IBInspectable var isSelectedStatus: Bool = false
    @IBInspectable var titlePosition: UInt = 0
    
    static public var selectedButtonList: SelectedButtonList = [:]
    static public var groupButtonsList: ButtonsList = [:]
    
    @IBOutlet var groupButtons: [WWRadioButton] = [] {
        didSet { storeGroupButtons(groupButtons, forKey: groupIdentifier) }
    }
    
    public var isTouched: Bool = false {
        willSet { buttonsAction(with: newValue, with: groupIdentifier) }
    }
    
    override open func draw(_ rect: CGRect) {
        
        let image: UIImage = isSelectedStatus ? selectedImage : noneSelectedImage
        let title = titleLabel?.text ?? ""
        let position: TitlePosition = TitlePosition.init(rawValue: titlePosition) ?? .none
        
        buttonSetting(image: image, title: title, titlePosition: position, additionalSpacing: 10.0, state: .normal)
    }
}

// MARK: - 共用的函式
extension WWRadioButton {
    
    /// 清除全部List
    public static func clearButtonsLists() {
        selectedButtonList.removeAll()
        groupButtonsList.removeAll()
    }
    
    /// 清除部分List
    public static func clearButtonsList(with identifier: String) {
        selectedButtonList.removeValue(forKey: identifier)
        groupButtonsList.removeValue(forKey: identifier)
    }
}

extension WWRadioButton {
    
    /// 儲存GroupButtons
    private func storeGroupButtons(_ buttons: [WWRadioButton], forKey identifier: String) {
        
        for button in buttons {
            
            guard let _array = WWRadioButton.groupButtonsList[identifier],
                  var array = _array
            else {
                WWRadioButton.groupButtonsList[identifier] = [button]; return
            }
            
            array.append(button)
            WWRadioButton.groupButtonsList[identifier] = array
        }
    }
    
    /// 選中跟沒選中時的反應 (換圖片)
    private func buttonsAction(with status: Bool, with identifier: String) {
        
        guard status == true,
              let _groupButtons = WWRadioButton.groupButtonsList[identifier],
              let groupButtons = _groupButtons
        else {
            return
        }
        
        for button in groupButtons {
            button.isTouched = false
            button.setImage(noneSelectedImage, for: .normal)
        }
        
        setImage(selectedImage, for: .normal)
        WWRadioButton.selectedButtonList[identifier] = self
    }
}

// MARK: - 小工具
extension WWRadioButton {
    
    /// 按鍵設定
    private func buttonSetting(image anImage: UIImage?, title: String, titlePosition: TitlePosition, additionalSpacing: CGFloat, state: UIControl.State) {
        
        imageView?.contentMode = .center
        titleLabel?.contentMode = .center
        setImage(anImage, for: state)
        setTitle(title, for: state)
        
        (titleEdgeInsets, imageEdgeInsets) = edgeInsetsInfomation(title: title, position: titlePosition, spacing: additionalSpacing)
    }
    
    /// 取得圖文的相對位置 (上 / 下 / 左 / 右)
    private func edgeInsetsInfomation(title: String, position: TitlePosition, spacing: CGFloat) -> EdgeInsetsInfo {
        
        var edgeInsets: EdgeInsetsInfo = (.zero, .zero)
        
        guard let label = titleLabel,
              let titleFont = label.font,
              let titleSize = Optional.some(title.size(withAttributes: [.font: titleFont])),
              let imageSize = Optional.some(imageRect(forContentRect: frame))
        else {
            return edgeInsets
        }
        
        switch (position) {
        case .top: edgeInsets = edgeInsetsForTop(titleSize: titleSize, imageSize: imageSize, spacing: spacing)
        case .bottom: edgeInsets = edgeInsetsForBottom(titleSize: titleSize, imageSize: imageSize, spacing: spacing)
        case .left: edgeInsets = edgeInsetsForLeft(titleSize: titleSize, imageSize: imageSize, spacing: spacing)
        case .right: edgeInsets = edgeInsetsForRight(titleSize: titleSize, imageSize: imageSize, spacing: spacing)
        case .none: break
        }
        
        return edgeInsets
    }
}

// MARK: - 小工具2
extension WWRadioButton {
    
    /// 設定圖文的相對位置(上)
    private func edgeInsetsForTop(titleSize: CGSize, imageSize: CGRect, spacing: CGFloat) -> EdgeInsetsInfo {
        
        let insets = (top: imageSize.height + titleSize.height + spacing, left: imageSize.width, right: titleSize.width)
        var edgeInsets: EdgeInsetsInfo = (.zero, .zero)
        
        edgeInsets.title = UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: 0, right: 0)
        edgeInsets.image = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -insets.right)
        
        return edgeInsets
    }
    
    /// 設定圖文的相對位置(下)
    private func edgeInsetsForBottom(titleSize: CGSize, imageSize: CGRect, spacing: CGFloat) -> EdgeInsetsInfo {
        
        let insets = (top: imageSize.height + titleSize.height + spacing, left: imageSize.width, right: titleSize.width)
        var edgeInsets: EdgeInsetsInfo = (.zero, .zero)
        
        edgeInsets.title = UIEdgeInsets(top: insets.top, left: -insets.left, bottom: 0, right: 0)
        edgeInsets.image = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -insets.right)
        
        return edgeInsets
    }
    
    /// 設定圖文的相對位置(左)
    private func edgeInsetsForLeft(titleSize: CGSize, imageSize: CGRect, spacing: CGFloat) -> EdgeInsetsInfo {
        
        let insets = (left: imageSize.width * 2, right: titleSize.width * 2 + spacing)
        var edgeInsets: EdgeInsetsInfo = (.zero, .zero)
        
        edgeInsets.title = UIEdgeInsets(top: 0, left: -insets.left, bottom: 0, right: 0)
        edgeInsets.image = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -insets.right)
        
        return edgeInsets
    }
    
    /// 設定圖文的相對位置(右)
    private func edgeInsetsForRight(titleSize: CGSize, imageSize: CGRect, spacing: CGFloat) -> EdgeInsetsInfo {
        
        let insets = (left: imageSize.width * 2, right: titleSize.width * 2 + spacing)
        var edgeInsets: EdgeInsetsInfo = (.zero, .zero)
        
        edgeInsets.title = UIEdgeInsets(top: 0, left: -insets.left, bottom: 0, right: 0)
        edgeInsets.image = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -insets.right)
        
        return edgeInsets
    }
}
