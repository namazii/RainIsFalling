import UIKit
import SnapKit
import Combine

final class WeatherVC: UIViewController {
    private let viewModel: WeatherViewModel
    private var cancellables = Set<AnyCancellable>()

    private var hourlyData: [HourlyItem] = []
    private var dailyData: [DailyItem] = []
    
    // MARK: - UI
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title.Title1.bold
        label.textColor = Colors.Content.primary
        return label
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Title.Large.bold
        label.textColor = Colors.Content.secondary
        return label
    }()
    
    private lazy var currentTempVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, currentTempLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    private let hourlyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Почасовой прогноз"
        label.font = Fonts.Title.Title3.semibold
        label.textColor = Colors.Content.primary
        return label
    }()
    
    private let hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.BackGround.secondary
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.identifier)
        return collectionView
    }()
    
    private let dailyHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 3 дня"
        label.font = Fonts.Title.Title3.semibold
        label.textColor = Colors.Content.primary
        return label
    }()
    
    private let dailyStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Headline.regular
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Повторить", for: .normal)
        button.titleLabel?.font = Fonts.Body.BodyL.semibold
        button.isHidden = true
        return button
    }()

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.BackGround.primary
        setupUI()
        bindViewModel()
        
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.delegate = self
        
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        viewModel.send(.fetchForecast)
    }
    
    //MARK: - Actions
    @objc private func retryTapped() {
        viewModel.send(.retry)
    }

    //MARK: - Private Methods
    private func bindViewModel() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &cancellables)
    }

    private func render(state: WeatherViewState) {
        cityLabel.text = state.city
        currentTempLabel.text = state.currentTemp

        hourlyData = state.hourly
        hourlyCollectionView.reloadData()

        dailyData = state.daily
        updateDailyForecastUI()

        if state.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }

        if let message = state.errorMessage {
            showError(message: message)
        } else {
            errorLabel.isHidden = true
            retryButton.isHidden = true
        }
    }
    
    private func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        retryButton.isHidden = false
    }
    
    private func updateDailyForecastUI() {
        dailyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for day in dailyData {
            let dayLabel = UILabel()
            dayLabel.text = day.day
            dayLabel.font = .systemFont(ofSize: 16)
            dayLabel.textColor = Colors.Content.primary
            
            let tempLabel = UILabel()
            tempLabel.text = day.range
            tempLabel.font = .systemFont(ofSize: 16)
            tempLabel.textColor = Colors.Content.secondary
            
            let stack = UIStackView(arrangedSubviews: [dayLabel, tempLabel])
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            
            dailyStackView.addArrangedSubview(stack)
        }
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.addSubview(currentTempVStack)
        view.addSubview(hourlyHeaderLabel)
        view.addSubview(hourlyCollectionView)
        view.addSubview(dailyHeaderLabel)
        view.addSubview(dailyStackView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
        
        currentTempVStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        hourlyHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(currentTempVStack.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        hourlyCollectionView.snp.makeConstraints {
            $0.top.equalTo(hourlyHeaderLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        dailyHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(hourlyCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        dailyStackView.snp.makeConstraints {
            $0.top.equalTo(dailyHeaderLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        retryButton.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - UICollectionView
extension WeatherVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyCell.identifier,
            for: indexPath
        ) as? HourlyCell else { return UICollectionViewCell() }
        
        let data = hourlyData[indexPath.item]
        cell.configure(time: data.time, temp: data.temp)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 60, height: 80)
    }
}
