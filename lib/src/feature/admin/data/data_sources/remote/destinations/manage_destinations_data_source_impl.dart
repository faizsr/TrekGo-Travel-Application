import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/destinations/manage_destinations_data_source.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class ManageDestinationsDataSourceImpl implements ManageDestinationsDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseStorage fireStorage;

  ManageDestinationsDataSourceImpl({
    required this.fireStore,
    required this.fireStorage,
  });

  FirebaseFirestore get storeInstance => fireStore;
  FirebaseStorage get storageInstance => fireStorage;

  @override
  void addNewDestination(DestinationEntity destination) async {
    log('Adding New Destination');
    String imageUrl = '';

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference refDirImages = storageInstance.ref().child('images');
    Reference refImageToUpload = refDirImages.child(uniqueFileName);

    try {
      await refImageToUpload.putFile(File(destination.image));
      imageUrl = await refImageToUpload.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    }

    DocumentReference docRef = storeInstance.collection('destination').doc();
    log('Document Id When Saving: ${docRef.id}');

    await docRef.set({
      "id": docRef.id,
      "category": destination.category,
      "state": destination.state,
      "image": imageUrl,
      "name": destination.name,
      "description": destination.description,
      "location": destination.location,
      "map": destination.mapUrl,
      "rating": destination.rating,
    });
  }

  @override
  void updateDestination(DestinationEntity destination, XFile? newImage) async {
    log('Editing Old Destination ID: ${destination.id}');
    String imageUrl = destination.image;
    String imageName = getFileNameFromUrl(imageUrl);
    if (newImage != null) {
      // ======= Deleting Old Image From Firebase Storage =======
      await storageInstance.ref().child('/images/$imageName').delete();

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference refDirImages = storageInstance.ref().child('images');
      Reference refImageToUpload = refDirImages.child(uniqueFileName);

      try {
        await refImageToUpload.putFile(File(newImage.path));
        imageUrl = await refImageToUpload.getDownloadURL();
      } catch (e) {
        debugPrint(e.toString());
      }

      log('New Image Added: $imageUrl');
    } else {
      log('here: ${destination.image}');
      log('Old Image Deleted');
    }

    await storeInstance.collection('destination').doc(destination.id).update({
      "category": destination.category,
      "state": destination.state,
      "image": imageUrl,
      "name": destination.name,
      "description": destination.description,
      "location": destination.location,
      "map": destination.mapUrl,
      "rating": destination.rating,
    });
  }

  @override
  void deleteDestination(String id) async {
    await storeInstance.collection('destination').doc(id).delete();
    log('Destination deleted');
  }

  String getFileNameFromUrl(String url) {
    var storageReference = storageInstance.refFromURL(url);
    String imgName = storageReference.name;
    log('Image name: $imgName');
    return imgName;
  }
}
