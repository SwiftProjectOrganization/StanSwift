//
//  Optimize.swift
//  
//
//  Created by Robert Goedman on 10/30/25.
//

import Foundation

public func pathfinder(modelPath: String,
                    model: String,
                    arguments: [String] = ["optimize"]) -> (String, String) {
  var args = arguments
  args.append(contentsOf: ["data", "file=" + modelPath + "/" + model + ".data.json"])
  args.append(contentsOf: ["output", "file=" + modelPath + "/" + model + "_pathfinder.csv"])
  print(args)
  return swiftSyncFileExec(program: modelPath + "/" + model,
                           arguments: args)
}

public func getPathfinderResult(result: String) -> [String] {
                          
  var theResult: [String] = []
  var copy = false

  do {
          do {
            let myStrings = result.components(separatedBy: .newlines)
            for result in myStrings {
              if result.count > 0 {
                let index = result.index(result.startIndex, offsetBy: 0)
                let index4 = result.index(result.startIndex, offsetBy: 4)
                let contents = result[index...index4]
                if contents != "Path" {
                  copy = true
                }
                if copy {
                  print(result)
                  theResult.append(result)
                }
              }
            }
          } catch {
            print(error.localizedDescription)
          }
      }
  }
  return theResult
}
