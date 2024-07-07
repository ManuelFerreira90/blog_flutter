import 'package:blog_mobile/controllers/home_controller.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/home/components/container_tag.dart';
import 'package:flutter/material.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  late Future<List<String>> _tags;

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tags,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.colorCircularProgressIndicator,
              ),
            );
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ContainerTag(tag: snapshot.data![index],);
                  },
                ),
              );
            }
        }
      },
    );
  }

  Future<void> _fetchTags() async {
    _tags = HomeController.tagsPostsController();
  }
}


