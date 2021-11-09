import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/image_list.dart';
import 'package:testapp/image_picker.dart';
import 'package:testapp/tiktok.dart';

void main() {
  runApp(MyImagePicker());
}

void isolateFunction(Map<String, int> params) {
  int _count = 0;

  for (int i = 0; i < params["finalNum"]!; i++) {
    _count++;
    if ((_count % 100) == 0) {
      print("isolate: " +  _count.toString());
    }
  }
}

void isolateImageMemory(Map<String, dynamic> params) async {
  
  print("url: " + params["url"]!);

  // var response = await Dio().get(
  //   params["url"]!,
  //   options: Options(responseType: ResponseType.bytes),
  // );
  // print(response.data);

  new NetworkImage(params["url"]!)
      .resolve(new ImageConfiguration())
      .addListener(new ImageStreamListener((ImageInfo image, bool _) {
        // print("mantep image width: ${image.image.width} height ${image.image.height}");
        // if (state.type == ImageType.ImageUnload) {
        //   emit(ImageState(
        //     type: ImageType.ImageLoaded,
        //     url: url,
        //     imageBytes: Uint8List.fromList(response.data),
        //     width: image.image.width * (width * 100 / (image.image.width)) / 100,
        //     height: image.image.height * (width * 100 / (image.image.width)) / 100,
        //     // counter: _counter++
        //   ));
        // }
      }));

  params["sendPort"].send("Hello from Isolate");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _message = "";
  late Isolate isolate;
  late ReceivePort receivePort;

  @override
  void initState() {

    // Map<String, int> params = {
    //   "finalNum": 1000,
    //   "test": 10
    // };

    // Map<String, String> image = {
    //   "url": "https://i.pinimg.com/originals/bf/82/f6/bf82f6956a32819af48c2572243e8286.jpg",
    // };

    // Isolate.spawn(isolateFunction, params);
    // Isolate.spawn(isolateImageMemory, image);
    super.initState();

    spawnNewIsolate();
  }

  void spawnNewIsolate() async {
    receivePort = ReceivePort();
    try {
      Map<String, dynamic> image = {
        "url": "https://i.pinimg.com/originals/bf/82/f6/bf82f6956a32819af48c2572243e8286.jpg",
        "sendPort": receivePort.sendPort
      };

      isolate = await Isolate.spawn(sayHello, receivePort.sendPort);
      print("Isolate: $isolate");
      receivePort.listen((dynamic message) {
        setState(() {
          _message = message;
        });
        print('New message from Isolate: $message');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  static void sayHello(SendPort sendPort) {

    var test = new NetworkImage("https://i.pinimg.com/originals/bf/82/f6/bf82f6956a32819af48c2572243e8286.jpg");
      // .addListener(new ImageStreamListener((ImageInfo image, bool _) {
      //   print("mantep image width: ${image.image.width} height ${image.image.height}");

      //   completer.complete(image.image);
      //   // if (state.type == ImageType.ImageUnload) {
      //   //   emit(ImageState(
      //   //     type: ImageType.ImageLoaded,
      //   //     url: url,
      //   //     imageBytes: Uint8List.fromList(response.data),
      //   //     width: image.image.width * (width * 100 / (image.image.width)) / 100,
      //   //     height: image.image.height * (width * 100 / (image.image.width)) / 100,
      //   //     // counter: _counter++
      //   //   ));
      //   // }
      // }));

    
    sendPort.send("New message from Isolate");
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    receivePort.close();
    isolate.kill();
    super.dispose();
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
              _message,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => ImageList()));
              }, 
              child: Text("Image List")
            ),
            Image.network(
              "https://i.pinimg.com/originals/bf/82/f6/bf82f6956a32819af48c2572243e8286.jpg"
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
