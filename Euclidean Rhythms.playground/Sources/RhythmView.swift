import Foundation
import UIKit

public class RhythmView : UIView {
    public var rhythm : Rhythm? {
        didSet {
            self.path.removeAllPoints()
            self.draw(self.rect)
        }
    }
    public var rect : CGRect!
    public var path: UIBezierPath!
    
    private func drawSlice(_ rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) -> UIBezierPath {
        let center = CGPoint(x: rect.origin.x + (rect.width/2), y: rect.origin.y + (rect.height/2))
        let radius = min(rect.width, rect.height)/2
        let startAngle = (startPercent/100) * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)/2
        let endAngle = (endPercent/100) * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)/2
        
        let path = UIBezierPath()
        
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius-2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        path.lineWidth = 4
        path.stroke()
        color.setFill()
        path.fill()
        
        return path
    }
    
    public func renderRhythm() {
        let circle = UIBezierPath()
        
        guard let rhythm = self.rhythm else { return }
        for i in 0..<rhythm.steps {
            let startPercent = Double(i) * 100/Double(rhythm.steps)
            let endPercent = Double(i+1) * 100/Double(rhythm.steps)
            if rhythm.sequence[i] == 1 {
                circle.append(drawSlice(self.rect, startPercent: CGFloat(startPercent), endPercent: CGFloat(endPercent), color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
            } else {
                circle.append(drawSlice(self.rect, startPercent: CGFloat(startPercent), endPercent: CGFloat(endPercent), color: UIColor.white))
            }
        }
        
        let innerCircle = UIBezierPath()
        innerCircle.append(drawSlice(self.rect.insetBy(dx: 20, dy: 20), startPercent: 0, endPercent: 100, color: UIColor.white))
        
        circle.append(innerCircle.reversing())
        
        self.path = circle
        self.setNeedsDisplay()
    }
    
    public init(rhythm: Rhythm, frame: CGRect) {
        self.rhythm = rhythm
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.rhythm = nil
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        self.rect = rect
        self.renderRhythm()
    }
}

