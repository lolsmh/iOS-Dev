import SwiftUI
import LinkPresentation

struct LinkView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> LPLinkView {
        let metadataProvider = LPMetadataProvider()
        var view: LPLinkView = LPLinkView()
        metadataProvider.startFetchingMetadata(for: url) { metadata, error in
            if error != nil {
                return
            }
            if let data = metadata {
                view = LPLinkView(metadata: data)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: LPLinkView, context: Context) {
        let metadataProvider = LPMetadataProvider()
        metadataProvider.startFetchingMetadata(for: url) { metadata, error in
            if error != nil {
                return
            }
            if let data = metadata {
                uiView.metadata = data
            }
        }
    }
}
