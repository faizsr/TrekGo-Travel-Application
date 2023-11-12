import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({
    this.uid,
  });

  // ===== Reference for user collection =====
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // ===== Reference for admin collection =====
  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection("admin");

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
  ) async {
    return await destinationCollection.doc().set({
      "place_category": placeCategory,
      "place_state": placeState,
      "place_image": placeImage,
      "place_name": placeName,
      "place_description": placeDescription,
      "place_location": placeLocation,
      "place_rating": placeRating,
    });
  }

  // ===== Getting user data =====
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email").get();
    return snapshot;
  }

  // ===== Getting admin data =====
  Future gettingAdminData(String email) async {
    QuerySnapshot snapshot = await adminCollection.where('admin_email').get();
    return snapshot;
  }

  Stream<DocumentSnapshot> getdestinationData(String placeId) {
    return destinationCollection.doc(placeId).snapshots();
  }
}
