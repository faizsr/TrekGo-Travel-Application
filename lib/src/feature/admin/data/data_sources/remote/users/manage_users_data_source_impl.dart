import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/users/manage_users_data_source.dart';
import 'package:trekgo_project/src/feature/user/data/mappers/user_mapper.dart';
import 'package:trekgo_project/src/feature/user/data/models/user_model.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class ManageUsersDataSourceImpl implements ManageUsersDataSource {
  final FirebaseFirestore fireStore;

  ManageUsersDataSourceImpl({required this.fireStore});

  FirebaseFirestore get instance => fireStore;

  @override
  Stream<List<UserEntity>> fetchAllUsers() {
    try {
      final data = instance.collection('users').snapshots().map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              final data = doc.data();
              final userModel = UserModel.fromJson(data);
              return UserMapper.mapToEntity(userModel);
            },
          ).toList();
        },
      );
      return data;
    } catch (e) {
      log('On Error: $e');
      return const Stream.empty();
    }
  }

  @override
  Future<void> blockUser(String id) async {
    await instance.collection('users').doc(id).update({'block': true});
    log('Block done');
  }

  @override
  Future<void> unblockUser(String id) async {
    await instance.collection('users').doc(id).update({'block': false});
    log('Unblock done');
  }
}
