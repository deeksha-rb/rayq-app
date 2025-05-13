import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? leading;
  final TextStyle? titleTextStyle; // <-- make it nullable and optional

  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.leading,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true, // shows back arrow if needed
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      elevation: 0,
      titleSpacing: 0, // very important, removes default extra spacing
      centerTitle: false, // left-align the title
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0), // slight left padding like WhatsApp
        child: Text(
          title,
          style: titleTextStyle,
          ),
      ),
      leading: leading != null
          ? Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 18.0), // move the arrow a bit inside
        child: leading,
      )
          : null,// <-- set the custom leading if passed
      actions: actions,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // custom height
}
