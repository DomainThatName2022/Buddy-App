import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Variables
    File? imageFile;
    return Container(
        child: imageFile == null
            ? Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.grey[350],
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: const Text("PICK FROM GALLERY"),
                      )
                    ]),
              )
            : Container(
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }
}
