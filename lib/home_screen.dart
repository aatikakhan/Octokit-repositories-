import 'package:flutter/material.dart';
import 'package:gofinance/data_repository.dart';
import 'package:gofinance/widgets.dart';
import 'package:provider/provider.dart';

import 'data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double opacity = 1.0;

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).getData();
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
    List<DataModel>? entries =
        Provider.of<DataProvider>(context, listen: false).data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Trending',
          style:
              TextStyle(color: Color(0xff25282b), fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<Widget>(
              icon: Image.asset('assets/icons/more-black-24.png'),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Widget>>[
                PopupMenuItem<Widget>(
                  child: GestureDetector(
                    child: const Text('Sort by stars'),
                    onTap: () {
                      // sort based on stars on repo
                      entries!.sort((a, b) =>
                          a.stargazersCount!.compareTo(b.stargazersCount!));
                      Navigator.pop(context);
                    },
                  ),
                ),
                PopupMenuItem<Widget>(
                  child: GestureDetector(
                    child: const Text('Sort by name'),
                    onTap: () {
                      // sort based on name

                      entries!.sort((a, b) => a.name!.compareTo(b.name!));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () {
          setState(() {});
          // on refresh update the data
          return Provider.of<DataProvider>(context, listen: false).getData();
        },
        child: entries == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .5,
                        child: Image.asset(
                            'assets/icons/nointernet_connection.png')),
                    const Text(
                      'Something went wrong..',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'An alien is probably blocking your signal.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () {
                              Provider.of<DataProvider>(context, listen: false)
                                  .getData();
                              entries = Provider.of<DataProvider>(context,
                                      listen: false)
                                  .data;
                            },
                            style: TextButton.styleFrom(
                              side: const BorderSide(color: Colors.green),
                            ),
                            child: const Text(
                              'RETRY',
                              style: TextStyle(color: Colors.green),
                            ),),
                      ),
                    ),
                  ],
                ),
              )
            : listwidget(entries),
      ),
    );
  }
}
