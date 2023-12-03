import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function() onPressed;
  const DrawerItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 8, 0),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
                color: const Color(0xFF1485b9),
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  letterSpacing: 0.4
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
