import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services/202/service/comment_learn_view.dart';
import 'package:flutter_services/202/service/post_service.dart';
import 'post_model.dart';

class ServiceGetLearn extends StatefulWidget {
  const ServiceGetLearn({super.key});

  @override
  State<ServiceGetLearn> createState() => _ServiceGetLearnState();
}

class _ServiceGetLearnState extends State<ServiceGetLearn> {
  List<PostModel>? _items;
  bool _isLoading = false;

  //Test edilebilir kod
  late final IPostService _postService;

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    fetchPostItemsAdvanced();
  }

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  //advanced service request
  Future<void> fetchPostItemsAdvanced() async {
    changeLoading();
    _items = await _postService.fetchPostItemsAdvanced();
    changeLoading();
  }

  Future<void> fetchItems() async {
    changeLoading();

    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;

      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });

        changeLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: _items == null
          ? const Placeholder()
          : ListView.builder(
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return _PostCard(model: _items?[index]);
              },
            ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required PostModel? model,
  }) : _model = model;

  //gelen değeri modele aktarıyoruz

  final PostModel? _model;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommentsLearnView(
                postId: _model?.id,
              ),
            ),
          );
        },
        title: Text(_model?.title ?? ''),
        subtitle: Text(_model?.body ?? ''),
      ),
    );
  }
}
