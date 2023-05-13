
import UIKit

class AddExcersiceListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedScheduleTitleLbl: UILabel!
    
    var currentSchedule:FirestoreSchedule?
    
    override func viewDidLoad() {
        selectedScheduleTitleLbl.text = currentSchedule?.scheduleTitle
        tableView.reloadData()
        super.viewDidLoad()
    }
    
    func navigateToPickExcerciseView(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "PickExcerciseVC")
        if let _vc = vc as? PickExcerciseVC {
            _vc.firestoreSchedule = currentSchedule
        }
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: true)
        present(navigationController, animated: true)
    }
    
    func startSchedule(){
        let vc = ApplicationServiceProvider.shared.viewController(in: .Schedule, identifier: "StartedScheduleVC")
        if let _vc = vc as? StartedScheduleVC {
            _vc.currentSchedule = currentSchedule
        }
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: true)
        present(navigationController, animated: true)
    }

    @IBAction func addExcerciceAction(_ sender: Any) {
        navigateToPickExcerciseView()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func startScheduleAction(_ sender: Any) {
        startSchedule()
    }
}

extension AddExcersiceListVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSchedule!.exerciseList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddExersiceListTVCell" , for: indexPath)
        if let _cell = cell as? AddExersiceListTVCell {
            _cell.configCell(scheduleExercise: currentSchedule!.exerciseList[indexPath.row])

        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
