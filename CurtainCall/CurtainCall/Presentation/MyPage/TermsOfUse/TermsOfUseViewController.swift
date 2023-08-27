//
//  TermsOfUseViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/26.
//

import UIKit

final class TermsOfUseViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let content = UILabel()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(content)
        content.numberOfLines = 0
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        content.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        content.text =
        """
        # 서비스 이용약관

        ### 제 1장 커튼콜 서비스

        **제 1조 (목적)**

        이 약관은 <커튼콜>(이하 “회사”)가 제공하는 <커튼콜> “애플리케이션” (이하 “애플리케이션”을 “어플”이라고 합니다)의 서비스 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정하는데 그 목적이 있습니다.

        **제 2조 (용어의 정의)**

        이 약관에서 사용하는 용어의 정의는 다음 각 항과 같으며, 정의되지 않은 용어에 대한 해석은 관계법령 및 서비스 어플리케이션 내 별도 안내에서 정하는 바에 따릅니다.

        ① "서비스"라 함은 구현되는 모바일 기기를 통하여 회원이 이용할 수 있는 공연 정보 열람, 라이브톡 참여, 파티원 모집 및 참여 등 회사가 제공하는 모든 제반 서비스를 의미합니다.

        ② "회원"이라 함은 회사의 어플리케이션 프로그램을 다운 받아 본 약관에 동의 후 이용계약을 체결하고, 서비스에 정상적으로 가입되어 "서비스"를 이용하는 고객을 의미합니다.

        ③ ”어플”이라 함은 회사가 서비스를 위해 개발한 “커튼콜” 어플리케이션 프로그램을 말합니다.

        ④ “콘텐츠”라 함은 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제2조 제1항 제1호의 규정에 의한 정보통신망에서 사용되는 부호, 문자, 음성, 음향, 이미지 또는 영상 등으로 표현된 자료 또는 정보를 말합니다.

        ⑤ ”파티원”이란 식사 및 공연 관람 등 특정 목적을 지니고 타 사용자를 모집할 시 그룹의 멤버를 지칭할 때 사용하는 용어입니다.

        ⑥ “라이브톡”이라 함은 실시간으로 진행되는 공연에 관한 채팅을 사용자 간 주고 받을 수 있는 어플 내 기능을 의미합니다.

        ⑦ “계정정보”란 회원의 카카오 등 외부 연동 계정정보, 기기정보 등 회원이 회사에 제공한 정보를 의미합니다.

        ⑧ 이 약관에 사용하는 용어의 정의는 관계법령 및 서비스별 정책에서 정하는 바에 의하며, 이에 정하지 아니한 것은 일반적인 상관례에 따릅니다.

        **제 3조 (약관의 효력과 개정)**

        ① 본 약관은 서비스 화면에 게시하여 회원에게 공지함으로써 효력이 발생합니다.

        ② 회사는 "약관의 규제에 관한 법률", "정보통신망 이용촉진 및 정보보호 등에 관한 법률” 등 관련 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.

        ③ 본 약관은 필요 시 개정될 수 있으며 약관을 개정하고자 할 경우, 회사는 개정된 약관을 적용일자 및 개정사유를 명시하여 현행약관과 함께 그 개정약관의 적용일자 7일 이전부터 적용일자 전일까지 고지합니다. 개정약관의 공지는 서비스 페이지에 공지하거나 회원이 가입 시 등록한 이메일, 어플을 통해 팝업 메시지 등으로 고지합니다. 변경된 약관은 공지하거나 고지한 시행일로부터 효력이 발생합니다.

        ④ 이용자는 개정되는 약관의 전체 또는 일부 내용에 동의하지 않을 권리가 있습니다. 본 약관의 변경에 대하여 이의가 있는 이용자는 회원 탈퇴를 통해 이용 계약을 해지할 수 있습니다. 다만, 이용 계약이 해지되면 로그인 후 제공되는 서비스를 이용할 수 없게 됩니다.

        ⑤ 회사가 전항에 따라 개정약관을 공지 또는 통지하면서 회원에게 30일 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음에도 회원과 사용자가 명시적으로 거부의 의사표시를 하지 아니한 경우 회원은 개정약관에 동의한 것으로 봅니다.

        ⑥ 회사는 필요한 경우 특정 서비스에 관하여 적용될 사항을 위해 개별약관이나 이용정책을 정하여 운영할 수 있으며, 해당 내용은 서비스 내 공지할 수 있습니다. 본 약관에 규정되지 않은 사항에 대해서는 관련법령 또는 개별약관, 이용정책에서 정한 바에 따릅니다.

        **제 4조 (회원가입)**

        ① 서비스 이용계약은 만 14세 이상의 회원이 되고자 하는 자 (이하 “가입신청자”)가 본 약관 및 "개인정보처리방침" 등에 대하여 동의하고 회사가 제공하는 가입양식을 작성하여 서비스 이용을 신청한 경우 회사가 이를 승낙함으로써 회원으로 가입됩니다.

        ② 서비스 이용계약은 EU GDPR 계정 시행 국가에서 서비스를 이용하여 14세 이상(또는 상위 국가인 경우 법정 성년 이상)이고 회사의 서비스 약관을 준수할 수 있음을 확인하며, 회원이 14세 미만이고 서비스를 사용할 수 없는 경우에도 서비스를 사용할 경우 계정을 정지 및 삭제합니다.

        ③ 회사는 "가입 신청자"의 신청에 대하여 서비스 이용을 승낙함을 원칙으로 합니다.

        ④ 다만, 회사는 다음 각 호에 해당하는 신청에 대하여는 사후에 회원가입을 거절할 수 있습니다.
        • ㉮ 가입신청자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우 (단, 회사의 회원 재가입 승낙을 얻은 경우에는 예외로 함.)
        • ㉯ 서비스 이용할 수 없는 연령일 경우
        • ㉰ 부정한 용도로 서비스를 이용하고자 하는 경우
        • ㉱ 이용 목적이나 서비스 이용 방법이 회사의 재산권이나 영업권을 침해하거나 침해할 우려가 있는 경우
        • ㉲ 이용자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하며 신청하는 경우

        ④ 제1항에 따른 신청에 있어 회사는 회원의 본인인증을 요청할 수 있습니다.

        ⑤ 회사는 본 서비스 관련 설비상, 기술상 기타 운영 업무상 문제의 소지가 예상될 경우 그 승낙을 유보할 수 있습니다.

        ⑥ 회사는 회원들에게 원활한 서비스 제공을 위해 회원에게 이메일 및 SMS 등을 통한 광고 및 서비스 관련 각종 정보를 제공할 수 있습니다. 회원이 원치 않는 경우 언제든지 무선서비스를 통해서 수신거부를 할 수 있습니다.

        ⑦ 회사는 서비스 운영 중 회사 정책에 따라 서비스 관리자가 이벤트 회원의 자격을 제한할 시 회원은 서비스 이용에 제한이 따를 수 있습니다.

        ⑧ 회사는 다음 각 호의 어느 하나에 해당하는 경우 그 사유가 해소될 때까지 승낙을 유보할 수 있습니다.

        • ㉮ 회사의 설비에 여유가 없거나, 특정 기기의 지원이 어렵거나, 기술적 장애가 있는 경우
        • ㉯ 그 밖의 각 호에 준하는 사유로서 이용신청의 승낙이 어렵다고 판단되는 경우

        **제 5조 (회원탈퇴 및 자격상실)**

        ① 회원은 언제든지 서비스 이용을 원하지 않는 경우 탈퇴를 요청할 수 있으며, 이 경우 회사는 즉시 회원탈퇴를 처리합니다. 회원탈퇴로 인해 회원이 서비스 내에서 보유한 이용정보는 모두 삭제되어 복구가 불가능하게 됩니다.

        ② 회사는 회원이 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 등 본 계약을 유지할 수 없는 중대한 사유가 있는 경우에 는 회원에게 통지하고, 서비스 이용을 제한. 중지하거나 회원 자격을 상실시킬 수 있습니다.

        ③ 회사가 회원자격을 상실시키는 경우에는 회원 등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원 등록 말소 전에 소명할 기회를 부여합니다. 단, 회사가 정한 소명 기간 동안 소명하지 않은 경우 회원 등록 말소 동의로 간주합니다.

        ④ ﻿﻿회사는 최근의 서비스 이용일부터 연속하여 1년 동안 회사의 서비스를 이용하지 않은 회원(이하 "휴면계정"이라 합니다)의 개인정보를 보호하기 위해 이용계약을 정지 또는 해지하고 회원 의 개인정보를 분리보관 또는 파기 등의 조치를 취할 수 있습니 다. 이 경우 조치일 30일 전까지 계약 정지 또는 해지, 개인정보 분리보관 또는 파기 등의 조치가 취해진다는 사실 및 파기될 개인정보 등을 회원에게 통지합니다.

        **제 6조 (서비스의 제공)**

        ① 회사가 본 약관에 정해진 바에 따라 회원에게 제공하는 서비스는 다음 각 호와 같습니다.

        • ㉮ 국내 공연 정보 제공 서비스
        • ㉯ 공연 전후 파티원 모집/참여 서비스
        • ㉰ 공연 전후 실시간 라이브 채팅 서비스
        • ㉱ 기타 회사가 추가 개발하거나 다른 회사와의 제휴 계약 등을 통해 회원에게 제공하는 일체의 서비스

        ② 회사는 회원의 가입신청을 승낙한 때부터 서비스를 개시합니다.

        ③ 서비스 이용시간은 회사의 업무상 또는 기술상 불가능한 경우를 제외하고는 연중무휴 1일 24시간(00:00-24:00)으로 함을 원칙으로 합니다.

        ④ 회사는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신두절 또는 운영상 상당한 이유가 있는 경우 서비스의 제공을 일시적으로 중단할 수 있습니다. 이 경우 회사는 제20조[회원에 대한 통지]에 정한 방법으로 통지합니다. 다만, 회사가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.

        ⑤ 회사는 서비스의 제공에 필요한 경우 정기점검을 실시할 수 있으며, 정기점검시간은 서비스 제공화면에 공지한 바에 따릅니다.

        ⑥ 회사가 제공하는 서비스는 모바일 기기 또는 이동통신사의 특성에 맞도록 제공됩니다. 모바일 기기의 변경, 번호 변경 또는 해외 로밍의 경우에는 콘텐츠의 전부 또는 일부의 이용이 불가능할 수 있으며, 이 경우 회사는 책임을 지지 않습니다.

        **제 7조 (서비스의 변경 및 중단)**

        ① 회사는 이용 감소로 인한 원활한 서비스 제공의 곤란 및 수익성 악화, 기술 진보에 따른 차세대 서비스로의 전환 필요성, 서비스 제공과 관련한 회사 정책의 변경 등 기타 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 서비스를 변경 또는 중단할 수 있습니다.

        ② 회사는 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 이에 대하여 관련법에 특별한 규정이 없는 한 회원에게 별도의 보상을 하지 않습니다.

        ③ 서비스의 내용, 이용방법, 이용시간에 대하여 변경 또는 서비스 중단이 있는 경우에는 변경 또는 중단될 서비스의 내용 및 사유와 일자 등은 그 변경 또는 중단 전에 서비스 내 "공지사항" 화면 등 회원과 사용자가 충분히 인지할 수 있는 방법으로 [30]일의 기간을 두고 사전에 공지합니다.

        **제 8조 (게시물의 권리와 책임)**
        ① 서비스에 대한 저작권 및 지적재산권, 회사가 작성한 게시물의 저작권은 회사에 귀속되고, 회원이 회사의 서비스를 이용하면 서 생성한 콘텐츠도 모두 회사에 귀속되며, 회사는 위 콘텐츠를 분석하거나 사용할 수 있습니다. 단, 제휴 계약에 따라 제공된 저작물 등은 제외합니다.
        ② ﻿﻿회원은 서비스를 이용하는 과정에서 회원이 작성한 텍스트, 이미지 등의 기타 정보 (이하 '게시물 )에 대한 책임 및 권리를 보유하며, 해당 게시물이 타인의 지적 재산권을 침해하여 발생하는 모든 책임 또한 회원 본인에게 귀속됩니다.
         ﻿﻿회원은 자신이 서비스 내에 게시한 게시물을 회사가 다음과 같은 목적으로 사용하는 것을 허락합니다.
        • ㉮ ﻿﻿﻿서비스 내에서 게시물을 사용하기 위하여 게시물의 크기를 변환하거나 단순화하는 등의 방식으로 수정 혹은 게시물 위치를 이동하는 경우
        • ㉯ 회사의 서비스를 홍보하기 위한 목적으로 미디어, 통신사 등 에게 게시물의 내용을 보도, 방영하는 경우 (단, 이 경우 회원의 개별 동의 없이 회원정보를 제공하지 않습니다.)
        • ㉰ ﻿﻿﻿서비스 개선 및 서비스 개발을 위해 게시물의 내용을 분석 활용하는 경우
        ③ 회원은 회사가 제공하는 서비스를 이용하여 얻은 정보 중에서 회사 또는 제공업체에 지적재산권이 귀속된 정보를 회사 또는 제공업체의 사전 동의 없이 복제 • 전송 등의 방법(편집, 공표, 공 연, 배포, 방송, 2차적 저작물 작성 등을 포함합니다. 이하 같습니다)에 의하여 영리목적으로 이용하거나 타인에게 이용하게 하여서는 안됩니다.
        ④ 회원의 게시물이 정보통신망법 및 저작권법 등 관련법에 위반 되는 내용을 포함하는 경우, 권리자는 관련법이 정한 절차에 따라 해당 게시물의 게시 중단 및 삭제 등을 요청할 수 있으며, 이로 인해 발생하는 민• 형사상의 책임은 전적으로 해당 회원 본인이 부담하여야 하며, 회사는 관련법에 따라 조치를 취하여야 합니다.
        ⑤ 회사는 전항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인적될 만한 사유가 있거나 기타 회사 정책 및 관련법에 위반되는 경우에는 관련법에 따라 해당 게시물에 대해 임시조치 등을 취할 수 있습니다.
        ⑥ 이 조는 회사가 서비스를 운영하는 동안 유효하며, 회원 탈퇴 후에도 지속적으로 적용됩니다.

        **제 9조 (게시물의 관리)**

        ① '회원'이 서비스 내에 작성한 '게시물'에 대한 책임 및 권리는 ‘게시물’을 등록한 '회원'에게 있습니다.

        ② '회사'는 '회원'이 작성한 ‘콘텐츠’에 대해서 임의로 관리할 수 없습니다.

        ③ '회사'는 '회원'이 등록하는 ‘게시물’의 신뢰성, 진실성, 정확성 등에 대해서 책임지지 않으며 보증하지 않습니다.

        ④ '회원'의 ‘게시물’이 “정보통신망 이용촉진 및 정보보호 등에 관한 법률” 및 “저작권법” 등 관련 법령에 위반되는 내용을 포함하는 경우, 권리자는 관련법령이 정한 절차에 따라 해당 “게시물”의 게시 중단 및 삭제 등을 요청할 수 있으며, '회사'는 관련법에 따라 조치를 취할 수 있습니다.

        ⑤ '회사'는 다음 각 호와 같은 내용의 ‘게시물’이 서비스 내에 게재되는 경우 제한할 수 있습니다.

        • ㉮ 사생활 침해, 명예훼손, 욕설, 비속어로 타인에게 불쾌감을 주는 경우
        • ㉯ 공서양속 저해 및 특정 집단, 단체, 종교 비하로 타인에게 불쾌감을 주는 경우
        • ㉰ 확인되지 않거나 근거 없는 내용으로 타인의 권리를 침해하는 경우
        • ㉱ 타인의 저작권을 침해하는 경우
        • ㉲ 타인의 개인정보가 포함된 경우
        • ㉳ 광고/홍보 내용이 포함된 경우
        • ㉴ 동일 내용의 게시물을 반복 게재하는 경우
        • ㉵ 악성코드 등 회사의 원활한 서비스 제공을 방해하는 경우
        • ㉶ 기타 회원의 원활한 서비스 이용에 불건전한 영향을 미칠 수 있다고 판단되는 경우

        ⑥ '회원'이 비공개로 설정한 ‘게시물’에 대해서는 ‘회사’를 포함한 다른 사람이 열람할 수 없습니다. 다만, ‘회사’는 법원, 수사기관이나 기타 행정기관으로부터 정보제공을 요청받은 경우나 기타 법률에 의해 요구되는 경우에는 ‘회사’를 포함한 이해관계가 있는 다른 사람으로 하여금 해당 ‘게시물’을 열람하게 할 수 있습니다.

        ⑦ '회원'이 회원 가입 계약을 해지한 경우에는 본인이 작성한 저작물 일체는 삭제될 수 있습니다. 다만, 저작물이 공동 저작을 통해 작성된 경우에는 공동 저작자의 ‘게시물’ 등에 해당 ‘게시물’이 남을 수 있고, 제3자에 의하여 보관되거나 무단복제 등을 통하여 복제됨으로써 해당 저작물이 삭제되지 않고 재 게시된 경우에 대하여 '회사'는 책임을 지지 않습니다.

        ⑧ ‘회사’는 다른 '회원'을 보호하고, 법원, 수사기관 또는 관련 기관의 요청에 따른 증거자료로 활용하기 위해 본 약관 및 관계 법령을 위반한 '회원'이 회원가입 계약 해지 후에도 ‘회사’의 개인정보처리방침상 보존기간 및 관계 법령에 따라서 '회원'의 아이디 및 회원정보를 보존할 수 있습니다.

        **제 10조 (정보의 수집)**

        회사는 회원의 서비스 이용 단말기의 데이터를 수집하고 이용할 수 있으며, 수집된 데이터는 서비스를 개선하거나 이용자의 사용 환경에 적합한 서비스 또는 기술을 제공하기 위한 목적으로만 사 용하며 그 외의 다른 목적으로 사용하지 않습니다.

        **제 11조 (정보의 제공 및 광고의 게재)**

        ① 회사는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보를 서비스 내 "공지사항", 서비스 화면 등의 방법으로 회원과 사용자에게 제공할 수 있습니다. 다만, 회원은 관련법에 따른 거래관련 정보 및 고객문의 등에 대한 답변 등을 제외하고는 언제든지 위 정보제공에 대해서 수신 거절을 할 수 있습니다.

        ② 회사는 서비스의 운영과 관련하여 커튼콜 서비스 화면 등에 광고를 게재할 수 있습니다. (기타 "회사"가 추가 개발하거나 다른 회사와 제휴 계약 등을 통해 "회원"에게 제공하는 일체의 서비스 또는 콘텐츠)

        ③ 회사가 제공하는 서비스, 광고 중의 배너 또는 링크 등을 통해 타인이 제공하는 광고나 서비스에 연결될 수 있습니다.

        ④ 제 3항에 따라 타인이 제공하는 광고나 서비스에 연결될 경우 해당 영역에서 제공하는 내용은 회사의 서비스 영역이 아니므로 회사가 신뢰성, 안정성 등을 보장하지 않으며, 그로 인한 회원의 손해에 대하여도 회사는 책임을 지지 않습니다. 다만, 회사가 고의 또는 중과실로 손해의 발생을 용이하게 하거나 손해 방지를 위한 조치를 취하지 아니한 경우에는 그러하지 아니합니다.

        **제 12조 (권리의 귀속)**

        ① 회사가 작성한 저작물에 대한 저작권 기타 지적재산권은 회사에 귀속합니다.

        ② 이용자가 서비스를 이용하면서 게시한 저작물에 대한 권리와 책임은 이용자 본인에게 있습니다.

        ③ 이용자가 회사의 서비스를 통해 얻은 정보 중 회사 또는 정보를 제공한 업체에 지적재산권이 귀속정보를 사전 승인 없이 전송, 복제, 배포, 출판, 방송 등을 통해 영리 목적으로 이용하거나 제3자에게 이용하게 해서는 안됩니다.

        ④ 이용자는 서비스 내에서 본인이 게시하거나 다른 이용자에게 전송하는 대화 텍스트, 이미지, 사운드, 동영상 등 모든 자료 및 정보에 대해 회사가 이를 이용하는 것을 허락합니다.

        ⑤ 회사는 특정 게시물이 명예 훼손, 사생활 침해, 사회 상규상 문제가 있는 내용이라고 판단되는 경우 사전 통지 없이 블라인드 및 삭제 처리를 할 수 있으며, 이용자와의 협의 및 관계 법령과 회사의 정책에 따라 삭제 또는 복원할 수 있습니다.

        ⑥ 제 ④항은 회사가 서비스를 운영하는 동안 유효하며 이용자의 탈퇴 및 계약 해지 후에도 지속적으로 적용됩니다.

        **제 13조 (회사의 의무)**

        ① 회사는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 서비스를 제공하기 위하여 최선을 다하여 노력합니다.

        ② 회사는 회원이 안전하게 서비스를 이용할 수 있도록 개인정보 보호를 위해 최대한 노력하여야 하며 개인정보처리방침을 공시하고 준수합니다. 회사는 이 약관 및 개인정보처리방침에서 정한 경우를 제외하고는 회원의 개인정보가 제3자에게 공개 또는 제공되지 않도록 합니다.

        ③ 회사는 서비스 이용과 관련하여 회원으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. 회원이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나 전자우편 등을 통하여 회원과 사용자에게 처리과정 및 결과를 전달합니다.

        ④ 회사는 계속적이고 안정적인 서비스의 제공을 위하여 서비스 개선을 하던 중 설비에 장애가 생기거나 데이터 등이 멸실, 훼손된 때에는 천재지변, 비상사태, 현재의 기술로는 해결이 불가능한 장애나 결함 등 부득이한 사유가 없는 한 지체 없이 이를 수리 또는 복구하도록 최선의 노력을 다합니다.

        **제 14조 (회원의 의무)**

        ① 회원은 회사에서 제공하는 서비스의 이용과 관련하여 다음 각 호에 해당하는 행위를 해서는 안 됩니다.
        • ㉮ 이용신청 또는 회원 정보 변경 시 타인의 명의를 도용하거나 허위사실을 기재하는 행위
        • ㉯ ﻿﻿﻿회사를 사칭하거나 관련 정보를 도용하는 행위
        • ㉰ ﻿﻿﻿다른 회원의 개인정보를 무단으로 수집 • 저장 • 게시 또는 유포하는 행위
        • ㉱ ﻿﻿﻿서비스를 무단으로 본래의 용도 이외의 용도로 이용하는 행위
        • ㉲ 회사의 서비스를 이용하여 얻은 정보를 무단으로 변경 • 유포 하거나, 상업적으로 이용하는 행위
        • ㉳ 회사나 기타 제3자의 저작권, 영업비밀, 특허권 등 지적재산 권을 침해하는 행위
        • ㉴ 회사나 다른 회원 및 기타 제3자를 희롱하거나, 위협하거나 명예를 손상시키는 행위
        • ㉵ 법령에 의하여 전송 또는 게시가 금지된 정보(컴퓨터 프로그램)나 컴퓨터 소프트웨어 • 하드웨어 또는 전기통신장비의 정상 적인 작동을 방해 파괴할 목적으로 고안된 바이러스• 컴퓨터 코 드• 파일 • 프로그램 등을 고의로 전송• 게시 • 유포 또는 사용하는 행위
        • ㉶ ﻿﻿﻿회사의 동의 없이 서비스 또는 이에 포함된 소프트웨어의 일부를 복사, 수정, 배포, 판매, 양도, 대여하거나 타인에게 그 이용을 허락하는 행위와 소프트웨어를 역설계하거나 소스 코드의 추출을 시도하는 등 서비스를 복제, 분해 또는 모방하거나 기타 변형하는 행위
        • 그 밖에 관련 법령에 위반되거나 선량한 풍속 기타 사회통념
        에 반하는 행위
        ② 회사는 회원이 전항에서 금지한 행위를 하는 경우, 위반 행위의 경중에 따라 서비스의 이용정지/계약의 해지 등 서비스 이용 제한, 수사 기관에의 고발 조치 등 합당한 조치를 취할 수 있습니다.
        ③ ﻿﻿회원의 ID와 비밀번호에 관한 관리책임은 회원에게 있으며, 이를 제3자가 이용하도록 하여서는 안됩니다.
        ④ 회원은 회사의 사전 허락 없이 회사가 정한 이용 목적과 방법 에 반하여 영업/광고 활동 등을 할 수 없고, 회원의 서비스 이용이 회사의 재산권, 영엽권 또는 비즈니스 모델을 침해하여서는 안됩니다.
        ⑤ 이용자는 본 약관 및 관련법령에 규정한 사항을 준수하여야 하며, 회사는 회원이 본 조에서 규정한 의무를 위반하여 발생한 일체의 문제에 대해서는 책임을 지지 않습니다.

        **제 15조 (회원의 정보 관리에 대한 의무)**

        ① 회원의 정보에 관한 관리책임은 본인에게 있으며, 이를 제3자가 이용하도록 하여서는 안됩니다.

        ② 회사는 회원의 정보가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나 회사 및 회사의 운영자로 오인한 우려가 있는 경우, 해당 정보의 이용을 제한할 수 있습니다.

        ③ 회원은 정보가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 회사에 통지하고 회사의 안내에 따라야 합니다.

        ④ 제3항의 경우에 해당 회원이 회사에 그 사실을 통지하지 않거나, 통지한 경우에도 회사의 안내에 따르지 않아 발생한 불이익에 대하여 회사는 책임지지 않습니다.

        **제 16조 (회원의 고충처리 및 분쟁해결)**
        ① ﻿﻿회사는 회원의 편의를 고려하여 회원의 의견이나 불만을 제시 하는 방법을 서비스 내 또는 그 연결화면에 안내합니다.
        ② ﻿﻿회사는 회원으로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 합리적인 기간 내에 이를 신속하게 처리합니다. 다만, 처리에 장기간이 소요되는 경우에는 회원에게 장기간이 소요되는 사유와 처리일정을 별도로 공지합니다.

        **제 17조 (개인정보보호 의무)**

        회사는 "정보통신망법" 등 관계 법령이 정하는 바에 따라 회원과 사용자의 개인정보를 보호하기 위하여 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 회사의 개인정보처리방침이 적용됩니다.

        **제 18조 (이용제한 등)**

        ① 회사는 회원이 본 약관의 의무를 위반하거나 서비스의 정상적인 운영을 방해한 경우, 경고, 일시정지, 영구이용정지 등으로 서비스 이용을 단계적으로 제한할 수 있습니다.

        ② 회사는 전항에도 불구하고, 일회용 이메일 사용, "저작권법" 및 "컴퓨터프로그램보호법"을 위반한 불법프로그램의 제공 및 운영방해, "정보통신망법"을 위반한 불법통신 및 해킹, 악성프로그램의 배포, 접속권한 초과행위 등과 같이 관련법을 위반한 경우에는 즉시 영구이용정지를 할 수 있습니다. 본 항에 따른 영구이용정지시 서비스 이용을 통해 획득한 혜택 등도 모두 소멸되며, 회사는 이에 대해 별도로 보상하지 않습니다.

        ③ 본 조의 이용제한 범위 내에서 제한의 조건 및 세부내용은 회사의 이용제한정책에서 정하는 바에 의합니다.

        ④ 본 조에 따라 서비스 이용을 제한하거나 계약을 해지하는 경우에는 회사는 제20조[회원에 대한 통지]에 따라 통지합니다.

        ⑤ 회원은 본 조에 따른 이용제한 등에 대해 회사가 정한 절차에 따라 이의신청을 할 수 있습니다. 이 때 이의가 정당하다고 회사가 인정하는 경우 회사는 즉시 서비스의 이용을 재개합니다.

        **제 19조 (면책조항)**

        ① 회사는 천재지변 또는 이에 준하는 불가항력(서비스 동시 접속자 폭주로 인한 서버장애 등)으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.

        ② 회사는 회원과 사용자의 귀책사유로 인한 서비스 이용의 장애에 대하여는 책임을 지지 않습니다.

        ③ 회사는 경품이벤트 주최자로부터 제공받아 서비스에 등록된 이벤트 내용 및 저작권에 대한 책임을 지지 않으며 회원이 서비스와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.

        ④ 회사에서 직접 등록한 내용이 아닌 회원간 또는 회원과 제3자 상호간에 서비스를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.

        ⑤ 회사는 무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.

        ⑥ 회사는 제3자가 서비스 내 화면 등을 통하여 광고한 제품 또는 서비스의 내용과 품질에 대하여 감시할 의무 기타 어떠한 책임도 지지 아니합니다.

        ⑦ 회사 및 회사의 임직원 그리고 대리인은 다음과 같은 사항으로부터 발생하는 손해에 대해 책임을 지지 아니합니다.

        • ㉮ 회원과 사용자의 상태정보의 허위 또는 부정확성에 기인하는 손해
        • ㉯ 그 성질과 경위를 불문하고 서비스에 대한 접속 및 서비스의 이용과정에서 발생하는 개인적인 손해
        • ㉰ 서버에 대한 제3자의 모든 불법적인 접속 또는 서버의 불법적인 이용으로부터 발생하는 손해
        • ㉱ 서버에 대한 전송 또는 서버로부터의 전송에 대한 제3자의 모든 불법적인 방해 또는 중단행위로부터 발생하는 손해
        • ㉲ 제3자가 서비스를 이용하여 불법적으로 전송, 유포하거나 또는 전송, 유포되도록 한 모든 바이러스, 스파이웨어 및 기타 악성 프로그램으로 인한 손해
        • ㉳ 전송된 데이터의 오류 및 생략, 누락, 파괴 등으로 발생되는 손해
        • ㉴ 회원 간의 정보 등록 및 서비스 이용 과정에서 발생하는 명예훼손 기타 불법행위로 인한 각종 민형사상 책임

        **제 20조 (재판권 및 준거법)**
        이 약관은 대한민국 법률에 따라 규율되고 해석됩니다. 회사와 회원 간에 발생한 분쟁으로 소송이 제기되는 경우에는 법령에 정 한 절차에 따른 법원을 관할 법원으로 합니다.

        **제 21조 (약관 외 준칙)**
        이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 「약관의 규제에 관한 법률」, 「정보통신망이용촉진 및 정보보호 등에 관한 법률」등 관련 법령 또는 상 관례에 따릅니다.

        **부칙**

        본 약관은 2023년 8월 16일부터 시행합니다.

        이용약관은 커튼콜 어플 서비스 내에서 확인할 수 있습니다.
        """
    }
    
    
    
}