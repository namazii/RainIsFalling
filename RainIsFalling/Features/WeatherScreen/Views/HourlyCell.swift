import UIKit

final class HourlyCell: UICollectionViewCell {
    
    static let identifier = "HourlyCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.NoSystemDisign.subheadRegular
        label.textColor = Colors.Content.secondary
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.NoSystemDisign.subheadBold
        label.textColor = Colors.Content.primary
        label.textAlignment = .center
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack.addArrangedSubview(timeLabel)
        stack.addArrangedSubview(tempLabel)
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(time: String, temp: String) {
        timeLabel.text = time
        tempLabel.text = temp
    }
}
