import 'package:flutter/material.dart';
import 'package:flutter_services/202/service/user/model_user.dart';
import 'package:flutter_services/202/service/user/photo_view.dart';

import 'service/service.dart';

//Simple GET Service Örneği

class UserLearnView extends StatefulWidget {
  const UserLearnView({super.key});

  @override
  State<UserLearnView> createState() => _UserLearnViewState();
}

class _UserLearnViewState extends State<UserLearnView> {
  bool _isLoading = false;
  List<UserModel>? _users;

  late final IUserService _userService;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    changeLoading();
    _users = await _userService.fetchUsers();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _users == null
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: _users?.length ?? 0,
              itemBuilder: (context, index) {
                return UserCard(model: _users?[index]);
              },
            ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required UserModel? model,
  }) : _model = model;

  final UserModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PhotoView(
                id: _model.id,
              ),
            ),
          );
        },
        title: Text(_model?.name ?? ''),
        trailing: Text(_model?.username ?? ''),
        subtitle: Text(_model?.address?.city ?? ''),
        leading: Text(_model!.id.toString()),
      ),
    );
  }
}
