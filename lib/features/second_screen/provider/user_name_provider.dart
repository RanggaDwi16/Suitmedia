import 'package:flutter/material.dart';

class UserNameProvider with ChangeNotifier {
  String _selectedUserName = '';

  String get selectedUserName => _selectedUserName;

  void setSelectedUserName(String selectedUserName) {
    _selectedUserName = selectedUserName;
    notifyListeners();
  }
}
