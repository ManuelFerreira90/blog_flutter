import 'package:blog_mobile/models/comment.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({super.key, required this.comment});

  final Comment comment;

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: widget.comment.getUser?.image != null
                              ? Colors.transparent
                              : Colors.black12,
                          child: widget.comment.getUser?.image != null
                              ? Image.network(widget.comment.getUser!.image!)
                              : const Icon(Icons.person),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.comment.getUser?.firstame ?? 'no name',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.comment.getUser?.userName ?? 'no username',
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        widget.comment.getBody != null
                            ? Text(widget.comment.getBody!)
                            : const SizedBox.shrink(),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${widget.comment.getLikes ?? '0'}'),
                        IconButton(
                          onPressed: () {
                            _likeAndDeslike(0);
                          },
                          icon: widget.comment.getLike
                              ? const Icon(Icons.thumb_up_alt)
                              : const Icon(
                                  Icons.thumb_up_alt_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _likeAndDeslike(int i) {
        setState(() {
          if (!widget.comment.getLike) {
            widget.comment.setLike = true;
            widget.comment.setLikes = widget.comment.getLikes! + 1;
          } else {
            widget.comment.setLike = false;
            widget.comment.setLikes = widget.comment.getLikes!  - 1;
          }
        });
  }
}
