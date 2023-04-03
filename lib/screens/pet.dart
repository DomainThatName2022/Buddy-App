// import 'dart:html';
import 'package:buddy_app/model/pet.dart';
import 'package:buddy_app/theme/color_palette.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController descEditingController = TextEditingController();

  //Co-Parenting Form Key
  final _coParentingFormKey = GlobalKey<FormState>();
  final _details = GlobalKey<FormState>();

  Decisions? _flag = Decisions.No;

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
        fillColor: colors.textfieldaccent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.textfieldaccent, width: 3.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cursorColor: colors.dominant,
    );

    //Submit Button
    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: colors.dominantTweaked,
      child: MaterialButton(
        onPressed: () {},
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Invite',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //Report Button
    final reportButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      color: colors.dominantTweaked,
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
    final deleteButton = OutlinedButton(
        child: Text(
          'Delete Pet',
          style: TextStyle(
              color: colors.dominantTweaked,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        // clipBehavior: Clip.antiAlias,
        style: OutlinedButton.styleFrom(
            foregroundColor: colors.dominantTweaked,
            side: BorderSide(
              color: colors.dominantTweaked,
              width: 2,
            )),
        onPressed: () => {});

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
          color: colors.dominantTweaked,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colors.textfieldaccent,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.dominant, width: 2),
        ),
      ),
      cursorColor: colors.dominantTweaked,
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
            suffixIcon: Icon(
              Icons.calendar_today,
              color: colors.dominantTweaked,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.textfieldaccent,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.textfieldaccent, width: 2),
            ),
          ),
          cursorColor: colors.dominantTweaked,
        ),
      ),
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
          borderSide: BorderSide(
            color: colors.textfieldaccent,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.dominantTweaked, width: 2),
        ),
      ),
      cursorColor: colors.dominantTweaked,
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "${widget._pet.name}",
            style: TextStyle(color: colors.accent, fontWeight: FontWeight.w800),
          ),
          iconTheme: IconThemeData(color: colors.dominantTweaked),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 12, right: 20),
              child: NotificationIcon(),
            ),
          ]),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    width: 340,
                    height: 270,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
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
                    padding: const EdgeInsets.only(top: 20, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget._pet.name}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.accent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget._pet.petBreed}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: colors.lightgrey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Icon(
                                    widget._pet.petGender == "Male"
                                        ? Icons.male
                                        : Icons.female,
                                    color: widget._pet.petGender == "Male"
                                        ? colors.male
                                        : colors.female,
                                  ),
                                ),
                                Text(
                                  '${widget._pet.petGender}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Icon(
                                    Icons.timelapse_outlined,
                                    color: colors.dominantTweaked,
                                  ),
                                ),
                                Text(
                                  '${widget._pet.yearOfBirth}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Icon(
                                    Icons.pets,
                                    color: colors.accent,
                                  ),
                                ),
                                Text(
                                  '${widget._pet.petType}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                    child: Container(
                      height: 100,
                      width: 340,
                      // color: Colors.amber[50],
                      child: Text(
                        "${widget._pet.description}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  //Co-parenting Section
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Co-Parenting',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.accent),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Form(
                        key: _coParentingFormKey,
                        child: Column(
                          children: [
                            coParentField,
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: submitButton,
                            )
                          ],
                        )),
                  ),
                  //Report pet as missing Section
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Report pet as missing',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.accent),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colors.textfieldaccent),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                activeColor: colors.dominantTweaked,
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
                                  activeColor: colors.dominantTweaked,
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
                                padding:
                                    const EdgeInsets.only(top: 40, left: 40),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Please fill in below',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: colors.accent),
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
                                          top: 30, right: 40, left: 40),
                                      child: descField,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40,
                                          right: 40,
                                          left: 40,
                                          bottom: 50),
                                      child: Container(
                                          width: 400, child: reportButton),
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
                            child: Container(
                                width: 400.0,
                                height: 56.0,
                                child: deleteButton),
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
                primary: colors.dominantTweaked,
                onPrimary: Colors.black,
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
        dateController.text = date;
      });
    }
  }
}
