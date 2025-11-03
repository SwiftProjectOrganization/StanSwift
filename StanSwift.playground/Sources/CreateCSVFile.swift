//
//  CreateCSVFiles.swift
//  
//
//  Created by Robert Goedman on 10/31/25.
//

import Foundation

public func createCSV(from data: [String],
                      modelPath: String,
                      model: String,
                      kind: String = "optimize") {
  let fileManager = FileManager.default
  let filePath: String? = modelPath + "/" + model + "_" + kind + ".csv"
  
  do {
    var isDirectory: ObjCBool = false
    if fileManager.fileExists(atPath: filePath!, isDirectory: &isDirectory) {
      try fileManager.removeItem(atPath: filePath!)
      //print("\(model)_summary.csv deleted successfully, will create a new one.")
    }
  } catch {
    print("Error deleting file \(model)_summary.csv: \(error)")
  }
  
  var csvString: String = ""
  
  for record in data {
    csvString.append("\(record)\n")
  }
  
  let fileURL = URL(string: "\(filePath!.description)")
  
  do {
    try csvString.write(to: fileURL!, atomically: true, encoding: .utf8)
    print("CSV file created at: \(fileURL!)")
  } catch {
    print("Error creating file: \(error)")
  }
}
