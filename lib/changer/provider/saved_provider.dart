import 'package:flutter/material.dart';

class SavedProvider extends ChangeNotifier {
  List<String> _savedIds;

  SavedProvider({required List<String> savedIds}) : _savedIds = savedIds;
  List<String> get savedIds => _savedIds;

  void updateSavedIds(List<String> newSavedIds) {
    _savedIds = newSavedIds;
    notifyListeners();
  }

  bool isExist(String savedIds) {
    final isExist = _savedIds.contains(savedIds);
    return isExist;
  }

  void listenForChanges() {}
}
