import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let networkService: NetworkServiceProtocol = NetworkService()
   
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = WeatherViewController(networkService: networkService)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
