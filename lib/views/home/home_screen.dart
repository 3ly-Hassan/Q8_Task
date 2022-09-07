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
      body: SingleChildScrollView(
        child: BlocBuilder<UserCubit, UserState>(
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
                                  userCubit.addPlayer(UserCubit.get(context)
                                      .palyersList[index]);
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
                        userCubit
                            .search(userCubit.searchController.text.trim());
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      ...userCubit.searchList
                          .map((e) => UserItem(
                                color: userCubit.palyersList.contains(e)
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                                image: NetworkImage(e.image ?? unKnownImage),
                                name: '${e.firstName} ${e.lastName}',
                                onTap: () {
                                  userCubit.addPlayer(e);
                                },
                                buttonText: userCubit.palyersList.contains(e)
                                    ? 'Remove'
                                    : 'Add',
                              ))
                          .toList()
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
