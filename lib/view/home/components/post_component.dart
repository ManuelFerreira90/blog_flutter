import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:flutter/material.dart';

class PostComponent extends StatefulWidget {
  const PostComponent({super.key, required this.post, required this.user});

  final Post post;
  final User user;

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  bool _imageError = false;
  bool like = false;
  bool dislike = false;

  void _changeBool(int index) {
    switch (index) {
      case 0:
        setState(() {
          like = !like;
        });
        break;
      case 1:
        setState(() {
          dislike = !dislike;
        });
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: ThemeColors.colorDiviser,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Row(
                children: [
                  widget.user.image != null
                      ? CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _imageError
                              ? null
                              : NetworkImage(widget.user.image!),
                          onBackgroundImageError: (_, __) {
                            setState(() {
                              _imageError = true;
                            });
                          },
                          child: _imageError
                              ? const Icon(Icons.person, size: 25)
                              : null,
                        )
                      : const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black12,
                          child: Icon(Icons.person),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.firstame ?? 'No name'),
                      widget.user.userName != null
                          ? Text('@${widget.user.userName}')
                          : const Text('no username'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(widget.post.getBody ?? 'No body'),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: ThemeColors.colorDiviser,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.post.getReactions?['likes'].toString() ?? '0',
                        style: const TextStyle(
                            color: ThemeColors.colorNumberInfoPost,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('likes', style: TextStyle(color: ThemeColors.colorInfoPost,)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.post.getReactions?['dislikes'].toString() ?? '0',
                        style: const TextStyle(
                            color: ThemeColors.colorNumberInfoPost,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('dislikes', style: TextStyle(color: ThemeColors.colorInfoPost,)),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.post.getViews?.toString() ?? '0',
                        style: const TextStyle(
                            color: ThemeColors.colorNumberInfoPost,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('views',
                          style: TextStyle(
                            color: ThemeColors.colorInfoPost,
                          )),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: ThemeColors.colorDiviser,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mode_comment_outlined,
                        color: ThemeColors.colorIconPost,
                      )),
                  IconButton(
                      onPressed: () {
                        _changeBool(0);
                      },
                      icon: like ? const Icon(
                        Icons.thumb_up_alt,
                        color: ThemeColors.colorIconPost,
                      ) : const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: ThemeColors.colorIconPost,
                      )),
                  IconButton(
                      onPressed: () {
                        _changeBool(1);
                      },
                      icon: dislike ? const Icon(
                        Icons.thumb_down_alt,
                        color: ThemeColors.colorIconPost,
                      ) : const Icon(
                        Icons.thumb_down_alt_outlined,
                        color: ThemeColors.colorIconPost,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
