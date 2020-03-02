import UIKit

let kXMToastView_fontSize :CGFloat  = 20.0
let kXMToastView_width              = 200
let kMax_ConstrainedSize            = CGSize(width: 200, height:100)

class ToastView: UIView {
    
    private var bgColor  :CGColor?
    private var infoShow :NSString?
    private var fontSize :CGSize?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    private init(frame: CGRect, bgColor: CGColor, info: String) {
        let viewRect = CGRect(x: 0, y: 0, width: frame.size.width*1.2, height: frame.size.height*1.2)
        super.init(frame: viewRect)
        
        self.backgroundColor = UIColor.clear
        self.bgColor = bgColor
        infoShow = info as NSString?
        fontSize = frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setAlpha(0.8)
        self.addRoundRectToPath(context: context!, rect: rect, width: 4.0, height: 4.0)
        context!.setFillColor(bgColor!)
        context!.fillPath()
        
        context!.setAlpha(1.0)
        
        context!.setShadow(offset: CGSize(width: 0, height: -1), blur: 1, color: UIColor.white.cgColor)
        context!.setFillColor(UIColor.black.cgColor)
        let x = (rect.size.width - (fontSize?.width)!) / 2.0
        let y = (rect.size.height - (fontSize?.height)!) / 2.0
        let r = CGRect(x: x, y: y, width: fontSize!.width, height: fontSize!.height)
        let attrs = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: kXMToastView_fontSize),NSAttributedStringKey.baselineOffset:1] as [NSAttributedStringKey : Any]
        infoShow?.draw(with: r, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
    
    //MARK: - public
    class func showInfo(info: String, bgColor color: UIColor,inView view: UIView,vertical height: Float) {
        let h = height < 0 ? 0 : height > 1 ? 1 : height;
        let temInfo :NSString = info as NSString
        let attributes = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: kXMToastView_fontSize)]
        var frame = temInfo.boundingRect(with: kMax_ConstrainedSize, options: .truncatesLastVisibleLine, attributes:attributes , context: nil)
        frame.origin = CGPoint(x: 0, y: 0)
        let alert = ToastView(frame: frame, bgColor: color.cgColor, info: info)
        alert.center = CGPoint(x: view.center.x, y: view.frame.size.height*CGFloat(h))
        alert.alpha = 0;
        view .addSubview(alert)
        UIView.animate(withDuration: 0.4) {
            alert.alpha = 1.0
        }
        alert.perform(#selector(fadeAway), with: nil, afterDelay: 1.5)
        
    }
    
    //MARK: - private
    private func addRoundRectToPath(context: CGContext, rect: CGRect, width: Float, height: Float) {
        if width == 0 || height == 0 {
            context.addRect(rect)
            return
        }
        var fw :CGFloat = 0.0
        var fh :CGFloat = 0.0
        context.saveGState()
        
        context.translateBy(x: rect.minX, y: rect.minY)
        context.scaleBy(x: CGFloat(width), y: CGFloat(height))
        fw = rect.width / CGFloat(width)
        fh = rect.height / CGFloat(height)
        context.move(to: CGPoint(x: fw, y: fh/2))
        context.addArc(tangent1End: CGPoint(x: fw, y:fh), tangent2End: CGPoint(x: fw/2, y:fh), radius: 1)
        context.addArc(tangent1End: CGPoint(x: 0,  y:fh), tangent2End: CGPoint(x: 0,    y:fh/2), radius: 1)
        context.addArc(tangent1End: CGPoint(x: 0,  y:0),  tangent2End: CGPoint(x: fw/2, y:0), radius: 1)
        context.addArc(tangent1End: CGPoint(x: fw, y:0),  tangent2End: CGPoint(x: fw,   y:fh/2), radius: 1)
        context.closePath()
        context.restoreGState()
    }
    
    @objc func fadeAway() {
        UIView.animate(withDuration: 1.5) {
            self.alpha = 0
        }
        self.perform(#selector(removeAway), with: nil, afterDelay: 1.5)
    }
    
    @objc func removeAway() {
        self.removeFromSuperview()
    }
}
