//
//  homeViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit
import SnapKit
import Then
import Combine

enum Section: Int {
    case currentDeliverySection
    case insightDeliverySection
}

class HomeMainViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    var itemModel1: [Int] = [1]
    var itemModel2: [Int] = [4,5,6,7,8]
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int>
    
    private var dataSource: DataSource!
    private var cancelBag = Set<AnyCancellable>()
    private var snapshot = Snapshot()
//    private var viewModel: AccountMainViewModel!
    
//    public init(viewModel: HomeMainViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = Self.getLayout()
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        $0.collectionViewLayout = layout
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        $0.contentInset = .zero
        $0.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 247/255, alpha: 1)
        $0.clipsToBounds = true
        $0.register(CurrentDeliveryCell.self, forCellWithReuseIdentifier: CurrentDeliveryCell.reuseIdentifier)
        $0.register(InsightDeliveryCell.self, forCellWithReuseIdentifier: InsightDeliveryCell.reuseIdentifier)
        $0.register(CurrentDeliveryHeaderView.self, forSupplementaryViewOfKind: CurrentDeliveryHeaderView.supplementaryViewOfKind, withReuseIdentifier: CurrentDeliveryHeaderView.reuseIdentifier)
        $0.register(InsightDeliveryHeaderView.self, forSupplementaryViewOfKind: InsightDeliveryHeaderView.supplementaryViewOfKind, withReuseIdentifier: InsightDeliveryHeaderView.reuseIdentifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        addViews()
        makeConstraints()
        setUpCollectionView()
        fetchSnapShot()
//        bind()
    }
    
    func fetchSnapShot() {// MARK: - 여기부터 다시 시작
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.currentDeliverySection,
                                 .insightDeliverySection])
        itemModel1.map { snapshot.appendItems([$0], toSection: .currentDeliverySection)}
        itemModel2.map { snapshot.appendItems([$0], toSection: .insightDeliverySection)}
        
        dataSource.apply(snapshot)
    }
}





extension HomeMainViewController {
    static private func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let itemInset: CGFloat = CGFloat(moderateScale(number: 10))

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: 0, trailing: itemInset)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(CGFloat(moderateScale(number: 160/812)))
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: CGFloat(moderateScale(number: -10)), trailing: 0)
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(moderateScale(number: 56)))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: CurrentDeliveryHeaderView.supplementaryViewOfKind,
                    alignment: .top
                )
                header.pinToVisibleBounds = true
                header.zIndex = 1
                section.boundarySupplementaryItems = [header]
                return section
            default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(CGFloat(moderateScale(number: 77/812)))
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(moderateScale(number: 56)))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: InsightDeliveryHeaderView.supplementaryViewOfKind,
                    alignment: .top
                )
                header.pinToVisibleBounds = true
                header.zIndex = 2
                section.boundarySupplementaryItems = [header]
                return section
            }
        }
    }
    
    private func setUpCollectionView() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let section = Section(rawValue: indexPath.section)
            
            switch section {
            case .currentDeliverySection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentDeliveryCell.reuseIdentifier, for: indexPath)
                (cell as? CurrentDeliveryCell)?.model = itemIdentifier
                return cell
            case .insightDeliverySection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InsightDeliveryCell.reuseIdentifier, for: indexPath)
                (cell as? InsightDeliveryCell)?.model = itemIdentifier
                return cell
            default:
                return UICollectionViewCell()
            }
        })
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let section = Section(rawValue: indexPath.section)
            switch section {
            case .currentDeliverySection:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentDeliveryHeaderView.reuseIdentifier, for: indexPath) as? CurrentDeliveryHeaderView else {
                    fatalError("Could not dequeue sectionHeader: \(CurrentDeliveryHeaderView.reuseIdentifier)")
                }
                return sectionHeader
            case .insightDeliverySection:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InsightDeliveryHeaderView.reuseIdentifier, for: indexPath) as? InsightDeliveryHeaderView else {
                    fatalError("Could not dequeue sectionHeader: \(InsightDeliveryHeaderView.reuseIdentifier)")
                }
                
//                sectionHeader.delegate = self
                
//                if sectionHeader.viewModel == nil {
//                    sectionHeader.viewModel = self.viewModel
//                }
                return sectionHeader
            default:
                return UICollectionReusableView()
            }
        }
    }
}


extension HomeMainViewController {
    private func addViews() {
        view.addSubview(collectionView)
    }

    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(moderateScale(number: 64))
            $0.bottom.equalToSuperview().offset(moderateScale(number: -64))
            $0.leading.trailing.equalToSuperview()
        }
    }
}
