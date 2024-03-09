import UIKit
import Lottie

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let animationView: LottieAnimationView = .init(name: "로켓")
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.loopMode = .loop
        animationView.play()
    }
}

