//
//  PerformanceExpressionDictionaryData.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/12.
//

import Foundation

enum PerformanceExpressionType {
    case ticketing
    case show
    case theater
    case audience
    case other
}


struct PerformanceExpressionDictionaryData {
    let title: String
    let description: String
    let type: PerformanceExpressionType
    
    static let list: [PerformanceExpressionDictionaryData] = [
        PerformanceExpressionDictionaryData(title: "고속도로", description: "극장 좌석 사이에 가로로 넓은 통로", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "공원/파크", description: "대표적인 티켓 예매처인 인터파크(interpark)를 뜻하는 말", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "그래/예사/예스", description: "대표적인 티켓 예매처인 예스24(yes24)를 뜻하는 말", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "눈밭", description: "좌석이 거의 남지 않았거나 매진된 공연으로, 이미 예매한 자리는 흰색으로 표시돼 하얗게 보이는 것에서 유래", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "멜티", description: "멜론티켓", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "박성훈석", description:"무대에서 매우 먼 좌석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "벽싸/벽 사이드", description: "사이드 블록 자리 중 벽에 붙어 있는 자리", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "산책", description: "수시로 예매 창에 들어가서 남은 자리가 있는지 살피는 행위", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "상석", description: "공연장 별로 여러 여건을 고려한 가장 좋은 자리", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "서방", description: "서치 방지용", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "세탁", description: "예매한 티켓을 다른 할인 종류 변경해서 결제하는 것", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "시방", description: "시야 방해", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "실결", description: "실제로 결제하는 행위", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "예대", description: "예매 대기", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "오케스트라피트/오케피", description: "라이브 반주자들이 있는 곳", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "오피석", description: "대극장의 경우 무대 바로 앞에 있는 오케스트라석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "용병", description: "실제 관람객 대신 티켓을 예매해주는 행위 또는 사람", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "이결좌", description: "이미 결제된 좌석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "이벤트석/이벵석", description: "공연 중에 배우와 직접적인 소통을 할 수 있는 좌석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "이선좌", description: "이미 선택된 좌석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "중블/왼블/오블", description: "좌석 예매 창 기준 중간 블록/왼쪽 블록/오른쪽 블록", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "창조주석", description: "창조주가 된 듯한 같은 기분을 느낄 수 있는 좌석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "취재예", description: "할인 종류를 변경하기 위해 취소 후 다시 예매하는 것", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "취켓팅", description: "취소 티켓을 잡는 행위", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "타임세일/탐셀", description: "특정 기간 동안 티켓 값을 할인해주는 것", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "통로석/통", description: "객석 통로에 위치한 좌석", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "티링", description: "티켓링크", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "티켓팅", description: "예매 창이 열리는 시간을 맞춰 자리를 잡는 것", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "포도알/자리", description: "예매 창에 보이는 좌석이 보라색인 것에서 유래", type: .ticketing),
        PerformanceExpressionDictionaryData(title: "피켓팅", description: "피 튀기는 성공하기 어려운 티켓팅", type: .ticketing),
        
        PerformanceExpressionDictionaryData(title: "1막/2막/인터미션", description: "극을 1막과 2막으로 나눠 인터미션(=쉬는 시간)을 두고 극을 진행함", type: .show),
        PerformanceExpressionDictionaryData(title: "관극", description: "연극을 구경하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "관대", description: "관객과의 대화", type: .show),
        PerformanceExpressionDictionaryData(title: "넘버/OST", description: "뮤지컬에서 사용되는 모든 노래, 음악", type: .show),
        PerformanceExpressionDictionaryData(title: "논 레플리카", description: "라이선스 공연 종류 중, 원작에 수정과 각색/번안을 허용하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "다작", description: "다양한 공연을 관람하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "다작러", description: "다양한 공연의 관람을 즐기는 사람", type: .show),
        PerformanceExpressionDictionaryData(title: "더블/트리플/쿼드 캐스팅", description: "하나의 배역에 2, 3, 4명의 배우가 캐스팅 되어 있는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "라이선스 공연", description: "해외 원작자에게 저작권료를 지급하여 판권을 산 후 우리말로 공연하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "런타임", description: "1막, 2막, 인터미션을 모두 포함한 전체 공연 시간", type: .show),
        PerformanceExpressionDictionaryData(title: "레플리카", description: "라이선스 공연 종류 중, 음악과 가사/안무/의상/무대 세트까지 똑같이 공연하는 작품", type: .show),
        PerformanceExpressionDictionaryData(title: "리미티드런", description: "기간을 정해두고 하는 연극이나 뮤지컬", type: .show),
        PerformanceExpressionDictionaryData(title: "리프라이즈/반복(rep)", description: "이전에 한 번 등장한 넘버가 변주되거나 반복되어 사용하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "마티네", description: "평일 낮 공연", type: .show),
        PerformanceExpressionDictionaryData(title: "무인", description: "무대인사", type: .show),
        PerformanceExpressionDictionaryData(title: "스콜", description: "스페셜 커튼콜", type: .show),
        PerformanceExpressionDictionaryData(title: "시츠프로브/시츠", description: "무대 연출이나 기술 없이 오케스트라와의 교감에 집중하는 리허설", type: .show),
        PerformanceExpressionDictionaryData(title: "앙상블", description: "2인 이상 하는 노래/연주로, 주조연 배우들 뒤에서 화음을 넣으며 춤을 추고 노래를 부르며 분위기를 돋구는 역할", type: .show),
        PerformanceExpressionDictionaryData(title: "오리지널 공연/내한 공연", description: "해외에서 공연 됐거나 공연 중인 작품을 원형 그대로 가져와 보여주는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "오바추어", description: "극의 시작을 알리는 서곡", type: .show),
        PerformanceExpressionDictionaryData(title: "오픈런", description: "공연 종료 시점을 정해두지 않고 상시 공연하는 연극이나 뮤지컬", type: .show),
        PerformanceExpressionDictionaryData(title: "자연재해", description: "앞에 사람이 앉아 있어 무대 위 시야 확보가 방해되는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "자첫/자막", description: "본인의 첫 번째 관극/마지막 관극", type: .show),
        PerformanceExpressionDictionaryData(title: "전캐", description: "전체 캐스팅", type: .show),
        PerformanceExpressionDictionaryData(title: "차기작/기작", description: "배우가 다음 시기에 발표하거나 내놓을 예정인 작품", type: .show),
        PerformanceExpressionDictionaryData(title: "창작 공연", description: "음악, 의상, 대사 등 모든 것을 독창적으로 만들어낸 공연", type: .show),
        PerformanceExpressionDictionaryData(title: "초연/재연", description: "극의 첫 번째 시즌, N 번째 시즌", type: .show),
        PerformanceExpressionDictionaryData(title: "초연/재연/삼연.../N연", description: "각 공연의 첫 번째, 두 번째, 세 번째, …, N번째 시즌", type: .show),
        PerformanceExpressionDictionaryData(title: "총첫/총막/세미막", description: "극의 첫 번째 공연, 마지막 공연, 마지막 전 공연", type: .show),
        PerformanceExpressionDictionaryData(title: "캐스팅", description: "뮤지컬 작품에 출연하는 배우", type: .show),
        PerformanceExpressionDictionaryData(title: "캐스팅 보드", description: "전체 출연진 목록", type: .show),
        PerformanceExpressionDictionaryData(title: "커튼콜", description: "공연이 끝난 후 출연진들이 관객의 박수에 응하기 위해 무대 위로 올라와 최종인사하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "페어", description: "함께 캐스팅 되어 연기하는 것", type: .show),
        PerformanceExpressionDictionaryData(title: "프레스콜", description: "정식 공연 전, 취재진 앞에서 공연의 일부를 보여주어 언론에 알리는 시사회", type: .show),
        PerformanceExpressionDictionaryData(title: "프리뷰 공연", description: "본 공연이 개막되기 전, 일정 기간 동안 해당 공연을 미리 볼 수 있는 것", type: .show),
        
        PerformanceExpressionDictionaryData(title: "국극", description: "국립 극장", type: .theater),
        PerformanceExpressionDictionaryData(title: "댕로", description: "대학로", type: .theater),
        PerformanceExpressionDictionaryData(title: "동숭", description: "동숭아트홀", type: .theater),
        PerformanceExpressionDictionaryData(title: "드아센", description: "드림아트센터", type: .theater),
        PerformanceExpressionDictionaryData(title: "디큐브/디큡", description: "대성 디큐브아트센터", type: .theater),
        PerformanceExpressionDictionaryData(title: "링아센", description: "링크아트센터", type: .theater),
        PerformanceExpressionDictionaryData(title: "백암", description: "백암아트홀", type: .theater),
        PerformanceExpressionDictionaryData(title: "브릭스", description: "브릭스 씨어터", type: .theater),
        PerformanceExpressionDictionaryData(title: "샤롯데", description: "샤롯데씨어터", type: .theater),
        PerformanceExpressionDictionaryData(title: "세종", description: "세종문화회관", type: .theater),
        PerformanceExpressionDictionaryData(title: "아트원/앝원", description: "아트원씨어터", type: .theater),
        PerformanceExpressionDictionaryData(title: "엘아센", description: "LG아트센터 서울", type: .theater),
        PerformanceExpressionDictionaryData(title: "예당", description: "예술의 전당", type: .theater),
        PerformanceExpressionDictionaryData(title: "우금홀", description: "우리금융아트홀", type: .theater),
        PerformanceExpressionDictionaryData(title: "유아센", description: "유니버셜아트센터", type: .theater),
        PerformanceExpressionDictionaryData(title: "유플", description: "유니플렉스", type: .theater),
        PerformanceExpressionDictionaryData(title: "이해랑", description: "이해랑예술극장", type: .theater),
        PerformanceExpressionDictionaryData(title: "자유", description: "자유극장", type: .theater),
        PerformanceExpressionDictionaryData(title: "충무", description: "충무아트센터", type: .theater),
        PerformanceExpressionDictionaryData(title: "치킨홀", description: "광림아트센터 BBCH홀", type: .theater),
        PerformanceExpressionDictionaryData(title: "티오엠/툐엠", description: "대학로 TOM", type: .theater),
        PerformanceExpressionDictionaryData(title: "플씨", description: "플러스씨어터", type: .theater),
        PerformanceExpressionDictionaryData(title: "한전", description: "한전아트센터", type: .theater),
        PerformanceExpressionDictionaryData(title: "홍아센", description: "홍익대 대학로 아트센터", type: .theater),
        
        PerformanceExpressionDictionaryData(title: "관크", description: "공연 관람 시 방해가 되는 행동을 뜻하는 ‘관객 크리티컬’을 줄인 말", type: .audience),
        PerformanceExpressionDictionaryData(title: "뉴비/newbie", description: "웹사이트 커뮤니티에 처음 온 사람", type: .audience),
        PerformanceExpressionDictionaryData(title: "머글", description: "덕질 하지 않는 일반인", type: .audience),
        PerformanceExpressionDictionaryData(title: "메뚜기", description: "지정된 자리에 앉지 않고 다른 자리로 옮기는 사람", type: .audience),
        PerformanceExpressionDictionaryData(title: "못사/본사", description: "못 본 사람, 본 사람", type: .audience),
        PerformanceExpressionDictionaryData(title: "바발/밥알", description: "배우가 무대에서 객석을 바라보면 관객들이 마치 밥알처럼 보이는 것에서 유래되어 관객을 뜻함", type: .audience),
        PerformanceExpressionDictionaryData(title: "수구리", description: "‘관크’의 일종으로, 몸을 앞으로 숙이고 공연을 관람하는 것", type: .audience),
        PerformanceExpressionDictionaryData(title: "연뮤덕", description: "연극과 뮤지컬 관람을 좋아하는 덕후", type: .audience),
        
        PerformanceExpressionDictionaryData(title: "갈말갈", description: "갈까 말까 고민될 땐 가라", type: .other),
        PerformanceExpressionDictionaryData(title: "갤관크", description: "특정 관극을 생각나게 하여 본의 아니게 공연 예의범절을 지키지 않는 것", type: .other),
        PerformanceExpressionDictionaryData(title: "겹치기", description: "한 배우가 동시에 여러 작품을 같은 기간 동안 하는 것", type: .other),
        PerformanceExpressionDictionaryData(title: "레전", description: "레전드", type: .other),
        PerformanceExpressionDictionaryData(title: "본진", description: "애정하는 배우", type: .other),
        PerformanceExpressionDictionaryData(title: "본진극", description: "애정하는 극", type: .other),
        PerformanceExpressionDictionaryData(title: "ㅃㅃ", description: "딱히 아무 의미 없는 내용", type: .other),
        PerformanceExpressionDictionaryData(title: "씨왓/See What", description: "‘모든 극은 보는 사람에 따라 다르다’는 말로, 다른 사람들의 평가가 어떻든 자기가 느끼는 바가 가장 중요하다는 의미", type: .other),
        PerformanceExpressionDictionaryData(title: "어셔/안내원(Usher)", description: "공연장 스태프", type: .other),
        PerformanceExpressionDictionaryData(title: "엄마오리", description: "처음으로 본 배우의 조합으로만 고정해서 보든 행동", type: .other),
        PerformanceExpressionDictionaryData(title: "오글/오페라 글라스", description: "공연 관람 시 사용하는 소형의 망원경", type: .other),
        PerformanceExpressionDictionaryData(title: "웨투파/Way too far", description: "매체 활동을 시작하며 무대와 멀어진 배우", type: .other),
        PerformanceExpressionDictionaryData(title: "지뢰", description: "특정 극이 연상 될 만한 말이나 행동 또는 물건", type: .other),
        PerformanceExpressionDictionaryData(title: "참사랑", description: "공연을 관람하기 어려운 상황에도 불구하고 공연을 보러 극장에 가는 것", type: .other),
        PerformanceExpressionDictionaryData(title: "컨프롱/confrontation", description: "무언가를 할 지 말 지 고민하는 것", type: .other),
        PerformanceExpressionDictionaryData(title: "퇴근(길)", description: "공연 후 퇴근길에 진행하는 팬미팅 (ex. 선물 전해주기, 편지 전해주기, 싸인 받기, 사진찍기 등)", type: .other),
        PerformanceExpressionDictionaryData(title: "회전문", description: "같은 공연을 여러 번 관람하는 것", type: .other)
    ]
}
