import Foundation
import UIKit
import AVFoundation

public class RhythmViewController : UIViewController {
    var bpmStepper : UIStepper!
    var stepSteppers : [UIStepper] = []
    var pulseSteppers : [UIStepper] = []
    var rotationSteppers : [UIStepper] = []
    var bpmLabel : UILabel!
    var stepLabels : [UILabel] = []
    var pulseLabels : [UILabel] = []
    var rotationLabels : [UILabel] = []
    var playButton : UIButton!
    var rhythms : [Rhythm] = []
    var rhythmViews : [RhythmView] = []
    var audioControllers : [AudioController] = []
    
    override public func viewDidLoad() {
        let sounds = ["bd", "sd", "hh", "ht"]
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        bpmStepper = UIStepper()
        bpmStepper.maximumValue = 200
        bpmStepper.minimumValue = 80
        bpmStepper.stepValue = 1
        bpmStepper.value = 120
        
        for i in 0..<3 {
            let stepStepper = UIStepper()
            stepStepper.maximumValue = 20
            stepStepper.minimumValue = 2
            stepStepper.stepValue = 1
            stepStepper.value = 4
            stepSteppers.append(stepStepper)
            
            let pulseStepper = UIStepper()
            pulseStepper.maximumValue = stepSteppers[i].value
            pulseStepper.minimumValue = 1
            pulseStepper.stepValue = 1
            pulseSteppers.append(pulseStepper)
            
            let rotationStepper = UIStepper()
            rotationStepper.maximumValue = stepSteppers[i].value - 1
            rotationStepper.minimumValue = 0
            rotationStepper.stepValue = 1
            rotationSteppers.append(rotationStepper)
        }
        
        playButton = UIButton(type: .system)
        playButton.setTitle("Play", for: .normal)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        playButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        playButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        playButton.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        playButton.layer.borderWidth = 1
        playButton.layer.cornerRadius = 4
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        for i in 0..<3 {
            let rhythm = Rhythm(steps: Int(stepSteppers[i].value), pulses: Int(pulseSteppers[i].value), rotation: Int(rotationSteppers[i].value))
            rhythms.append(rhythm)
            
            let rhythmView = RhythmView(rhythm: rhythms[i], frame: rect)
            rhythmViews.append(rhythmView)
            
            let audioController = AudioController(rhythm: rhythms[i], bpm: Int(bpmStepper.value), sound: sounds[i])
            audioControllers.append(audioController)
            
            let stepLabel = UILabel()
            stepLabel.text = "Steps: \(rhythms[i].steps)"
            stepLabels.append(stepLabel)
            
            let pulseLabel = UILabel()
            pulseLabel.text = "Notes: \(rhythms[i].pulses)"
            pulseLabels.append(pulseLabel)
            
            let rotationLabel = UILabel()
            rotationLabel.text = "Rotate by: \(rhythms[i].rotation)"
            rotationLabels.append(rotationLabel)
            
            stepSteppers[i].addTarget(rhythm, action: #selector(updateRhythm), for: .valueChanged)
            pulseSteppers[i].addTarget(rhythm, action: #selector(updateRhythm), for: .valueChanged)
            rotationSteppers[i].addTarget(rhythm, action: #selector(updateRhythm), for: .valueChanged)
        }
        
        bpmLabel = UILabel()
        bpmLabel.text = "Tempo: \(Int(bpmStepper.value))"
        
        bpmStepper.addTarget(self, action: #selector(updateTempo), for: .valueChanged)
        playButton.addTarget(self, action: #selector(togglePlay), for: .touchUpInside)
        
        view.addSubview(bpmLabel)
        view.addSubview(bpmStepper)
        for i in 0..<3 {
            view.addSubview(stepLabels[i])
            view.addSubview(stepSteppers[i])
            view.addSubview(pulseLabels[i])
            view.addSubview(pulseSteppers[i])
            view.addSubview(rotationLabels[i])
            view.addSubview(rotationSteppers[i])
            view.addSubview(rhythmViews[i])
        }
        view.addSubview(playButton)
        
        for i in 0..<3 {
            stepLabels[i].translatesAutoresizingMaskIntoConstraints = false
            stepSteppers[i].translatesAutoresizingMaskIntoConstraints = false
            pulseLabels[i].translatesAutoresizingMaskIntoConstraints = false
            pulseSteppers[i].translatesAutoresizingMaskIntoConstraints = false
            rotationLabels[i].translatesAutoresizingMaskIntoConstraints = false
            rotationSteppers[i].translatesAutoresizingMaskIntoConstraints = false
            rhythmViews[i].translatesAutoresizingMaskIntoConstraints = false
        }
        bpmLabel.translatesAutoresizingMaskIntoConstraints = false
        bpmStepper.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepLabels[0].topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            stepLabels[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stepSteppers[0].trailingAnchor.constraint(equalTo: rhythmViews[0].leadingAnchor, constant: -8),
            stepSteppers[0].centerYAnchor.constraint(equalTo: stepLabels[0].centerYAnchor),
            
            pulseLabels[0].topAnchor.constraint(equalTo: stepLabels[0].bottomAnchor, constant: 16),
            pulseLabels[0].leadingAnchor.constraint(equalTo: stepLabels[0].leadingAnchor),
            pulseSteppers[0].trailingAnchor.constraint(equalTo: stepSteppers[0].trailingAnchor),
            pulseSteppers[0].centerYAnchor.constraint(equalTo: pulseLabels[0].centerYAnchor),
            
            rotationLabels[0].topAnchor.constraint(equalTo: pulseLabels[0].bottomAnchor, constant: 16),
            rotationLabels[0].leadingAnchor.constraint(equalTo: pulseLabels[0].leadingAnchor),
            rotationSteppers[0].trailingAnchor.constraint(equalTo: pulseSteppers[0].trailingAnchor),
            rotationSteppers[0].centerYAnchor.constraint(equalTo: rotationLabels[0].centerYAnchor),
            
            rhythmViews[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            rhythmViews[0].heightAnchor.constraint(equalToConstant: rhythmViews[0].frame.height),
            rhythmViews[0].widthAnchor.constraint(equalToConstant: rhythmViews[0].frame.width),
            rhythmViews[0].centerYAnchor.constraint(equalTo: pulseLabels[0].centerYAnchor),
            
            stepLabels[1].topAnchor.constraint(equalTo: rotationLabels[0].bottomAnchor, constant: 32),
            stepLabels[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stepSteppers[1].trailingAnchor.constraint(equalTo: rhythmViews[1].leadingAnchor, constant: -8),
            stepSteppers[1].centerYAnchor.constraint(equalTo: stepLabels[1].centerYAnchor),
            
            pulseLabels[1].topAnchor.constraint(equalTo: stepLabels[1].bottomAnchor, constant: 16),
            pulseLabels[1].leadingAnchor.constraint(equalTo: stepLabels[1].leadingAnchor),
            pulseSteppers[1].trailingAnchor.constraint(equalTo: stepSteppers[1].trailingAnchor),
            pulseSteppers[1].centerYAnchor.constraint(equalTo: pulseLabels[1].centerYAnchor),
            
            rotationLabels[1].topAnchor.constraint(equalTo: pulseLabels[1].bottomAnchor, constant: 16),
            rotationLabels[1].leadingAnchor.constraint(equalTo: pulseLabels[1].leadingAnchor),
            rotationSteppers[1].trailingAnchor.constraint(equalTo: pulseSteppers[1].trailingAnchor),
            rotationSteppers[1].centerYAnchor.constraint(equalTo: rotationLabels[1].centerYAnchor),
            
            rhythmViews[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            rhythmViews[1].heightAnchor.constraint(equalToConstant: rhythmViews[1].frame.height),
            rhythmViews[1].widthAnchor.constraint(equalToConstant: rhythmViews[1].frame.width),
            rhythmViews[1].centerYAnchor.constraint(equalTo: pulseLabels[1].centerYAnchor),
            
            stepLabels[2].topAnchor.constraint(equalTo: rotationLabels[1].bottomAnchor, constant: 32),
            stepLabels[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stepSteppers[2].trailingAnchor.constraint(equalTo: rhythmViews[2].leadingAnchor, constant: -8),
            stepSteppers[2].centerYAnchor.constraint(equalTo: stepLabels[2].centerYAnchor),
            
            pulseLabels[2].topAnchor.constraint(equalTo: stepLabels[2].bottomAnchor, constant: 16),
            pulseLabels[2].leadingAnchor.constraint(equalTo: stepLabels[2].leadingAnchor),
            pulseSteppers[2].trailingAnchor.constraint(equalTo: stepSteppers[2].trailingAnchor),
            pulseSteppers[2].centerYAnchor.constraint(equalTo: pulseLabels[2].centerYAnchor),
            
            rotationLabels[2].topAnchor.constraint(equalTo: pulseLabels[2].bottomAnchor, constant: 16),
            rotationLabels[2].leadingAnchor.constraint(equalTo: pulseLabels[2].leadingAnchor),
            rotationSteppers[2].trailingAnchor.constraint(equalTo: pulseSteppers[2].trailingAnchor),
            rotationSteppers[2].centerYAnchor.constraint(equalTo: rotationLabels[2].centerYAnchor),
            
            rhythmViews[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            rhythmViews[2].heightAnchor.constraint(equalToConstant: rhythmViews[2].frame.height),
            rhythmViews[2].widthAnchor.constraint(equalToConstant: rhythmViews[2].frame.width),
            rhythmViews[2].centerYAnchor.constraint(equalTo: pulseLabels[2].centerYAnchor),
            
            bpmLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -32),
            bpmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            bpmStepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            bpmStepper.centerYAnchor.constraint(equalTo: bpmLabel.centerYAnchor),
            
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            playButton.leadingAnchor.constraint(equalTo: bpmLabel.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: bpmStepper.trailingAnchor),
            
            
            ])
    }
    
    @objc func updateRhythm() {
        for i in 0..<3 {
            self.rhythms[i].steps = Int(stepSteppers[i].value)
            stepLabels[i].text = "Steps: \(rhythms[i].steps)"
            
            pulseSteppers[i].maximumValue = stepSteppers[i].value
            self.rhythms[i].pulses = Int(pulseSteppers[i].value)
            pulseLabels[i].text = "Notes: \(rhythms[i].pulses)"
            
            rotationSteppers[i].maximumValue = stepSteppers[i].value
            self.rhythms[i].rotation = Int(rotationSteppers[i].value)
            rotationLabels[i].text = "Rotate by: \(rhythms[i].rotation)"
            
            self.rhythmViews[i].rhythm = self.rhythms[i]
            self.audioControllers[i].rhythm = self.rhythms[i]
        }
    }
    
    @objc func updateTempo() {
        for i in 0..<3 {
            self.audioControllers[i].bpm = Int(bpmStepper.value)
        }
        bpmLabel.text = "Tempo: \(audioControllers[0].bpm)"
    }
    
    @objc func togglePlay() {
        if self.playButton.title(for: .normal) == "Play" {
            self.audioControllers[0].state = .playing
            self.audioControllers[1].state = .playing
            self.audioControllers[2].state = .playing
            self.playButton.setTitle("Stop", for: .normal)
            self.playButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            self.playButton.layer.borderColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            for i in 0..<3 {
                self.stepSteppers[i].isEnabled = false
                self.pulseSteppers[i].isEnabled = false
                self.rotationSteppers[i].isEnabled = false
            }
            self.bpmStepper.isEnabled = false
        } else if self.playButton.title(for: .normal) == "Stop" {
            self.audioControllers[0].state = .stopped
            self.audioControllers[1].state = .stopped
            self.audioControllers[2].state = .stopped
            self.playButton.setTitle("Play", for: .normal)
            self.playButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            self.playButton.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            for i in 0..<3 {
                self.stepSteppers[i].isEnabled = true
                self.pulseSteppers[i].isEnabled = true
                self.rotationSteppers[i].isEnabled = true
            }
            self.bpmStepper.isEnabled = true
        }
    }
}
