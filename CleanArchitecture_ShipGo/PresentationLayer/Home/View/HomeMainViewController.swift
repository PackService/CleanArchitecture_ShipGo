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
    case insightDetailSection
}

class HomeMainViewController: UIViewController {
    
    weak var coordinator: TabBarHomeCoordinator?
    private var cancelBag = Set<AnyCancellable>()
    
    var itemModel1: [Int] = [1]
    var itemModel2: [Int] = [4]
    var itemModel3: [Int] = [5,6,7,8]
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int>
    private typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<CurrentDeliveryHeaderView>
    private typealias FooterRegistration = UICollectionView.SupplementaryRegistration<CurrentDeliveryFooterView>
    
    private var dataSource: DataSource!
    private var snapshot = Snapshot()
    var viewModel: HomeMainViewModel!
//    var viewModel: HomeMainViewModel = AppContainer.shared._resolve(name: <#T##String?#>, invoker: <#T##((Arguments) -> Any) -> Any#>)

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
        $0.register(CurrentDeliveryCell.self, forCellWithReuseIdentifier: CurrentDeliveryCell.reuseIdentifier)
        $0.register(InsightDeliveryMainCell.self, forCellWithReuseIdentifier: InsightDeliveryMainCell.reuseIdentifier)
        $0.register(InsightDeliverySubCell.self, forCellWithReuseIdentifier: InsightDeliverySubCell.reuseIdentifier)
        $0.register(CurrentDeliveryHeaderView.self, forSupplementaryViewOfKind: CurrentDeliveryHeaderView.supplementaryViewOfKind, withReuseIdentifier: CurrentDeliveryHeaderView.reuseIdentifier)
        $0.register(InsightDeliveryHeaderView.self, forSupplementaryViewOfKind: InsightDeliveryHeaderView.supplementaryViewOfKind, withReuseIdentifier: InsightDeliveryHeaderView.reuseIdentifier)
        $0.register(CurrentDeliveryFooterView.self, forSupplementaryViewOfKind: CurrentDeliveryFooterView.supplementaryViewOfKind, withReuseIdentifier: CurrentDeliveryFooterView.reuseIdentifier)
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
        bind()
    }
    
    func bind() {
        viewModel.showRegisterPublisher()
            .sink { state in
                if state == true {
                    self.coordinator?.registerTrackNumber()
                }
            }
            .store(in: &cancelBag)
    }
    
    func fetchSnapShot() {// MARK: - 여기부터 다시 시작
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.currentDeliverySection,
                                 .insightDeliverySection,
                                 .insightDetailSection])
        itemModel1.map { snapshot.appendItems([$0], toSection: .currentDeliverySection)}
        itemModel2.map { snapshot.appendItems([$0], toSection: .insightDeliverySection)}
        itemModel3.map { snapshot.appendItems([$0], toSection: .insightDetailSection)}
        
        dataSource.apply(snapshot)
    }
}

extension HomeMainViewController {
    static private func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
//                let itemInset: CGFloat = CGFloat(moderateScale(number: 10)) // MARK: - 이런식으로 inset 줌

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: 0, trailing: itemInset)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(CGFloat(moderateScale(number: 160/812)))
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(moderateScale(number: 56)))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: CurrentDeliveryHeaderView.supplementaryViewOfKind,
                    alignment: .top
                )
                
                let footer =  NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(moderateScale(number: 36))),
                    elementKind: CurrentDeliveryFooterView.supplementaryViewOfKind,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [header, footer]
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(CGFloat(moderateScale(number: 88/812)))
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
            default:
                let itemInset: CGFloat = CGFloat(moderateScale(number: 5)) // MARK: - 이런식으로 inset 줌
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
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
            let section = Section(rawValue: indexPath.section)
            
            switch section {
            case .currentDeliverySection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentDeliveryCell.reuseIdentifier, for: indexPath)
                (cell as? CurrentDeliveryCell)?.model = itemIdentifier
                return cell
            case .insightDeliverySection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InsightDeliveryMainCell.reuseIdentifier, for: indexPath)
                (cell as? InsightDeliveryMainCell)?.model = itemIdentifier
                return cell
            case .insightDetailSection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InsightDeliverySubCell.reuseIdentifier, for: indexPath)
                (cell as? InsightDeliverySubCell)?.model = itemIdentifier
                return cell
            default:
                return UICollectionViewCell()
            }
        })
        
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let section = Section(rawValue: indexPath.section)
            switch section {
            case .currentDeliverySection:
                if kind == CurrentDeliveryHeaderView.supplementaryViewOfKind {
                    guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentDeliveryHeaderView.reuseIdentifier, for: indexPath) as? CurrentDeliveryHeaderView else {
                        fatalError("Could not dequeue sectionHeader: \(CurrentDeliveryHeaderView.reuseIdentifier)")
                    }
                    if sectionHeader.viewModel == nil {
                        sectionHeader.viewModel = self?.viewModel
                    }
                    return sectionHeader
                } else if kind == CurrentDeliveryFooterView.supplementaryViewOfKind {
                    guard let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentDeliveryFooterView.reuseIdentifier, for: indexPath) as? CurrentDeliveryFooterView else {
                        fatalError("Could not dequeue sectionFooter: \(CurrentDeliveryFooterView.reuseIdentifier)")
                    }
                    return sectionFooter
                }
                return UICollectionReusableView() // 빈 뷰를 반환하도록 수정
            case .insightDeliverySection:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InsightDeliveryHeaderView.reuseIdentifier, for: indexPath) as? InsightDeliveryHeaderView else {
                    fatalError("Could not dequeue sectionHeader: \(InsightDeliveryHeaderView.reuseIdentifier)")
                }
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
            $0.leading.equalToSuperview().offset(moderateScale(number: 20))
            $0.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
    }
    
//    @objc func RegisterTrackNumberButtonTapped(){ // MARK: - 이거하려면 viewmodel있어야함
//        coordinator?.registerTrackNumber()
//    }
}
