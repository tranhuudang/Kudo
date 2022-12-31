//
//  ContentView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 30/12/2022.
//

import SwiftUI
import OpenAISwift
import SwiftUIFontIcon


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
                    Button("Asking") {
                    }
                    .padding(15)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    Button("Translate"){}
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
                    Button(action: {
                        send()
                    }, label: {
                        Label("", systemImage: "mic")}
                    )
                    .padding()
                }.padding(.horizontal)
            }
            .navigationTitle("Kudo")
            .navigationBarItems(trailing:
                                    HStack {
                NavigationLink{ToolsView()} label: {
                    Label("Tools", systemImage: "plus.app" )
                }
                NavigationLink{ToolsView()} label: {
                    Label("Settings", systemImage: "gearshape" )
                }
            }.padding()
            )
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
