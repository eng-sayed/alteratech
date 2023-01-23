import 'package:alteratech/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCategory extends StatelessWidget {
  const LoadingCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          width: 120.w,
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 48.0,
                    height: 48.0,
                    color: Colors.green,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 2.0),
                  // ),
                  Container(
                    width: 25,
                    height: 8.0,
                    color: Colors.green,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: 25.0,
                    height: 8.0,
                    color: Colors.green,
                  )
                ],
              ),
            ),
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
