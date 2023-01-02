//
//  Message.swift
//  Kudo
//
//  Created by Tran Huu Dang on 31/12/2022.
//

import Foundation

struct Message {
    
    let id = UUID()
    let content : String
    init(content: String) {
        self.content = content
    }
    
    
}
