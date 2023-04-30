import UIKit
import FirebaseAuth
import RappleProgressHUD

class SignInScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func handleSignInActionClick(){
        if(validateForm()){
            authenticateWithFirebaseAuth()
        }
    }
    
    private func validateForm() -> Bool {
        
        var email :String? = ""
        var password:String? = ""
        
        
        guard let _email = email else {
            showErrorAlert(messageString: "Email Required!")
            return false
        }
        guard !(_email.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
            showErrorAlert(messageString: "Enter Valid Email!")
            return false
        }
        guard (_email.isValidEmailAddress()) else {
            showErrorAlert(messageString: "Enter Valid Email!")
            return false
        }
        
        guard let _password = password else {
            showErrorAlert(messageString:"Enter Password!")
            return false
        }
        guard !(_password.isEmpty) else {
            showErrorAlert(messageString:"Enter Password!")
            return false
        }
        
        return true
    }
    
    private func showErrorAlert(messageString:String){
        AlertManager.shared.singleActionMessage(title: "Alert", message: messageString, actionButtonTitle: "Ok", vc: self)
    }
    
    private  func authenticateWithFirebaseAuth(){
        var email :String? = ""
        var password:String? = ""
        
        RappleActivityIndicatorView.startAnimating()
        Auth.auth().fetchSignInMethods(forEmail: email!){(methods, signInMethodsError) in
            guard let _signInMethods = methods,signInMethodsError == nil else {
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: signInMethodsError!.localizedDescription)
                return
            }
            if ( _signInMethods.contains("password")){
                Auth.auth().signIn(withEmail: email!, password: password!){(authResult,signInError) in
                    guard let _authResult = authResult?.user,signInError == nil else {
                        RappleActivityIndicatorView.stopAnimation()
                        self.showErrorAlert(messageString: signInError!.localizedDescription)
                        return
                    }
                    FirestoreUserManager.shared.getUserDetailsStoredOnFirestoreDb(firebaseUser:_authResult) { status, message, data in
                        if (status){
                            var firestoreUser =  data as! FirestoreUser
                            Constants.currentLoggedInFireStoreUser = firestoreUser
                            RappleActivityIndicatorView.stopAnimation()
                            AlertManager.shared.singleActionMessage(title: "Alert", message: "Sign In Successfully!", actionButtonTitle: "Ok", vc: self) { action in
                                //navigate to the app home
                            }
                        }else{
                            RappleActivityIndicatorView.stopAnimation()
                            self.showErrorAlert(messageString: message!)
                        }
                    }
                }
            }else{
                RappleActivityIndicatorView.stopAnimation()
                self.showErrorAlert(messageString: "No User Found with this Email.Please Sign Up!")
                return
            }
        }
    }
    
}