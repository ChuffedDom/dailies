import 'package:flutter/material.dart';

class ActionItem extends StatefulWidget {
  final String actionText;
  bool isDone;
  ActionItem({
    Key? key,
    required this.actionText,
    required this.isDone,
  }) : super(key: key);

  @override
  State<ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.25,
          ),
        ),
      ),
      child: ListTile(
        leading: Checkbox(
          onChanged: (value) {
            setState(
              () {
                widget.isDone = value!;
              },
            );
          },
          value: widget.isDone,
        ),
        title: Text(widget.actionText),
      ),
    );
  }
}
