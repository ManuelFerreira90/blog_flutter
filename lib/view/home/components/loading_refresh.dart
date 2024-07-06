import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:flutter/material.dart';

Widget loadingWidget(ValueNotifier loadingRefresh) {
  return ValueListenableBuilder(
    valueListenable: loadingRefresh,
    builder: (context, loading, _) {
      return loading
          ? const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  color: ThemeColors.colorCircularProgressIndicator,
                ),
              ),
            )
          : const SizedBox.shrink();
    },
  );
}
