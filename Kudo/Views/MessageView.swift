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
    var body: some View {
        let userBackgroundColor = #colorLiteral(red: 0.1637533307, green: 0.1771335602, blue: 0.1965154707, alpha: 1)
        let userForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let botBackgroundColor = #colorLiteral(red: 0.09458664805, green: 0.1521758139, blue: 0.4795582891, alpha: 1)
        let botForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        HStack {
            if floatToRight { Spacer() }
            Text(message.content)
                .frame(minWidth: 20, maxWidth: 270, alignment: .leading)
                .truncationMode(.middle)
                .padding()
                .background(Color(floatToRight ? botBackgroundColor : userBackgroundColor))
                .foregroundColor(Color(floatToRight ? botForegroundColor : userForegroundColor))
                
            .cornerRadius(20)
            if !floatToRight { Spacer() }//asdsdad
        }
            
    }
}

struct MessageView_Previews: PreviewProvider {
    
    static var prototype1 = Message(content: "user short message")
    static var prototype2 = Message(content: "user long message user long message user long message user long message user long message user long message user long message user long message user long message")
    static var prototype3 = Message(content: "bot short answer")
    static var prototype4 = Message(content: "bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer bot long answer")
    
    static var previews: some View {
        Group{
            MessageView(message: prototype1)
            MessageView(message: prototype2)
            MessageView(message: prototype3, floatToRight: true)
            MessageView(message: prototype4, floatToRight: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
