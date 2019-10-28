//
//  MasterViewController.swift
//  TextKitSample
//
//  Created by Taichiro Yoshida on 2019/10/21.
//  Copyright © 2019 Taichiro Yoshida. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  let dafaultSamples: [Sample] = [
    ForegroundSample(),
    BackgroundSample(),
    FontSample(),
  ]
  
  let customSamples: [Sample] = [
    InlineCodeSample(),
    CodeSample(),
    QuoteSample()
  ]
  
  enum Section: Int {
    case `default`
    case custom
  }
  
  func getSamples(section: Int) -> [Sample]? {
    guard let section = Section(rawValue: section) else { return nil }
    
    switch section {
    case .default:
      return dafaultSamples
    case .custom:
      return customSamples
    }
  }
  
  func getSample(indexPath: IndexPath) -> Sample? {
    guard let samples = getSamples(section: indexPath.section) else { return nil }
    return samples[indexPath.row]
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow,
          let sample = getSample(indexPath: indexPath) else { return }
    
    (segue.destination as? DetailViewController)?.sample = sample
  }
}

extension MasterViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let section = Section(rawValue: section) else { return nil }
    
    switch section {
    case .default:
      return "標準"
    case .custom:
      return "カスタム"
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let samples = getSamples(section: section) else { return 0 }
    return samples.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    guard let sample = getSample(indexPath: indexPath) else { return cell }
    
    cell.textLabel?.text = sample.name
    return cell
  }
}

extension MasterViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "DetailView", sender: nil)
  }
}
