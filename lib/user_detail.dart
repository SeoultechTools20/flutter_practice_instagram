import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    super.initState();
    context.read<State_Store>().getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(context.watch<State_Store2>().name),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.more_horiz))
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Detailheader(),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (c, i) => Container(color: Colors.grey)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3))
          ],
        ));
  }
}

class Detailheader extends StatelessWidget {
  const Detailheader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/몬스터.jpeg',
                ),
                backgroundColor: Colors.black,
                radius: 40,
              ),
              Column(
                children: [
                  Text('1,042'),
                  Text('Posts'),
                ],
              ),
              Column(
                children: [
                  Text('1,214'),
                  Text('Followers'),
                ],
              ),
              Column(
                children: [
                  Text('1,696'),
                  Text('Following'),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 10, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(

                  children: [
                    Text('이태석', style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text('안녕하세요. Monster.Corp 회장입니다.', style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ))
                  ],
                ),
                Row(
                  children: [
                    Text('⭐️ Monster.Corp CEO ⭐', style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
