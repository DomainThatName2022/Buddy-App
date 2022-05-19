import 'package:flutter/cupertino.dart';

abstract class Pet {
  String? name;
  List? type;
  List? gender;
  List? breed;
  String? address;
  String? description;
  FileImage? images;

  //Constructor
  Pet(this.name, this.address, this.breed, this.description, this.gender,
      this.type, this.images);
}
