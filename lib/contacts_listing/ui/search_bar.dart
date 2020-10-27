import 'package:flutter/material.dart';

typedef OnSearchPressedCallback(String query);

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final OnSearchPressedCallback onSearchPressedCallback;
  final String hintText;

  SearchBar({
    @required this.controller,
    @required this.focusNode,
    @required this.onSearchPressedCallback,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.left,
      maxLines: 1,
      onSubmitted: (query) {
        onSearchPressedCallback(query);
        focusNode.unfocus();
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
