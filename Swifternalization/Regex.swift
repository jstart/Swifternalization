//
//  Regex.swift
//  Swifternalization
//
//  Created by Tomasz Szulc on 27/06/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation

class Regex {
    class func firstMatchInString(str: String, pattern: String) -> String? {
        if let result = regexp(pattern)?.firstMatchInString(str, options: .ReportCompletion, range: NSMakeRange(0, str.length)) {
            return substring(str, result: result)
        }
        return nil
    }
    
    class func matchesInString(str: String, pattern: String) -> [String] {
        var matches = [String]()
        if let results = regexp(pattern)?.matchesInString(str, options: .ReportCompletion, range: NSMakeRange(0, str.length)) {
            for result in results {
                matches.append(substring(str, result: result))
            }
        }
        
        return matches
    }
    
    private class func regexp(pattern: String) -> NSRegularExpression? {
        do {
            return try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        } catch {
            print("Cannot create NSRegularExpressions instead with this pattern - \(pattern)")
            return nil
        }
    }
    
    private class func substring(str: String, result: NSTextCheckingResult) -> String {
        let startRange = advance(str.startIndex, result.range.location)
        let endRange = advance(startRange, result.range.length)
        
        return str.substringWithRange(Range(start: startRange, end: endRange))
    }
}

extension String {
    var length: Int {
        return distance(self.startIndex, self.endIndex)
    }
}