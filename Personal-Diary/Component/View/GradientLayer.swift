//
//  GradientLayer.swift
//  Personal-Diary
//
//  Created by Isaac on 11/20/22.
//

import UIKit

enum GradientDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
    case custom(Int)
}

class GradientLayer: CAGradientLayer {
    private var direction: GradientDirection = .bottomLeftToTopRight

    public init(direction: GradientDirection, colors: [UIColor], cornerRadius: CGFloat = 0, locations: [Double]? = nil) {
        super.init()
        self.direction = direction
        self.needsDisplayOnBoundsChange = true
        self.colors = colors.map { $0.cgColor as Any }
        let (startPoint, endPoint) = UIGradientHelper.getStartAndEndPointsOf(direction)
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.cornerRadius = cornerRadius
        self.locations = locations?.map { NSNumber(value: $0) }
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    public final func clone() -> GradientLayer {
        if let colors = self.colors {
            return GradientLayer(direction: self.direction, colors: colors.map { UIColor(cgColor: ($0 as! CGColor)) }, cornerRadius: self.cornerRadius, locations: self.locations?.map { $0.doubleValue } )
        }
        return GradientLayer(direction: self.direction, colors: [], cornerRadius: self.cornerRadius, locations: self.locations?.map { $0.doubleValue })
    }
}
