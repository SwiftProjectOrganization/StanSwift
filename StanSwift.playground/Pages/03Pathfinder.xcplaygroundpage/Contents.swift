//: # StanSwift
//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
//: ## 02 Normal

import Cocoa
import Foundation

let model = "bernoulli"
let modelPath = "\(cmdstan)/examples/\(model)"

stanCompile(modelPath: modelPath,
            model: model)

pathfinder(modelPath: modelPath,
        model: model,
         arguments: ["pathfinder", "num_threads=4"])

//getPathfinderResult(modelPath: modelPath,
//                  model: model)

//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
