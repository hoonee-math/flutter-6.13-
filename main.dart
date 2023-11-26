import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

/*#6.6강 코드 & 설명
/*home_screen.dart에서 Future 로 만들어주면서 const가 아니게 되었기 때문에 home변수도 const를 지워줘야함*/

void main() {
  /* ApiService().getTodaysToons();
  호출하는 이 코드를 지워주자. 이 코드는 그냥 콘솔로 확인해보려는 작업이었을 뿐임.*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
