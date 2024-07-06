import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/view/posts/post_page.dart';
import 'package:flutter/material.dart';

class CardPost extends StatefulWidget {
  CardPost({
    super.key,
    required this.post,
    required this.isPostPage,
    this.isMyPost = false,
    this.edit,
    this.delete,
  });

  final Post post;
  final bool isPostPage;
  bool isMyPost;
  Future<void> Function()? edit;
  Future<void> Function()? delete;

  @override
  State<CardPost> createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  List<String> options = ['edit', 'delete'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 1, maxWidth: 500),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    widget.post.getImageUser != null
                                        ? Colors.transparent
                                        : Colors.black12,
                                child: widget.post.getImageUser != null
                                    ? Image.network(widget.post.getImageUser!)
                                    : const Icon(Icons.person),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post.getFullName ?? 'no name',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.post.getUserName ?? 'no username',
                                    style: const TextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          widget.isMyPost
                              ? PopupMenuButton<String>(
                                  onSelected: (option) {
                                    switch (option) {
                                      case 'edit':
                                        if(widget.edit != null) {
                                          widget.edit!();
                                        }
                                        break;
                                      case 'delete':
                                        if(widget.delete != null) {
                                          widget.delete!();
                                        }
                                        break;
                                      default:
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return options.map((option) {
                                      return PopupMenuItem<String>(
                                          value: option, child: Text(option));
                                    }).toList();
                                  },
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _goToComments,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        widget.post.getTitle != null
                            ? Text(widget.post.getTitle!)
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.post.getBody != null
                            ? Text(widget.post.getBody!)
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              widget.isPostPage
                                  ? const SizedBox.shrink()
                                  : IconButton(
                                      onPressed: _goToComments,
                                      icon: const Icon(Icons.comment_outlined),
                                    ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.post.getReactions?['likes']
                                          .toString() ??
                                      '0'),
                                  IconButton(
                                    onPressed: () {
                                      _likeAndDeslike(0);
                                    },
                                    icon: widget.post.getLike
                                        ? const Icon(Icons.thumb_up_alt)
                                        : const Icon(
                                            Icons.thumb_up_alt_outlined),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.post.getReactions?['dislikes']
                                          .toString() ??
                                      '0'),
                                  IconButton(
                                    onPressed: () {
                                      _likeAndDeslike(1);
                                    },
                                    icon: widget.post.getDislike
                                        ? const Icon(Icons.thumb_down_alt)
                                        : const Icon(
                                            Icons.thumb_down_alt_outlined),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.post.getViews?.toString() ?? '0',
                                  ),
                                  const Text(
                                    ' views',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _likeAndDeslike(int i) {
    switch (i) {
      case 0:
        setState(() {
          if (widget.post.getDislike) {
            widget.post.setDislike = false;
            widget.post.setDislikes = widget.post.getReactions?['dislikes'] - 1;
          }
          if (!widget.post.getLike) {
            widget.post.setLike = true;
            widget.post.setLikes = widget.post.getReactions?['likes'] + 1;
          } else {
            widget.post.setLike = false;
            widget.post.setLikes = widget.post.getReactions?['likes'] - 1;
          }
        });
        break;
      case 1:
        setState(() {
          if (widget.post.getLike) {
            widget.post.setLike = false;
            widget.post.setLikes = widget.post.getReactions?['likes'] - 1;
          }
          if (!widget.post.getDislike) {
            widget.post.setDislike = true;
            widget.post.setDislikes = widget.post.getReactions?['dislikes'] + 1;
          } else {
            widget.post.setDislike = false;
            widget.post.setDislikes = widget.post.getReactions?['dislikes'] - 1;
          }
        });
        break;
      default:
        break;
    }
  }

  void _goToComments() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPage(post: widget.post),
      ),
    );
    setState(() {});
  }
}
