//
//  Sample.swift
//
//
//  Created by Robert Goedman on 10/30/25.
//

import Foundation

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
  let result = swiftSyncFileExec(program: cmdstan + "/bin/stansummary",
                                 arguments: [ modelPath + "/" + model + "_output_1.csv",
                                              modelPath + "/" + model + "_output_2.csv",
                                              modelPath + "/" + model + "_output_3.csv",
                                              modelPath + "/" + model + "_output_4.csv",
                                              "--csv_filename", modelPath + "/" + model + "_summary.csv"])
  extractStanSummaryResult(modelPath: modelPath, model: model)
  return result
}

public func extractStanSummaryResult(modelPath: String,
                                     model: String) {
  
  let fileManager = FileManager.default
  var theResult: String = "name,mean,mcse,stddev,mad,p05,p50,p95,ess_bulk,ess_tail,ess_bulk_per_s,R_hat\n"
  do {
    var isDirectory: ObjCBool = false
    let filePath: String? = modelPath + "/" + model + "_summary.csv"
    if fileManager.fileExists(atPath: filePath!, isDirectory: &isDirectory) {
      if let path = filePath {
        replaceNanByNil(path)
        do {
          var count = 0
          print("Reading file \(path).")
          let data = try String(contentsOfFile: path, encoding: .utf8)
          let myStrings = data.components(separatedBy: .newlines)
          for result in myStrings {
            //print(result)
            if (count > 0) && (count < 9) {
              theResult += result + "\n"
            }
            count += 1
          }
        } catch {
          print(error.localizedDescription)
        }
      }
    } else {
      print("\(model)_summary.csv not found.")
    }
  }
  print(theResult)
  createCSV(from: [theResult],
            modelPath: modelPath,
            model: model,
            kind: "stansummary")
}

