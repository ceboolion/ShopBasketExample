import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navController
        setupNavBarAppearance()
        return true
    }
    
    private func setupNavBarAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.standardAppearance = customNavBarAppearance()
        appearance.compactAppearance = customNavBarAppearance()
        appearance.scrollEdgeAppearance = customNavBarAppearance()
    }
    
    private func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = .systemBackground
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.secondaryLabel]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.label]
        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
        return customNavBarAppearance
    }


}

