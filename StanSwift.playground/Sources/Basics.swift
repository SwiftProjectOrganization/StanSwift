//
//  Basics.swift
//  
//
//  Created by Robert Goedman on 10/5/25.
//

import Cocoa
import Foundation

public let cmdstan = "/Users/rob/Projects/StanSupport/cmdstan"

func swiftSyncFileExec(program: String,
                       arguments: [String]) -> (String, String) {
  let process = Process()
  process.executableURL = URL(fileURLWithPath: program)
  process.arguments = arguments
  //print(arguments)
  
  let outputPipe = Pipe()
  let errorPipe = Pipe()
  process.standardOutput = outputPipe
  process.standardError = errorPipe
  
  try! process.run()
  
  let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
  let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
  
  let output = String(decoding: outputData, as: UTF8.self)
  let error = String(decoding: errorData, as: UTF8.self)
  
  return (output,error)
}

public func stanCompile(modelPath: String,
                        model: String) -> (String, String) {
  
  let result = createStanBinary(modelPath: modelPath, model: model)
  //print(result)
  
  let result1 = checkQuarantine(modelPath: modelPath, model: model)
  //print(result1)
  
  if result1.0.count > 0 {
    //let result2 = removeQuarantine(modelPath: modelPath, model: model)
    //print(result2)
    return ("", "Quarantine present")
  }
  
  return result
}

func createStanBinary(modelPath: String,
                             model: String) -> (String, String) {
  let result = swiftSyncFileExec(program: "/usr/bin/make",
                                 arguments: ["-C", cmdstan, modelPath + "/" + model ])
  return result
}
func checkQuarantine(modelPath: String,
                      model: String) -> (String, String) {
  let result = swiftSyncFileExec(program: "/usr/bin/xattr",
                                 arguments: ["-l", modelPath + "/" + model])
  return result
}

                    
func removeQuarantine(modelPath: String,
                      model: String) -> (String, String) {
  let result = swiftSyncFileExec(program: "/usr/bin/xattr",
                                 arguments: ["-d", "com.apple.quarantine", modelPath + "/" + model])
  return result
}


public func replaceNanByNil(_ filePath: String) {
  // Step 1: Read the file content
  let fileManager = FileManager.default
  var content: String
  
  var isDirectory: ObjCBool = false
  if fileManager.fileExists(atPath: filePath, isDirectory: &isDirectory) {
    do {
      content = try String(contentsOfFile: filePath, encoding: .utf8)
    } catch {
      print("Error reading file: \(error)")
      exit(1)
    }
    
    // Step 2: Define the regex pattern
    let regexPattern = "nan" // Replace with your actual pattern
    let replacement = "-100000"
    
    // Step 3: Perform the replacement
    let modifiedContent = content.replacingOccurrences(of: regexPattern, with: replacement, options: .regularExpression)
    
    // Step 4: Write back to the file
    do {
      try modifiedContent.write(toFile: filePath, atomically: true, encoding: .utf8)
    } catch {
      print("Error writing to file: \(error)")
    }
  }
}
