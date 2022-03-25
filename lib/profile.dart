import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (c, i) => Container(color: Colors.grey)
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3
                )
            )
          ],
        )
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text('팔로워 ${context.watch<State_Store>().follower.toString()}명'),
            if (context.watch<State_Store>().friend == false)
              ElevatedButton(
                onPressed: () {
                  context.read<State_Store>().changeFollower();
                },
                child: Text('팔로우'),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              )
            else
              ElevatedButton(
                onPressed: () {
                  context.read<State_Store>().changeFollower();
                },
                child: Text('팔로우 해제'),
                style: ElevatedButton.styleFrom(primary: Colors.grey),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<State_Store>().getData();
              },
              child: Text('사진 가져오기'),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<State_Store2>().changeName();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              child: Text('쭈니 이름 변경'),
            ),
          ],
        ),
        Divider(
          color: Colors.black,
          thickness: 2.0,
        ),
      ],
    );
  }
}
