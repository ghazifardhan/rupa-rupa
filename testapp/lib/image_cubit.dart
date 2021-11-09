import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ImageType {
  ImageUnload,
  ImageLoaded
}

class ImageState {

  final ImageType? type;
  final String? url;
  final double? width;
  final double? height;
  final int? counter;
  final Uint8List? imageBytes;

  ImageState({
    this.type,
    this.url,
    this.width,
    this.height,
    this.counter,
    this.imageBytes,
  });
}

class ImageCubit extends Cubit<ImageState> {
  
  ImageCubit() : super(ImageState(
    type: ImageType.ImageUnload,
    url: null,
    width: 0,
    height: 0,
    counter: 0,
    imageBytes: null
  ));

  void getImageData(String url) async {
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    var test = new MemoryImage(Uint8List.fromList(response.data))
      ..resolve(new ImageConfiguration())
      .addListener(new ImageStreamListener((ImageInfo image, bool _) {
        print("mantep image width: ${image.image.width} height ${image.image.height}");
        if (state.type == ImageType.ImageUnload) {
          emit(ImageState(
            type: ImageType.ImageLoaded,
            url: url,
            imageBytes: Uint8List.fromList(response.data),
            width: image.image.width.toDouble(),
            height: image.image.height.toDouble(),
            // counter: _counter++
          ));
        }
      }));

    test.evict();
  }

}