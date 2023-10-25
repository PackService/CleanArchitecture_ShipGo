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

enum TrackCompanySection {
    case list
}

class SelectTrackCompanyViewController: UIViewController {
    weak var coordinator: Coordinator?
    
    var itemModel: [Int] = [5,6,7,8,9,10,11]
    
    private typealias DataSource = UICollectionViewDiffableDataSource<TrackCompanySection, Int>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TrackCompanySection, Int>
    
    private var dataSource: DataSource!
    private var cancelBag = Set<AnyCancellable>()
    private var snapshot = Snapshot()
   
//    private lazy var scrollView = UIScrollView()
    
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
        snapshot.appendSections([.list])
        itemModel.map { snapshot.appendItems([$0], toSection: .list)}
        dataSource.apply(snapshot)
    }
    
    // MARK: - 작업중
    static private func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
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
            let section = TrackCompanySection(rawValue: indexPath.section)
            switch section {
            case .currentDeliverySection:
                if kind == CurrentDeliveryHeaderView.supplementaryViewOfKind {
                    guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentDeliveryHeaderView.reuseIdentifier, for: indexPath) as? CurrentDeliveryHeaderView else {
                        fatalError("Could not dequeue sectionHeader: \(CurrentDeliveryHeaderView.reuseIdentifier)")
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
