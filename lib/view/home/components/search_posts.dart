import 'package:blog_mobile/themes/style/consts.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:flutter/material.dart';

class SearchPosts extends StatelessWidget {
  const SearchPosts({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ThemeColors.colorScaffold,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: _searchController,
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
          labelText: 'search posts',
          labelStyle: kLabelStyleAuthPages,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: kBoderTextFormFieldSearch,
          focusedBorder: kFocusedBorderTextFormFieldSearch,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}