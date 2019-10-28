//
//  DetailViewController.swift
//  TextKitSample
//
//  Created by Taichiro Yoshida on 2019/10/21.
//  Copyright © 2019 Taichiro Yoshida. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var sample: Sample?
  
  var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    prepareTextView()
    textView.attributedText = sample?.attributedString
  }

  func prepareTextView() {
    let textStorage = NSTextStorage()
    let layoutManager = CustomLayoutManager()
    let textContainer = NSTextContainer()
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)
    
    textView = UITextView(frame: .zero, textContainer: textContainer)
    textView.isEditable = false
    textView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(textView)
    textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    textView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    textView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
  }
}
