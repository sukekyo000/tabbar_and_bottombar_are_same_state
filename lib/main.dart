import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  int currentIndex = 0;
  TabController? _tabController;

  Widget aPage = const Page(pageName: "A Page");
  Widget bPage = const Page(pageName: "B Page");

  final tab = [
    const Tab(text: "A"),
    const Tab(text: "B"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController?.addListener(() {
      setState(() {
        currentIndex = _tabController?.index ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab and BottomBar are Same State'),
          centerTitle: true,
          bottom: TabBar(
            labelStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
            controller: _tabController,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                _tabController?.animateTo(index);
              });
            },
            tabs: tab,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            aPage,
            bPage
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 24,
          unselectedFontSize: 18,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              _tabController?.animateTo(index);
            });
          },
          items: [
            BottomNavigationBarItem(icon: Container(), label: 'A'),
            BottomNavigationBarItem(icon: Container(), label: 'B'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class IconText extends Text {
  const IconText(String title, {super.key} ):super(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18
    )
  );
}

class Page extends StatelessWidget{
  const Page({super.key, required this.pageName});
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        pageName,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}