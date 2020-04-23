//
//  EntryDetailViewController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    //MARK: - Properties
    var entry: Entry?

    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        designClearButton()
        setTitle()
        updateViews()
    }

    //MARK: - Helper Methods
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }

    func designClearButton() {
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.backgroundColor = UIColor.systemPink.withAlphaComponent(0.80)
        clearButton.layer.borderColor = UIColor.systemPink.cgColor
        clearButton.layer.borderWidth = 2
        clearButton.setTitle("Clear", for: .normal)
    }

    func setTitle() {
        if let entry = entry {
            title = entry.title
        }
    }

    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }

        if let entry = entry {
            // update
            EntryController.sharedInstance.updateEntry(entry: entry, newTitle: title, newBody: body)
        } else {
            //create
            EntryController.sharedInstance.createEntry(withTitle: title, withBody: body)
        }
        // Pop that view
        navigationController?.popViewController(animated: true)
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
}
