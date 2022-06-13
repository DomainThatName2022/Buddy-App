import 'dart:io';

class PetModel {
  String? name;
  String? petType;
  String? petGender;
  String? petBreed;
  String? yearOfBirth;
  String? address;
  String? description;
  List mediaUrlList;

  PetModel(
      {this.name,
      this.petType,
      this.petBreed,
      this.address,
      this.yearOfBirth,
      this.petGender,
      this.description,
      required this.mediaUrlList});

  // receiving data from server
  // factory Dog.fromMap(map) {
  //   return Dog(
  //     uid: map['uid'],
  //     email: map['email'],
  //     firstName: map['firstName'],
  //     secondName: map['secondName'],
  //     phoneNumber: map['phoneNumber'],
  //   );
  // }

  // sending data to our server
  Map<String, dynamic> toMap(String petId, String? uid) {
    return {
      "petId": petId,
      "ownerId": uid,
      "petname": name,
      "pet-type": petType,
      "pet-gender": petGender,
      "pet-breed": petBreed,
      "year-of-birth": yearOfBirth,
      "address": address,
      "description": description,
      "pet-images": mediaUrlList
    };
  }

  void addImages(image) {
    var imageList = mediaUrlList.add(File(image.path));
    return imageList;
  }
}
