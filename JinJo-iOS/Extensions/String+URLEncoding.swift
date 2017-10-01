//
//  String+URLEncoding.swift
//  weather
//
//  Created by Paco Lee on 2017-07-27.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    
    func urlWithEncoding() -> URL? {
        
        guard let urlString = self, let escapedString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            return nil
        }
        
        return URL(string: escapedString)
    }
}


extension String {
    func stringWithEncoding() -> String? {
        guard let escapedString = self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            return nil
        }
        
        return escapedString
    }
}
