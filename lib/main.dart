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
import 'homepage.dart';
import 'img_upload.dart';
import 'profile.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => State_Store()),
          ChangeNotifierProvider(create: (c) => State_Store2())
        ],
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => Upload(
                            userImage: userImage,
                            setUserContent: setUserContent,
                            addMyData: addMyData)));
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


class State_Store extends ChangeNotifier {
  var follower = 0;
  var friend = false;
  var profileImage = [];

  getData() async {
    var image = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result = jsonDecode(image.body);
    profileImage = result;
    notifyListeners();
    print(profileImage);
  }

  changeFollower() {
    if (friend == false) {
      follower++;
      friend = true;
    } else {
      follower--;
      friend = false;
    }
    notifyListeners();
  }
}

class State_Store2 extends ChangeNotifier {
  var name = 'fd_gallery_';
  var change = false;

  changeName() {
    if (change == false) {
      name = 'jjunni_food';
      change = true;
    } else {
      name = 'bbyoungjun_is_live';
      change = false;
    }
    notifyListeners();
  }
}

