//
//  TicketingInfo.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/12.
//

import Foundation

enum TicketingType {
    case prev
    case next
}

struct TicketingInfo {
    let title: String
    let description: String
    
    static let prevList: [TicketingInfo] = [
        TicketingInfo(
            title: "선예매 가능 여부 확인",
            description: "선예매: 공연 티켓 오픈일의 하루 혹은 몇 시간 앞서 티켓을 예매하는 것"
        ),
        TicketingInfo(
            title: "컴퓨터 + 핸드폰 동시 활용",
            description: "핸드폰이 더 빠르게 접속 될 때도 있기에 성공 가능성 높이기"
        ),
        TicketingInfo(
            title: "새로고침 금지",
            description: "로딩 중에 새로고침 시 대기 순번이 뒤로 밀리거나 접속이 불가능할 가능성 존재 (다만, 티켓팅 시간에 맞춰 새로고침 해야 하는 사이트 확인 필요)"
        ),
        TicketingInfo(
            title: "티켓팅 시계 활용",
            description: "사이트마다 고유한 시간대가 있기에 정확한 파악을 위해 활용 필요"
        ),
        TicketingInfo(
            title: "티켓팅 연습",
            description: "자신이 예매하고자 하는 사이트의 실제 티켓팅 상황을 미리 연습해보기"
        ),
        TicketingInfo(
            title: "팝업 차단 해제 후 잘 띄워지는지 확인",
            description: ""
        ),
        TicketingInfo(
            title: "키보드 영문 변환해두기 (보안문자 확인용)",
            description: ""
        ),
        TicketingInfo(
            title: "인터넷 속도 확인하기 (300mbps 이상인지)",
            description: ""
        ),
        TicketingInfo(
            title: "예매 시 필요한 정보 복사해두기(ex. 생년월일)",
            description: ""
        ),
        TicketingInfo(
            title: "주소지, 휴대전화 번호 정보 사이트에 미리 저장하기",
            description: ""
        ),
        TicketingInfo(
            title: "사이트 아이디 본인인증 미리 하기",
            description: ""
        ),
        TicketingInfo(
            title: "예매 일시 후보 미리 정해두기",
            description: ""
        )
    ]
    static let nextList: [TicketingInfo] = [
        TicketingInfo(
            title: "취켓팅",
            description: "• 입금이 안 된 티켓은 입금 기한이 넘어가면 자동으로 새로 생성\n•  예매처 별 취켓 시간이 다르므로 확인 필요"
        ),
        TicketingInfo(
            title: "예매 대기 서비스 (인터파크 한정)",
            description: "•  인터파크 한정 티켓 오픈 후 일정 날짜 결과 시 예매 대기 서비스 신청 가능\n•   이미 예매가 완료된 좌석에 예약 대기 신청"
        ),
        TicketingInfo(
            title: "튕긴 티켓 잡기",
            description: "•  정각 티켓팅 후, 약 6~8분 이후 티켓 업데이트"
        )
    ]
}
