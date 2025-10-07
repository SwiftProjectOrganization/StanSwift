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
  return swiftSyncFileExec(program: "/usr/bin/make",
                           arguments: [ modelPath + "/" + model ])
}

public func stanRun(modelPath: String,
                    model: String,
                    arguments: [String] = ["sample",
                                           "num_chains=4"]) -> (String, String) {
  var args = arguments
  args.append(contentsOf: ["data", "file=" + modelPath + "/" + model + ".data.json"])
  args.append(contentsOf: ["output", "file=" + modelPath + "/" + model + "_output.csv"])
  print(args)
  return swiftSyncFileExec(program: modelPath + "/" + model,
                           arguments: args)
}

public func stanSummary(modelPath: String,
                        model: String,
                        cmdstan: String) -> (String, String) {
  
  swiftSyncFileExec(program: cmdstan + "/bin/stansummary",
                    arguments: [ modelPath + "/" + model + "_output_1.csv",
                                modelPath + "/" + model + "_output_2.csv",
                                modelPath + "/" + model + "_output_3.csv",
                                modelPath + "/" + model + "_output_4.csv" ])
}

