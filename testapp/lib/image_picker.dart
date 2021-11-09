import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MyImagePicker extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Direct Caller',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: MyImagePickerWidget(),
    );
  }

}

class MyImagePickerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePickerWidget> {

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? _compressImage;

  @override
  void initState() {
    super.initState();
  }

  void _imagePicker() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    compressImage(image!.path);
    setState(() {
      _image = image;
    });
  }

  void compressImage(String path) async {
    print(path);
    Directory? dir = await getExternalStorageDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(
      path,
      dir!.absolute.path + Platform.pathSeparator + basename(path),
      quality: 50
    );

    print(result?.lengthSync());

    setState(() {
      _compressImage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ImagePicker"),
      ),
      body: Center(
        child: ListView(
          children: [
            _image != null ? Text("Original Image") : Container(),
            _image != null ? Text("Size: ${File(_image!.path).lengthSync()}") : Container(),
            _image != null ? Image.file(File(_image!.path)) : Container(),
            _compressImage != null ? Text("Compressed Image") : Container(),
            _compressImage != null ? Text("Size: ${_compressImage?.lengthSync()}") : Container(),
            _compressImage != null ? Image.file(_compressImage!) : Container(),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _imagePicker,
        tooltip: "Image Picker",
        child: Icon(Icons.image),
      ),
    );
  }
}