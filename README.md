### The Movie Database(TMDB) API를 활용한 iOS 앱 제작 연습

#### 1월 29일 (월)
![0130](https://github.com/Jin0331/Media-Project/assets/42958809/2ba9ad48-776e-4d42-bfff-c0899374a27d)

> 1. TMDB의 TRENDING-TV, TV SERIES LISTS-Top Rated, Popular 등 3개의 API를 활용
> 2. Collection View(상단), 하단 Table View + Collection View로 구현함
> 3. UI는 점차 나아질 예정...

#### 1월 31일 (수) ~ 2월 1일 (목)
![1](https://github.com/Jin0331/Media-Project/assets/42958809/e29aaf34-ca0f-4e32-91ca-988c7e1594c6)
![2](https://github.com/Jin0331/Media-Project/assets/42958809/6a8e22a4-7063-47eb-ab3a-98b7c9fa27b0)


>1. View Controller에서 View 분리
>2. API Request -> API Manager의 로직개선(generic, enumeration 등등..)을 활용해서 반복적인 구문 개선
>3. UI는 크게 바뀐 것이 없음..ㅎ
>4. Search API를 활용하여, 첫 화면의 Collection View Cell을 클릭했을 때 전환하도록 수정해야 할 듯(로직은 다 구성되어 있어서, 조금만 수정하면 될 것 같다. 현재는 고정값으로 id가 박혀있음)

#### 2월 2일 (금) ~ 2월 6일 (화)

![media (2)](https://github.com/Jin0331/Media-Project/assets/42958809/857e55e8-3eca-4fcb-b628-fa4f79c1eb14)

1차 마무리...
>1. URLSession, Alamofire를 이용한 TMDB API 연습
>2. Snapkit + Then을 이용한 MVC pattern 연습
>3. TableView 속 Collection View 등 혼합 View 연습

```
-- 마무리 못한 것들 🥲
1. Image의 리사이징
2. Decodable의 간헐적인 에러(nil 일 경우에 대한 완벽한 예외처리가 구현되지 않음)
3. Detail View에서 button의 기능을 토글로 구현하여 버그 있음.
  -> Watcha처럼 슬라이드 뷰로 구현해야 됨.
4. Search에서 장르 및 국가 비디오에서 Sort기능이 없어, 원하는 항목찾기 어렵고 비디오가 0개 임에도 포함된 경우가 있음.
5. UI가 조잡한 느낌?!
6. Search에서 데이터 꼬인듯?? 나중에 확인....
```
