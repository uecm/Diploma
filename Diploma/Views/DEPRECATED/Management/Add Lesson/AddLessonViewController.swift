//
//  AddLessonViewController.swift
//  Diploma
//
//  Created by Egor on 3/27/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class AddLessonViewController: UITableViewController {
 
    var lesson = Lesson()
    lazy var dataProvider = AddLessonDataProvider()
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lesson = Lesson()
        doneButton.isEnabled = false
    }
    
    fileprivate func configurationForCell(at indexPath: IndexPath) -> TextFieldCell.Configurator {
        var title: String?, placeholder: String?, text: String?
        switch indexPath.row {
        case 0:
            title = "Предмет"
            placeholder = "Название предмета"
            text = lesson.subject?.name
        case 1:
            title = "Преподаватель"
            placeholder = "Имя преподавателя"
            text = lesson.teacher?.fullName()
        case 2:
            title = "Группа"
            placeholder = "Название группы"
            text = lesson.studentGroup?.name
        case 3:
            title = "День"
            placeholder = "День недели"
            text = lesson.weekday?.name
        case 4:
            title = "Неделя"
            placeholder = "Неделя"
            text = "\(lesson.week)"
        default:
            break
        }
        return TextFieldCell.Configurator(title: title ?? "",
                                          placeholder: placeholder,
                                          text: text)
    }
    
    
    // MARK: - Picker
    fileprivate func showPickerForCell(at index: Int) {

        let picker = ActionSheetStringPicker(title: "",
                                             rows: rowTitlesForItem(at: index),
                                             initialSelection: 0,
                                             doneBlock: { (picker, objIndex, object) in
                                                self.setSelectedObjectfForItem(at: index,
                                                                               objectIndex: objIndex)
        },
                                             cancel: { (picker) in
            
        },
                                             origin: view)
        picker?.show()
    }
    
    private func rowTitlesForItem(at index: Int) -> [String] {
        switch index {
        case 0:
            return DataManager.shared.subjects.map({ $0.name ?? "No name" })
        case 1:
            return DataManager.shared.teachers.map({ $0.fullName() })
        case 2:
            return DataManager.shared.groups.map({ $0.name ?? "No name" })
        case 3:
            return ["nothing"]
//            return SubjectsDataProvider().dayNames
        case 4:
            return ["1", "2"]
        default:
            break
        }
        return []
    }
    
    private func setSelectedObjectfForItem(at index: Int, objectIndex: Int) {
        switch index {
        case 0:
            lesson.subject = DataManager.shared.subjects[objectIndex]
        case 1:
            lesson.teacher = DataManager.shared.teachers[objectIndex]
        case 2:
            lesson.studentGroup = DataManager.shared.groups[objectIndex]
        case 3:
            break
//            let dayName = SubjectsDataProvider().dayNames[objectIndex]
//            lesson.weekday = Day(name: dayName, weekday: objectIndex + 1)
        case 4:
            lesson.week = objectIndex + 1
        default:
            break
        }
        let rowIndexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [rowIndexPath], with: .none)
        doneButton.isEnabled = (lesson.subject != nil  && lesson.teacher != nil
                               && lesson.studentGroup != nil && lesson.weekday != nil)
    }
    
    
    
    // MARK: - Buttons
    
    @IBAction func donePressed(_ sender: Any) {
        dataProvider.addLesson(lesson)
    }
}

//MARK: - Data Source
extension AddLessonViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let configuration = configurationForCell(at: indexPath)
        
        cell.textLabel?.text = configuration.title
        if let text = configuration.text {
            cell.detailTextLabel?.text = text
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.detailTextLabel?.text = configuration.placeholder
            cell.detailTextLabel?.textColor = .gray
        }
        return cell
    }
}

//MARK: - Delegate
extension AddLessonViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showPickerForCell(at: indexPath.row)
    }
}

extension AddLessonViewController: TextFieldCellDelegate {
    func textFiledCell(_ cell: TextFieldCell, didEndEditingWith text: String) {
        
    }
}

