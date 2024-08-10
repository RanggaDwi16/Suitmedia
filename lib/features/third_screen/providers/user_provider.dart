import 'package:flutter/widgets.dart';
import 'package:suitmedia/features/third_screen/models/user_model.dart';
import 'package:suitmedia/features/third_screen/services/user_service.dart';
import 'package:dartz/dartz.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> users = [];
  bool loading = false;
  int currentPage = 1;
  bool hasMore = true;
  final int perPage = 10;
  final UserService _userService;

  UserProvider(this._userService);

  Future<void> getUserData({bool loadMore = false}) async {
    if (loading || !hasMore) return;

    loading = true;
    notifyListeners();

    if (!loadMore) {
      currentPage = 1;
      users.clear();
      hasMore = true;
    }

    final Either<String, List<UserModel>> result =
        await _userService.getData(currentPage, perPage);

    result.fold(
      (error) {
        // Handle the error appropriately here
        print(error);
      },
      (userList) {
        if (userList.isEmpty) {
          hasMore = false;
        } else {
          if (userList.length < perPage) {
            hasMore = false;
          } else {
            currentPage++;
          }
          users.addAll(userList);
        }
      },
    );

    loading = false;
    notifyListeners();
  }
}
