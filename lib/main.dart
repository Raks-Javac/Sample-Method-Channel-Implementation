import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Method channel Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SampleChannelApp(),
    );
  }
}

class SampleChannelApp extends StatefulWidget {
  const SampleChannelApp({super.key});

  @override
  State<SampleChannelApp> createState() => _SampleChannelAppState();
}

class _SampleChannelAppState extends State<SampleChannelApp> {
  static const platform = MethodChannel('sample/popUp');
  static void popUpDialogWithChannels() async {
    logExecutionTime("Dialog with channels", () async {
      try {
        final result = await platform.invokeMethod('popUp');
        log(result.toString());
      } on PlatformException catch (e) {
        log(e.toString());
      }
    });
  }

  //pop up dialog with widget
  static void popUpDialogWithWidget(BuildContext context) async {
    logExecutionTime("Dialog with widget", () async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Dialog Title'),
            content: const Text('This is a custom dialog.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Method channel Sample App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TextButton(
                onPressed: popUpDialogWithChannels,
                child: Text(
                  "Pop Up Native Dialog with Channels",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  popUpDialogWithWidget(context);
                },
                child: const Text("Pop Up Native Dialog with Widget"),
              ),
            ], // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ));
  }
}

void logExecutionTime(String functionName, Function function) {
  // Record the start time
  final startTime = DateTime.now().millisecondsSinceEpoch;

  // Execute the function
  function();

  // Record the end time
  final endTime = DateTime.now().millisecondsSinceEpoch;

  // Calculate the execution time
  final executionTime = endTime - startTime;

  // Log the execution time
  log('$functionName executed in $executionTime milliseconds');
}
