import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (c) => State_Store(),
        child: MaterialApp(
            theme: style.theme,
            // initialRoute: '/',
            // routes: {
            //   '/' : (c) => Text('첫페이지'),
            //   '/detail' : (c) => Text('둘째페이지')
            // },
            home: MyApp(),
            debugShowCheckedModeBanner: false)),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];
  var userImage;
  var userContent;

  saveData() async {
    var storage = await SharedPreferences.getInstance();

    var map = {'age': 20, 'name': '장민수', 'sex': '남자'};
    storage.setString('map', jsonEncode(map));

    var result = storage.getString('map') ?? '없는뎁쇼?';

    print(jsonDecode(result));
  }

  addMyData() {
    var myData = {
      'id': data.length,
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'John Kim'
    };
    setState(() {
      data.add(myData);
    });
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('Instagram'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    userImage = File(image.path);
                  });
                }
              },
              icon: Icon(Icons.add_box_outlined),
              iconSize: 30,
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/몬스터.jpeg'),
                  backgroundColor: Colors.white,
                ),
                accountName: Text('몬스터'),
                accountEmail: Text('monstercorp@naver.com'),
                onDetailsPressed: () {
                  print('arrow is cliked');
                },
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    )),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.indigoAccent),
                title: Text('Home', style: TextStyle(color: Colors.black)),
                onTap: () {
                  print('Home is Clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading:
                    Icon(Icons.question_answer, color: Colors.indigoAccent),
                title: Text('Q&A', style: TextStyle(color: Colors.black)),
                onTap: () {
                  print('Q&A is Clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.indigoAccent),
                title: Text('Settings', style: TextStyle(color: Colors.black)),
                onTap: () {
                  print('Settings is Clicked');
                },
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ),
        body: [Home(data: data), Text('샵페이지')][tab],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (i) {
            setState(() {
              tab = i;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: '홈',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: '샵',
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
            ),
          ],
        ));
  }
}

class listView extends StatelessWidget {
  const listView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
          controller: scroll,
          itemCount: 4,
          itemBuilder: (c, i) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.data[i]['image'].runtimeType == String
                      ? Image.network(widget.data[i]['image'])
                      : Image.file(widget.data[i]['image']),
                  GestureDetector(
                    child: Text(widget.data[i]['user'],
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => Profile(),
                            transitionsBuilder: (c, a1, a2, child) =>
                                FadeTransition(opacity: a1, child: child),
                            // transitionDuration: Duration(microseconds: 500000),
                          ));
                    },
                  ),
                  Text(widget.data[i]['id'].toString()),
                  Text(widget.data[i]['likes'].toString()),
                  Text(widget.data[i]['date'].toString()),
                  Text(widget.data[i]['content'].toString()),
                  Text(widget.data[i]['liked'].toString()),
                ]);
          });
    } else {
      return Text('로딩중임');
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData})
      : super(key: key);

  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('사진 업로드 확인 상자'),
                        content: Text('정말로 업로드 할거임?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('아니오')),
                          TextButton(
                              onPressed: () async {
                                await addMyData();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('예스'))
                        ],
                      ));
            },
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('업로드화면'),
          TextField(
            onChanged: (text) {
              setUserContent(text);
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
    );
  }
}

class State_Store extends ChangeNotifier {
  var name = 'bbyoungjun_is_live';
  var follower = 0;
  var follower2 = 1;

  changeName() {
    name = 'jjunni_food';
    notifyListeners();
  }

  changeFollower() {
    follower == follower2 ? follower = follower - 1 : follower = follower + 1;
    notifyListeners();
    print(follower);
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(context.watch<State_Store>().name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/몬스터.jpeg',
                ),
                backgroundColor: Colors.black,
                radius: 40,
              ),
              Text('팔로워 ' +
                  context.watch<State_Store>().follower.toString() +
                  '명'),
              ElevatedButton(
                onPressed: () {
                  context.read<State_Store>().changeFollower();
                },
                child: Text('팔로우'),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              )
            ],
          ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       context.read<State_Store>().changeName();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.purple,
          //     ),
          //     child: Text('버튼'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
