//
//  Sample.swift
//  TextKitSample
//
//  Created by Taichiro Yoshida on 2019/10/21.
//  Copyright © 2019 Taichiro Yoshida. All rights reserved.
//

import UIKit

protocol Sample {
  var name: String { get }
  var attributedString: NSAttributedString { get }
}
