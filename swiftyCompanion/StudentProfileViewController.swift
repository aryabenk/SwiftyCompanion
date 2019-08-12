import UIKit

class skillCell : UITableViewCell {
    @IBOutlet weak var skillProgress: UIProgressView!
    @IBOutlet weak var skillName: UILabel!
}

class projectCell : UITableViewCell {
    @IBOutlet weak var projectName: UILabel!
}

class StudentProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var student = Student()
    
    @IBOutlet weak var coalitionLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionPointsLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayProfileHat()
    }
    
    func setCoalitionBackground() {
        let coalitionUrl = URL(string: student.getCoalitionUrl()!)
        do {
            try coalitionLabel.backgroundColor = UIColor(patternImage: UIImage(data: Data(contentsOf: coalitionUrl!))!)
        } catch {
            coalitionLabel.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage")!)
        }
    }
    
    func setStudentImage() {
        do {
            try imageLabel.image = UIImage(data: Data(contentsOf: URL(string: student.getImageUrl())!))
        } catch {
            imageLabel.image = UIImage(named: "defaultUserImage")
        }
        imageLabel.setRounded()
    }
    
    func displayProfileHat() {
        setCoalitionBackground()
        setStudentImage()
        
        loginLabel.text = student.getLogin()
        emailLabel.text = "Email: \(student.getEmail())"
        walletLabel.text = "Wallet: \(student.getWallet()) ₳"
        correctionPointsLabel.text = "Correction Points: \(student.getCorrectionPoints())"
        locationLabel.text = student.getLocation()
        levelLabel.text = "Level: \(student.getLevel()) %"
        
        levelProgress.progress = Float(student.getLevel().truncatingRemainder(dividingBy: 1.0))
        levelProgress.progressTintColor = .init(red: 0.1804, green: 0.4392, blue: 0, alpha: 1)
        levelProgress.setRounded()
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.skillsTableView {
            return student.getSkills().count
        }
        else {
            return student.getProjects().count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        if student.getProjects()[indexPath.section].opened {
            student.projects[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            student.projects[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if student.getProjects()[section].opened && student.getProjects()[section].subprojects.count >= 1 {
            return student.getProjects()[section].subprojects.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if tableView == self.skillsTableView {
                return createSkillCell(tableView, cellForRowAt: indexPath)
            }
            else {
                return createProjectCell(tableView, cellForRowAt: indexPath)
            }
        }
        else {
            return createSubCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    func createSubCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! projectCell
        var mark = String()
        
        if student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].validated {
            cell.projectName.textColor = .init(red: 0.1804, green: 0.4392, blue: 0, alpha: 1)
            mark = String(student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].finalMark)
        }
        else if student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].status == "in_progress" {
            cell.projectName.textColor = .lightGray
            mark = "in progress"
        }
        else if student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].status == "searching_a_group" {
            cell.projectName.textColor = .lightGray
            mark = "searching a group"
        }
        else if !student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].validated {
            cell.projectName.textColor = .init(red: 0.7176, green: 0.1765, blue: 0, alpha: 1)
            mark = String(student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].finalMark)
        }
        cell.projectName.text = "\(student.getProjects()[indexPath.section].subprojects[indexPath.row - 1].name) - \(mark)"
        return cell
    }
    
    func createSkillCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! skillCell
        skillsTableView.rowHeight = 60
        cell.skillName.text = "\(student.getSkills()[indexPath.section].name) - level \(student.getSkills()[indexPath.section].level)"
        cell.skillProgress.progress = Float(student.getSkills()[indexPath.section].level.truncatingRemainder(dividingBy: 1.0))
        cell.skillProgress.progressTintColor = .init(red: 0.1804, green: 0.4392, blue: 0, alpha: 1)
        cell.skillProgress.setRounded()
        return cell
    }
    
    func createProjectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! projectCell
        projectsTableView.rowHeight = 60
        var mark = String()
        
        if (student.getProjects()[indexPath.section].name == "Piscine C") {
            cell.projectName.textColor = .init(red: 0.1804, green: 0.4392, blue: 0, alpha: 1)
            mark = "\(student.getProjects()[indexPath.section].slug) %"
        }
        else if student.getProjects()[indexPath.section].validated {
            cell.projectName.textColor = .init(red: 0.1804, green: 0.4392, blue: 0, alpha: 1)
            mark = String(student.getProjects()[indexPath.section].finalMark)
        }
        else if student.getProjects()[indexPath.section].status == "in_progress" {
            cell.projectName.textColor = .lightGray
            mark = "in progress"
        }
        else if student.getProjects()[indexPath.section].status == "searching_a_group" {
            cell.projectName.textColor = .lightGray
            mark = "searching a group"
        }
        else if !student.getProjects()[indexPath.section].validated {
            cell.projectName.textColor = .init(red: 0.7176, green: 0.1765, blue: 0, alpha: 1)
            mark = String(student.getProjects()[indexPath.section].finalMark)
        }
        cell.projectName.text = "\(student.getProjects()[indexPath.section].name) - \(mark)"
        return cell
    }
}

extension UIProgressView {
    func setRounded() {
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.layer.sublayers![1].cornerRadius = 3
        self.subviews[1].clipsToBounds = true
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
