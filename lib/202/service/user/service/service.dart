import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_services/202/service/user/model_photos.dart';
import 'package:flutter_services/202/service/user/model_user.dart';

abstract class IUserService {
  Future<List<UserModel>?> fetchUsers();
  Future<List<PhotoModel>?> fetchRelatedPhotos(id);
}

class UserService implements IUserService {
  final Dio _networkManager;
  UserService()
      : _networkManager =
            Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  @override
  Future<List<UserModel>?> fetchUsers() async {
    try {
      final response = await _networkManager.get(_PostServicePaths.users.name);

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => UserModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      print(exception);
    }
    return null;
  }

  @override
  Future<List<PhotoModel>?> fetchRelatedPhotos(id) async {
    try {
      final response = await _networkManager.get(_PostServicePaths.photos.name,
          queryParameters: {_PostQueryPaths.id.name: id});

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => PhotoModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      print(exception);
    }
    return null;
  }
}

enum _PostServicePaths { users, photos }

enum _PostQueryPaths { id }
