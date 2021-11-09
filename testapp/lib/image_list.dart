import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/image_cubit.dart';

class ImageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageListState();

}

class _ImageListState extends State<ImageList> {

  List<String> images = [
    "https://i.pinimg.com/originals/bf/82/f6/bf82f6956a32819af48c2572243e8286.jpg",
    "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/2559941/pexels-photo-2559941.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image List"),
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          // return Image.network(images[index]);

          return BlocProvider<ImageCubit>(
            create: (context) => ImageCubit()..getImageData(images[index]),
            child: BlocConsumer<ImageCubit, ImageState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.type == ImageType.ImageLoaded) {
                  return Image.memory(
                    state.imageBytes!,
                  );
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }
}