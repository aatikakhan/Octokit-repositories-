import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> entries = [1, 1, 2, 2, 2, 2, 2, 2];
  String hexString = '#25282B';
  bool isExpanded = false;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Trending',
          style: TextStyle(
            color: Color(0xff25282b),
          ),
        ),
      ),
      body: Consumer<DataProvider>(
          builder: (context, DataProvider dataProvider, child) {
        return AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 2),
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  onExpansionChanged: (status){
                    setState(() {
                      dataProvider.getData();
                      
                    });
                  },
                  leading: Image.asset('assets/icons/fork-black-16.png'),
                  title: Text('${entries[index]}'),
                  children: const [
                    Center(child: Text('we are exploring')),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ));
      }),
    );
  }
}
