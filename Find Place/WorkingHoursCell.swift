//
//  WorkingHours.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 11.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import TableKit

protocol WorkingHoursCellDelegate: class {
    func setOpenHours(hour: Int)
    func setOpenMinutes(minutes: Int)
    func setCloseHours(hour: Int)
    func setCloseMinute(minutes: Int)
}

class WorkingHoursCell: UITableViewCell {
    @IBOutlet weak var openingTimeField: UITextField!

    @IBOutlet weak var closingTimeField: UITextField!

    let openDatePicker = UIDatePicker()
    let closeDatePicker = UIDatePicker()
    let calendar = Calendar.current
    weak var delegate: WorkingHoursCellDelegate?

    var openHour: Int?
    var openMinute: Int?
    var closeHour: Int?
    var closeMinute: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        openDatePicker.datePickerMode = .time
        closeDatePicker.datePickerMode = .time

        openDatePicker.minuteInterval = 5
        closeDatePicker.minuteInterval = 5

        openDatePicker.locale = Locale(identifier: "en_GB")
        closeDatePicker.locale = Locale(identifier: "en_GB")

        openDatePicker.addTarget(self, action: #selector(openDatePickerValueChanged), for: .valueChanged)
        closeDatePicker.addTarget(self, action: #selector(closeDatePickerValueChanged), for: .valueChanged)

        openingTimeField.inputView = openDatePicker
        closingTimeField.inputView = closeDatePicker

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 62.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        openingTimeField.inputAccessoryView = toolBar
        closingTimeField.inputAccessoryView = toolBar

    }

    func donePicker() {
        openingTimeField.resignFirstResponder()
        closingTimeField.resignFirstResponder()
    }

    func openDatePickerValueChanged(sender: UIDatePicker) {
        openHour = calendar.component(Calendar.Component.hour, from: openDatePicker.date)
        openMinute = calendar.component(Calendar.Component.minute, from: openDatePicker.date)

        openingTimeField.text = "\(openHour!):\(openMinute!/10 == 0 ? "0"+String(openMinute!): String(openMinute!))"

        TableCellAction(key: Actions.openHour, sender: self).invoke()
        TableCellAction(key: Actions.openMinute, sender: self).invoke()
    }

    func closeDatePickerValueChanged(sender: UIDatePicker) {
        closeHour = calendar.component(Calendar.Component.hour, from: closeDatePicker.date)
        closeMinute = calendar.component(Calendar.Component.minute, from: closeDatePicker.date)

        closingTimeField.text = "\(closeHour!):\(closeMinute!/10 == 0 ? "0"+String(closeMinute!): String(closeMinute!))"

        TableCellAction(key: Actions.closeHour, sender: self).invoke()
        TableCellAction(key: Actions.closeMinute, sender: self).invoke()
    }

    func configureWith(delegate: WorkingHoursCellDelegate) {
        self.delegate = delegate
    }
}

extension WorkingHoursCell: ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 90
    }

    func configure(with place: PlaceM) {
        if place.openHour != nil {
            openingTimeField.text = "\(place.openHour!):\(place.openMinute!/10 == 0 ? "0"+String(describing: place.openMinute!): String(describing: place.openMinute!))"
            closingTimeField.text = "\(place.closeHour!):\(place.closeMinute!/10 == 0 ? "0"+String(describing: place.closeMinute!): String(describing: place.closeMinute!))"
        }
    }
}
