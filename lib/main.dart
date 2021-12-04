import 'package:flutter/material.dart';
import 'package:pagination_flutter/custom_pagination_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int lenth = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomPaginationLayout(
            onScrollFinish: fetch,
            query: {'id': 1},
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: lenth,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  color: Colors.black12,
                  margin: EdgeInsets.all(10),
                );
              },
            )));
  }

  Future<int> fetch(Map<String, int> query) async {
    print(query);
    lenth += 10;
    if (query['page'] == 1) lenth = 10;
    setState(() {});
    return lenth;
  }
}
