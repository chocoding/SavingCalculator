//
//  RealMainViewController.swift
//  SavingCalculator
//
//  Created by 이정민 on 2021/03/30.
//

import UIKit
import GoogleMobileAds
import SideMenu

class RealMainViewController : UIViewController
{
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var braketButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var calculateLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var saveFolder: UIButton!
    
    // variable
    
    var calculationButtons: [UIButton] = [UIButton]()
    
    var calculates = ""
    var interstitial: GADInterstitialAd?
    var bannerView: GADBannerView!
    var bannerID = ""
    var interstitialAdID = ""
    var operatorInput = false
    var resulted = false
    var calculateModel: [Calculate] = []
    var sideMenu: SideMenuNavigationController?
    var menuController: MenuController?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateUIMain()
        sideMenu = SideMenuNavigationController(rootViewController:MenuController.init(with: calculateModel))
        sideMenu!.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        NotificationCenter.default.addObserver(self, selector: #selector(getShow), name: NSNotification.Name(rawValue: "getShow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteItem), name: NSNotification.Name(rawValue: "deleteItem"), object: nil)
    }
}

class MenuController : UITableViewController{

    private let menuItems: [Calculate]
    
    init(with menuItems: [Calculate]){
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.backgroundColor = .darkGray
        //view.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1) : \(menuItems[indexPath.row].calculate ?? "계산식 없음")"
        //cell.textLabel?.textColor = .white
        //cell.contentView.backgroundColor = .darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        let sheet = UIAlertController(title: "편집", message: selectedItem.calculate, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "복사", style: .default, handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getShow"), object: [selectedItem.calculate, selectedItem.resulted])
        }))
        
        sheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteItem"), object: selectedItem)
        }))
        
        present(sheet, animated: true)
    }
}
