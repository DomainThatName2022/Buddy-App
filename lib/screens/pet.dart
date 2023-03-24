// import 'dart:html';

import 'package:buddy_app/model/pet.dart';
import 'package:buddy_app/theme/color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../components/custom_bottom_navigation.dart';
import '../components/notification_icon.dart';

class Pet extends StatefulWidget {
  // const Pet({Key? key}) : super(key: key);
  final PetModel _pet;

  Pet(this._pet);

  @override
  _PetState createState() => _PetState();
}

enum Decisions { Yes, No }

class _PetState extends State<Pet> {
  final colors = const ColorPalette();
  DateTime selectedDate = DateTime.now();

  //editing controller
  final TextEditingController coParentingController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //Co-Parenting Form Key
  final _coParentingFormKey = GlobalKey<FormState>();
  final _details = GlobalKey<FormState>();

  Decisions? _flag = Decisions.Yes;

  @override
  Widget build(BuildContext context) {
    //Co-Parenting Field
    final coParentField = TextFormField(
      autofocus: false,
      controller: coParentingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter username to invite for co-parenting");
        }

        return null;
      },
      onSaved: (value) {
        coParentingController.text = value!;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Username',
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cursorColor: colors.dominant,
    );

    //Submit Button
    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: colors.dominant,
      child: MaterialButton(
        onPressed: () {},
        minWidth: MediaQuery.of(context).size.width,
        height: 10,
        child: const Text(
          'Send Invite',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //Report Button
    final reportButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: colors.dominant,
      child: MaterialButton(
        onPressed: () {},
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Report missing pet',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //Delete Button
    final deleteButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.red[400],
      child: MaterialButton(
        onPressed: () {},
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Delete Pet',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //Address
    final addressField = TextFormField(
      autofocus: false,
      controller: addressController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter address pet was last seen");
        }

        return null;
      },
      onSaved: (value) {
        addressController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: const Text(
          'Address pet was last seen',
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
          borderSide: BorderSide(color: colors.dominant, width: 2),
        ),
      ),
      cursorColor: colors.dominant,
    );

    //date pet was last seen
    final dateField = GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          autofocus: false,
          controller: dateController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please enter pet year of birth");
            }

            return null;
          },
          onSaved: (value) {
            dateController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            label: const Text(
              'Date pet was last seen',
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
              borderSide: BorderSide(color: colors.dominant, width: 2),
            ),
          ),
          cursorColor: colors.dominant,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "${widget._pet.name}",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: colors.dominant,
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 20),
              child: NotificationIcon(),
            ),
          ]),
      body: Container(
        color: colors.accentTweaked,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    width: 305,
                    height: 260,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: "${widget._pet.mediaUrlList[0]}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Pet Details',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red[400]),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.accentTweaked),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pet Type: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "${widget._pet.petType}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.accentTweaked),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pet Breed: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "${widget._pet.petBreed}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.accentTweaked),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Year of Birth: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "${widget._pet.yearOfBirth}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.accentTweaked),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender: ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "${widget._pet.petGender}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Invite for Co-parenting?',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red[400]),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Form(
                      key: _coParentingFormKey,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors.accentTweaked),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: coParentField,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: submitButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Flag this pet as missing?',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red[400]),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.accentTweaked),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: const Text('Yes'),
                              leading: Radio<Decisions>(
                                value: Decisions.Yes,
                                groupValue: _flag,
                                onChanged: (Decisions? value) {
                                  setState(() {
                                    _flag = value;
                                  });
                                },
                                activeColor: colors.dominant,
                              ),
                            ),
                          )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('No'),
                                leading: Radio<Decisions>(
                                  value: Decisions.No,
                                  groupValue: _flag,
                                  onChanged: (Decisions? value) {
                                    setState(() {
                                      _flag = value;
                                    });
                                  },
                                  activeColor: colors.dominant,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _flag == Decisions.Yes
                      ? Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 40, right: 40),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Please fill in below*',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red[400]),
                                  ),
                                ),
                              ),
                              Form(
                                key: _details,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, right: 40, left: 40),
                                      child: addressField,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, right: 40, left: 40),
                                      child: dateField,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40,
                                          right: 40,
                                          left: 40,
                                          bottom: 50),
                                      child: reportButton,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 40, right: 40, bottom: 50),
                            child: deleteButton,
                          ),
                        )
                ],
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
                primary: colors.dominant,
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
        dateController.text = date;
      });
    }

    // _deletePet(index) async {
    //   await FirebaseFirestore.instance
    //       .runTransaction((Transaction myTransaction) async {
    //     await myTransaction.delete(snapshot.data.documents[index].reference);
    //   });
    // }
  }
}
