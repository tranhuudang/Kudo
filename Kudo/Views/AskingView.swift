//
//  ContentView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 30/12/2022.
//

import SwiftUI
import OpenAISwift


struct AskingView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var loadingIndicator : Bool = false
    @State var conversation = [MessageView]()
    var listTools: [String] = [
        "Asking",
        "Translate",
        "Notes",
        ]
    var primaryColor = #colorLiteral(red: 0.1713213623, green: 0.1699589193, blue: 0.1723452508, alpha: 1)
    var body: some View {
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
                ScrollView(.horizontal) {
                    HStack(){
                        ForEach(listTools, id: \.count) { tool in
                            Button(tool) {
                            }
                            .padding(15)
                            .background(Color(primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                        //Old static list tools
//                        Button("Asking") {
//                        }
//                        .padding(15)
//                        .background(Color(primaryColor))
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                        Button("Translate"){}.foregroundColor(Color(primaryColor))
//                        Button("Notes"){}.foregroundColor(Color(primaryColor))
//                        Spacer()
                    }
                    .padding(.horizontal) 
                }
                HStack{
                    loadingIndicator ? LoadingIndicator(color: Color(primaryColor))
                        .padding()
                    :
                    nil
                    TextField("Type here to ask", text: $text)
                        .padding(.horizontal)
                        .frame(height: 48)
                        .cornerRadius(20)
                        .onSubmit {
                            send()
                        }
                    Button(action: {
                        //loadingIndicator = true
                        send()
                       
                    }, label: {
                        Label("", systemImage: "paperplane")
                            .foregroundColor(Color(primaryColor))
                    }
                    )
                    .padding()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Kudo")
            .navigationBarItems(trailing:
                                    HStack {
                NavigationLink{ToolsView()} label: {
                    Label("Tools", systemImage: "plus.app" ).foregroundColor(Color(primaryColor))
                }
                NavigationLink{SettingsView()} label: {
                    Label("Settings", systemImage: "gearshape" ).foregroundColor(Color(primaryColor))
                }
            }.padding()
            )
        }
    
    
    
    func send(){
        loadingIndicator.toggle()
        
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
      
        conversation.append(MessageView(message: Message(content: text)))
        self.text = ""
        viewModel.send(text: text){
            response in
            DispatchQueue.main.async{
                // Check if a url is exist in a answer
                let urlInContent = UrlDetector(inputContent: response).getUrl()
                
                if urlInContent != "" {
                    self.conversation.append(MessageView(message: Message(content: response),floatToRight: true, imageUrl: urlInContent))
                } else {
                    self.conversation.append(MessageView(message: Message(content: response),floatToRight: true))
                }
                loadingIndicator.toggle()
            }
        }
        
}

}
struct AskingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AskingView()
        }
    }
}
