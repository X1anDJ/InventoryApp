//
//  AppDelegate.swift
//  InventoryApp
//
//  Created by Dajun Xian on 2024/1/7.
//
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

let appColor: UIColor = .systemGray

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let smsController = VerificationController()
    let onboardingViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    let productCardController = ProductCardViewController()
    var cardViewModel: CardViewModel!
    var frontCardViewController: FrontCardViewController!
    var backCardViewController: BackCardViewController!
    let storageController = StorageCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    /*
     
     
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        //Google sign-in instance and configuration
        guard let clientID = FirebaseApp.app()?.options.clientID else { return false }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        //        window?.rootViewController = loginViewController
        
        //===============Front card testing=================
        let product = Product() // Initialize your product model
        cardViewModel = CardViewModel(product: product)
        // Fetch product data
        cardViewModel.fetchProductData()
        
        // Initialize and configure child view controllers
        frontCardViewController = FrontCardViewController(viewModel: cardViewModel)
        backCardViewController  = BackCardViewController(viewModel: cardViewModel)
        //================================
        
        let navigationController = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navigationController
        
        if Auth.auth().currentUser == nil {
            window?.rootViewController = navigationController
            //window?.rootViewController = smsController
        } else {
            window?.rootViewController = mainViewController
            //window?.rootViewController = navigationController
            //window?.rootViewController = smsController
            //window?.rootViewController = frontCardViewController
            //window?.rootViewController = backCardViewController
            //window?.rootViewController = storageController
            //window?.rootViewController = productCardController
        }
        
        return true
    }
    
}


extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    //Google login
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}
