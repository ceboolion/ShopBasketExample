import UIKit
import SnapKit

class StartController: UIViewController {
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }


}

//MARK: - EXTENSIONS
extension StartController {
    enum Event {
        case showProduct
    }
}

