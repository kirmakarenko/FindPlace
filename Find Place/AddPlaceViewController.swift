//
//  AddPlaceViewController.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 01.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import CoreLocation

import ViperKit
import Dip_UI
import Cosmos

class AddPlaceViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    var output: AddPlaceViewControllerOutput!
    var displayManager = AddDisplayManager()

    var chosenPhoto: UIImage?
    var imageData: Data?
    var ratingView: CosmosView?
    var keyboadrMovedSize: CGFloat?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        displayManager.tableView = tableView
        displayManager.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tap)
        ratingView = CosmosView()

        setBackBarButtonCustom()

        output.viewReadyEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        displayManager.setUpTableView()
        navigationController?.navigationBar.setVisibleState()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.navigationBar.setInvisibleState()

        NotificationCenter.default.removeObserver(self)
    }

    // MARK: IBActions

    @IBAction func saveAction(_ sender: UIButton) {
        if displayManager.placeM.name != "" {
            showPlaceAlert(validForm: true)
        } else {
            showPlaceAlert(validForm: false)
        }
    }

    func showPlaceAlert(validForm: Bool) {
        if validForm {
            let alertController = UIAlertController(title: "Cпасибо",
                                                    message: "Заведение отправлено на модерацию", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { _ in
                self.output.savePressed(place: self.displayManager.placeM)
                if let image = self.imageData {
                    self.output.saveImage(data: image, name: self.displayManager.placeM.key)
                }

            }))
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Ошибка",
                                                    message: "Введите название заведения", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func setBackBarButtonCustom() {
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setTitle("Назад", for: .normal)
        btnLeftMenu.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }

    func onClickBack() {
        output?.backPressed()
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y >= -200 && view.frame.origin.y <= 80 {
                self.keyboadrMovedSize = keyboardSize.size.height
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y < -200 {
                self.view.frame.origin.y += self.keyboadrMovedSize!
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        imageData = UIImagePNGRepresentation(chosenPhoto!) as Data?
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: AddPlaceViewControllerInput

extension AddPlaceViewController: AddPlaceViewControllerInput {

    func configure(with place: PlaceM) {

        displayManager.configureWith(place: place)
    }

    func updateLocation(latitude: Double, longitude: Double) {
        displayManager.placeM.latitude = latitude
        displayManager.placeM.longitude = longitude
        displayManager.setUpTableView()
        displayManager.tableDirector.reload()
    }
}

// MARK: AddDisplayManagerDelegate

extension AddPlaceViewController: AddDisplayManagerDelegate {

    func movedTop() {
        UIView.animate(withDuration: 0.1, delay: 0.2, options: [], animations: {
            self.saveButton.alpha = 1.0
        }, completion: nil)
    }

    func movedBottom() {
        UIView.animate(withDuration: 0.1, delay: 0.2, options: [], animations: {
            //self.saveButton.alpha = 0.0
        }, completion: nil)
    }

    func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Камера", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        })

        alert.addAction(UIAlertAction(title: "Фотогалерея", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        })

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}

extension AddPlaceViewController: ModuleInputProvider {
    var moduleInput: ModuleInput! {
        // swiftlint:disable:next force_cast
        return output as! ModuleInput
    }
}

extension AddPlaceViewController: StoryboardInstantiatable {}
