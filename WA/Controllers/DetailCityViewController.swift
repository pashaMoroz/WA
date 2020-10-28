//
//  DetailCityViewController.swift
//  WA
//
//  Created by Pavel Moroz on 27.10.2020.
//

import UIKit

class DetailCityViewController: UIViewController {

    let noteLabel = UILabel()
    private var noteTextFeild = UITextField()

    private let backgroundImage = UIImageView()
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()

        noteTextFeild.addTarget(self, action: #selector(noteTextFeildDidChange(_ :)), for: .editingChanged)
        setupConstraint()
        setupElements()
    }

    private func setupConstraint() {

        view.addSubview(backgroundImage)
        view.addSubview(cityNameLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(noteLabel)
        view.addSubview(noteTextFeild)

        self.cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noteLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noteTextFeild.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            self.cityNameLabel.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: 25),
            self.cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            self.noteTextFeild.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            self.noteTextFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            self.noteTextFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            self.noteTextFeild.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            self.noteLabel.topAnchor.constraint(equalTo: noteTextFeild.bottomAnchor, constant: 20),
            self.noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            self.noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            self.noteLabel.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            self.temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            self.temperatureLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        ])

        NSLayoutConstraint.activate([
            self.backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupElements() {

        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 80)

        cityNameLabel.textColor = .white
        cityNameLabel.font = .systemFont(ofSize: 55)

        noteTextFeild.textColor = .white
        noteTextFeild.font = .systemFont(ofSize: 25)
        noteTextFeild.backgroundColor = .lightText

        noteLabel.textColor = .white
        noteLabel.font = .systemFont(ofSize: 25)
        noteLabel.numberOfLines = 0
        //noteLabel.text = noteTextFeild.text
        noteLabel.textAlignment = .center

        backgroundImage.image = UIImage(named: "city")

        self.navigationController?.navigationBar.tintColor = .white

    }

    @objc func noteTextFeildDidChange(_ textField: UITextField) {

        WeatherSettings.notesForCurrentCity = textField.text!
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
