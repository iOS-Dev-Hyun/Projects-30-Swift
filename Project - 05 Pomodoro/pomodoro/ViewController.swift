import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToggleButton()
    }
    
    func setTimerInfoViewVisible(isHidden: Bool) {
        timerLabel.isHidden = isHidden
        progressView.isHidden = isHidden
    }
    
    func configureToggleButton() {
        toggleButton.setTitle("시작", for: .normal)
        toggleButton.setTitle("일시정지", for:.selected)
    }
    
    func startTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [],queue: .main)
            timer?.schedule(deadline: .now(), repeating: 1)
            timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return}
                self.currentSeconds -= 1
                let hour = currentSeconds / 3600
                let minutes = currentSeconds % 3600 / 60
                let seconds = currentSeconds % 3600 % 60
                timerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                progressView.progress = Float(currentSeconds) / Float(duration)
                UIView.animate(withDuration:  0.5,delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration:  0.5,delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                
                if self.currentSeconds <= 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1002)
                }
            })
            timer?.resume()
        }
    }
    
    func stopTimer() {
        if timerStatus == .pause {
            timer?.resume()
        }
        timerStatus = .end
        cancleButton.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        })
        toggleButton.isSelected = false
        timer?.cancel()
        timer = nil
    }
    
    @IBAction func tapCancleButton(_ sender: UIButton) {
        switch timerStatus {
        case .start, .pause:
            stopTimer()
        default:
            break
        }
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        duration = Int(datePicker.countDownDuration)
        
        switch timerStatus {
        case .start:
            timerStatus = .pause
            toggleButton.isSelected = false
            timer?.suspend()
        case .end:
            currentSeconds = duration
            timerStatus = .start
            UIView.animate(withDuration: 0.5, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            toggleButton.isSelected = true
            cancleButton.isEnabled = true
            startTimer()
        case .pause:
            timerStatus = .start
            toggleButton.isSelected = true
            timer?.resume()
        }
    }
}



