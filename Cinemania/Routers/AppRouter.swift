import UIKit

class AppRouter {
    static let shared =  AppRouter()
    
    private init() {}
    
    func navigateToDetails(
        from viewController: UIViewController,
        media: Media,
        genres: [Genre]
    ) {
        let detailsViewModel = DetailsViewModel(media: media, genres: genres)
        detailsViewModel.fetchMediaDetails()
        let detailsViewController = DetailsViewController(detailsViewModel: detailsViewModel)
        detailsViewController.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
