import 'dart:io';
import 'dart:math';
import 'package:buddy_app/components/animated_check.dart';
import 'package:buddy_app/components/loading.dart';
import 'package:buddy_app/screens/my_pets.dart';
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
  final List<File> _imageList = [];
  List<File> imageList = [];

  String errorMessage = "";

  // ignore: prefer_typing_uninitialized_variables
  var selectedPetType;
  // ignore: prefer_typing_uninitialized_variables
  var selectedPetBreed;
  // ignore: prefer_typing_uninitialized_variables
  var selectedPetGender;

  // static Data for testing
  final List<String> _petType = <String>["Dog", "Cat"];
  final List<String> _dogBreed = <String>[
    'Poodle',
    'Golden Retriever',
    'Bulldog',
    'Labrador'
  ];
  final List<String> _catBreed = <String>[
    'American Bobtail',
    'Abyssinian',
    'British Shorthair',
    'Calico'
  ];
  final List<String> _petGender = <String>['Male', 'Female'];

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
          return ("Please enter pet name");
        }

        return null;
      },
      onSaved: (value) {
        petNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: Text(
          'Enter Pet Name',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // filled: true,
        // fillColor: colors.textfieldaccent,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.textfieldaccent, width: 2)),
        errorStyle: TextStyle(color: colors.dominant),
      ),
      cursorColor: colors.dominant,
    );

    //pet type field
    final petTypeField = CustomDropDownMenu(
        _petType,
        'Select Pet Type',
        selectedPetType,
        ((value) => {
              setState(() => {selectedPetType = value})
            }),
        ((value) => value == null ? 'Please select pet type' : null));
    //pet gender field
    final petGenderField = CustomDropDownMenu(
        _petGender,
        'Select Pet Gender',
        selectedPetGender,
        ((value) => {
              setState(() => {selectedPetGender = value})
            }),
        ((value) => value == null ? 'Please select pet gender' : null));

    //pet breed field
    final petBreedField = CustomDropDownMenu(
        selectedPetType == "Cat" ? _catBreed : _dogBreed,
        'Select Pet Breed',
        selectedPetBreed,
        ((value) => {
              setState(() => {selectedPetBreed = value})
            }),
        ((value) => value == null ? 'Please select pet breed' : null));

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
              return ("Please enter pet year of birth");
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
            suffixIcon: Icon(
              Icons.calendar_today,
              color: colors.dominantTweaked,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: colors.textfieldaccent, width: 2)),
          ),
          cursorColor: colors.dominant,
        )));

    //Address
    final addressField = TextFormField(
      autofocus: false,
      controller: addressEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter pet address");
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
          color: colors.dominantTweaked,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.textfieldaccent, width: 2)),
      ),
      cursorColor: colors.dominant,
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
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.dominantTweaked, width: 2),
        ),
      ),
      cursorColor: colors.dominant,
    );

    //Submit Button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: colors.accent,
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
          title: Text(
            'Add Pets',
            style: TextStyle(color: colors.accent, fontWeight: FontWeight.w800),
          ),
          iconTheme: IconThemeData(color: colors.accent),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 20),
              child: NotificationIcon(),
            ),
          ]),
      body: isUploading
          ? Loading('Adding Pet Entry...')
          : Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 210,
                              width: 315,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    // color: colors.accentTweaked,
                                  ),
                                  child: Stack(children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      child: SizedBox(
                                        height: 200,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _imageList.length + 1,
                                            itemBuilder: (context, index) {
                                              return index == 0
                                                  ? Container(
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: colors
                                                            .textfieldaccent,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                color: colors
                                                                    .dominantTweaked),
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed:
                                                                  limitReached
                                                                      ? null
                                                                      : () =>
                                                                          chooseImage(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: 200,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image(
                                                            image: FileImage(
                                                              _imageList[
                                                                  index - 1],
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            }),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Pet Information',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: colors.accent,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: petNameField,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.fromBorderSide(BorderSide(
                                        color: colors.gray,
                                        width: 1,
                                      )),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: petTypeField),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.fromBorderSide(BorderSide(
                                        color: colors.gray,
                                        width: 1,
                                      )),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: petGenderField),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.fromBorderSide(BorderSide(
                                        color: colors.gray,
                                        width: 1,
                                      )),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: petBreedField),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: yearOfBirthField,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: addressField,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: descField,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 40, bottom: 50),
                              child: saveButton,
                            )
                          ],
                        ),
                      ),
                    ),
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
                primary: colors.dominantTweaked,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
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

  //Remove image
  removeImage(index) async {
    setState(() {
      _imageList.removeAt(index - 1);
      --counter;
      limitReached = false;
    });
  }

  //Choose image from gallery and save to a list
  chooseImage() async {
    final XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      if (pickedFile != null) {
        PetModel(mediaUrlList: _imageList).addImages(pickedFile);

        setState(() {
          imageList = _imageList;
          counter++;
        });
      }
    });
    if (counter == 3) {
      setState(() {
        limitReached = true;
      });
    }

    if (pickedFile?.path == null) {
      retrieveLostData();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker().retrieveLostData();
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
  Future<List<File>> compressImages(List<File> imageList) async {
    List<Future<File>> compressedImgFutures = [];
    for (var file in imageList) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      compressedImgFutures.add(compressImage(file, path));
    }

    List<File> compressedImgList = await Future.wait(compressedImgFutures);

    return compressedImgList;
  }

  Future<File> compressImage(File file, String path) async {
    Im.Image? imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImgFile = File('$path/img_$petId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 70));

    return compressedImgFile;
  }

  //Upload Image Files to Firebase
  Future<List<String>> uploadImageFiles(
      String selectedPetType, List<File> imagelist) async {
    List<UploadTask> uploadTasks = [];
    List<String> downloadUrlsList = [];
    String uploadPath = selectedPetType == 'Dog' ? "Dog" : "Cat";

    for (var file in imagelist) {
      int randomNumber = random.nextInt(100);
      UploadTask uploadTask = storageRef
          .child("$uploadPath/pets_$petId$randomNumber.jpg")
          .putFile(file);
      uploadTasks.add(uploadTask);
    }

    List<TaskSnapshot> taskSnapshots = await Future.wait(uploadTasks);

    for (TaskSnapshot storageSnap in taskSnapshots) {
      String downloadUrl = await storageSnap.ref.getDownloadURL();
      downloadUrlsList.add(downloadUrl);
    }

    return downloadUrlsList;
  }

  createPetInFireStore(List mediaUrls) async {
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

    // Create a WriteBatch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Add write operations to the batch
    DocumentReference userPetDocRef =
        petRef.doc(user?.uid).collection("userPets").doc(petId);
    batch.set(userPetDocRef, petModel.toMap(petId, user?.uid));

    // Commit the batch
    await batch.commit().then((value) {
      //When Successful navigate to animated check
      Navigator.of(context)
          .pushReplacement(
              MaterialPageRoute(builder: ((context) => const AnimatedCheck())))
          .then((value) => Fluttertoast.showToast(
              msg: "Pet added Successfully", backgroundColor: colors.accent));
    }).catchError((error) {
      // Handle any errors that occur during the commit
      print("Error committing batch: $error");
      Fluttertoast.showToast(
          msg: "Error adding pet", backgroundColor: colors.accent);
    });
  }

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      //set uploading to true
      setState(() {
        isUploading = true;
      });
      try {
        //Await compressed images
        await compressImages(imageList);

        //Receive the media Urls
        List mediaUrls = await uploadImageFiles(selectedPetType, imageList);

        //Create Pet entry in Firestore

        await createPetInFireStore(mediaUrls);
      } on FirebaseAuthException catch (error) {
        //loading
        setState(() {
          isUploading = false;
        });

        errorMessage = 'Something went wrong';

        Fluttertoast.showToast(
            msg: errorMessage, backgroundColor: colors.accent);
        debugPrint(error.code);
      }
    }
  }
}
