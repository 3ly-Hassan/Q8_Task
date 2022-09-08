import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q8_task/cubits/user_cubit/user_cubit.dart';
import 'package:q8_task/cubits/user_cubit/user_states.dart';
import 'package:q8_task/views/home/widgets/player_item.dart';

import 'widgets/user_item.dart';

const unKnownImage =
    'https://img.freepik.com/free-vector/modern-question-mark-help-support-page_1017-27395.jpg?w=740&t=st=1662531633~exp=1662532233~hmac=d7d9d0b629acef3f74de9762fae927252d0feff028833f675e579115e273698b';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add players',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserCubit.get(context)
                              .palyersList
                              .asMap()
                              .containsKey(index)
                          ? PlayerItem(
                              myAccount: index == 0,
                              onTap: () {
                                userCubit.addPlayer(
                                    UserCubit.get(context).palyersList[index]);
                              },
                              image: NetworkImage(
                                  userCubit.palyersList[index].image ??
                                      unKnownImage),
                              name:
                                  '${userCubit.palyersList[index].firstName} ${userCubit.palyersList[index].lastName}',
                            )
                          : PlayerItem(
                              image: null,
                              name: '',
                              onTap: () {},
                            );
                    },
                    itemCount: 10,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: userCubit.searchController,
                  onEditingComplete: () {
                    if (userCubit.searchController.text.isNotEmpty) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      userCubit.search(userCubit.searchController.text.trim());
                    }
                  },
                  onChanged: (val) {
                    userCubit.showClear();
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: userCubit.searchController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              userCubit.clearTheField();
                            },
                            child: const Icon(Icons.clear))
                        : null,
                    labelText: 'Search by player name',
                    hintText: 'Search by player name',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: userCubit.searchList.isNotEmpty
                      ? ListView.builder(
                          itemCount: userCubit.searchList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var user = userCubit.searchList[index];
                            return UserItem(
                              image: NetworkImage(user.image ?? unKnownImage),
                              name: '${user.firstName} ${user.lastName}',
                              onTap: () {
                                userCubit.addPlayer(user);
                              },
                              buttonText: userCubit.palyersList.contains(user)
                                  ? 'Remove'
                                  : 'Add',
                              color: userCubit.palyersList.contains(user)
                                  ? Colors.red
                                  : Theme.of(context).primaryColor,
                            );
                          },
                        )
                      : const SizedBox(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: Card(
                  color: Colors.white,
                  elevation: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
