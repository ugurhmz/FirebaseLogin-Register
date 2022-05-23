//
//  HomeVC.swift
//  LoginRegister
//
//  Created by ugur-pc on 22.05.2022.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isCurrentUserCheck()
        view.backgroundColor = .white
        customNavigateBar()
    }
    
    private func customNavigateBar(){
        if #available(iOS 13.0, *) {
              let navBarAppearance = UINavigationBarAppearance()
               navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: UIFont(name: "Charter-Black", size: 30)!]
             
               navigationController?.navigationBar.barStyle = .black
              navigationController?.navigationBar.standardAppearance = navBarAppearance
              navigationController?.navigationBar.compactAppearance = navBarAppearance
              navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

              navigationController?.navigationBar.prefersLargeTitles = false
            guard let user = Auth.auth().currentUser else { return }
            navigationItem.title = user.email
                  
          }
    }
    

    private func isCurrentUserCheck(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
               let navController = UINavigationController(rootViewController: LoginVC())
                navController.modalPresentationStyle = .fullScreen
               self.present(navController, animated: true, completion: nil)
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
        //  user == true
        if let user = Auth.auth().currentUser {
            
            let logOutImage = UIImage(systemName: "person.fill.xmark")?.withRenderingMode(.alwaysOriginal)
           navigationItem.leftBarButtonItem = UIBarButtonItem(image: logOutImage, style: .done,
                                                          target: self, action: nil)
            navigationItem.leftBarButtonItem?.action =  #selector(clickLogoutBtn)
        } else {
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
         }
    }
    
    @objc func clickLogoutBtn(){
     
        do {
            try Auth.auth().signOut()
            let view = HomeVC()
            let nav = UINavigationController(rootViewController: view)
            self.view.window?.rootViewController = nav
        } catch {
            self.handleFireAuthError(error: error,
                                           fontSize: 25,
                                           textColor: #colorLiteral(red: 0.9254902005, green: 0.3018482075, blue: 0.1536569698, alpha: 1),
                                           bgColor: .white)
            print(error.localizedDescription)
        }
    }
    
   

}
