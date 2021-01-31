
import UIKit
import SnapKit

class PracticeSessionsCell: UITableViewCell {
    var cardView = UIView()
    var exerciseNameLabel = UILabel()
    var excerciseBpmLabel = UILabel()
    var exerciseImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardView()
        setupExerciseNameLabel()
        setupExcerciseBpmLabel()
        setupExerciseImage()
    }
    
    func setupCardView() {
        contentView.addSubview(cardView)
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
    
    func setupExerciseNameLabel() {
        cardView.addSubview(exerciseNameLabel)
        exerciseNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        exerciseNameLabel.textColor = .systemBackground
        exerciseNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.top).offset(5)
            make.centerX.equalTo(cardView)
        }
    }
    
    func setupExcerciseBpmLabel() {
        cardView.addSubview(excerciseBpmLabel)
        excerciseBpmLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        excerciseBpmLabel.textColor = .systemBackground
        excerciseBpmLabel.snp.makeConstraints { (make) in
            make.left.equalTo(exerciseNameLabel)
            make.top.equalTo(exerciseNameLabel.snp.bottom).offset(5)
        }
    }
    
    func setupExerciseImage() {
        cardView.addSubview(exerciseImageView)
        exerciseImageView.contentMode = .scaleAspectFill
        exerciseImageView.snp.makeConstraints { (make) in
            make.top.equalTo(exerciseNameLabel)
            make.left.equalTo(cardView).offset(20)
            make.bottom.equalTo(cardView).offset(-5)
            make.right.equalTo(exerciseNameLabel.snp.left).offset(-20)
        }
    }
    
    var exercise: Exercise? {
        didSet {
            guard let exercise = exercise else { return }
            guard let imageUrl = URL(string: "\(ApiStringConstants.imageBaseUrl)\(exercise.exerciseId)\(ApiStringConstants.png)") else { return }
            contentView.backgroundColor = .systemBackground
            UIImage.loadImage(from: imageUrl) { [weak self] (image) in
                guard let strongSelf = self else { return }
                strongSelf.exerciseImageView.image = image
            }
            exerciseNameLabel.text = "\(PracticeSessionsCellConstants.exerciseName) \(exercise.name)"
            excerciseBpmLabel.text = "\(PracticeSessionsCellConstants.practisedAt) \(exercise.practicedAtBpm) \(PracticeSessionsCellConstants.bpm)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError(PracticeSessionsCellConstants.fatalError) }
}
