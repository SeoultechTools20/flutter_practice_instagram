import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'user_detail.dart';

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
                            pageBuilder: (c, a1, a2) => Detail(),
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