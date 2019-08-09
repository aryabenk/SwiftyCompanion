import UIKit

class StudentProfileViewController: UIViewController {
    var student = Student()
    
    @IBOutlet weak var coalitionLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionPointsLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set different background
        coalitionLabel.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage")!)
        
        let url = URL(string: student.getImageUrl()!)
        do {
            try imageLabel.image = UIImage(data: Data(contentsOf: url!))
        } catch {
            imageLabel.image = UIImage(named: "defaultUserImage")
        }
        imageLabel.setRounded()
        
        loginLabel.text = student.getLogin()
        phoneLabel.text = "Phone: \(student.getPhone())"
        walletLabel.text = "Wallet: \(student.getWallet())"
        correctionPointsLabel.text = "Correction Points: \(student.getCorrectionPoints())"
        locationLabel.text = student.getLocation()
        levelLabel.text = "Level: \(student.getLevel()) %"
        levelProgress.progress = Float(student.getLevel().truncatingRemainder(dividingBy: 1.0))
    }
}

extension UIImageView {
    func setRounded() {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
