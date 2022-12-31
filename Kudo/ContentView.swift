//
//  ContentView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 30/12/2022.
//

import SwiftUI
import OpenAISwift
import SwiftUIFontIcon

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
    @State var conversation = [MessageView]()
    var body: some View {
        NavigationView{
            VStack{
                ScrollViewReader { scrollView in
                ScrollView{
                    ForEach(conversation, id: \.message.id){
                        message in
                        HStack{
                            message.id(message.id)
                        }
                        }
                    }.onChange(of: conversation.count, perform: {value in
                        scrollView.scrollTo(conversation.last?.id)
                    })
                }
                .onAppear(perform: {
                    viewModel.setup()
                })
                .padding()
                Spacer()
                HStack{
                    Button("Translate") {
                    }
                    .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                    Button("Notes"){}
                    Spacer()
                }
                .padding(.horizontal)
                HStack{
                    TextField("Type here to ask", text: $text)
                        .padding(.horizontal)
                        .frame(height: 48)
                        .cornerRadius(20)
                        .onSubmit {
                            send()
                        }
                    FontIcon.button(.materialIcon(code: .mic), action: { send() })
                }.padding(.horizontal)
            }.navigationTitle("Kudo")
        }
    }
    
        
    func send(){
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        conversation.append(MessageView(message: Message(content: text)))
        viewModel.send(text: text){
            response in
            DispatchQueue.main.async{
                self.conversation.append(MessageView(message: Message(content: response),floatToRight: true))
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
