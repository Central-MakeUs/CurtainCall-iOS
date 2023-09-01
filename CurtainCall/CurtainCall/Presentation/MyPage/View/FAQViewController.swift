//
//  FAQViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/01.
//

import UIKit

final class FAQViewController: UIViewController {
    
    // MARK: - UI properties
    
    private var productList = FAQData.productList
    private var partyList = FAQData.partyList
    private var liveList = FAQData.liveList
    private var ETCList = FAQData.ETCList
    
    private let categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let categoryContentView = UIView()
    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let productButton: MyWriteCategoryButton = {
        let button = MyWriteCategoryButton()
        button.setTitle("작품 탐색", for: .normal)
        button.isSelected = true
        button.setBackground(true)
        return button
    }()
    
    private let partyButton: MyWriteCategoryButton = {
        let button = MyWriteCategoryButton()
        button.setTitle("파티원", for: .normal)
        return button
    }()
    
    private let liveButton: MyWriteCategoryButton = {
        let button = MyWriteCategoryButton()
        button.setTitle("라이브톡", for: .normal)
        return button
    }()
    
    private let etcButton: MyWriteCategoryButton = {
        let button = MyWriteCategoryButton()
        button.setTitle("기타", for: .normal)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FAQCell.self, forCellReuseIdentifier: FAQCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .hexF5F6F8
        tableView.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        return tableView
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addTargets()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(categoryScrollView, tableView)
        categoryScrollView.addSubview(categoryContentView)
        categoryContentView.addSubview(categoryStackView)
        categoryStackView.addArrangedSubviews(
            productButton, partyButton, liveButton, etcButton
        )
    }
    
    private func configureConstraints() {
        categoryScrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(36)
        }
        categoryContentView.snp.makeConstraints {
            $0.edges.equalTo(categoryScrollView.contentLayoutGuide)
            $0.height.equalTo(categoryScrollView.frameLayoutGuide)
        }
        categoryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        productButton.snp.makeConstraints {
            $0.width.equalTo(91)
        }
        partyButton.snp.makeConstraints {
            $0.width.equalTo(73)
        }
        liveButton.snp.makeConstraints {
            $0.width.equalTo(87)
        }
        etcButton.snp.makeConstraints {
            $0.width.equalTo(58)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    private func configureNavigation() {
        configureBackbarButton()
        title = "자주 묻는 질문"
    }
    private func addTargets() {
        [productButton, partyButton, liveButton, etcButton].forEach {
            $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
    }
    @objc
    private func categoryButtonTapped(_ sender: MyWriteCategoryButton) {
        [productButton, partyButton, liveButton, etcButton].forEach {
            $0.isSelected = false
            $0.setBackground(false)
        }
        sender.isSelected = true
        sender.setBackground(true)
        tableView.reloadData()
    }
}

final class FAQCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private let content = UIView()
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
//        view.isHidden = true
        return view
    }()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .body1
        label.font = .body1
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x333C53)
        label.font = .body2
        label.numberOfLines = 0
        return label
    }()
    
    let expandButton = ExpandButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(stackView)
        stackView.addArrangedSubviews(headerView, descriptionView)
        headerView.addSubviews(headerLabel, expandButton)
        descriptionView.addSubview(descriptionLabel)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(70)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        expandButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    func draw(data: FAQData) {
        headerLabel.text = data.header
        descriptionLabel.text = data.description
        expandButton.isSelected = data.isSelected
        descriptionView.isHidden = !data.isSelected
    }
}

struct FAQData {
    let header: String
    let description: String
    var isSelected: Bool = false
    
    static var productList: [FAQData] = [
        FAQData(
            header: "Q. 새로운 작품은 언제 업데이트되나요?",
            description: "커튼콜은 공연예술통합전산망(KOPIS)에서 제공하는 OPEN API를 통해 데이터를 제공하고 있어요. KOPIS가 제공하는 업데이트 일시에 따라 다음 날 오전 9시에 업데이트 돼요."
        ),
        FAQData(
            header: "Q. 한 줄 리뷰를 수정하고 싶어요. 어떻게 해야 하나요?",
            description: "[MY] - [내가 쓴 글] - [한 줄 리뷰] - [더보기 클릭] - [수정 or 삭제]"
        ),
        FAQData(
            header: "저장한 작품 정보는 어디에서 확인하나요?",
            description: "[MY] - [저장된 작품 목록]"
        ),
        FAQData(
            header: "분실물 정보는 어떻게 올리고 찾을 수 있나요?",
            description: """
                         (1) 만약 물건을 발견했다면, 아래의 경로로 올릴 수 있어요.
                         
                         [작품 탐색] - [해당 공연 페이지] - [분실물] - [모두 보기] - [글쓰기 아이콘 클릭]
                         
                         (2) 만약 물건을 분실했다면, 아래의 경로로 확인할 수 있어요.
                         
                         [작품 탐색] - [해당 공연 페이지] - [분실물] - [모두 보기] - [잃어버린 날짜/분류 검색]
                         """
        )
    ]
    
    static var partyList: [FAQData] = [
        FAQData(
            header: "Q. 파티원은 어떤 기능인가요?",
            description: """
                         공연 관람 시와 전후에 공연을 함께 즐길 사람을 구하는 기능이에요.
                         
                         총 세 가지 주제가 있어요.
                         
                         [공연 관람]
                         둘이서 혹은 여럿이 함께 공연을 관람할 파티원을 구할 수 있어요.
                         
                         [식사/카페]
                         공연 전후에 근처 맛집이나 카페에서 사람들과 관심 있는 공연 혹은 배우에 관한 이야기를 나눌 파티원을 구할 수 있어요.
                         
                         [기타]
                         이외에 공연 혹은 배우 관련 이벤트나 굿즈 제작 등 자유롭게 주제를 정해서 필요한 파티원을 구할 수 있어요.
                         """
        ),
        FAQData(
            header: "Q. 파티원은 어떻게 모집하고 참여하나요?",
            description: """
                         (1) 만약 새로운 파티원을 모집하고 싶다면, 아래의 경로로 모집할 수 있어요.
                         
                         [파티원] - [원하는 주제 클릭] - [글쓰기 아이콘 클릭]
                         
                         (2) 만약 기존 파티원에 참여하고 싶다면, 아래의 경로로 참여할 수 있어요.
                         
                         [파티원] - [원하는 주제 클릭] - [검색 or 리스트 스크롤] - [원하는 모집 글 클릭] - [참여하기]
                         """
        ),
        FAQData(
            header: "Q. 파티원 간 소통은 어떻게 할 수 있나요?",
            description: """
                         하나의 모집 글에 참여 인원이 모두 차게 되면 자동으로 파티원 간 톡방이 개설돼요. 이때 해당 글에 ‘TALK 입장’ 버튼이 생기는데 여기에서 파티원들이 서로 대화할 수 있어요.
                         
                         이후에 자신의 모집/참여 톡방을 보려면, 아래의 경로로 확인할 수 있어요.
                         
                         [MY] - [MY 모집 or MY 참여] - [해당하는 글의 ‘TALK 입장’ 클릭]
                         """
        ),
        FAQData(
            header: "Q. MY 모집의 톡방을 직접 개설 또는 삭제할 수 있나요?",
            description: """
                         파티원 모집 톡방의 경우 직접 개설이나 삭제는 불가능해요.
                         단, 파티원 모집 인원이 모두 찼을 때 톡방이 자동으로 개설되고, 모집 글을 삭제하면 자동으로 해당 톡방이 없어져요.
                         """
        ),
        FAQData(
            header: "Q. MY 모집 글을 삭제해도 톡방은 유지되나요?",
            description: """
                         아니요, 모집 글을 삭제하면 해당 모집 글의 톡방은 자동으로 사라져요. 글 삭제 시 톡방이 함께 삭제되니 이 점 유의해주세요.
                         """
        ),
        FAQData(
            header: "Q. 파티원 톡방이 뜨지 않아요. 어떻게 참여할 수 있나요?",
            description: """
                         파티원 모집 글에 기재된 인원 수가 다 모이지 않으면 톡방이 개설되지 않아요. 인원이 다 찰 때까지 조금만 더 기다려주세요!
                         
                         현재 참여 중인 톡방의 경우, 아래의 경로로 확인할 수 있어요.
                         
                         [MY] - [MY 모집 or MY 참여] - [해당하는 글의 ‘TALK 입장’ 클릭]
                         """
        ),
        FAQData(
            header: "Q. 파티원 모집에 참여했다가 취소하기가 가능한가요?",
            description: """
                         아니요, 한 번 파티원 모집에 참여하면 되돌아가기가 불가능해요. 따라서 신중하게 생각하고 모집 글에 참여해주세요!
                         """
        ),
        FAQData(
            header: "Q. 특정 글을 신고할 수 있나요?",
            description: """
                         네, 가능해요. 한 줄 리뷰, 분실물 정보, 파티원 모집 글의 우측 상단에서 ‘신고’ 기능을 통해 부적절한 글을 신고할 수 있어요.
                         """
        ),
        
    ]
    
    static let liveList: [FAQData] = [
        FAQData(
            header: "Q. 라이브톡은 어떤 기능인가요?",
            description: """
                         공연 전후에 실시간으로 사람들과 대화를 할 수 있는 기능이에요. 공연 전 공연에 대한 기대감을 공유하고, 공연 후 공연에 대한 실시간 후기를 공유할 수 있어요.
                         """
        ),
        FAQData(
            header: "Q. 지난 공연의 라이브톡을 볼 수 있나요?",
            description: """
                         네, 가능해요. 지난 공연과 현재 상영 중인 공연에 대한 실시간 대화들을 모두 확인할 수 있어요.
                         """
        )
    ]
    
    static let ETCList: [FAQData] = [
        FAQData(
            header: "Q. 커튼콜은 어떤 서비스인가요?",
            description: """
                         커튼콜은 연극과 뮤지컬에 관한 정보를 공유하고 사용자 간 네트워크를 형성하는 커뮤니티 앱 서비스예요.
                         
                         커튼콜은 크게 세 가지의 기능을 제공해요.
                         
                         여러 작품들에 대한 정보를 알 수 있는 작품 탐색 기능, 무대 위의 감동을 공유하고자 하는 이들을 위한 파티원 모집 기능, 그리고 실시간으로 공연에 대한 기대감 혹은 후기를 나눌 수 있는 라이브톡 기능을 제공하고 있어요.
                         """
        ),
        FAQData(
            header: "Q. 연뮤 가이드가 무엇인가요?",
            description: """
                         연극과 뮤지컬에 막 입문한 이들을 위한 초보 가이드예요. 연극과 뮤지컬의 매력에 빠져 공연에 관한 다양한 정보들을 얻고 싶은 분들을 위해 커튼콜이 여러 정보들을 모아 놓았어요.
                         
                         총 세 가지 가이드가 있어요. 이럴 때 추천해요.
                         
                         [알쏭달쏭 용어 사전]
                         그동안 알기 어려웠던 연뮤덕들의 용어를 알고 싶을 때 추천
                         
                         [티켓팅 안내]
                         티켓팅을 어떻게 하면 더 쉽게 성공할 수 있는지 알고 싶다면 추천
                         
                         [할인 꿀팁]
                         비싼 티켓을 할인 받아서 살 수 있는 방법이 궁금하다면 추천
                         """
        ),
        FAQData(
            header: "Q. 문의는 어디에서 할 수 있나요?",
            description: """
                         문의 사항이 있으시다면 커튼콜 메일로 문의해주세요. 아래 메일 주소로 문의해 주시면, 빠르게 안내해 드릴게요.
                         
                         [커튼콜 고객센터] curtaincall.official2023@gmail.com
                         """
        )
    ]

}

extension FAQViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(type: FAQCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        if productButton.isSelected {
            cell.draw(data: productList[indexPath.row])
        } else if partyButton.isSelected {
            cell.draw(data: partyList[indexPath.row])
        } else if liveButton.isSelected {
            cell.draw(data: liveList[indexPath.row])
        } else {
            cell.draw(data: ETCList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productButton.isSelected {
            return productList.count
        } else if partyButton.isSelected {
            return partyList.count
        } else if liveButton.isSelected {
            return liveList.count
        } else {
            return ETCList.count
        }
        
    }
    
}

extension FAQViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if productButton.isSelected {
            productList[indexPath.row].isSelected.toggle()
        } else if partyButton.isSelected {
            partyList[indexPath.row].isSelected.toggle()
        } else if liveButton.isSelected {
            liveList[indexPath.row].isSelected.toggle()
        } else {
            ETCList[indexPath.row].isSelected.toggle()
        }
            
        tableView.reloadData()
    }
}
