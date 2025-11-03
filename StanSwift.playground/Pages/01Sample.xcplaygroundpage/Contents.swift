//: # StanSwift
//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
//: ## 01 Bernoulli

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

stanSummary(modelPath: modelPath,
            model: model,
            cmdstan: cmdstan)


//: [TOC](00TOC) | [Previous](@previous) | [Next](@next)
