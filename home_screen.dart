import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_services.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';
/*#6.5강 (waitForWebToons) 데이터를 fetch해서 State에 넣는 방법 
/* Api_services.dart에서 만든 metod(static Future<List<WebtoonModel>> getTodaysToons() async)를 HomeScreen에 호출하기!
  데이터를 보여줘야 하는 곳이 home_screen이기 때문에!
  */
/* Future데이터를 불러와서 보여주는 방법은 크게 두 가지가 있다.
  우선 아래 HomeScreen 을 StatefulWidget으로 바꾸자. 
  class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
  */
/* StatefulWidget 으로 바꾸는 이유는 이제 State를 사용할 거기 때문에!
  바꾸고나면 widget class와 Satate class가 생긴다.
  state class 에는 UI 와 변할 수 있는 데이터를 가지고 있다.
  */
/* State class 첫 줄에 (@override위쪽) State가 가지는 데이터를 써주자
  데이터 타입은 WebtoonModel의 리스트이기 때문에, List<WebtoonModel> 이름은 webtoons 라고 지어주자. 초기값은 빈 배열이기 때문에 = [];
  */
/* 다음 데이터 isLoading state를 만들기위한 변수도 만들자.
  bool타입으로 만들고 이름은 isLoading, 초기값은 ture;
  */
/* 다음 initState를 사용하자
  initState 를 tab하여 만들면 @override로 생성됨.
  먼저 super.initState를 호출하고, waitForWebtoons라는 함수를 호출하자.  
  */
/* waitForWebtoons 함수를 정의하자. (getTodaysToons의 api호출을 기다리는 함수)
  ititState 를 만들면서 필요했던 waitForWebtoons함수를 정의해주자.
  이건 비동기 함수(async)가 될거야. HTTP 요청을 기다리는 함수를 기다려야 하기 때문이지.
  API Service에 있는 getTodaysToons 함수가 Http 요청을 기다리기 때문에 getTodaysToons 함수가 종료되는 것도 기다려워쟈 함!
  */
/* State의 webtoons 배열에 데이터를 넣어보자.
  webtoons = await ApiService.getTodaysToons(); 이렇게 넣어주고 이 waiting작업이 끝나면,
  isLoading을 flase로 바꿔주는 작업을 추가하자.
  isLoading = false;
  이후에 StatefulWidget의 Ui가 새로고침되게끔 함수를 만들어주자.
  setState(() {}); //이 부분은 비어있어도 새로고침하는데 문제 없다.
  */
*/
/*#6.5강 코드
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
*/

/*#6.6강 (FutureBuilder) State를 사용하지 않고 필요한 데이터를 fetch하는 다른 방법! 즉 FutureBuilder가 future값을 기다리고, 데이터가 존재하는지 알려줌. future를 정의하기만 하면됨
/* 사실 ApiService 클래스는 만들지 않아도 됨.
  강의에서 이걸 사용한 이유는 코드를 정돈하고, 서비스로 분리하고 ui와 api접근이 간섭받지 않게 하기 위해서 였음
  하지만 api_services.dart 문서에 있는 다음 코드를 void waitForWebToons() async { 여기에 복사 붙여넣어서 사용할 수도 있음
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
        for (var webtoon in webtoons) {
          webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        }
      }
*/
/* 이분은 필요없어짐
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }
*/
/* code action을 열어서 stateLesWidget으로 되돌리기
*/
/* const HomeScreen({super.key}); 에서 const를 지워줘야함.
  HomeScreen를 const 클래스로 만들었지만, 지금 class안에 Future를 넣었기 때문에 클래스가 const일 수 없음
  const는 컴파일 전에 값을 알고 있다는 뜻이기 때문에!!
  지금 같은 경우에는 우리가 값을 알수 없다! Api로부터 오는 Future이기 때문에!
  main.dart 에서 home도 const를 지워줘야 함.
  */
/* 그럼 어떻게 Future(아래 부분)를 기다릴 수 있을까? 
  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons(); 이 부분을 wait걸어줄 방법  
  */
/* 그리고 Future의 로딩 상태를 어떻게 build메소드(아래 부분)에 전달할 수 있을까?
  Widget build(BuildContext context) {
    return Scaffold(
*/
/* build메소드에 print(webtoons)를 출력해 보면 Future를 전혀 기다리지 않고 있음.
  Widget build(BuildContext context) {
  print(webtoons);
  결과 : Future<List<WebtoonModel>> webtoondModel의 리스트 그 자체가 출력되지는 않음
  이걸 위한 정확한 위젯이 존재함.
  */
/* 이걸 위한 widget이 바로 FutureBuilder라는 위젯이 있다.
  Scaffold의 body에 FutureBuilder를 넣어주자.
  FutureBuilder에는 builder라는 매개변수가 필요함.
  Builder는 Ui를 그려주는 함수임.
  그리고 initialData도 전달할 수 있음.
  future도 전달할 수 있지. 우리가 원하는 것이 이거임.
  */
/* FutureBuilder에게 webtoons를 기다려달라고 하자.
  future: webtoons,
  여기에는 await를 쓸 필요가 없음. FutureBuilder가 알아서 해줄 거기 때문에!
  */
/* builder 함수를 만들어줘야 한다.
  FutureBuilder가 Builder에 전달하는 매개변수를 살펴보면, (context, snapshot)
  build context와 snapshot이다. context는 이미 알고있는데 snapshot은??
  snapshot을 이용하면 Future의 상태를 알 수 있다.
  snapshot의 메서드들을 확인해보면, Future가 데이터를 받았는지, 오류가 났는지 알 수 있다.
  
  snapshot.hasData가 참이면 future가 완료되어서 데이터가 존재하면 "There is data!"라는 Text를 반환해보자.
  builder: (context, snapshot) {
    if(snapshot.hasData){
      return Text("There is data!");
    }
    return const Text('Loading....');
  },
  */
*/
/*#6.6강 코드
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text("There is data!");
            }
            return const Text("loading....");
          }),
    );
  }
}
*/

/*#6.7강 (Listview Widget) snapshot.data안에 있는 데이터를 화면에 띄워보자. 
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /* 한번에 로딩해주는 Listview대신에 더 전문적이고 많은 아이템에 최적화되어있는 코드를 써보자
            return ListView(
              children: [
                for (var webtoon in snapshot.data!) Text(webtoon.title) 
                //snapshot.data가 null일 수 있어서 오류가 나지만 '!'를 이용해 데이터가 있을거라고 확신을 주자
              ],
            );*/
            /*listview를 통해 list에 index를 주고 화면에 보이는것만 로딩해서 보여주는 작업
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var webtoon = snapshot.data![index];
                print(index);
                return Text(webtoon.title);
              },
            );*/
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
*/

/*#6.8강 (Webtoon Card)
/* Listview.separated를 code action을 이용해 Extract metod로 만들어 이름지어주기
  builder라는 단어가 너무 많이 보이는걸 깔끔하게 만들어줄 수 있음.
  */
*/
/*#6.8강 코드
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

/* extract metod로 만들어진 분리된 metod
  snapshot을 쓴다는걸 이미 알고 있기 때문에, 그걸 parameter로 받는 metod가 만들어짐
  위의 코드는 보기 훨씬 좋아짐.*/
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      offset: const Offset(10, 10),
                      color: Colors.red.withOpacity(0.5),
                    )
                  ]),
              child: Image.network(
                webtoon.thumb,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
*/

//#6.9강 (Detail Screen) 카드를 클릭하면 웹툰의 상세페이지로 이동하도록 위젯만들기
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

/* extract metod로 만들어진 분리된 metod
  snapshot을 쓴다는걸 이미 알고 있기 때문에, 그걸 parameter로 받는 metod가 만들어짐
  위의 코드는 보기 훨씬 좋아짐.*/
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );

        /* #6.9강 이부분을 widget으로 만들어줄거임. Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      offset: const Offset(10, 10),
                      color: Colors.red.withOpacity(0.5),
                    )
                  ]),
              child: Image.network(
                webtoon.thumb,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        );*/
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
