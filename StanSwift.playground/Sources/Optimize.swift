//
//  Optimize.swift
//  
//
//  Created by Robert Goedman on 10/30/25.
//

import Foundation

protocol Decodable {
  init(from decoder: Decoder) throws
}

public func optimize(modelPath: String,
                    model: String,
                    arguments: [String] = ["pathfinder"]) -> (String, String) {
  var args = arguments
  args.append(contentsOf: ["data", "file=" + modelPath + "/" + model + ".data.json"])
  args.append(contentsOf: ["output", "file=" + modelPath + "/" + model + "_optimize.csv"])
  //print(args)
  return swiftSyncFileExec(program: modelPath + "/" + model,
                           arguments: args)
}

public func getOptimizeResult(modelPath: String,
                        model: String,) -> [String] {
                          
  let fileManager = FileManager.default
  let filePath: String? = modelPath + "/" + model + "_optimize.csv"
  var theResult: [String] = []

  do {
    var isDirectory: ObjCBool = false
    if fileManager.fileExists(atPath: filePath!, isDirectory: &isDirectory) {
      if let path = filePath {
          do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let myStrings = data.components(separatedBy: .newlines)
            for result in myStrings {
              if result.count > 0 {
                let index = result.index(result.startIndex, offsetBy: 0)
                let character = result[index]
                if character != "#" {
                  //print(result)
                  theResult.append(result)
                }
              }
            }
          } catch {
            print(error.localizedDescription)
          }
      }
    } else {
      print("\(model)_summary.csv not found.")
    }
  }
  createCSV(from: theResult,
            modelPath: modelPath,
            model: model,
            kind: "optimize")

  return theResult
}
