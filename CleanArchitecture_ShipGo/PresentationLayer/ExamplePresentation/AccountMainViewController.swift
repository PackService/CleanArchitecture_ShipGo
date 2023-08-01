//
//  AccountMainViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

//import UIKit
//import Combine
//import SnapKit
//import Then
//
//enum Section: Int {
//    case summarySection
//    case transactionSection
//}
//
//enum SortBy: String {
//    case date
//    case amount
//}
//
//final class TransactionMainViewController: UIViewController {
//
//    private typealias DataSource = UICollectionViewDiffableDataSource<Section, TransactionResponseModel.ItemModel>
//    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TransactionResponseModel.ItemModel>
//    
//    private var dataSource: DataSource!
//    private var cancelBag = Set<AnyCancellable>()
//    private var snapshot = Snapshot()
//    var viewModel: TransactionMainViewModel!
//    
//    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
//        let layout = Self.getLayout()
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 16
//        layout.configuration = config
//        $0.collectionViewLayout = layout
//        $0.isScrollEnabled = true
//        $0.showsHorizontalScrollIndicator = false
//        $0.showsVerticalScrollIndicator = true
//        $0.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
//        $0.contentInset = .zero
//        $0.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 247/255, alpha: 1)
//        $0.clipsToBounds = true
//        $0.register(SummaryCell.self, forCellWithReuseIdentifier: "SummaryCell")
//        $0.register(TransactionCell.self, forCellWithReuseIdentifier: "TransactionCell")
//        $0.register(SummaryHeaderView.self, forSupplementaryViewOfKind: SummaryHeaderView.supplementaryViewOfKind, withReuseIdentifier: SummaryHeaderView.reuseIdentifier)
//        $0.register(TransactionHeaderView.self, forSupplementaryViewOfKind: TransactionHeaderView.supplementaryViewOfKind, withReuseIdentifier: TransactionHeaderView.reuseIdentifier)
//        $0.delegate = self
//        $0.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    private static func getLayout() -> UICollectionViewCompositionalLayout {
//        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
//            switch section {
//            case 0:
//                let itemFractionalWidthFraction = 1.0
//                let groupFractionalHeightFraction = 0.15
//                let itemInset: CGFloat = 2.5
//
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
//                    heightDimension: .fractionalHeight(1)
//                )
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
//
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
//                )
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: 30, trailing: itemInset)
//
//                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(moderateScale(number: 53)))
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerFooterSize,
//                    elementKind: SummaryHeaderView.supplementaryViewOfKind,
//                    alignment: .top
//                )
//                header.pinToVisibleBounds = true
//                header.zIndex = 1
//                section.boundarySupplementaryItems = [header]
//                return section
//            default:
//                let itemFractionalWidthFraction = 5.0 / 5.0
//                let groupFractionalHeightFraction = 1.0 / 4.0
//                let itemInset: CGFloat = 2.5
//
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
//                    heightDimension: .fractionalHeight(1)
//                )
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
//
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
//                )
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
//                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(moderateScale(number: 43)))
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerFooterSize,
//                    elementKind: TransactionHeaderView.supplementaryViewOfKind,
//                    alignment: .top
//                )
//                header.pinToVisibleBounds = true
//                header.zIndex = 2
//                section.boundarySupplementaryItems = [header]
//                return section
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//        self.view.backgroundColor = .white
//        addViews()
//        makeConstraints()
//        setUpCollectionView()
//        bind()
//    }
//
//    private func addViews() {
//        self.view.addSubview(self.collectionView)
//    }
//
//    private func makeConstraints() {
//        collectionView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(moderateScale(number: 64))
//            $0.bottom.equalToSuperview().offset(moderateScale(number: -64))
//            $0.leading.trailing.equalToSuperview()
//        }
//    }
//}
//
//extension TransactionMainViewController {
//    private func setUpCollectionView() {
//        dataSource = DataSource(
//            collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//                let section = Section(rawValue: indexPath.section)
//                
//                switch section {
//                case .summarySection:
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SummaryCell", for: indexPath)
//                    (cell as? SummaryCell)?.model = itemIdentifier
//                    return cell
//                case .transactionSection:
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransactionCell", for: indexPath)
//                    (cell as? TransactionCell)?.model = itemIdentifier
//                    return cell
//                default:
//                    return UICollectionViewCell()
//                }
//            })
//        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
//            let section = Section(rawValue: indexPath.section)
//            switch section {
//            case .summarySection:
//                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SummaryHeaderView.reuseIdentifier, for: indexPath) as? SummaryHeaderView else {
//                    fatalError("Could not dequeue sectionHeader: \(SummaryHeaderView.reuseIdentifier)")
//                }
//                return sectionHeader
//            case .transactionSection:
//                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TransactionHeaderView.reuseIdentifier, for: indexPath) as? TransactionHeaderView else {
//                    fatalError("Could not dequeue sectionHeader: \(TransactionHeaderView.reuseIdentifier)")
//                }
//                
//                if sectionHeader.viewModel == nil {
//                    sectionHeader.viewModel = self.viewModel
//                }
//                return sectionHeader
//            default:
//                return UICollectionReusableView()
//            }
//        }
//    }
//    
//    private func bind() {
//        viewModel.getSectionModelPublisher()
//            .sink { [weak self] accountData in
//                self?.updateUI(accountData)
//                if self?.viewModel.getSortedStateValue() == .highest {
//                    self?.sortHighest()
//                }
//            }.store(in: &cancelBag)
//        
//        viewModel.getSortedStatePublisher()
//            .sink { [weak self] state in
//                if state == .highest {
//                    self?.sortHighest()
//                } else {
//                    self?.sortLatest()
//                }
//            }.store(in: &cancelBag)
//    }
//    
//    private func updateUI(_ data: TransactionResponseModel.SummaryTransaction) {
//        if snapshot.sectionIdentifiers.isEmpty {
//            snapshot.appendSections([.summarySection, .transactionSection])
//        }
//        
//        data.transactions.transaction.forEach { transactionItem in
//            let transaction: TransactionResponseModel.ItemModel = .init(summary: .init(fromAmount: "", fee: "", discountFee: ""), transaction: transactionItem)
//            snapshot.appendItems([transaction], toSection: .transactionSection)
//        }
//        
//        if data.summary.fromAmount != "" && data.summary.fee != "" && data.summary.discountFee != "" {
//            let USDWallet: TransactionResponseModel.ItemModel = .init(summary: .init(fromAmount: data.summary.fromAmount, fee: data.summary.fee, discountFee: data.summary.discountFee), transaction: TransactionResponseModel.TransactionItem())
//            let itemsOfTransactionSection = snapshot.itemIdentifiers(inSection: snapshot.sectionIdentifiers[0])
//            snapshot.deleteItems(itemsOfTransactionSection)
//            snapshot.appendItems([USDWallet], toSection: .summarySection)
//        }
//        dataSource.apply(snapshot, animatingDifferences: true)
//        print("페이지네이션 완료")
//    }
//    
//    private func sortHighest() {
//        var currentTransactions = dataSource.snapshot().itemIdentifiers(inSection: .transactionSection)
//        currentTransactions.sort { $0.transaction.fromAmount > $1.transaction.fromAmount }
//        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .transactionSection))
//        snapshot.appendItems(currentTransactions, toSection: .transactionSection)
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//    private func sortLatest() {
//        var transactions: [TransactionResponseModel.ItemModel] = []
//        snapshot.itemIdentifiers(inSection: .transactionSection).map { [weak self] transaction in
//            transactions.append(transaction)
//        }
//        transactions.sort { $0.transaction.createDate > $1.transaction.createDate}
//        transactions.map { snapshot.appendItems([$0], toSection: .transactionSection) }
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//}
//
//extension TransactionMainViewController: UICollectionViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.frame.height
//        if offsetY > (contentHeight - height) {
//            print("페이지네이션 시작")
//            viewModel?.didScrollPage()
//        }
//    }
//}
