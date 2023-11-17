## LessonNote
![image](https://github.com/dudwnssss/LessonNote/assets/76581866/269ba525-70d8-4c7f-84db-16b95f9d914c)

## Topic
- **[레슨노트 - 과외 선생님을 위한 학생 관리 서비스]**
- **맡은 역할** : 서비스 기획, iOS 개발 (1인)
- **개발 기간** : 2023.09 ~ 2023.10 (지속적으로 업데이트 중)
- **앱스토어 링크** :  [레슨노트 앱스토어 바로가기](https://apple.co/475WPgo)   

## Main Functions
1. 학생 추가하기
2. 수업 일정표와 캘린더
3. 수업 일지 기록하기
4. 커스텀 메시지 / 전화걸기

## Tech
- **Language** : Swift
- **Architecture** : MVVM Input/Output Pattern
- **Reactive** : RxSwift, RxCocoa
- **UI** : CodeBase, Snapkit, Custom View
- **Database** : Realm
- **etc** : FSCalendar, EllioTable, FloatingPanel

## Experience
- **MVVM 아키텍쳐** : ViewModel에서 데이터와 비즈니스 로직을 담당, View에서는 UI presentation과  상호작용을 담당하도록 설계하여 코드의 재사용성과 유지보수성을 향상

- **디자인 시스템, 커스텀 뷰 재사용** : 디자이너와 협업을 통해서, Figma를 사용하여 디자인시스템을 구축,  재사용이 가능한 컴포넌트를 제작했습니다. 사용자에게  일관성있는 UI/UX를 제공

- **Realm 기반 로컬 데이터베이스 구축** : 데이터베이스 정규화 과정을 통해 To-Many 관계의 Realm 테이블 구축
Repository 패턴을 사용하여 CRUD 과정의 코드 일관성 및 서비스 유지보수성 확보

- **Modern CollectionView** : Compositional Layout을 사용하여, MultiSection의 레이아웃을 구성, 데이터의 CRUD가 자주 발생하는 화면에서 Diffable DataSource를 적용. Snapshot 기반의 애니메이션 효과를 통해 보다 인터렉티브한 사용자 경험 제공

- **라이브러리 커스텀** : 요일 단위의 시간표 라이브러리 EllioTable을  CollectionView로 래핑, EllioTable의 dataSource를 커스텀하여 페이징을 통해, 주차별 수업 일정을 나타내는 일정표를 구현


## Trouble Shooting
- **캘린더에 수업일정 반영**: <br>
FSCalendar의 확장함수들은 Date 배열 형식으로만, event나 subtitle을 표현합니다. 유저로부터 받는, 수업요일, 기준요일, 격주여부, 시작날짜 정보를 활용하여, 특정 기간동안 수업 일자를 알아내야 하는 문제가 있었습니다. Date 정보를 포함하고 있는 시작날짜가 유일하기 때문에 이를 기준으로, 요일을 Int로 매핑하고, 수업요일에 대해 +-연산을 적용하여 1주일치 Date를 계산, 격주를 n*7로 연산하여 1년치의 수업일정 [Date]를 생성하는 함수를 구현했습니다. 


- **주간 단위 일정표 구현** <br>
EllioTable의 Model은 요일과, 시작시간, 종료시간 정보만을 포함하고 있어, 날짜 개념이 존재하지 않는 문제가 있었습니다. 격주 수업일정을 반영하기 위해서는, 특정주차의 요일에 수업유무를 판단할 수 있는 로직이 필요했고, 8주치의 수업날짜를 계산, 주차정보와 요일별 수업유무를 나타내는 이중배열로 변환하여 요일에 수업이 false일 경우 hidden하는 방식으로 구현했습니다.

## ScreenShots
![image](https://github.com/dudwnssss/LessonNote/assets/76581866/e070706c-6e3b-414f-81d5-d3ef54b13b93)
![image](https://github.com/dudwnssss/LessonNote/assets/76581866/321e352f-49ef-4898-bc08-4e4ddf5deb62)
![image](https://github.com/dudwnssss/LessonNote/assets/76581866/2fdfde14-8071-456e-b828-8583ad143e8c)


## Post Mortem
### 업데이트
**1.0.4**
- 리팩토링 (input output 패턴 적용)<br>
- 커스텀 메시지, 여러 월 선택 시 UI 수정

**1.0.3**
- 종료시간이 시작시간보다 빠른 시간으로 설정 가능한 버그 수정<br>
- 연락처, 커스텀 메시지 UI 수정

**1.0.2** 
- 수업 내역을 남기고, 시작 일자를 변경 시, 수업 내역 초기화<br>
- today UI 수정, 학생 이름 UI 수정

**1.0.1**
- 캘린더 수업 일정 버그 수정
- 일정표에 격주 여부 반영
