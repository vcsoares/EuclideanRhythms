import Foundation
import UIKit
import AVFoundation

public class RhythmViewController : UIViewController {
    var bpmStepper : UIStepper!
    var stepStepper : UIStepper!
    var pulseStepper : UIStepper!
    var bpmLabel : UILabel!
    var stepLabel : UILabel!
    var pulseLabel : UILabel!
    var playButton : UIButton!
    var rhythm : Rhythm!
    var rhythmView : RhythmView!
    var audioController : AudioController!
    
    override public func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        bpmStepper = UIStepper()
        bpmStepper.maximumValue = 200
        bpmStepper.minimumValue = 80
        bpmStepper.stepValue = 1
        bpmStepper.value = 120
        
        stepStepper = UIStepper()
        stepStepper.maximumValue = 20
        stepStepper.minimumValue = 2
        stepStepper.stepValue = 1
        
        pulseStepper = UIStepper()
        pulseStepper.maximumValue = stepStepper.value
        pulseStepper.minimumValue = 1
        pulseStepper.stepValue = 1
        
        playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        playButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        playButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        playButton.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        playButton.layer.borderWidth = 1
        playButton.layer.cornerRadius = 4
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        rhythm = Rhythm(steps: 4, pulses: 4, rotation: 0)
        rhythmView = RhythmView(rhythm: self.rhythm, frame: rect)
        
        audioController = AudioController(rhythm: rhythm, bpm: 120, sound: "ht")
        
        bpmLabel = UILabel()
        bpmLabel.text = "Tempo: \(audioController.bpm)"
        
        stepLabel = UILabel()
        stepLabel.text = "Steps: \(rhythm.steps)"
        
        pulseLabel = UILabel()
        pulseLabel.text = "Notes: \(rhythm.pulses)"
        
        bpmStepper.addTarget(self, action: #selector(updateTempo), for: .valueChanged)
        stepStepper.addTarget(rhythm, action: #selector(updateRhythm), for: .valueChanged)
        pulseStepper.addTarget(rhythm, action: #selector(updateRhythm), for: .valueChanged)
        playButton.addTarget(self, action: #selector(togglePlay), for: .touchUpInside)
        
        view.addSubview(bpmLabel)
        view.addSubview(bpmStepper)
//        view.addSubview(stepLabel)
//        view.addSubview(stepStepper)
//        view.addSubview(pulseLabel)
//        view.addSubview(pulseStepper)
        view.addSubview(playButton)
        view.addSubview(rhythmView)
        
        bpmLabel.translatesAutoresizingMaskIntoConstraints = false
        bpmStepper.translatesAutoresizingMaskIntoConstraints = false
//        stepLabel.translatesAutoresizingMaskIntoConstraints = false
//        stepStepper.translatesAutoresizingMaskIntoConstraints = false
//        pulseLabel.translatesAutoresizingMaskIntoConstraints = false
//        pulseStepper.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        rhythmView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            stepLabel.bottomAnchor.constraint(equalTo: pulseLabel.topAnchor, constant: -24),
//            stepLabel.leadingAnchor.constraint(equalTo: pulseLabel.leadingAnchor),
//            stepStepper.trailingAnchor.constraint(equalTo: pulseStepper.trailingAnchor),
//            stepStepper.centerYAnchor.constraint(equalTo: stepLabel.centerYAnchor),
//            
//            pulseLabel.bottomAnchor.constraint(equalTo: rhythmView.topAnchor, constant: -32),
//            pulseLabel.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
//            pulseStepper.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
//            pulseStepper.centerYAnchor.constraint(equalTo: pulseLabel.centerYAnchor),
            
            bpmLabel.topAnchor.constraint(equalTo: rhythmView.bottomAnchor, constant: 32),
            bpmLabel.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            bpmStepper.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            bpmStepper.centerYAnchor.constraint(equalTo: bpmLabel.centerYAnchor),
            
            playButton.topAnchor.constraint(equalTo: bpmLabel.bottomAnchor, constant: 24),
            playButton.leadingAnchor.constraint(equalTo: bpmLabel.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: bpmStepper.trailingAnchor),
            
            rhythmView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rhythmView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rhythmView.heightAnchor.constraint(equalToConstant: rhythmView.frame.height),
            rhythmView.widthAnchor.constraint(equalToConstant: rhythmView.frame.width),
            ])
    }
    
    @objc func updateRhythm() {
        self.rhythm.steps = Int(stepStepper.value)
        stepLabel.text = "Steps: \(rhythm.steps)"
        
        pulseStepper.maximumValue = stepStepper.value
        self.rhythm.pulses = Int(pulseStepper.value)
        pulseLabel.text = "Notes: \(rhythm.pulses)"
        
        self.rhythmView.rhythm = self.rhythm
        self.audioController.rhythm = self.rhythm
    }
    
    @objc func updateTempo() {
        self.audioController.bpm = Int(bpmStepper.value)
        bpmLabel.text = "Tempo: \(audioController.bpm)"
    }
    
    @objc func togglePlay() {
        if self.playButton.title(for: .normal) == "Play" {
            self.audioController.state = .playing
            self.playButton.setTitle("Stop", for: .normal)
            self.playButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            self.playButton.layer.borderColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        } else if self.playButton.title(for: .normal) == "Stop" {
            self.audioController.state = .stopped
            self.playButton.setTitle("Play", for: .normal)
            self.playButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            self.playButton.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
    }
}
