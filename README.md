# FindDict-Client

![iPad Pro 11_ - 22](https://user-images.githubusercontent.com/25932970/205915035-5c505977-41e8-486f-bff5-07f42ce6e84f.svg)



## Library

|                     라이브러리                      |                   용도                    |
| :-------------------------------------------------: | :---------------------------------------: |
|    [SnapKit](https://github.com/SnapKit/SnapKit)    |      코드 베이스 UI 작업 시간 최소화      |
|       [Then](https://github.com/devxoul/Then)       | 클로저를 통해 인스턴스에 대한 처리 간결화 |
| [Alamofire](https://github.com/Alamofire/Alamofire) |           네트워킹 작업 단순화            |

## Code Convention

- 함수 : `lowerCamelCase`, `동사 + 목적어` 형태
- 변수, 상수 : `lowerCamelCase`
- 클래스 : `UpperCamelCase`
- 약어 사용 범위
```
  TableView -> TV
  TableViewCell -> TVC
  CollectionView -> CV
  CollectionViewCell -> CVC
  ViewController -> VC
  identifier -> id
  ```

  
- 주석

    `//`-> MARK, TODO 주석

    `///`-> 문서화 주석
- MARK 구문
    - 10줄 이상의 모든 파일에서는 MARK 구문을 사용합니다.
    - 해당하는 MARK 구문만 사용합니다.
    ```
    // MARK: - Properties
    // MARK: - Initialization
    // MARK: - View Life Cycle
    // MARK: - UI
    // MARK: - Functions

    // MARK: - Extension명
    // MARK: - Network
    ```


## Git Flow
 
### 작업 순서
```
1. Issue 생성
2. Branch 생성
3. 작업, commit
4. push
5. PR 작성
6. 코드 리뷰 (24시간 이내)
7. 두 명(권장), 한 명(최소) Approve 받았을 경우 셀프 merge
8. Delete Branch
```
### Commit Convention
>  `타입`: `설명` #`이슈 번호`

```
  Feat: 기능 구현
  Fix: 버그 수정
  Refactor: 코드 리팩토링
  Design: UI 디자인 수정
  Docs: 주석, 문서화 
  Chore: 그 외
```
### Branch

- 가장 처음에 붙는 분류 영역에서는, 커밋 컨벤션의 워딩과 동일하게 작성합니다.

#### Branch Naming

> `분류` /#`이슈 번호` - `작업 내용`

```swift
chore/#3-ProjectSetting
feat/#3-GameLogic
fix/#5-DictionaryDetail
refactor/#1-Vision

```


### Merge

- 본인의 `PR`은 본인이 `Merge`합니다.
- 최대한 빨리, 최대 24시간 이내에 코드 리뷰를 등록합니다.
- Approve를 최소 1명한테 받아야 Merge가 가능합니다.
    - 2명이 최대한 Approve 줄 수 있도록 합시다!
- 코드 리뷰를 하면서 필수적인 수정 사항을 발견할 경우, `Approve` 대신 `Request Changes`를 주어 수정을 요구합니다.
    - 해당 `PR` 작업자는, 수정 사항을 반영하여 새로 `commit`을 추가한 후, 해당 `PR`에 `push`하여 `Re-request review`를 요청합니다.
        1. `Request Changes`: 컨벤션 
        2. `Approve`: 일단 OK! 로직, 리팩토링 가능한 부분, 더 나은 코드를 위한 제안 등
- 모든 작업이 완료되어 `Merge`가 된 경우, 해당 `PR` 하단의 `Delete Branch`를 선택하여 작업이 끝난 `Branch`를 삭제합니다.
 
 
 
 ## Foldering
 
 ```
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Global
│   ├── Base
│   ├── Extensions
│   ├── MessageType.swift
│   └── UserToken.swift
├── Info.plist
├── Model
├── Network
│   ├── APIEssentials
│   ├── APIManagers
│   ├── Bases
│   ├── EvenLogger.swift
│   └── Services
├── Protocols
├── Resources
│   ├── Assets.xcassets
│   ├── Fonts
│   └── WordDictionary.swift
└── Sources
    ├── Components
    └── Scences
        ├── Auth
        ├── Base.lproj
        ├── Dictionary
        ├── Game
        ├── Main
        └── Tutorial
```
