import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';

class GridBuilderCell extends StatelessWidget{

  final List<FbPost> post;

  const GridBuilderCell({super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // number of items in each row
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 8.0, // spacing between columns
      ),
      padding: EdgeInsets.all(8.0), // padding around the grid
      itemCount: post.length, // total number of items
      itemBuilder: (context, index) {
        return Container(
          color: Colors.lightGreen, // color of grid items
          child: Center(
            child: Text(
              post[index].titulo,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

}