import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlayerItem extends StatelessWidget {
  const PlayerItem(
      {Key? key,
      required this.image,
      required this.name,
      this.userItem = false,
      required this.onTap,
      this.myAccount = false})
      : super(key: key);
  final ImageProvider? image;
  final String name;
  final bool userItem;
  final VoidCallback onTap;
  final bool myAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: userItem ? 0 : 20.0, vertical: userItem ? 0 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 76,
            width: 76,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    radius: 36,
                    backgroundImage: image,
                    onBackgroundImageError: image != null
                        ? (exception, stackTrace) {
                            if (kDebugMode) print('Erroe has occured');
                          }
                        : null,
                    child: image == null
                        ? const Icon(
                            Icons.person_add,
                            size: 32,
                          )
                        : const SizedBox(),
                  ),
                ),
                if (!userItem && !myAccount)
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        onTap();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          !userItem ? Text(name) : const SizedBox(),
        ],
      ),
    );
  }
}
