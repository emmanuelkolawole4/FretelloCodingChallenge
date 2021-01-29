
import UIKit
import SnapKit

protocol PracticeSessionsDisplayLogic {
    func displayPracticeSessions(sessions: [PracticeSession])
    func displayPracticeSessionsError(prompt: String)
}

class PracticeSessionsViewController: UIViewController {
    
    var practiceSessions: [PracticeSession]?
    
    let banner: UIImageView = {
        let banner = UIImageView()
        banner.image = UIImage(named: PracticeSessionsVCStringConstants.fretelloImage)
        banner.contentMode = .scaleAspectFill
        banner.backgroundColor = .systemBackground
        banner.clipsToBounds = true
        return banner
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = .zero
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(PracticeSessionsCell.self, forCellReuseIdentifier: PracticeSessionsVCStringConstants.cellId)
        return tableView
    }()
    
    func setupBanner() {
        view.addSubview(banner)
        banner.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(banner.snp.bottom).offset(0)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PracticeSessionsInteractor.shared.loadPracticeSessions()
        injectView()
        setupViews()
    }
    
    func setupViews() {
        setupBanner()
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func injectView() {
        PracticeSessionsPresenter.shared.practiceSessionsView = self
    }
    
}


extension PracticeSessionsViewController: PracticeSessionsDisplayLogic {
    func displayPracticeSessions(sessions: [PracticeSession]) {
        practiceSessions = sessions
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayPracticeSessionsError(prompt: String) {
        presentAlertForNetworkError(with: prompt)
    }
}


extension PracticeSessionsViewController: UITableViewDelegate {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return practiceSessions?.count ?? 0
//    }
    
//    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = #colorLiteral(red: 0.6010031104, green: 0.5656787753, blue: 0.4985913038, alpha: 1)
//
//        let nameLabel = UILabel()
//        nameLabel.text = (practiceSessions?[section].name)?.uppercased()
//        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        nameLabel.frame = CGRect(x: 15, y: -7 , width: self.view.frame.width, height: 50)
//        headerView.addSubview(nameLabel)
//
//        let dateLabel = UILabel()
//        dateLabel.text = String((practiceSessions?[section].practicedOnDate)?.prefix(10) ?? "")
//        dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        dateLabel.font = UIFont.boldSystemFont(ofSize: 10)
//        dateLabel.frame = CGRect(x: 15, y: 7 , width: self.view.frame.width, height: 50)
//        headerView.addSubview(dateLabel)
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 45
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -5, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

extension PracticeSessionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return practiceSessions?.count ?? Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PracticeSessionsVCStringConstants.cellId, for: indexPath) as? PracticeSessionsCell
        let exercises = practiceSessions?[indexPath.row]
        cell?.practiceSession = exercises
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
