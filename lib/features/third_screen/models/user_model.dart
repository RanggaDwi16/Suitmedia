import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
    const factory UserModel({
        @JsonKey(name: "id")
        int? id,
        @JsonKey(name: "email")
        String? email,
        @JsonKey(name: "first_name")
        String? firstName,
        @JsonKey(name: "last_name")
        String? lastName,
        @JsonKey(name: "avatar")
        String? avatar,
    }) = _UserModel;
    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
