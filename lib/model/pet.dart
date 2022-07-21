import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetModel {
  String? name;
  String? petType;
  String? petGender;
  String? petBreed;
  String? yearOfBirth;
  String? address;
  String? description;
  List mediaUrlList;

  final CollectionReference petRef =
      FirebaseFirestore.instance.collection('userPets');

  User? user = FirebaseAuth.instance.currentUser;

  PetModel(
      {this.name,
      this.petType,
      this.petBreed,
      this.address,
      this.yearOfBirth,
      this.petGender,
      this.description,
      required this.mediaUrlList});

  factory PetModel.fromSnaphot(snapshot) {
    return PetModel(
      name: snapshot.data()['petname'],
      petType: snapshot.data()['pet-type'],
      petBreed: snapshot.data()['pet-breed'],
      petGender: snapshot.data()['pet-gender'],
      yearOfBirth: snapshot.data()['year-of-birth'],
      address: snapshot.data()['address'],
      description: snapshot.data()['description'],
      mediaUrlList: snapshot.data()['pet-images'],
    );
  }

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
      "pet-images": mediaUrlList,
      "createdOn": DateTime.now(),
    };
  }

  void addImages(image) {
    var imageList = mediaUrlList.add(File(image.path));
    return imageList;
  }
}
