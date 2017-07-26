//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case home = 0
    case notice
    case contactbook
    case talk
    case stamp
    case configuration
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["ホーム", "園からのお知らせ", "連絡帳", "個人トーク", "スタンプ帳", "設定"]
    var homeViewController: UIViewController!
    var noticeViewController: UIViewController!
    var contactbookViewController: UIViewController!
    var talkViewController: UIViewController!
    var stampViewController: UIViewController!
    var configurationViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.noticeViewController = UINavigationController(rootViewController: homeViewController)

        let noticeViewController = storyboard.instantiateViewController(withIdentifier: "NoticeViewController") as! NoticeViewController
        self.noticeViewController = UINavigationController(rootViewController: noticeViewController)
        
        let contactbookViewController = storyboard.instantiateViewController(withIdentifier: "ContactbookViewController") as! ContactbookViewController
        self.contactbookViewController = UINavigationController(rootViewController: contactbookViewController)
        
        let talkViewController = storyboard.instantiateViewController(withIdentifier: "TalkViewController") as! TalkViewController
        self.talkViewController = UINavigationController(rootViewController: talkViewController)
        
        let stampViewController = storyboard.instantiateViewController(withIdentifier: "StampViewController") as! StampViewController
        self.stampViewController = UINavigationController(rootViewController: stampViewController)
        
        let configurationViewController = storyboard.instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
        self.configurationViewController = UINavigationController(rootViewController: configurationViewController)
        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
//        self.imageHeaderView = ImageHeaderView.loadNib()
//        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.slideMenuController()?.changeMainViewController(self.homeViewController, close: true)
        case .notice:
            self.slideMenuController()?.changeMainViewController(self.noticeViewController, close: true)
        case .contactbook:
            self.slideMenuController()?.changeMainViewController(self.contactbookViewController, close: true)
        case .talk:
            self.slideMenuController()?.changeMainViewController(self.talkViewController, close: true)
        case .stamp:
            self.slideMenuController()?.changeMainViewController(self.stampViewController, close: true)
        case .configuration:
            self.slideMenuController()?.changeMainViewController(self.configurationViewController, close: true)

        }
    }
}


extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .notice, .contactbook, .talk, .stamp, .configuration:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .notice, .contactbook, .talk, .stamp, .configuration:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
