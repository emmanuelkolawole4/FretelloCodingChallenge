
import UIKit
import SnapKit

class PracticeSessionsCell: UITableViewCell {
    var cardView = UIView()
    var sessionNameLabel = UILabel()
    var practiceDateLabel = UILabel()
    var excerciseBpmLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardView()
        setupSessionNameLabel()
        setupPracticeDateLabel()
        setupExcerciseBpmLabel()
    }
    
    func setupCardView() {
        contentView.addSubview(cardView)
        cardView.layer.cornerRadius = 10
        cardView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.7176470588, blue: 0.368627451, alpha: 1)
        cardView.sizeToFit()
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowOpacity = 0.8
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
    
    func setupSessionNameLabel() {
        cardView.addSubview(sessionNameLabel)
        sessionNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        sessionNameLabel.textColor = .systemBackground
        sessionNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.top).offset(10)
            make.centerX.equalTo(cardView)
        }
    }
    
    func setupPracticeDateLabel() {
        cardView.addSubview(practiceDateLabel)
        practiceDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        practiceDateLabel.textColor =  .systemBackground
        practiceDateLabel.snp.makeConstraints { (make) in
            make.center.equalTo(cardView)
        }
    }
 
    func setupExcerciseBpmLabel() {
        cardView.addSubview(excerciseBpmLabel)
        excerciseBpmLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        excerciseBpmLabel.textColor = .systemBackground
        excerciseBpmLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cardView)
            make.bottom.equalTo(cardView.snp.bottom).offset(-10)
        }
    }
    
    var practiceSession: PracticeSession? {
        didSet {
            guard let practiceSession = practiceSession else { return }
            contentView.backgroundColor = .systemBackground
            
            sessionNameLabel.text = "\(PracticeSessionsCellConstants.sessionName) \(practiceSession.name)"
            practiceDateLabel.text = String("\(PracticeSessionsCellConstants.practisedDate) \(practiceSession.practicedOnDate.prefix(10))")
            
            let arrayOfExerciseBpm = practiceSession.exercises.map{$0}

            for exerciseBpm in arrayOfExerciseBpm {
                excerciseBpmLabel.text = "\(PracticeSessionsCellConstants.practisedAt) \(exerciseBpm.practicedAtBpm) \(PracticeSessionsCellConstants.bpm)"
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(PracticeSessionsCellConstants.fatalError)
    }
}
