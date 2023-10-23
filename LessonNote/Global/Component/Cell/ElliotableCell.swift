//
//  ElliotableCell.swift
//  Elliotable
//
//  Created by TaeinKim on 2019/11/03.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

 class ElliotableCell: UICollectionViewCell {
    
    let textLabel = PaddingLabel()
    var borderLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderLayer.frame = self.bounds
        layer.addSublayer(borderLayer)
        addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

@IBDesignable class PaddingLabel: UILabel {
    private var padding: UIEdgeInsets = UIEdgeInsets.zero
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
