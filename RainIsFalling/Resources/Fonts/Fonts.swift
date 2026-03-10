import SwiftUI

enum Fonts {
    enum Title {
        enum Large {
            static let bold = UIFont.systemFont(ofSize: 34, weight: .bold)
            static let regular = UIFont.systemFont(ofSize: 34, weight: .regular)
        }
        enum Title1 {
            static let bold = UIFont.systemFont(ofSize: 28, weight: .bold)
            static let regular = UIFont.systemFont(ofSize: 28, weight: .regular)
        }
        
        enum Title2 {
            static let bold = UIFont.systemFont(ofSize: 22, weight: .bold)
            static let regular = UIFont.systemFont(ofSize: 22, weight: .regular)
        }
        
        enum Title3 {
            static let bold = UIFont.systemFont(ofSize: 20, weight: .bold)
            static let semibold = UIFont.systemFont(ofSize: 20, weight: .semibold)
            static let regular = UIFont.systemFont(ofSize: 20, weight: .regular)
        }
    }
    
    enum Headline {
        static let semibold = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let regular = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let medium = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    enum Body {
        enum BodyL {
            static let semibold = UIFont.systemFont(ofSize: 17, weight: .semibold)
            static let regular = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
        
        enum BodyM {
            static let semibold = UIFont.systemFont(ofSize: 15, weight: .semibold)
            static let regular = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
        
        enum BodyS {
            static let semibold = UIFont.systemFont(ofSize: 13, weight: .semibold)
            static let regular = UIFont.systemFont(ofSize: 13, weight: .regular)
        }
    }
    
    enum NoSystemDisign {
        static let subheadBold = UIFont.systemFont(ofSize: 15, weight: .bold)
        static let subheadMedium = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let subheadRegular = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    enum Caption {
        enum Caption1 {
            static let semibold = UIFont.systemFont(ofSize: 12, weight: .semibold)
            static let medium = UIFont.systemFont(ofSize: 12, weight: .medium)
            static let regular = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        enum Caption2 {
            static let semibold = UIFont.systemFont(ofSize: 11, weight: .semibold)
            static let regular = UIFont.systemFont(ofSize: 11, weight: .regular)
        }
    }
}

extension UIFont {
    var suiFont: Font {
        Font(self as CTFont)
    }
}

#Preview {
    return ScrollView {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                Text("Title Large Bold")
                    .font(Fonts.Title.Large.bold.suiFont)
                Text("Title Large Regular")
                    .font(Fonts.Title.Large.regular.suiFont)
                Text("Title1 Bold")
                    .font(Fonts.Title.Title1.bold.suiFont)
                Text("Title1 Regular")
                    .font(Fonts.Title.Title1.regular.suiFont)
                Text("Title2 Bold")
                    .font(Fonts.Title.Title2.bold.suiFont)
                Text("Title2 Regular")
                    .font(Fonts.Title.Title2.regular.suiFont)
                Text("Title3 Semibold")
                    .font(Fonts.Title.Title3.semibold.suiFont)
                Text("Title3 Regular")
                    .font(Fonts.Title.Title3.regular.suiFont)
            }
            
            Group {
                Text("Headline Semibold")
                    .font(Fonts.Headline.semibold.suiFont)
                Text("Headline Regular")
                    .font(Fonts.Headline.regular.suiFont)
                Text("Headline Medium")
                    .font(Fonts.Headline.medium.suiFont)
                Text("BodyL Semibold")
                    .font(Fonts.Body.BodyL.semibold.suiFont)
                Text("BodyL Regular")
                    .font(Fonts.Body.BodyL.regular.suiFont)
                Text("BodyM Semibold")
                    .font(Fonts.Body.BodyM.semibold.suiFont)
                Text("BodyM Regular")
                    .font(Fonts.Body.BodyM.regular.suiFont)
                Text("BodyS Semibold")
                    .font(Fonts.Body.BodyS.semibold.suiFont)
                Text("BodyS Regular")
                    .font(Fonts.Body.BodyS.regular.suiFont)
            }
            
            Group {
                Text("Caption1 Semibold")
                    .font(Fonts.Caption.Caption1.semibold.suiFont)
                Text("Caption1 Regular")
                    .font(Fonts.Caption.Caption1.regular.suiFont)
                Text("Caption2 Semibold")
                    .font(Fonts.Caption.Caption2.semibold.suiFont)
                Text("Caption2 Regular")
                    .font(Fonts.Caption.Caption2.regular.suiFont)
            }
        }
        .padding()
    }
}
