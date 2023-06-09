import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_isolate/api.dart';
import 'package:lets_isolate/services/bidirectional.dart';
import 'package:lets_isolate/services/compute.dart';
import 'package:lets_isolate/services/spawn.dart';
import 'package:lets_isolate/services/streams.dart';

import 'services/load_balancer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Person? person;
  String? md5Hash;

  final loadBalancerService = LoadBalancerService();
  final computeService = ComputeService();
  final biDirectionalService = BiDirectionalService();
  final spawnService = SpawnService();
  final streamService = StreamService();

  void _loadBalancer() {
    loadBalancerService.fetchUser().then((value) {
      setState(() {
        person = value;
      });
    });
  }

  void _compute() {
    computeService.fetchUser().then((value) {
      setState(() {
        person = value;
      });
    });
  }

  void _biDirectional() {
    biDirectionalService.fetchUser().then((value) {
      setState(() {
        person = value;
      });
    });
  }

  void _spawn() {
    spawnService.fetchUser().then((value) {
      setState(() {
        person = value;
      });
    });
  }

  void _stream() {
    streamService.getHashedUserData().listen((value) {
      setState(() {
        md5Hash = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              person?.name ?? 'Hello World',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              md5Hash ?? 'No Hashes yet',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: _compute, child: const Text("Using Compute")),
            ElevatedButton(onPressed: _spawn, child: const Text("Using Spawn")),
            ElevatedButton(
                onPressed: _biDirectional,
                child: const Text("Using BiDirectional")),
            ElevatedButton(
                onPressed: _loadBalancer,
                child: const Text("Using LoadBalancer")),
            ElevatedButton(
                onPressed: _stream,
                child: const Text("Using Stream"))
          ],
        ),
      ),
    );
  }
}
