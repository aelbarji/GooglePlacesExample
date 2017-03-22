//
//  ViewController.swift
//  GooglePlacesExample
//
//  Created by Ayoub El barji on 22/03/2017.
//  Copyright © 2017 groupehn. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class ViewController: UIViewController {
  
  @IBOutlet weak var placeNameLabel: UILabel!
  @IBOutlet weak var placeAddressLabel: UILabel!
  // Present the Autocomplete view controller when the button is pressed.
  @IBAction func onLaunchClicked(sender: UIButton) {
    let acController = GMSAutocompleteViewController()
    acController.delegate = self
    present(acController, animated: true, completion: nil)
  }
  
  @IBAction func pickPlace(_ sender: UIButton) {
    let config = GMSPlacePickerConfig(viewport: nil)
    let placePicker = GMSPlacePicker(config: config)
    
    placePicker.pickPlace(callback: { (place, error) -> Void in
      if let error = error {
        print("Pick Place error: \(error.localizedDescription)")
        return
      }
      
      guard let place = place else {
        print("No place selected")
        return
      }
      
      print("Place name \(place.name)")
      self.placeNameLabel.text = place.name
      print("Place address \(place.formattedAddress)")
      self.placeAddressLabel.text = place.formattedAddress
      print("Place attributions \(place.attributions)")
    })
  }

}

extension ViewController: GMSAutocompleteViewControllerDelegate {
  
  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    self.placeNameLabel.text = place.name
    print("Place address: \(place.formattedAddress)")
    self.placeAddressLabel.text = place.formattedAddress
    print("Place attributions: \(place.attributions)")
    dismiss(animated: true, completion: nil)
  }
  
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: \(error)")
    dismiss(animated: true, completion: nil)
  }
  
  // User cancelled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    print("Autocomplete was cancelled.")
    dismiss(animated: true, completion: nil)
  }
}
