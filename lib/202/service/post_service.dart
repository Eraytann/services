import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_services/202/service/comment_model.dart';

import 'post_model.dart';

//Son Adım
//abstract class oluşturarak sadece işlemlere erişebilmek
abstract class IPostService {
  Future<bool> addItemToService(PostModel postModel);
  Future<bool> putItemToService(PostModel postModel, int id);
  Future<bool> deleteItemFromService(int id);
  Future<List<PostModel>?> fetchPostItemsAdvanced();
  Future<List<CommentModel>?> fetchRelatedCommentWithPostId(postId);
}

class PostService implements IPostService {
  final Dio _dio;
  PostService()
      : _dio =
            Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

//bool türünde bir değer döndüğü için
  @override
  Future<bool> addItemToService(PostModel postModel) async {
    try {
      final response =
          await _dio.post(_PostServicePaths.posts.name, data: postModel);

      return response.statusCode == HttpStatus.created;

      //Dio exception ile hata türü yakalama
    } on DioException catch (exception) {
      _ShowDebug().showDioError(exception, this);
    }
    return false;
  }

  @override
  Future<List<PostModel>?> fetchPostItemsAdvanced() async {
    //try catch ile hata yakalama
    try {
      final response = await _dio.get(_PostServicePaths.posts.name);

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
      //hatayı es geçiyor
    } catch (_) {
      print('hata');
    }
    return null;
  }

  //Id ile güncelleme
  @override
  Future<bool> putItemToService(PostModel postModel, int id) async {
    try {
      final response = await _dio.put('${_PostServicePaths.posts.name}\$id',
          data: postModel);
      return response.statusCode == HttpStatus.ok;
    } on DioException catch (exception) {
      _ShowDebug().showDioError(exception, this);
    }
    return false;
  }

  //delete
  @override
  Future<bool> deleteItemFromService(int id) async {
    try {
      final response = await _dio.delete('${_PostServicePaths.posts.name}\$id');

      return response.statusCode == HttpStatus.ok;
    } on DioException catch (exception) {
      _ShowDebug().showDioError(exception, this);
    }
    return false;
  }

  @override
  Future<List<CommentModel>?> fetchRelatedCommentWithPostId(postId) async {
    try {
      final response = await _dio.get(_PostServicePaths.comments.name,
          queryParameters: {_PostQueryPaths.postId.name: postId});

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => CommentModel.fromJson(e)).toList();
        }
      }
      //hatayı es geçiyor
    } on DioException catch (exception) {
      _ShowDebug().showDioError(exception, this);
    }
    return null;
  }
}

//service path lerine ulaşmak için
enum _PostServicePaths { posts, comments }

enum _PostQueryPaths { postId }

class _ShowDebug {
  //9.VİDEO 1.39.25 saniye - T type hata görüntüleme
  void showDioError<T>(DioException exception, T type) {
    if (kDebugMode) {
      print(exception.message);
      print(type);
    }
  }
}
