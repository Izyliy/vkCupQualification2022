//
//  PickerViewController.swift
//  vkCup
//
//  Created by iMac iOS Павел on 05.12.2022.
//

import UIKit

class PickerViewController: UIViewController {
    
    //MARK: - UI elements
    let infoStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        
        return stack
    }()
    
    let skipButton: UIButton = {
        let btn = UIButton()
        
        btn.layer.cornerRadius = 20
        btn.setTitle("Позже", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        btn.backgroundColor = UIColor(white: 1, alpha: 0.12)
        
        return btn
    }()
    
    let continueButton: UIButton = {
        let btn = UIButton()
        
        
        btn.layer.cornerRadius = 40
        btn.setTitle("Продолжить", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        btn.setTitleColor(UIColor(white: 0, alpha: 1), for: .normal)
        btn.backgroundColor = .white
        
        return btn
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Отметьте то, что вам интересно, чтобы настроить Дзен"
        label.numberOfLines = 0
        label.textColor = UIColor(white: 1, alpha: 0.5)
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomViewFlowLayout())
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    //MARK: - Variables
    var selectionCompletion: (([String]) -> Void)?
    private var state: PickerState?
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    //MARK: - Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        skipButton.addTarget(self, action: #selector(skipPressed(_:)), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continuePressed(_:)), for: .touchUpInside)
        
        setVisuals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    func configure(_ categories: [String]) {
        state = PickerState(from: categories)
        validateButton()
    }

    //MARK: - Private funcs
    private func setVisuals() {
        view.addSubview(collectionView)
        view.addSubview(infoStack)
        view.addSubview(continueButton)
        infoStack.addArrangedSubview(infoLabel)
        infoStack.addArrangedSubview(skipButton)
        
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            infoStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            infoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.widthAnchor.constraint(equalToConstant: 80),
            
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16),
            
            continueButton.widthAnchor.constraint(equalToConstant: 210),
            continueButton.heightAnchor.constraint(equalToConstant: 80),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func validateButton() {
        let enabled = state?.categories.first(where: { $0.checked == true }) != nil
        
        continueButton.isEnabled = enabled
        
        UIView.animate(withDuration: 0.2) {
            self.continueButton.alpha = enabled ? 1 : 0.5
        }
    }
    
    @objc
    private func skipPressed(_ sender: UIButton) {
        selectionCompletion?([])
    }
    
    @objc
    private func continuePressed(_ sender: UIButton) {
        guard let categories = state?.categories.filter({ $0.checked == true }) else { return }
        
        let titles: [String] = categories.map { $0.title }
        
        selectionCompletion?(titles)
    }
}

extension PickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? CategoryCollectionViewCell else { return }

        cell.cellTapped()
        validateButton()
    }
}

extension PickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let category = state?.categories[indexPath.row] {
            return category.cellSize
        } else {
            return .zero
        }
    }
}

extension PickerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        state?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as?  CategoryCollectionViewCell,
              let category = state?.categories[indexPath.row]
        else {
            return UICollectionViewCell()
        }

        cell.configure(with: category)
        
        cell.tapCallback = { [weak self] id in
            guard let index = self?.state?.categories.firstIndex(where: { $0.id == id }) else { return }
            self?.state?.categories[index].checked.toggle()
            self?.collectionView.reloadData()
        }
        
        return cell
    }
}
