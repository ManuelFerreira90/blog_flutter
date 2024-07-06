import 'package:blog_mobile/view/home/search_page.dart';
import 'package:flutter/material.dart';

class ContainerTag extends StatefulWidget {
  ContainerTag({
    super.key, required this.tag,
  });

  final String tag;

  @override
  State<ContainerTag> createState() => _ContainerTagState();
}

class _ContainerTagState extends State<ContainerTag> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(tag: widget.tag,)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHover ? Colors.black12 : Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(child: Text(widget.tag)),
        ),
      ),
    );
  }
}