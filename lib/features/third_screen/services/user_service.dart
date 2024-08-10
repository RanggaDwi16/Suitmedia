import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:suitmedia/features/third_screen/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:suitmedia/utils/errors/dio_error.dart';

class UserService {
  final Dio dio;

  UserService({required this.dio});

  Future<Either<String, List<UserModel>>> getData(int page, int perPage) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'] ?? '';
      final response = await dio.get('$baseUrl/users?page=$page&per_page=$perPage');
      if (response.statusCode == 200) {
        final List<dynamic> items = response.data['data'];
        final List<UserModel> users =
            items.map((item) => UserModel.fromJson(item)).toList();
        return Right(users);
      } else {
        return const Left('Failed to load data');
      }
    } on DioException catch (e) {
      final error =
          DioErrorHandler.handleError(e); // Assuming you have this method
      return Left(error.toString());
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
