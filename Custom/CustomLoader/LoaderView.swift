//
//  LoaderView.swift
//
//
//  Created by Mohd Shams Naqvi
//  
//

import UIKit

class LoaderView: UIView {
    
    @IBOutlet var contentView:UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var noDataLbl: UILabel!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showLoader(view:UIView){
        self.frame = CGRect(x:0,y:0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.center.x = view.center.x
        //self.activityIndicator.color =  UIColor.gymRedColor
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(self)
    }
    
    func hideLoader(view:UIView){
        for loader in view.subviews{
            if loader.isKind(of: LoaderView.self){
                loader.removeFromSuperview()
            }
        }
    }
}

