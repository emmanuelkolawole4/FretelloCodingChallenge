
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
    
    let maximumPracticePerformanceIncreaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
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
    
    func setupMaximumPracticePerformanceIncreaseLabel() {
        view.addSubview(maximumPracticePerformanceIncreaseLabel)
        maximumPracticePerformanceIncreaseLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(banner).offset(-10)
            make.left.equalTo(banner).offset(10)
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
        setupMaximumPracticePerformanceIncreaseLabel()
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    func injectView() { PracticeSessionsPresenter.shared.practiceSessionsView = self }
    
}


extension PracticeSessionsViewController: PracticeSessionsDisplayLogic {
    
    func displayPracticeSessions(sessions: [PracticeSession]) {
        practiceSessions = sessions.reversed()
        var exercises = [[Int]]()
        
        guard let unwrappedPracticeSessions = practiceSessions else { return }
        for practiceSession in unwrappedPracticeSessions {
            var exercisesBpms = [Int]()
            for exercise in practiceSession.exercises {
                exercisesBpms.append(exercise.practicedAtBpm)
            }
            exercises.append(exercisesBpms)
        }
        
        let maximumIncrease = PercentageMaximumIncrease.shared.getMaximumAverage(of: exercises.reversed())
        print(maximumIncrease)
        
        DispatchQueue.main.async {
            self.maximumPracticePerformanceIncreaseLabel.text = "\(PracticeSessionsVCStringConstants.maximumPerformance) \(maximumIncrease)"
            self.tableView.reloadData()
        }
        
    }
    
    func displayPracticeSessionsError(prompt: String) { presentAlertForError(with: prompt) }
    
}

extension PracticeSessionsViewController: UITableViewDelegate {

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
    
    func numberOfSections(in tableView: UITableView) -> Int { practiceSessions?.count ?? Int() }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { practiceSessions?[section].exercises.count ?? Int() }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.3529411765, blue: 0.2196078431, alpha: 1)
        
        let nameLabel = UILabel()
        nameLabel.text = (practiceSessions?[section].name)?.uppercased()
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        nameLabel.frame = CGRect(x: 15, y: -7 , width: self.view.frame.width, height: 40)
        headerView.addSubview(nameLabel)
        
        let dateLabel = UILabel()
        dateLabel.text = String((practiceSessions?[section].practicedOnDate)?.prefix(10) ?? "")
        dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        dateLabel.frame = CGRect(x: 15, y: 7 , width: self.view.frame.width, height: 40)
        headerView.addSubview(dateLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 40 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PracticeSessionsVCStringConstants.cellId, for: indexPath) as? PracticeSessionsCell
        let exercise = practiceSessions?[indexPath.section].exercises[indexPath.row]
        cell?.exercise = exercise
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
}
