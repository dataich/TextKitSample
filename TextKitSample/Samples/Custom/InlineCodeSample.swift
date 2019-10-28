//
//  InlineCodeSample.swift
//  TextKitSample
//
//  Created by Taichiro Yoshida on 2019/10/23.
//  Copyright © 2019 Taichiro Yoshida. All rights reserved.
//

import UIKit

struct InlineCodeSample: Sample {
  static let key = NSAttributedString.Key(rawValue: "InlineCode")
  
  var name: String {
    "インラインコード"
  }
  
  var attributedString: NSAttributedString {
    let text = """
      福岡のiOSエンジニア達が主催する、プログラミング言語 Swift とその周辺技術の勉強会です。

      発展を続ける Swift とその周辺技術の動向を追い、初心者/上級者/老若男女を問わず、情報交換の場として機能することを目的としています。
      """
    
    let attributedString = NSMutableAttributedString(string: text)
    
    attributedString.setAttributes([Self.key : UIColor.lightGray], range: NSRange(location: 18, length: 23))
    
    return attributedString
  }
}
