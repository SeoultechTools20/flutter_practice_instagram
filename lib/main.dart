import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
          theme: style.theme,
          home: MyApp()
      )
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

  getData() async {
    var result = await http.get(
        Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Instagram'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
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
                onDetailsPressed: (){
                  print('arrow is cliked');
                },
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),

                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.home,
                color: Colors.indigoAccent
                ),
                title: Text('Home',
                    style: TextStyle(
                      color: Colors.black
                    )
                ),
                onTap: (){
                  print('Home is Clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.question_answer,
                    color: Colors.indigoAccent
                ),
                title: Text('Q&A',
                    style: TextStyle(
                        color: Colors.black
                    )
                ),
                onTap: (){
                  print('Q&A is Clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    color: Colors.indigoAccent
                ),
                title: Text('Settings',
                    style: TextStyle(
                        color: Colors.black
                    )
                ),
                onTap: (){
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
        )
    );
  }
}

class listView extends StatelessWidget {
  const listView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return ListView.builder(
        itemCount: 3,
        itemBuilder: (c, i) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(data[i]['image']),
                Text(data[i]['id'].toString()),
                Text(data[i]['likes'].toString()),
                Text(data[i]['date'].toString()),
                Text(data[i]['content'].toString()),
                Text(data[i]['liked'].toString()),
                Text(data[i]['uesr'].toString()),
              ]
          );
        }
      );
    }
    else{
      return Text('로딩중임');
    }
    }
  }
