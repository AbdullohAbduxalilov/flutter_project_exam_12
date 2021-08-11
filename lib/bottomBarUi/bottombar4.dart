import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
bool toggled = true;
class BottomBar4 extends StatefulWidget {
  const BottomBar4({Key? key}) : super(key: key);

  @override
  _BottomBar4State createState() => _BottomBar4State();
}

class _BottomBar4State extends State<BottomBar4> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () => getImage(),
          child: _image == null
              ? Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.amber, width: 2.5),
                color: Colors.white),
            child: Icon(
              Icons.add_a_photo_outlined,
              size: 30.0,
              color: Colors.red,
            ),
          )
              : Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber, width: 2.5),
              color: Colors.white,
              image: DecorationImage(
                image: FileImage(_image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Lights'),
            value: toggled,
            onChanged: (bool value) {
              setState(() {
                toggled = value;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
    );
  }
}
