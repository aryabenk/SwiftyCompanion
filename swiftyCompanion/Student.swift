import UIKit

struct Skill {
    var name: String
    var level: Double
    init(name: String, level: Double) {
        self.name = name
        self.level = level
    }
}

struct Project {
    var name: String
    var slug: String
    var id: Int
    var parentId: Int?
    var status: String
    var validated: Bool
    var finalMark: Int
    var cursusIds: Int
    var subprojects = [Project]()
    var data = String()
    var opened: Bool
    init(name: String, slug: String, id: Int, parentId: Int?, status: String, validated: Bool, finalMark: Int, cursusIds: Int, subprojects: [Project], data: String, opened: Bool) {
        self.name = name
        self.slug = slug
        self.id = id
        self.parentId = parentId
        self.status = status
        self.validated = validated
        self.finalMark = finalMark
        self.cursusIds = cursusIds
        self.subprojects = subprojects
        self.data = data
        self.opened = opened
    }
}

class Student: NSObject {
    private var imageUrl = String()
    private var coalitionName = String()
    private var coalitionUrl = String()
    private var id = Int()
    private var login = String()
    private var email = String()
    private var wallet = Int()
    private var correctionPoints = Int()
    private var location = String()
    private var level = Double()
    private var skills = [Skill]()
    var projects = [Project]()
    
    
    func setImageUrl(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    func getImageUrl() -> String {
        return self.imageUrl
    }
    
    func setCoalitionName(coalitionName: String) {
        self.coalitionName = coalitionName
    }
    
    func getCoalitionName() -> String {
        return self.coalitionName
    }
    
    func setCoalitionUrl(coalitionUrl: String) {
        self.coalitionUrl = coalitionUrl
    }
    
    func getCoalitionUrl() -> String? {
        return self.coalitionUrl
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func setLogin(login: String) {
        self.login = login
    }
    
    func getLogin() -> String{
        return self.login
    }
    
    func setEmail(phone: String) {
        self.email = phone
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func setWallet(wallet: Int) {
        self.wallet = wallet
    }
    
    func getWallet() -> Int {
        return self.wallet
    }
    
    func setCorrectionPoints(correctionPoints: Int) {
        self.correctionPoints = correctionPoints
    }
    
    func getCorrectionPoints() -> Int {
        return self.correctionPoints
    }
    
    func setLocation(location: String) {
        self.location = location
    }
    
    func getLocation() -> String {
        return self.location
    }
    
    func setLevel(level: Double) {
        self.level = level
    }
    
    func getLevel() -> Double {
        return self.level
    }
    
    func setSkills(skills: [Skill]) {
        self.skills = skills
    }
    
    func getSkills() -> [Skill]{
        return self.skills
    }
    
    func setProjects(projects: [Project]) {
        self.projects = projects
    }
    
    func getProjects() -> [Project] {
        return self.projects
    }
}
