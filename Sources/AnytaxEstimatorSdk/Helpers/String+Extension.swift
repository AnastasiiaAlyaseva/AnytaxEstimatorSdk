import SwiftUI

extension String {
    init(localized: String.LocalizationValue) {
        self = String(localized: localized, bundle: .currentBundle)
    }
    
    var asAttributedString: AttributedString {
        AttributedString(self)
    }
    
    var italicized: AttributedString {
        italicize(substring: self)
    }
    
    var bolded: AttributedString {
        bold(substring: self)
    }
    
    func italicize(substring: String) -> AttributedString {
        var attributedString = AttributedString(self)
        
        if let range = attributedString.range(of: substring) {
            attributedString[range].font = .italic(.body)()
        }
        return attributedString
    }
    
    func bold(substring: String) -> AttributedString {
        var attributedString = AttributedString(self)
        
        if let range = attributedString.range(of: substring) {
            attributedString[range].font = .system(size: 60, weight: .bold, design: .rounded)
        }
        return attributedString
    }
}
