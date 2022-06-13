// import 'dart:io';
// // import 'package:buddy_app/model/dog.dart';
// import 'package:buddy_app/model/dog.dart';
// import 'package:buddy_app/theme/color_palette.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:fluttertoast/fluttertoast.dart';

// class CustomImagePicker extends StatefulWidget {
//   const CustomImagePicker({Key? key}) : super(key: key);

//   @override
//   State<CustomImagePicker> createState() => _CustomImagePickerState();
// }

// class _CustomImagePickerState extends State<CustomImagePicker> {
//   List<File> imageList = [];
//   final colors = const ColorPalette();
//   File? pickedFile;

//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: colors.scallopSeashell,
//       ),
//       child: Stack(children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           child: GridView.builder(
//               itemCount: imageList.length + 1,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3),
//               itemBuilder: (context, index) {
//                 return index == 0
//                     ? Center(
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               color: Colors.white),
//                           child: IconButton(
//                               icon: const Icon(Icons.add),
//                               onPressed: () => chooseImage()),
//                         ),
//                       )
//                     : Container(
//                         margin: const EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: FileImage(imageList[index - 1]),
//                                 fit: BoxFit.cover)),
//                       );
//               }),
//         )
//       ]),
//     );
//   }

//   chooseImage() async {
//     final XFile? pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         DogModel(images: imageList).addImages(pickedFile);
//       }
//     });
//     if (pickedFile?.path == null) retrieveLostData();
//   }

//   Future<void> retrieveLostData() async {
//     final LostData response = await ImagePicker().getLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       setState(() {
//         imageList.add(File(response.file!.path));
//       });
//     } else {
//       print(response.file);
//     }
//   }
// }
