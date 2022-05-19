import 'package:buddy_app/components/custom_image_picker.dart';
import 'package:buddy_app/model/pet.dart';
import 'package:flutter/material.dart';

import '../components/custom_bottom_navigation.dart';
import '../components/notification_icon.dart';
import '../theme/color_palette.dart';

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

  //controllers
  final petNameEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final descEditingController = TextEditingController();

  //Date
  DateTime selectedDate = DateTime.now();

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
    final petTypeField = DropdownButtonHideUnderline(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton<String>(
        hint: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Select Pet Type',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        isExpanded: true,
        iconSize: 40,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        items: <String>['Dog', 'Cat'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    ));

    //pet gender field
    final petGenderField = DropdownButtonHideUnderline(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton<String>(
        hint: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Select Pet Gender',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        isExpanded: true,
        iconSize: 40,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        items: <String>['Male', 'Female'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    ));

    //pet breed field
    final petBreedField = DropdownButtonHideUnderline(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton<String>(
        hint: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Select Pet Breed',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        isExpanded: true,
        iconSize: 40,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        items: <String>['Poodle', 'Golden Retriever', 'Bulldog', 'Labrador']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    ));

    //year of birth
    final yearOfBirthField = GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
            child: TextFormField(
          autofocus: false,
          controller: dateEditingController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.sentences,
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
      controller: petNameEditingController,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) {
        petNameEditingController.text = value!;
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
        onPressed: () {},
        minWidth: MediaQuery.of(context).size.width,
        height: 58,
        child: const Text(
          'Save',
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 315,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: colors.scallopSeashell,
                  ),
                  child: Form(
                    key: _formKey,
                    child: const Center(child: CustomImagePicker()
                        // Text(
                        //   'IMAGES',
                        //   style: TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.bold),
                        // ),
                        ),
                  ),
                ),
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
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
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
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
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
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
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
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: yearOfBirthField,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: addressField,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: descField,
                ),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 40, bottom: 50),
                  child: saveButton,
                ))
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
                primary: colors.scallopSeashell, // <-- SEE HERE
                onPrimary: Colors.black, // <-- SEE HERE
                onSurface: Colors.black, // <-- SEE HERE
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
}
