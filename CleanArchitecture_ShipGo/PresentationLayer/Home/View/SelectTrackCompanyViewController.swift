//
//  SelectTrackCompanyViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/25.
//

import UIKit
import SnapKit
import Then
import Combine

enum TrackCompanySection: Int {
    case logoListSection
}

// MARK: - CompanyModel쓰면 될듯
class SelectTrackCompanyViewController: UIViewController {
    weak var coordinator: Coordinator?
    var viewModel: TrackCompanyViewModel!
    var itemModel: [Int] = [5,6,7,8,9,10]
    
    private typealias DataSource = UICollectionViewDiffableDataSource<TrackCompanySection, Int>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TrackCompanySection, Int>
    
    private var dataSource: DataSource!
    private var cancelBag = Set<AnyCancellable>()
//    private var viewModel: TrackCompanyViewModel = TrackCompanyViewModel()
    private var snapshot = Snapshot()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = Self.getLayout()
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        $0.collectionViewLayout = layout
        $0.backgroundColor = ColorManager.background
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        $0.contentInset = .zero
        $0.clipsToBounds = true
        $0.register(CompanyLogoCell.self, forCellWithReuseIdentifier: CompanyLogoCell.reuseIdentifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorManager.background
        self.navigationController?.navigationBar.isHidden = true
        addViews()
        makeConstraints()
        setUpCollectionView()
        fetchSnapShot()
    }
    
    private func addViews() {
        view.addSubview(collectionView)
    }

    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(moderateScale(number: 64))
            $0.bottom.equalToSuperview().offset(moderateScale(number: -64))
            $0.leading.equalToSuperview().offset(moderateScale(number: 20))
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
    }
    
    private func fetchSnapShot() {// MARK: - 여기부터 다시 시작
        var snapshot = NSDiffableDataSourceSnapshot<TrackCompanySection, Int>()
        snapshot.appendSections([.logoListSection])
        itemModel.map { snapshot.appendItems([$0], toSection: .logoListSection)}
        dataSource.apply(snapshot)
    }
    
    // MARK: - 작업중
    static private func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            default:
                let itemInset: CGFloat = CGFloat(moderateScale(number: 5))
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(CGFloat(moderateScale(number: 98/812)))
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    }
    
    private func setUpCollectionView() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let section = TrackCompanySection(rawValue: indexPath.section)
            
            switch section {
            case .logoListSection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyLogoCell.reuseIdentifier, for: indexPath)
                (cell as? CompanyLogoCell)?.model = itemIdentifier
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
}
