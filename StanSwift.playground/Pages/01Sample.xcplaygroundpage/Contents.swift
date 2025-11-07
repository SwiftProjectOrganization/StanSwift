//: # StanSwift
//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
//: ## 01 Stan sample method

import Cocoa
import Foundation

let model = "bernoulli"
let modelPath = "\(cmdstan)/examples/\(model)"

stanCompile(modelPath: modelPath,
            model: model)

sample(modelPath: modelPath,
        model: model)

getSampleResult(modelPath: modelPath,
                model: model)

//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
