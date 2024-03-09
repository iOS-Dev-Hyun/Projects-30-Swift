import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            contentsLabel.text = text
        }
        contentsLabel.textColor = textColor
        view.backgroundColor = backgroundColor
    }
    

    @IBOutlet weak var contentsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.textColor = contentsLabel.textColor
            settingViewController.ledText = contentsLabel.text
            settingViewController.backgroundColor = view.backgroundColor ?? .black
        }
    }

}

