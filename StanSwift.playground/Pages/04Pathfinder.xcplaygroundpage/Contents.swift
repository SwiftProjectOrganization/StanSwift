//: # StanSwift
//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
//: ## 02 Normal

import Cocoa
import Foundation

let model = "bernoulli"
let modelPath = "\(cmdstan)/examples/\(model)"

stanCompile(modelPath: modelPath,
            model: model)

let result1 = pathfinder(modelPath: modelPath,
        model: model,
         arguments: ["pathfinder", "num_threads=4"])

let result2 = pathfinder(modelPath: modelPath,
        model: model,
         arguments: ["pathfinder"])

getPathfinderResult(result: result2.0,
                    modelPath: modelPath,
                    model: model)

//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
