//
//  BottomSheetViewController.swift
//  ARTISTACK
//
//  Created by 임영준 on 2023/09/14.
//

import UIKit
import FloatingPanel



final class BottomSheetViewController: FloatingPanelController{
    
    
    init(contentViewController: UIViewController){
        
        super.init(delegate: nil)
        
        setupView(contentViewController: contentViewController)
        
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(contentViewController: UIViewController){
        set(contentViewController: contentViewController)
        
        let appearance = SurfaceAppearance().then{
            $0.cornerRadius = 20
            $0.backgroundColor = .white
        }
        
        surfaceView.do {
            $0.grabberHandle.isHidden = false
            $0.grabberHandle.backgroundColor = Color.gray2
            $0.grabberHandleSize = .init(width: 30, height: 3)
            $0.appearance = appearance
        }
        
        backdropView.do {
            $0.dismissalTapGestureRecognizer.isEnabled = true
            let backdropColor = UIColor.black
            $0.backgroundColor = backdropColor
        }
        
        let layout = TouchBlockIntrinsicPanelLayout()
        self.layout = layout

        
        delegate = self
    }
}

extension BottomSheetViewController: FloatingPanelControllerDelegate{
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        let loc = fpc.surfaceLocation
        let minY = fpc.surfaceLocation(for: .full).y
        let maxY = fpc.surfaceLocation(for: .tip).y
        let y =  min(max(loc.y, minY), maxY)
        fpc.surfaceLocation = CGPoint(x: loc.x, y: y)
    }
    
    public func floatingPanelWillEndDragging(_ fpc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        guard velocity.y > 50 else {return}
        dismiss(animated: true)
    }
}

final class TouchBlockIntrinsicPanelLayout: FloatingPanelBottomLayout {
    override var initialState: FloatingPanelState {.full}
    override var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [ .full: FloatingPanelLayoutAnchor(absoluteInset: 380, edge: .bottom, referenceGuide: .safeArea)]
    }
    override func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        0.8
    }
}
