import 'dart:async';
import 'package:flutter/material.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:js/js.dart' as js;
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

@js.JSExport()
class _MyAppState extends State<MyApp> {
  final _streamController = StreamController<void>.broadcast();

  late final RiveAnimationController bounceController;
  late final RiveAnimationController moveidle;
  // late final RiveAnimationController stopController;

  // CounterScreen _counterScreen;
  int _counterCount = 0;
  bool isPLaying = false;

  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod(js_util.globalThis, '_stateSet', []);

    // loading = OneShotAnimation("Loading", autoplay: true, onStop: () {
    //   bounceController.isActive = false;
    // });
    moveidle = OneShotAnimation("Move_1", autoplay: false, onStop: () {
      // bounceController.isActive = true;
    });
    bounceController = OneShotAnimation("Jump", autoplay: false, onStop: () {});

    // stopController = OneShotAnimation(
    //   "FinishLoading",
    //   onStart: () {
    //     bounceController.isActive = false;
    //   },
    // );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  

  //! Rive handler
  @js.JSExport()
  void playRive() {
    setState(() {
      bounceController.isActive = true;
      moveidle.isActive = true;
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void moveRive() {
    setState(() {
      moveidle.isActive = true;
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void addHandler(void Function() handler) {
    _streamController.stream.listen((event) => handler());
  }

  @js.JSExport()
  int get count => _counterCount;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    // RiveAnimationController riveAnimationController = RiveAnimationController();
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //* Original
                  ElevatedButton(
                      onPressed: () {
                        bounceController.isActive = true;
                        moveidle.isActive = true;
                        // bounceController.isActive = ;
                      },
                      child: const Icon(Icons.play_arrow)),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        moveidle.isActive = true;
                      },
                      child: const Icon(Icons.forward)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: RiveAnimation.asset(
                  "assets/skull.riv",
                  controllers: [bounceController, moveidle],
                  onInit: (_) {
                    setState(() {});
                  },
                  // animations: ["StartLoading,Loading,FinishLoading"],
                  placeHolder: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: increaseCount,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
