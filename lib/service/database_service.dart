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
  Future savingUserData(
    String name,
    String email,
    String gender,
    String mobileNumber,
  ) async {
    return await userCollection.doc(uid).set({
      "fullname": name,
      "email": email,
      "uid": uid,
      "gender": gender,
      "mobile_number": mobileNumber,
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
    String placeMap,
    double placeRating,
  ) async {
    return await destinationCollection.doc().set({
      "place_category": placeCategory,
      "place_state": placeState,
      "place_image": placeImage,
      "place_name": placeName,
      "place_description": placeDescription,
      "place_location": placeLocation,
      "place_map": placeMap,
      "place_rating": placeRating,
    });
  }

  // ===== Getting user data =====
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // ===== Getting admin data =====
  Future gettingAdminData(String email) async {
    QuerySnapshot snapshot = await adminCollection.where('admin_email').get();
    return snapshot;
  }

  Stream<DocumentSnapshot> getdestinationData(String placeId) {
    if (placeId.isNotEmpty) {
      return destinationCollection.doc(placeId).snapshots();
    } else {
      return const Stream.empty();
    }
  }

  Stream<DocumentSnapshot> getUserDetails(String uid) {
    if (uid.isNotEmpty) {
      return userCollection.doc(uid).snapshots();
    } else {
      return const Stream.empty();
    }
  }
}
