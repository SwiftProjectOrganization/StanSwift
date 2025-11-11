//: # StanSwift
//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
//: ## 01 Stan sample method

import Cocoa
import Foundation

let model = "bernoulli"
let modelPath = "/Users/rob/StanSwift/bernoulli"

let result = stanCompile(modelPath: modelPath,
            model: model)

if result.1 != "Quarantine present" {
  sample(modelPath: modelPath,
          model: model)

  getSampleResult(modelPath: modelPath,
                  model: model)
} else {
  print("Quarantine is present, run: \"xattr -d com.apple.quarantine \(modelPath + "/" + model)\" in a terminal to clear.")
}

//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
