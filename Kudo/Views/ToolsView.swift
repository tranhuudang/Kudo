//
//  ToolsView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 31/12/2022.
//

import SwiftUI

struct ToolsView: View {
    var noteBackgroundColor = Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    var body: some View {
        ScrollView{
            ZStack{
                Text("Notes")
                    .padding()
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity, maxHeight: 150, alignment: .bottomLeading)
            .frame(height:150)
            .background(noteBackgroundColor)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.top)
            ZStack{
                Text("Translation")
                    .padding()
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity, maxHeight: 150, alignment: .bottomLeading)
            .frame(height: 150)
            .background(.gray)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.top)
            ZStack{
                Text("Taking notes")
                    .padding()
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity, maxHeight: 150, alignment: .bottomLeading)
            .frame(height: 150)
            .background(.gray)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.top)
            ZStack{
                Text("Taking notes")
                    .padding()
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity, maxHeight: 200, alignment: .bottomLeading)
            .frame(height: 150)
            .background(.gray)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.top)
            
        }
        .navigationTitle("Tools")
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ToolsView()
        }
    }
}
