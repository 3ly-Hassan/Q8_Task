import 'package:flutter/material.dart';
import 'package:q8_task/views/home/widgets/player_item.dart';

class UserItem extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final VoidCallback onTap;
  final String buttonText;
  final Color color;
  const UserItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.onTap,
      required this.buttonText,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PlayerItem(image: image, name: name, userItem: true),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                onTap();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              child: Text(
                buttonText,
              ))
        ],
      ),
    );
  }
}
