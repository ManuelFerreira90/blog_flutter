import 'package:blog_mobile/controllers/home_controller.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/home/components/card_post.dart';
import 'package:blog_mobile/view/home/components/loading_refresh.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.search, this.tag});

  final String? search;
  final String? tag;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _loadingRefresh = ValueNotifier(false);
  late Future<bool> isLoading;
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    isLoading = _searchPageController();
    _searchController.text = widget.search ?? '';
    _scrollController.addListener(_infinityScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _infinityScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _loadingRefresh.value = true;
        _searchPageController();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final _currentFocus = FocusScope.of(context);

        if(!_currentFocus.hasPrimaryFocus){
          _currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 50,
            child: TextField(
              controller: _searchController,
              cursorColor: Colors.white,
              onSubmitted: (value) {
                setState(() {
                  _posts.clear();
                  isLoading = _fetchPostsBySearch(value);
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'search',
                labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: isLoading,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.colorCircularProgressIndicator,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  const Center(child: Text('Error'));
                }
                return _posts.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(10),
                              itemCount: _posts.length,
                              itemBuilder: (context, index) {
                                return CardPost(
                                  post: _posts[index],
                                  isPostPage: false,
                                );
                              },
                            ),
                          ),
                          loadingWidget(_loadingRefresh),
                        ],
                      )
                    : const Center(
                        child: Text('No results'),
                      );
            }
          },
        ),
      ),
    );
  }

  Future<bool> _searchPageController() async {
    if (widget.search != null) {
      return _fetchPostsBySearch(widget.search!);
    } else if (widget.tag != null) {
      return _fetchPostsByTag();
    } else {
      return Future.value(false);
    }
  }

  Future<bool> _fetchPostsBySearch(String search) async {
    _posts += await HomeController.searchPostsController(search, _posts.length);
    _loadingRefresh.value = false;
    if (mounted) {
      setState(() {});
    }
    return Future.value(true);
  }

  Future<bool> _fetchPostsByTag() async {
    _posts +=
        await HomeController.postsByTagController(widget.tag!, _posts.length);
    _loadingRefresh.value = false;
    if (mounted) {
      setState(() {});
    }
    return Future.value(true);
  }
}
