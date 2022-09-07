import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q8_task/cubits/user_cubit/user_states.dart';
import 'package:q8_task/data/repository.dart';

import '../../data/models/user_model.dart';

class UserCubit extends Cubit<UserState> {
  final Repository repository;

  UserCubit({required this.repository}) : super(InitialState());
  static UserCubit get(context) => BlocProvider.of(context);
  late TextEditingController searchController;

  List<User> allUsers = [];
  List<User> palyersList = [
    User(
        firstName: 'Test',
        lastName: 'Account',
        image:
            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
  ];

  List<User> searchList = [];
  void searchEqualAll() {
    searchList = [...allUsers];
  }

  void search(String searchWord) {
    searchList = allUsers
        .where((element) =>
            element.firstName!
                .toLowerCase()
                .contains(searchWord.toLowerCase()) ||
            element.lastName!.toLowerCase().contains(searchWord.toLowerCase()))
        .toList();
    emit(SearchedComplet());
  }

  void showClear() {
    emit(ToggleClear());
  }

  void fieldSubmitted(context, focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void getAllUser() {
    repository.getAllUser().then((value) {
      if (value.isEmpty) {
        emit(GetUsersError());
      } else {
        allUsers = value;
        searchEqualAll();
        emit(UserLoadedSuccessfully());
      }
    });
  }

  void addPlayer(User user) {
    if (user.firstName == 'Test') {
      return;
    }
    palyersList.contains(user)
        ? palyersList.remove(user)
        : palyersList.add(user);
    emit(PlayerChangedSuccessfully());
  }

  void clearTheField() {
    searchController.clear();
    searchList = [...allUsers];
    emit(ToggleClear());
  }

  init() {
    searchController = TextEditingController();
  }
}
