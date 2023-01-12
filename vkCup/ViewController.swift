//
//  ViewController.swift
//  vkCup
//
//  Created by iMac iOS Павел on 05.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let categories: [String] = [
        "Поездки",
        "Путешествия",
        "Прогулки",
        "Кино",
        "Автомобили",
        "Жизнь",
        "Политика",
        "Юмор",
        "Новости",
        "Приключения",
        "Программирование",
        "Ремонт",
        "Море",
        "Аэропланы",
        "Сарказм",
        "Метрополитен",
        "Еда",
    ]
    
    private let button: UIButton = {
        let btn = UIButton()
        
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 25
        btn.setTitle("Переход", for: .normal)
        
        return btn
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 200),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
        ])
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        let controller = PickerViewController()
        
        controller.modalPresentationStyle = .fullScreen
        controller.configure(categories)
        controller.selectionCompletion = { [weak self] categories in
            self?.dismiss(animated: true)
            if categories.count != 0 {
                self?.label.text = categories.joined(separator: "\n")
            } else {
                self?.label.text = "empty"
            }
        }
        
        present(controller, animated: true)
    }
}
