import 'package:flutter/material.dart';
import 'package:flutter_services/202/service/user/model_photos.dart';
import 'package:flutter_services/202/service/user/service/service.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key, this.id});
  final int? id;

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late final IUserService userService;
  bool _isLoading = false;
  List<PhotoModel>? _photoItem;

  @override
  void initState() {
    super.initState();
    userService = UserService();
    fetchItemsWithId(widget.id ?? 0);
  }

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void fetchItemsWithId(int id) async {
    changeLoading();
    _photoItem = await userService.fetchRelatedPhotos(id);
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: _photoItem?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: [
                  Image.network(_photoItem?[index].thumbnailUrl ?? ''),
                  Text(_photoItem?[index].title ?? ''),
                ],
              ),
            );
          }),
    );
  }
}
