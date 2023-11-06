import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  final String? placeid;
  DatabaseService({
    this.uid,
    this.placeid,
  });

  // ===== Reference for user collection =====
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // ===== Reference for destination collection =====
  final CollectionReference destinationCollection =
      FirebaseFirestore.instance.collection('destination');

  // ===== Saving the user data =====
  Future savingUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": name,
      "email": email,
      "profilePic": "",
      "uid": uid,
    });
  }

  // ===== Saving the destination data =====
  Future savingDestination(
    String placeCategory,
    String placeState,
    String placeImage,
    String placeName,
    String placeDescription,
    String placeLocation,
    double placeRating, 
    String? placeId, 
  ) async {
    return await destinationCollection.doc(placeid).set({
      "place_category": placeCategory,
      "place_state": placeState,
      "place_image": placeImage,
      "place_name": placeName,
      "place_description": placeDescription,
      "place_locaton": placeLocation,
      "place_rating": placeRating,
      'place_id': placeid,
    });
  }

  // ===== Getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email").get();
    return snapshot;
  }
}
