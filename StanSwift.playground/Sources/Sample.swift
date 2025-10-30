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

public func stanSummary(modelPath: String,
                        model: String,
                        cmdstan: String) -> (String, String) {
  let fileManager = FileManager.default
  let filePath = modelPath + "/" + model + "_summary.csv"

  do {
    var isDirectory: ObjCBool = false
    if fileManager.fileExists(atPath: filePath, isDirectory: &isDirectory) {
      try fileManager.removeItem(atPath: filePath)
      //print("\(model)_summary.csv deleted successfully, will create a new one.")
    }
  } catch {
      print("Error deleting file \(model)_summary.csv: \(error)")
  }
  return swiftSyncFileExec(program: cmdstan + "/bin/stansummary",
                    arguments: [ modelPath + "/" + model + "_output_1.csv",
                                modelPath + "/" + model + "_output_2.csv",
                                modelPath + "/" + model + "_output_3.csv",
                                modelPath + "/" + model + "_output_4.csv",
                               "--csv_filename", modelPath + "/" + model + "_summary.csv"])
}
