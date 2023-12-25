import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'post_model.dart';

class ServicePostLearn extends StatefulWidget {
  const ServicePostLearn({super.key});

  @override
  State<ServicePostLearn> createState() => _ServicePostLearnState();
}

class _ServicePostLearnState extends State<ServicePostLearn> {
  bool _isLoading = false;
  late final Dio _networkManager;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/';
  String name = "";

  @override
  void initState() {
    super.initState();
    _networkManager = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _addItemToService(PostModel postModel) async {
    changeLoading();
    final response = await _networkManager.post('posts', data: postModel);

    if (response.statusCode == HttpStatus.created) {
      name = 'basarili';
    }
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _bodyController = TextEditingController();
    TextEditingController _userController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: _bodyController,
            decoration: const InputDecoration(labelText: 'Body'),
            textInputAction: TextInputAction.next,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _userController,
            decoration: const InputDecoration(labelText: 'User Id'),
          ),
          TextButton(
            //service post isteği yaparken
            onPressed: _isLoading
                ? null
                : () {
                    if (_titleController.text.isNotEmpty &&
                        _bodyController.text.isNotEmpty &&
                        _userController.text.isNotEmpty) {
                      final model = PostModel(
                        body: _bodyController.text,
                        title: _titleController.text,
                        userId: int.tryParse(_userController.text),
                      );
                      _addItemToService(model);
                    }
                  },
            child: const Text('Send'),
          ),
          Text(name),
        ],
      ),
    );
  }
}
