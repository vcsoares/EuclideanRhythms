import Foundation
import AVFoundation

public struct Rhythm {
    public var sequence : [Int] = []
    public var steps : Int {
        didSet {
            self.generateRhythm()
        }
    }
    public var pulses : Int {
        didSet {
            self.generateRhythm()
        }
    }
    public var rotation : Int {
        didSet {
            self.generateRhythm()
        }
    }
    
    public init(steps : Int, pulses : Int, rotation : Int){
        self.steps = steps
        self.pulses = pulses
        self.rotation = rotation
        self.generateRhythm()
    }
    
    private mutating func generateRhythm() {
        var accumulator = 0
        
        self.sequence.removeAll()
        
        for _ in 0..<steps {
            accumulator += pulses
            if accumulator >= pulses {
                accumulator -= steps
                sequence.append(1)
            } else {
                sequence.append(0)
            }
        }
        
        rotateRhythm(by: self.rotation)
    }
    
    private mutating func rotateRhythm(by positions : Int) {
        guard positions < sequence.count else { return }
        
        self.sequence[0..<positions].reverse()
        self.sequence[positions..<sequence.count].reverse()
        self.sequence[0..<sequence.count].reverse()
    }
}
