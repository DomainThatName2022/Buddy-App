import 'dart:io';
import 'dart:math';
import 'package:buddy_app/components/loading.dart';
import 'package:path/path.dart' as Path;
import 'package:buddy_app/components/custom_drop_down_menu.dart';
import 'package:buddy_app/model/pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../components/custom_bottom_navigation.dart';
import '../components/notification_icon.dart';
import '../model/user.dart';
import '../theme/color_palette.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';

class AddMyPets extends StatefulWidget {
  const AddMyPets({Key? key}) : super(key: key);

  @override
  _AddMyPetsState createState() => _AddMyPetsState();
}

class _AddMyPetsState extends State<AddMyPets> {
  //color Palette
  final colors = const ColorPalette();

  //form key
  final _formKey = GlobalKey<FormState>();

  //Firebase Instance
  final _auth = FirebaseAuth.instance;

  //PetModel
  PetModel petModel = PetModel(mediaUrlList: []);

  //Firestore References
  final userRef = FirebaseFirestore.instance.collection('users');
  final petRef = FirebaseFirestore.instance.collection('pets');
  //controllers
  final petNameEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final descEditingController = TextEditingController();

  //Date
  DateTime selectedDate = DateTime.now();
  final List _imageList = [];
  List imageList = [];

  String errorMessage = "";

  // ignore: prefer_typing_uninitialized_variables
  var selectedPetType;
  // ignore: prefer_typing_uninitialized_variables
  var selectedPetBreed;
  // ignore: prefer_typing_uninitialized_variables
  var selectedPetGender;

  // static Data for testing
  final List<String> _petType = <String>["Dog", "Cat"];
  final List<String> _petBreed = <String>[
    'Poodle',
    'Golden Retriever',
    'Bulldog',
    'Labrador'
  ];
  final List<String> _petGender = <String>['Male', 'Female'];

  double val = 0;
  late CollectionReference imgRef;

  //Storage reference
  final Reference storageRef = FirebaseStorage.instance.ref();

  bool isUploading = false;
  bool limitReached = false;
  String petId = const Uuid().v4();
  int counter = 0;
  var random = Random();

  @override
  Widget build(BuildContext context) {
    //pet name field
    final petNameField = TextFormField(
      autofocus: false,
      controller: petNameEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter Pet Name");
        }

        return null;
      },
      onSaved: (value) {
        petNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: const Text(
          'Enter Pet Name',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colors.scallopSeashell, width: 2),
        ),
      ),
      cursorColor: colors.scallopSeashell,
    );

    //pet type field
    final petTypeField = CustomDropDownMenu(
        _petType,
        'Select Pet Type',
        selectedPetType,
        ((value) => {
              setState(() => {selectedPetType = value})
            }));
    //pet gender field
    final petGenderField = CustomDropDownMenu(
        _petGender,
        'Select Pet Gender',
        selectedPetGender,
        ((value) => {
              setState(() => {selectedPetGender = value})
            }));

    //pet breed field
    final petBreedField = CustomDropDownMenu(
        _petBreed,
        'Select Pet Breed',
        selectedPetBreed,
        ((value) => {
              setState(() => {selectedPetBreed = value})
            }));

    //year of birth
    final yearOfBirthField = GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
            child: TextFormField(
          autofocus: false,
          controller: dateEditingController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please enter Pet Year Of Birth");
            }

            return null;
          },
          onSaved: (value) {
            dateEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            label: const Text(
              'Select Year of Birth',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            suffixIcon: const Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: colors.scallopSeashell, width: 2),
            ),
          ),
          cursorColor: colors.scallopSeashell,
        )));

    //Address
    final addressField = TextFormField(
      autofocus: false,
      controller: addressEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter Pet Name");
        }

        return null;
      },
      onSaved: (value) {
        addressEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: const Text(
          'Address',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        suffixIcon: Icon(
          Icons.location_pin,
          color: Colors.red[200],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colors.scallopSeashell, width: 2),
        ),
      ),
      cursorColor: colors.scallopSeashell,
    );

    //pet description field
    final descField = TextFormField(
      minLines: 4,
      autofocus: false,
      controller: descEditingController,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) {
        descEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: const Text(
          'Description (Optional)',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colors.scallopSeashell, width: 2),
        ),
      ),
      cursorColor: colors.scallopSeashell,
    );

    //Submit Button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: colors.scallopSeashell,
      child: MaterialButton(
        onPressed: isUploading
            ? null
            : () {
                handleSubmit();
              },
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Submit',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Add Pets',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: colors.scallopSeashell,
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 20),
              child: NotificationIcon(),
            ),
          ]),
      body: isUploading
          ? const Loading()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 210,
                          width: 315,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child:
                                  // CustomImagePicker()
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: colors.scallopSeashell,
                                ),
                                child: Stack(children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GridView.builder(
                                        itemCount: _imageList.length + 1,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3),
                                        itemBuilder: (context, index) {
                                          return index == 0
                                              ? Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color: Colors.white),
                                                    child: IconButton(
                                                        icon: const Icon(
                                                            Icons.add),
                                                        onPressed: limitReached
                                                            ? null
                                                            : () =>
                                                                chooseImage()),
                                                  ),
                                                )
                                              : Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              _imageList[
                                                                  index - 1]),
                                                          fit: BoxFit.cover)),
                                                );
                                        }),
                                  )
                                ]),
                              ),
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(right: 30, left: 30, top: 5),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 40,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, top: 5),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Pet Information',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: petNameField,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                  color: colors.gray,
                                  width: 1,
                                )),
                                borderRadius: BorderRadius.circular(15)),
                            child: petTypeField),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                  color: colors.gray,
                                  width: 1,
                                )),
                                borderRadius: BorderRadius.circular(15)),
                            child: petGenderField),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                  color: colors.gray,
                                  width: 1,
                                )),
                                borderRadius: BorderRadius.circular(15)),
                            child: petBreedField),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: yearOfBirthField,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: addressField,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: descField,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 40, bottom: 50),
                        child: saveButton,
                      )
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colors.scallopSeashell,
                onPrimary: Colors.black,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        dateEditingController.text = date;
      });
    }
  }

  //Choose image from gallery and save to a list
  chooseImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        PetModel(mediaUrlList: _imageList).addImages(pickedFile);
        counter++;
        setState(() {
          imageList = _imageList;
        });
      }
    });
    if (counter == 3) {
      setState(() {
        limitReached = true;
      });
    }
    // Fluttertoast.showToast(
    //     msg: "Image limit reached", backgroundColor: colors.scallopSeashell);
    if (pickedFile?.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageList.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  //Compress images and put in a list
  compressImages(imageList) async {
    List<File> compressedImgList = [];
    for (var file in imageList) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      Im.Image? imageFile = Im.decodeImage(file.readAsBytesSync());
      final compressedImgFile = File('$path/img_$petId.jpg')
        ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
      compressedImgList.add(compressedImgFile);
    }

    setState(() {
      imageList = compressedImgList;
    });
  }

  //Upload Image Files to Firebase
  Future<List> uploadImageFiles(imagelist) async {
    int cntr = 0;
    List downloadUrlsList = [];
    String downloadUrl;
    for (var file in imagelist) {
      int randomNumber = random.nextInt(100);
      UploadTask uploadTask =
          storageRef.child("Pets/pets_$petId$randomNumber.jpg").putFile(file);
      TaskSnapshot storageSnap = await uploadTask;
      downloadUrl = await storageSnap.ref.getDownloadURL();
      cntr++;
      print('Upload $cntr successful');
      downloadUrlsList.add(downloadUrl);
    }

    return downloadUrlsList;
  }

  createPetInFireStore(List mediaUrls) {
    User? user = _auth.currentUser;

    // writing all the values
    petModel.name = petNameEditingController.text;
    petModel.petType = selectedPetType;
    petModel.petGender = selectedPetGender;
    petModel.petBreed = selectedPetBreed;
    petModel.yearOfBirth = dateEditingController.text;
    petModel.address = addressEditingController.text;
    petModel.description = descEditingController.text;
    petModel.mediaUrlList = mediaUrls;

    //Post data to Firebase
    petRef
        .doc(user?.uid)
        .collection("userPets")
        .doc(petId)
        .set(petModel.toMap(petId, user?.uid));
  }

  handleSubmit() async {
    //set uploading to true
    setState(() {
      isUploading = true;
    });

    //Await compressed images
    await compressImages(imageList);

    //Receive the media Urls
    List mediaUrls = await uploadImageFiles(imageList);

    //Create Pet entry in Firestore
    createPetInFireStore(mediaUrls);

    await createPetInFireStore(mediaUrls);

    //When Successful
    Fluttertoast.showToast(
        msg: "Pet added Successfully", backgroundColor: colors.scallopSeashell);

    //clear fields
    petNameEditingController.clear();
    dateEditingController.clear();
    descEditingController.clear();
    addressEditingController.clear();
    setState(() {
      selectedPetType = null;
      selectedPetBreed = null;
      selectedPetGender = null;
      imageList.clear();
      isUploading = false;
    });
  }
}
