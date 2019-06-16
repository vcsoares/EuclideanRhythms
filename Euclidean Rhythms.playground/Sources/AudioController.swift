import Foundation
import AVFoundation

public class AudioController {
    public enum State {
        case stopped
        case playing
    }
    
    public var rhythm : Rhythm! {
        didSet {
            self.playhead = 0
            self.calculateTimeInterval()
        }
    }
    public var bpm : Int {
        didSet {
            self.calculateTimeInterval()
        }
    }
    public var player : AVAudioPlayer?
    public var timeInterval : Double
    public var state : State {
        didSet {
            if self.state == .playing {
                self.play()
            } else if self.state == .stopped {
                self.stop()
            }
        }
    }
    public var playhead : Int
    private var timer : Timer = Timer()
    
    public init(rhythm: Rhythm, bpm: Int, sound: String) {
        self.rhythm = rhythm
        self.bpm = bpm
        self.playhead = 0
        self.timeInterval = 60/Double(bpm) * 4/Double(self.rhythm.steps)
        self.state = .stopped
        
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        } catch {
            print(error)
        }
    }
    
    public func calculateTimeInterval() {
        self.timeInterval = 60/Double(bpm) * 4/Double(self.rhythm.steps)
    }
    
    public func play() {
        playRhythm()
        self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(playRhythm), userInfo: nil, repeats: true)
    }
    
    @objc public func playRhythm() {
        playNote(at: playhead)
        playhead = (playhead+1) % self.rhythm.steps
        
//        if self.state == .playing {
//            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + self.timeInterval, execute: { self.playRhythm() })
//        }
    }
    
    public func playNote(at index: Int) {
        self.player?.stop()
        self.player?.currentTime = 0
        self.player?.prepareToPlay()
        if self.rhythm.sequence[index] == 1 {
            self.player?.play()
        }
    }
    
    public func stop() {
        self.timer.invalidate()
        self.player?.stop()
        self.player?.currentTime = 0
        self.playhead = 0
    }
}
