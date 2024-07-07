import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double dh = MediaQuery.of(context).size.height;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Center(
        child: Image(
          image: const AssetImage(
            'assets/logo.png',
          ),
          height: dh * .07,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
