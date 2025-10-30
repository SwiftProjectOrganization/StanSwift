//: # StanSwift
//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
//: ## 02 Normal

import Cocoa
import Foundation

let model = "bernoulli"
let modelPath = "\(cmdstan)/examples/\(model)"

stanCompile(modelPath: modelPath,
            model: model)

optimize(modelPath: modelPath,
        model: model,
         arguments: ["optimize", "save_iterations=true"])

getOptimizeResult(modelPath: modelPath,
                  model: model)

//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
