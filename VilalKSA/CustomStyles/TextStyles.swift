//
//  TextStyles.swift
//  VilalKSA
//
//  Created by Elkilany on 10/12/2023.
//

import SwiftUI

struct TextExtraBold16: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .heavy))
            .foregroundColor(textColor)
    }
}



struct TextExtraBold20: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 22, weight: .heavy))
            .foregroundColor(textColor)
    }
}



struct TextRegular12: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(textColor)
    }
}


struct TextRegular14: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(textColor)
    }
}



struct TextSemiBold12: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(textColor)
    }
}


struct TextSemiBold11: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(textColor)
    }
}


struct TextSemiBold14: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(textColor)
    }
}


struct TextBold12: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold14: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold20: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(textColor)
    }
}

struct TextBold16: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(textColor)
    }
}



struct TextBold10: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold8: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 8, weight: .bold))
            .foregroundColor(textColor)
    }
}



struct TextMeduim: View {
    var text: String
    var textColor: Color
    
    init(text: String, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 10, weight: .medium))
            .foregroundColor(textColor)
    }
}
