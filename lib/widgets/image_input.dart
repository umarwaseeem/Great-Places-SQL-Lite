// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import "dart:io";

import 'package:image_picker/image_picker.dart';

import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(width: 2, color: Colors.black),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(_storedImage!, fit: BoxFit.fill)
              : const Text("No Image Taken", textAlign: TextAlign.center),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            color: Colors.lightBlueAccent,
            icon: const Icon(Icons.camera),
            label: const Text("Take a picture"),
            textColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              _takePicture();
            },
          ),
        )
      ],
    );
  }
}
