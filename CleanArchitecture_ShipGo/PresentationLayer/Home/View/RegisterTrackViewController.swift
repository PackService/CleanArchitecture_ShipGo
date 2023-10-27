//
//  AddTrackViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/25.
//

import UIKit
import SnapKit
import Then
import Combine

class RegisterTrackViewController: UIViewController {
    weak var coordinator: Coordinator? // MARK: - 그냥 Coordinator도 되나..?
    private var cancelBag = Set<AnyCancellable>()
    var viewModel: HomeMainViewModel!
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = ColorManager.background
    })
    
    private lazy var trackNumberTextField = InputTextField().then({
        $0.placeholder = "운송장 번호"
        $0.keyboardType = .numberPad
    })
    
    private lazy var trackCompanyTextField = InputTextField().then({
        $0.placeholder = "택배사"
        $0.activeLeftItemView()
    })
    
    private lazy var logoView = UIView().then({ // MARK: - cell로 할지 뭘로 할지 고민좀
        $0.backgroundColor = .blue
    })
    
    private lazy var registerButton = CompleteButton().then({
        $0.setTitle("운송장 등록", for: .normal)
        $0.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        print(Bundle.main.object(forInfoDictionaryKey: "DELIVERY_API_KEY") as? String)
        addViews()
        makeConstraints()
    }
    
    func addViews() {
        view.addSubview(containerView)
        containerView.addSubViews([trackNumberTextField,
                                   trackCompanyTextField,
                                   logoView,
                                   registerButton])
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        trackNumberTextField.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 60))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        trackCompanyTextField.snp.makeConstraints { constraints in
            constraints.top.equalTo(trackNumberTextField.snp.bottom).offset(moderateScale(number: 16))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        logoView.snp.makeConstraints { constraints in
            constraints.top.equalTo(trackCompanyTextField.snp.bottom).offset(moderateScale(number: 16))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 70))
            // 70
        }
        registerButton.snp.makeConstraints { constraints in
            constraints.bottom.equalToSuperview().offset(verticalScale(number: -47))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
    }
    
    @objc func registerButtonTapped(_ button: UIButton) {
        viewModel.sendShowRegister(state: false)
    }
}
