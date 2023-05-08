
import UIKit

class MyExcercieVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigateToPickExcerciseView(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "PickExcerciseVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func addExcerciceAction(_ sender: Any) {
        navigateToPickExcerciseView()
    }
}

extension MyExcercieVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyExcercieTVCell" , for: indexPath)
        if let _cell = cell as? MyExcercieTVCell {
            _cell.configCell(sat: 2, rep: 3.5, weight: 44)

        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
