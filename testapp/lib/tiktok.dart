import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class Tiktok extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Direct Caller',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: TiktokWidget(),
    );
  }

}

class TiktokWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TiktokState();
}

class _TiktokState extends State<TiktokWidget> {

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = <Color>[Colors.red, Colors.blue, Colors.green];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Caller"),
      ),
      body: TikTokStyleFullPageScroller(
        contentSize: colors.length,
        swipePositionThreshold: 0.2,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 2000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 300),
        // ^ how long the animation will take
        builder: (BuildContext context, int index) {
          return Container(
              color: colors[index],
              child: Text(
                '$index',
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            );
        },
      ),
    );
  }
}