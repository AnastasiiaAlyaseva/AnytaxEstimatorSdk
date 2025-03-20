import SwiftUI

extension Image {
    func responsiveImage(geometry: GeometryProxy) -> some View {
        let isLandscape = geometry.size.width > geometry.size.height
        let imageSizeFactor: CGFloat = isLandscape ? 0.2 : 0.4
        let topPaddingFactor: CGFloat = isLandscape ? 0.05 : 0.15
        
        return self
            .resizable()
            .scaledToFit()
            .frame(
                width: geometry.size.width * imageSizeFactor,
                height: geometry.size.width * imageSizeFactor
            )
            .padding(.top, geometry.size.height * topPaddingFactor)
            .padding(.bottom, geometry.size.height * 0.02)
    }
}
