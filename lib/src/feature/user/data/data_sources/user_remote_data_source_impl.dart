import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trekgo_project/src/feature/user/data/data_sources/user_remote_data_source.dart';
import 'package:trekgo_project/src/feature/user/data/mappers/user_mapper.dart';
import 'package:trekgo_project/src/feature/user/data/models/user_model.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserRemoteDataSourceImpl({
    required this.fireStore,
    required this.auth,
  });

  FirebaseFirestore get instance => fireStore;

  @override
  Stream<UserEntity> getUserDetails() {
    final uid = auth.currentUser?.uid ?? '';
    log('Uid: $uid');
    return instance.collection('users').doc(uid).snapshots().map(
      (snapshot) {
        final userModel = UserModel.fromJson(snapshot.data());
        final userEntity = UserMapper.mapToEntity(userModel);
        return userEntity;
      },
    );
  }

  @override
  Future<void> updateUserDetails(UserEntity user) {
    throw UnimplementedError();
  }
}
