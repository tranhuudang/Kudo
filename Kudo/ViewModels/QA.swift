//
//  QA.swift
//  Kudo
//
//  Created by Tran Huu Dang on 31/12/2022.
//

import Foundation
import OpenAISwift

class ViewModel: ObservableObject {
    init(){}
    
    private var client: OpenAISwift?
    func setup(){
        //client = OpenAISwift(authToken: "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")
        client = OpenAISwift(authToken: OpenAIToken().tokenKey)
    }
    func send(text: String, completion: @escaping (String) -> Void)
    {
        client?.sendCompletion(with: text, maxTokens: 630,
                               completionHandler: {
            result in
            switch result{
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output )
            case .failure:
                break
            }
        }
        
        )
    }
}
