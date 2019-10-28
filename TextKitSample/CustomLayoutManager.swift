//
//  CustomLayoutManager.swift
//  TextKitSample
//
//  Created by Taichiro Yoshida on 2019/10/21.
//  Copyright © 2019 Taichiro Yoshida. All rights reserved.
//

import UIKit

class CustomLayoutManager: NSLayoutManager {
  override func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
    super.drawBackground(forGlyphRange: glyphsToShow, at: origin)
    drawInlineCode(forGlyphRange: glyphsToShow, at: origin)
    drawCode(forGlyphRange: glyphsToShow, at: origin)
    drawQuote(forGlyphRange: glyphsToShow, at: origin)
  }
  
  func drawInlineCode(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
    let range = characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)

    textStorage?.enumerateAttribute(InlineCodeSample.key, in: range, options: []) { (color, range, _) in
      let glyphRange = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
      
      guard let color = color as? UIColor, color != .clear,
        let container = textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil),
        let context = UIGraphicsGetCurrentContext() else { return }

      context.saveGState()
      context.translateBy(x: origin.x, y: origin.y)
      
      self.enumerateEnclosingRects(forGlyphRange: glyphRange, withinSelectedGlyphRange: glyphRange, in: container) { (rect, stop) in
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 3.0, height: 3.0))
        color.setFill()
        
        path.fill()
        
        UIColor.gray.setStroke()
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.lineWidth = 1.0
        path.stroke()
      }
      
      context.restoreGState()
    }
  }
  
  func drawCode(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
    let range = characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
    
    textStorage?.enumerateAttribute(CodeSample.key, in: range, options: []) { (color, range, _) in
      let glyphRange = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
      
      guard let color = color as? UIColor, color != .clear,
        let context = UIGraphicsGetCurrentContext() else { return }

      context.saveGState()
      context.translateBy(x: origin.x, y: origin.y)
      
      var rects: [CGRect] = []
      
      self.enumerateLineFragments(forGlyphRange: glyphRange) { (rect, usedRect, textContainer, glyphRange, stop) in
        rects.append(rect)
      }
      let rect = containableRect(rects: rects)
      
      let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 3.0, height: 3.0))
      color.setFill()
      
      path.fill()
      
      UIColor.gray.setStroke()
      path.lineCapStyle = .round
      path.lineJoinStyle = .round
      path.lineWidth = 1.0
      path.stroke()
      
      context.restoreGState()
    }
  }
  
  func drawQuote(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
    let range = characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
    
    textStorage?.enumerateAttribute(QuoteSample.key, in: range, options: []) { (color, range, _) in
      let glyphRange = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
      
      guard let color = color as? UIColor, color != .clear,
        let context = UIGraphicsGetCurrentContext() else { return }

      context.saveGState()
      context.translateBy(x: origin.x, y: origin.y)
      
      var rects: [CGRect] = []
      
      self.enumerateLineFragments(forGlyphRange: glyphRange) { (rect, usedRect, glyphRange, range, stop) in
        rects.append(rect)
      }
      let rect = containableRect(rects: rects)
      
      let path = UIBezierPath()
      path.move(to: rect.origin)
      path.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height))
      path.lineWidth = 6
      UIColor.gray.setStroke()
      path.stroke()
      
      context.restoreGState()
    }
  }
  
  private func containableRect(rects: [CGRect]) -> CGRect {
    let points = rects.reduce((CGPoint(x: CGFloat.greatestFiniteMagnitude, y: CGFloat.greatestFiniteMagnitude), CGPoint(x: CGFloat.leastNonzeroMagnitude, y: CGFloat.leastNonzeroMagnitude))) { (result, rect) -> (CGPoint, CGPoint) in
      let from = result.0
      let to = result.1
      return (
        CGPoint(x: min(from.x, rect.minX), y: min(from.y, rect.minY)),
        CGPoint(x: max(to.x, rect.maxX), y: max(to.y, rect.maxY)))
    }
    
    return CGRect(x: points.0.x, y: points.0.y, width: points.1.x - points.0.x, height: points.1.y - points.0.y)
  }
}
