import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/auth/check_page.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/home/components/feed_componente.dart';
import 'package:blog_mobile/view/home/components/my_posts_componente.dart';
import 'package:blog_mobile/view/profile/profile_page.dart';
import 'package:blog_mobile/view/home/components/tags_component.dart';
import 'package:blog_mobile/view/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userLogged});

  final User userLogged;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: _currentIndex == 1 ? 0 : null,
            leading: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _currentIndex != 1
                      ? CircleAvatar(
                          backgroundColor: widget.userLogged.image != null
                              ? Colors.transparent
                              : Colors.black12,
                          child: widget.userLogged.image != null
                              ? Image.network(widget.userLogged.image!)
                              : const Icon(Icons.person),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            title: _buildTitleAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: _getBody(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _selectedPage,
            selectedIconTheme:
                const IconThemeData(color: ThemeColors.colorBottonSelected),
            selectedLabelStyle:
                const TextStyle(color: ThemeColors.colorBottonSelected),
            selectedItemColor: ThemeColors.colorBottonSelected,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedItemColor: Colors.white,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(label: 'feed', icon: Icon(Icons.feed)),
              BottomNavigationBarItem(
                  label: 'search', icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: 'post', icon: Icon(Icons.post_add)),
              BottomNavigationBarItem(
                  label: 'profile', icon: Icon(Icons.person)),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: _currentIndex == 3
              ? AuthButton(
                  onPressed: () {
                    _onPressed();
                  },
                  title: 'Logout',
                  fontSize: 20,
                  size: const Size(150, 40),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  void _selectedPage(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return FeedComponente(
          userId: widget.userLogged.id!,
        );
      case 1:
        return const TagsPage();
      case 2:
        return MyPostsPage(userLogged: widget.userLogged);
      case 3:
        return ProfilePage(
          userLogged: widget.userLogged,
        );
      default:
        return const Center(
          child: Text('Error'),
        );
    }
  }

  Widget _buildTitleAppBar() {
    if (_currentIndex == 1) {
      return SizedBox(
        height: 50,
        child: TextField(
          controller: _searchController,
          cursorColor: Colors.white,
          onSubmitted: (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(search: value)));
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'search',
            labelStyle: TextStyle(color: Colors.white, fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(Icons.search),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      );
    }
    return const Text('Blog');
  }

  void _onPressed() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ThemeColors.colorScaffold,
            title: const Text('Do you want to leave?'),
            content: const Text('You will return to the login screen'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ThemeColors.colorBottonSelected,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckPage()));
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
