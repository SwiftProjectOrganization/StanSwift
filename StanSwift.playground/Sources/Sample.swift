//
//  Sample.swift
//  
//
//  Created by Robert Goedman on 10/30/25.
//

import Foundation

public func sample(modelPath: String,
                    model: String,
                    arguments: [String] = ["sample",
                                           "num_chains=4"]) -> (String, String) {
  var args = arguments
  args.append(contentsOf: ["data", "file=" + modelPath + "/" + model + ".data.json"])
  args.append(contentsOf: ["output", "file=" + modelPath + "/" + model + "_output.csv"])
  //print(args)
  return swiftSyncFileExec(program: modelPath + "/" + model,
                           arguments: args)
}

public func getSampleResult(modelPath: String,
                        model: String,) -> [String] {
                          
  let fileManager = FileManager.default
  var theResult: [String] = []

  for i in 1...4 {
    do {
      var isDirectory: ObjCBool = false
      let filePath: String? = modelPath + "/" + model + "_output_\(i).csv"
      if fileManager.fileExists(atPath: filePath!, isDirectory: &isDirectory) {
        if let path = filePath {
            do {
              var count = 0
              print("Reading file \(path).")
              let data = try String(contentsOfFile: path, encoding: .utf8)
              let myStrings = data.components(separatedBy: .newlines)
              for result in myStrings {
                if result.count > 0 {
                  let index = result.index(result.startIndex, offsetBy: 0)
                  let character = result[index]
                  if character != "#" {
                    if (i == 1) || (i > 1 && count > 0) {
                      theResult.append(result)
                    }
                    count += 1
                  }
                }
              }
            } catch {
              print(error.localizedDescription)
            }
        }
      } else {
        print("\(model)_output_\(i).csv not found.")
      }
    }
  }
  createCSV(from: theResult,
            modelPath: modelPath,
            model: model,
            kind: "samples")
  return theResult
}
