import 'package:flutter/material.dart';
import 'package:jogodavelha/service/logic.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  final Logic logic = Logic();

  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Jogo Da Velha"),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return Column(
      children: [
        header(),
        bodyGame(),
        footer()
      ],
    );
  }

  header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Text(
                'Player 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Text(
                'Player 2',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  bodyGame() {
    return Expanded(
      flex: 4,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _tapped(index);
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Center(
                child: Text(
                  displayElement[index],
                  style: const TextStyle(color: Colors.black, fontSize: 35),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      displayElement[index] = 'A';
    });
  }

  footer() {
    return Container(
        child: Text(_packageInfo.version),
    );
  }

  getVersion(){
    return _packageInfo.version;
  }
}
