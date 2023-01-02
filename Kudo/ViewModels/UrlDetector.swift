//
//  UrlDetector.swift
//  Kudo
//
//  Created by Tran Huu Dang on 02/01/2023.
//

import Foundation

struct UrlDetector{
    
    let inputContent : String
    init(inputContent: String) {
        self.inputContent = inputContent
    }
    
    func getUrl() -> String {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: inputContent, options: [], range: NSRange(location: 0, length: inputContent.utf16.count))
        
        for match in matches {
            var result : String = ""
            guard let range = Range(match.range, in: inputContent) else { continue }
            let url = inputContent[range]
            result = result.appending(url)
            return result
        }
        return ""
    }
    
    
}
