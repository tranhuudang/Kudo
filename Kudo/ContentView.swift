//
//  ContentView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 30/12/2022.
//

import SwiftUI
import OpenAISwift


class ViewModel: ObservableObject {
    init(){}
    
    private var client: OpenAISwift?
    func setup(){
        client = OpenAISwift(authToken: "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")
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

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    var body: some View {
        ScrollView{
                ForEach(models, id : \.self){
                    string in
                    Text(string)
                }
                
        }
        
        .onAppear{
                viewModel.setup()
            }
            .padding()
            .navigationTitle("Kudo Playground")
        Spacer()
        HStack{
            TextField("Type here to ask", text: $text)
            Button("Send"){
                send()
            }
        }
        .padding()
    }
    
        
    func send(){
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        models.append("Me: \(text)")
        viewModel.send(text: text){
            response in
            DispatchQueue.main.async{
                self.models.append("Kudo: \(response)")
                self.text = ""
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
