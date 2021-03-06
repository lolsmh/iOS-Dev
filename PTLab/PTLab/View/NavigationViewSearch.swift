

import SwiftUI

struct NavigationViewSearch: UIViewControllerRepresentable {
    var view: CheckListView
    var onSearch: (String) -> Void
    var onCancel: () -> Void
    
    init(view: CheckListView, onSearch: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        self.onSearch = onSearch
        self.onCancel = onCancel
        self.view = view
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let child = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: child)
        controller.navigationBar.topItem?.title = "Органайзер"
        controller.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController()
        
        searchController.searchBar.placeholder = "Задача, дата, описание..."
        
        searchController.searchBar.delegate = context.coordinator
        
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: NavigationViewSearch
        
        init(_ parent: NavigationViewSearch) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.parent.onSearch(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.parent.onCancel()
        }
    }
}
