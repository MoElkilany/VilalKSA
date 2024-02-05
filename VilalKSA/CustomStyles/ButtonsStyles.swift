//
//  ButtonsStyles.swift
//  VilalKSA
//
//  Created by Elkilany on 06/12/2023.
//

import SwiftUI

struct BoarderCornerButton: ButtonStyle {
    
    let width:CGFloat
    let height:CGFloat
    let backgroundColor:Color
    let textColor:Color
    let borderColor: Color
    let textStyle: Font.TextStyle
    
    init(width: CGFloat, height: CGFloat, backgroundColor: Color, textColor: Color, borderColor: Color, textStyle: Font.TextStyle) {
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.textStyle = textStyle
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom(FontName.cairoSemiBold.rawValue, size: 18))
            .padding()
            .frame(width: width, height: height, alignment: .center)
        
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1)
            )
            .foregroundStyle(textColor)
            .cornerRadius(25)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}



struct DefaultButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    var backgroundColor: Color
    var foregroundColor: Color
    private let title: LocalizedStringKey
    private let action: () -> Void
    private let disabled: Bool
    private let fontWeight: Font.Weight

    init(title: LocalizedStringKey,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         action: @escaping () -> Void,fontWeight: Font.Weight) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.action = action
        self.disabled = disabled
        self.fontWeight = fontWeight
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: DefaultButton.buttonHorizontalMargins)
            Button(action:self.action) {
                Text(self.title)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(DefaultCornerButtonStyle( width: Double.infinity, backgroundColor: backgroundColor, textColor: foregroundColor, fontWeight: fontWeight))
                .disabled(self.disabled)
            Spacer(minLength: DefaultButton.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
    }
}


struct DefaultButtonWithIcon: View {
    
    var title: LocalizedStringKey
    var icon: String
    var actionButton: (()->())
    
    init(title: LocalizedStringKey, icon: String, actionButton: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.actionButton = actionButton
    }
    var body: some View {
        Button{
            actionButton()
        } label: {
            HStack(alignment: .center){
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.custom(FontName.cairoSemiBold.rawValue, size: 20))
                                
                Image(icon)
                    .frame(width: 50, height: 50, alignment : .center)
            }
        }
        .frame(maxWidth: Double.infinity, maxHeight: 60, alignment: .center)
        .background(R.color.colorPrimary.name.getColor())
        .clipShape(Capsule())
    }
}


struct DefaultBoarderButtonWithIcon: View {
    
    var title: LocalizedStringKey
    var borderColor: Color
    var backgroundColor: Color
    var titleColor: Color
    var actionButton: (()->())
    
    init(title: LocalizedStringKey, borderColor: Color, backgroundColor: Color, titleColor: Color, actionButton: @escaping () -> Void) {
        self.title = title
        self.borderColor = borderColor

        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.actionButton = actionButton
    }
    
    var body: some View {
        Button{
            actionButton()
        } label: {
                Text(title)
                    .foregroundColor(titleColor)
                    .font(Font.custom(FontName.cairoSemiBold.rawValue, size: 14))
        }
        .frame(maxWidth: Double.infinity, maxHeight: 50, alignment: .center)
        .background(backgroundColor)
        .clipShape(Capsule())
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}


struct DefaultCornerButtonStyle: ButtonStyle {
    let width:CGFloat

    let backgroundColor:Color
    let textColor:Color
    let fontWeight: Font.Weight
    
    init(width: CGFloat, backgroundColor: Color, textColor: Color, fontWeight: Font.Weight) {
        self.width = width
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.fontWeight = fontWeight
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: 50, alignment: .center)
            .font(Font.custom(FontName.cairoSemiBold.rawValue, size: 14))
            .background(backgroundColor)
            .foregroundStyle(textColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
}
