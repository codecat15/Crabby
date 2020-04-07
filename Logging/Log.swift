//
//  Log.swift
//  Crabby
//
//  Created by CodeCat15 on 4/7/20.
//  Copyright © 2020 Crabby. All rights reserved.
//

import Foundation

// A utility to print and retrive debug log messages in document directory

class Log {

    private static let fileManager = FileManager.default

    static func LogInformation(message:String, file: String = #file, function: String = #function, line: Int = #line){
        #if DEBUG
        let fileMessage = "Printing at \(Date())\n File name = \(file) \n Function name = \(function)  \n Line number = \(line)  \n DebugContent = \(message)"
        writeDataToLogFile(fileContent: fileMessage)
        #endif
    }

    static func resetLog(){
        #if DEBUG
        do {
            try String().write(to: getLogFilePathFromDocumentDirectory(), atomically: false, encoding: .utf8)
        } catch  {}
        #endif
    }

    static func printLogFile() -> String {
        #if DEBUG
        do{
            return try String(contentsOf: getLogFilePathFromDocumentDirectory(), encoding: .utf8)
        } catch {
            debugPrint("exception occured while reading log file")
        }
        #endif
        return String()

    }

    private static func getLogFilePathFromDocumentDirectory() -> URL {

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("logFile.txt")
    }

    private static func createLogFileInDocumentDirectory() -> Bool{

        let filePath = getLogFilePathFromDocumentDirectory()
        if !fileManager.fileExists(atPath: filePath.path){
            return fileManager.createFile(atPath: filePath.path, contents: nil, attributes: nil)
        }
        return true
    }

    private static func writeDataToLogFile(fileContent: String){
        let content = "\n\n\n\n \(fileContent)"
        if createLogFileInDocumentDirectory(){
            if let fileHandle = FileHandle(forWritingAtPath: getLogFilePathFromDocumentDirectory().path) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(content.data(using: .utf8)!)
            }
        }
    }
}
