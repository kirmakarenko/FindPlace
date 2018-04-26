//
//  PriceCell.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 11.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import TableKit

protocol PriceCellDelegate: class {
    func setMinPrice(price: Int)
    func setMaxPrice(price: Int)
}

class PriceCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var bottomPriceField: UITextField!
    @IBOutlet weak var topPriceField: UITextField!
    let pickerOne = UIPickerView()
    let pickerTwo = UIPickerView()

    var bottomPriceArray = [50]
    var topPriceArray = [50]
    var priceCount: Int?
    var bottomCount: Int?
    var topCount: Int?

    weak var delegate: PriceCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        pickerOne.tag = 1
        pickerTwo.tag = 2
        pickerOne.dataSource = self
        pickerOne.delegate = self
        pickerTwo.dataSource = self
        pickerTwo.delegate = self
        priceCount = 45
        bottomCount = 0
        topCount = 0

        for i in 1...priceCount! {
            bottomPriceArray.append(bottomPriceArray[i-1] + 10)
            topPriceArray.append(topPriceArray[i-1] + 10)
        }
        bottomPriceField.inputView = pickerOne
        topPriceField.inputView = pickerTwo
        //bottomPriceField.text = String(describing: bottomPriceArray.first!)
        //topPriceField.text = String(describing: topPriceArray.last!)

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 62.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        bottomPriceField.inputAccessoryView = toolBar
        topPriceField.inputAccessoryView = toolBar
    }

    func donePicker() {

        bottomPriceField.resignFirstResponder()
        topPriceField.resignFirstResponder()

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return bottomPriceArray.count
        } else {
            return topPriceArray.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(bottomPriceArray[row])"
        } else {
            return "\(topPriceArray[row])"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            bottomPriceField.text = "\(bottomPriceArray[row])"
            TableCellAction(key: Actions.minPrice, sender: self).invoke()
            if topPriceField.text != "" {
                if Int(bottomPriceField.text!)! > Int(topPriceField.text!)! {
                    topPriceField.text! = bottomPriceField.text!
                    TableCellAction(key: Actions.maxPrice, sender: self).invoke()
                }
            }
            topPriceArray.removeAll()
            for i in 0...priceCount! - bottomCount! {
                if bottomPriceArray[i] == bottomPriceArray[row] {
                    topPriceArray.append(bottomPriceArray[row])
                    if i != priceCount! - bottomCount! {
                        for _ in i...priceCount! - bottomCount!-1 {
                            topPriceArray.append(topPriceArray[topPriceArray.count-1] + 10)
                        }
                    }
                    break
                }
            }
        } else {
            topPriceField.text = "\(topPriceArray[row])"
            TableCellAction(key: Actions.maxPrice, sender: self).invoke()
        }
    }

    func configureWith(delegate: PriceCellDelegate) {
        self.delegate = delegate
    }
}

extension PriceCell: ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 90
    }

    func configure(with place: PlaceM) {
        if place.minPrice != nil && place.maxPrice != nil {
            bottomPriceField.text = String(describing: place.minPrice!)
            topPriceField.text = String(describing: place.maxPrice!)
        }
//        if place.minPrice != nil && place.maxPrice != nil {
//            bottomPriceField.text = String(describing: place.minPrice!)
//            topPriceField.text = String(describing: place.maxPrice!)
//
//            bottomCount = (place.minPrice!/10)-5
//            topCount = (place.maxPrice!/10)-5
//
//            bottomPriceArray.removeAll()
//            bottomPriceArray.append(place.minPrice!)
//            for i in 1...priceCount!-bottomCount! {
//                bottomPriceArray.append(bottomPriceArray[i-1] + 10)
//            }
//
//            topPriceArray.removeAll()
//            topPriceArray.append(place.maxPrice!)
//            for i in 1...priceCount!-topCount! {
//                topPriceArray.append(topPriceArray[i-1] + 10)
//            }
//            //bottomPriceField.text = String(describing: bottomPriceArray.first!)
//            //topPriceField.text = String(describing: topPriceArray.last!)
//
//        }
    }
}
