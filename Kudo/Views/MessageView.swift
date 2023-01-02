//
//  MessageView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 31/12/2022.
//

import SwiftUI

struct MessageView: View {
    let id = UUID()
    let message : Message
    var floatToRight : Bool = false
    var imageUrl : String = ""
    var body: some View {
        let userBackgroundColor = #colorLiteral(red: 0.1637533307, green: 0.1771335602, blue: 0.1965154707, alpha: 1)
        let userForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let botBackgroundColor = #colorLiteral(red: 0.09458664805, green: 0.1521758139, blue: 0.4795582891, alpha: 1)
        let botForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        HStack {
            if floatToRight { Spacer() }
            VStack{
                Text(message.content)
                    
                    .truncationMode(.middle)
                    
                if imageUrl != "" {
                    AsyncImage(url: URL(string: imageUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "photo.fill")
                    }
                    .frame(maxWidth: 270, maxHeight: 250)
                    .padding(.vertical)
                }
            }
            .frame(minWidth: 20, maxWidth: 270, alignment: .leading)
            .padding()
            .background(Color(floatToRight ? botBackgroundColor : userBackgroundColor))
            .foregroundColor(Color(floatToRight ? botForegroundColor : userForegroundColor))
            .cornerRadius(20)
            
            if !floatToRight { Spacer() }
        }
            
    }
}

struct MessageView_Previews: PreviewProvider {
    
    static var shortOutMessge = Message(content: "user short message")
    static var longOutMessage = Message(content: "user long message user long message user long message user long message user long message user long message user long message user long message user long message")
    static var shortInMessage = Message(content: "bot short answer")
    static var longInMessage = Message(content: "bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer")
    static var longInImageMessage = Message(content: "bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer")
    
    static var previews: some View {
        Group{
            MessageView(message: shortOutMessge)
            MessageView(message: longOutMessage)
            MessageView(message: shortInMessage, floatToRight: true)
            MessageView(message: longInMessage, floatToRight: true)
            MessageView(message: longInImageMessage, floatToRight: true, imageUrl: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")
        }
        .previewLayout(.sizeThatFits)
    }
}
