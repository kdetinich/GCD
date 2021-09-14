//
//  secondViewController.swift
//  GCD
//
//  Created by Екатерина Детинич on 07.07.2021.
//

import UIKit
class secondViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage?{
        
        get {
            return imageView.image
        }
        set{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
        
    }
    
    fileprivate func delay(_ delay:Int, closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
        
    }
    
    fileprivate func loginAlert(){
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш лоин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true 
            
        }
        
        self.present(ac, animated: true, completion: nil)
        
    }
    
    fileprivate func fetchImage(){
        imageURL = URL (string: "https://www.m24.ru/b/d/nBkSUhL2hFQmncmwL76BrNOp2Z318Ji-miDHnvyDoGuQYX7XByXLjCdwu5tI-BaO-42NvWWBK8AqGfS8kjIzIymM8G1N_xHb1A=DuEKGyzMcLXDjjbxhxLt6Q.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage (data: imageData)
            }
                    
        }
                
    }
}
