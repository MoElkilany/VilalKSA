//
//  TextStyles.swift
//  VilalKSA
//
//  Created by Elkilany on 10/12/2023.
//

import SwiftUI

struct TextExtraBold16: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoExtraBold.rawValue, size: 16))
//            .font(.system(size: 18, weight: .heavy))
            .foregroundColor(textColor)
    }
}



struct TextExtraBold20: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoExtraBold.rawValue, size: 20))
//            .font(.system(size: 22, weight: .heavy))
            .foregroundColor(textColor)
    }
}



struct TextRegular12: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoRegular.rawValue, size: 12))
//            .font(.system(size: 12, weight: .regular))
            .foregroundColor(textColor)
    }
}


struct TabBarText: View {
    
    var text: LocalizedStringKey
    init(text: LocalizedStringKey) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoMedium.rawValue, size: 12))
    }
}


struct TextRegular14: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
//            .font(.system(size: 14, weight: .regular))
            .font(Font.custom(FontName.cairoRegular.rawValue, size: 14))
            .foregroundColor(textColor)
    }
}


struct TextRegular16: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
//            .font(.system(size: 14, weight: .regular))
            .font(Font.custom(FontName.cairoRegular.rawValue, size: 16))
            .foregroundColor(textColor)
    }
}



struct TextSemiBold12: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
//            .font(.system(size: 12, weight: .semibold))
            .font(Font.custom(FontName.cairoSemiBold.rawValue, size: 12))
            .foregroundColor(textColor)
    }
}


struct TextSemiBold11: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoSemiBold.rawValue, size: 11))
//            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(textColor)
    }
}


struct TextSemiBold14: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
//            .font(.system(size: 14, weight: .semibold))
            .font(Font.custom(FontName.cairoRegular.rawValue, size: 14))
            .foregroundColor(textColor)
    }
}


struct TextBold12: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 12))
//            .font(.system(size: 12, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold14: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 14))
//            .font(.system(size: 14, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold20: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 20))
//            .font(.system(size: 20, weight: .bold))
            .foregroundColor(textColor)
    }
}

struct TextBold16: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 16))
//            .font(.system(size: 16, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold18: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 18))
//            .font(.system(size: 16, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold10: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 10))

//            .font(.system(size: 10, weight: .bold))
            .foregroundColor(textColor)
    }
}


struct TextBold8: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoBold.rawValue, size: 8))
//            .font(.system(size: 8, weight: .bold))
            .foregroundColor(textColor)
    }
}



struct TextMeduim: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoMedium.rawValue, size: 10))
//            .font(.system(size: 10, weight: .medium))
            .foregroundColor(textColor)
    }
}


struct TextMeduim12: View {
    var text: LocalizedStringKey
    var textColor: Color
    
    init(text: LocalizedStringKey, textColor: Color) {
        self.text = text
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .font(Font.custom(FontName.cairoMedium.rawValue, size: 12))
//            .font(.system(size: 10, weight: .medium))
            .foregroundColor(textColor)
    }
}
