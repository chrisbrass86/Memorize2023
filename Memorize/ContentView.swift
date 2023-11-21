//
//  ContentView.swift
//  Memorize
//
//  Created by Christoph Braß on 21.11.23.
//

import SwiftUI

struct ContentView: View {
    let vehicles = ["🚗","🚕","🚜","✈️","🚀","🚙","🚲","🚂","🚁","🛸","⛵️"]
    let animals = ["🐶","🐱","🐯","🐷","🦁","🐼","🐥","🐰","🐵"]
    let halloween = ["👻", "🎃","🕷️", "😈","💀","🕸️","🧙🏻","🙀","👹","😱","☠️","🍭"]
    let faces = ["😀","😎","💩","🥱","🙄","🥵","😍","☺️","🥹","😂"]
    
    @State var emojis: Array<String> = []
    @State var themeColor: Color = Color.orange
    
    var body: some View {
        VStack {
            gameTitle
            ScrollView {
                cards
            }
            .padding()
            Spacer()
            themeChooser
        }
        .padding()
    }
    
    var gameTitle: some View {
        Text("Memorize!").font(.largeTitle).padding()
    }
    
    var themeChooser: some View {
        HStack {
            themeVehicles
            themeFaces
            themeAnimals
        }
      
    }
    
    var themeVehicles: some View {
        themeButtonBuilder(theme: vehicles, themeSymbol: "car", themeName: "Vehicles", themeColor: Color.red, themePairCount: 2)
    }
    
    var themeFaces: some View {
        themeButtonBuilder(theme: faces, themeSymbol: "face.smiling.inverse", themeName: "Faces", themeColor: Color.yellow, themePairCount: 6)
    }
    
    var themeAnimals: some View {
        themeButtonBuilder(theme: animals, themeSymbol: "dog.circle", themeName: "Animals", themeColor: Color.green, themePairCount: 8)
    }
    
    func themeButtonBuilder(theme: Array<String>, themeSymbol: String, themeName: String, themeColor: Color, themePairCount: Int) -> some View {
            Button(action: {
                emojis = (theme[0..<themePairCount] + theme[0..<themePairCount]).shuffled()
                self.themeColor = themeColor
            },
                   label: {
                VStack{
                    Image(systemName: themeSymbol).imageScale(.large)
                        .font(.title)
                    Text(themeName).font(.caption)
                }
                 .padding()
            })
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        // Annäherung
        return 187.05*pow(CGFloat(cardCount),-0.5988)
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:  widthThatBestFits(cardCount: emojis.count)))]) {
                ForEach(0..<emojis.count, id: \.self){ index in
                    CardView(content: emojis[index])
                        .aspectRatio(2/3, contentMode: .fill)
                }
            }
            .foregroundColor(themeColor)
    }
    
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}





#Preview {
    ContentView()
}

