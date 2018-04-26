//
//  PlaceViewController.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 09.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import Cosmos
import ViperKit
import Dip_UI

class PlaceViewController: BaseViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var visitorsLabel: UILabel!
    // MARK: UIAlertController

    @IBAction func fakeRatingAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ваш рейтинг:", message: "\n\n", preferredStyle: .alert)

        var ratingValue = 0.0

        alertRatingView?.rating = 0.0
        alertRatingView?.settings.starSize = 40
        alertRatingView?.settings.updateOnTouch = true
        alertRatingView?.settings.fillMode = StarFillMode(rawValue: 1)!
        alertRatingView?.frame.origin.y = 50
        alertRatingView?.frame.origin.x = 25

        alert.addAction(UIAlertAction(title: "Назад", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Оценить", style: .default, handler: { _ in
            self.displayManager.place?.marksNumber += 1
            self.displayManager.place?.averageRating = ratingValue
            self.output?.ratingChanged(place: self.displayManager.place!)
            self.ratingView.rating = (self.displayManager.place?.averageRating)!
            self.visitorsLabel.text = String(describing: self.displayManager.place!.marksNumber)
        }))

        alert.view.addSubview(alertRatingView!)
        alert.actions[1].isEnabled = false

        self.present(alert, animated: true, completion: nil)

        alertRatingView?.didTouchCosmos = { rating in
            alert.actions[1].isEnabled = true
            ratingValue = rating
        }

        alertRatingView?.didFinishTouchingCosmos = { rating in
            alert.actions[1].isEnabled = true
            ratingValue = rating
        }
    }

    fileprivate let headerHeight: CGFloat = 300.0
    var headerMaskLayer: CAShapeLayer!

    var displayManager = PlaceDisplayManager()
    var output: PlaceViewControllerOutput?
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var alertRatingView: CosmosView?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(red: 62.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 1.0)

//        ratingView.rating = (displayManager.place?.averageRating)!
//        alertRatingView = CosmosView()

        indicator.startAnimating()

        //ratingView.isUserInteractionEnabled = false
        tableView.delegate = displayManager
        tableView.dataSource = displayManager
        displayManager.delegate = self

        output?.getPhoto(name: (displayManager.place?.key)!)
        indicator.startAnimating()

        nameLabel.text = displayManager.place?.name
        tableView.register(UINib(nibName: "PlacePriceCell", bundle: nil), forCellReuseIdentifier: "PlacePriceCell")
        setBackBarButtonCustom()
        setEditBarButtonCustom()

        tableView.rowHeight = UITableViewAutomaticDimension
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        updateHeaderView()

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setInvisibleState()
        //UIApplication.shared.isStatusBarHidden = true
//        visitorsLabel.text = String(describing: displayManager.place!.marksNumber)

    }

    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.navigationBar.setVisibleState()
        //UIApplication.shared.isStatusBarHidden = false
    }

    func setBackBarButtonCustom() {
        let btnLeftMenu: UIButton = UIButton()
        let arrowImage = UIImage(named: "left-arrow")

        btnLeftMenu.setImage(arrowImage, for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }

    func setEditBarButtonCustom() {
        let rightBarButton = UIButton()
        let editImage = UIImage(named: "edit")

        rightBarButton.setImage(editImage, for: .normal)
        rightBarButton.addTarget(self, action: #selector(onClickEdit), for: .touchUpInside)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let rightBarItem = UIBarButtonItem(customView: rightBarButton)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }

    func onClickBack() {
        output?.closePressed()
    }

    func onClickEdit() {
        output?.editPressed(place: displayManager.place!)
    }

    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -headerHeight, width: view.frame.width, height: headerHeight)
        if tableView.contentOffset.y < -headerHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
}

extension PlaceViewController: PlaceDisplayManagerDelegate {
    func update() {
        updateHeaderView()
    }
}

extension PlaceViewController: PlaceViewControllerInput {

    func configure(with place: PlaceM) {
        displayManager.place = place
    }

    func setPhoto(photo: UIImage) {
        imageView.image = photo
        imageView.clipsToBounds = true
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}

extension PlaceViewController: ModuleInputProvider {
    var moduleInput: ModuleInput! {
        // swiftlint:disable:next force_cast
        return output as! ModuleInput
    }
}

extension PlaceViewController: StoryboardInstantiatable {}
