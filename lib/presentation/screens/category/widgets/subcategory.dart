import 'package:alteratech/presentation/components/my+text.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/navigator.dart';
import '../../../../domain/models/category/woocategory.dart' as woo;

//TODO
class SubCategory extends StatefulWidget {
  SubCategory({Key? key, required this.subCategory}) : super(key: key);
  woo.WooProductCategory subCategory;
  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate(
        //     context: context,
        //     route: ShopScreen(
        //       title: widget.subCategory.name!,
        //       categoryId: widget.subCategory.id!,
        //       // name: widget.subCategory.name!,
        //     ));
        //   print(22);
      },
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 3,
            child: SizedBox(
              width: 100,
              height: 90,
              child: widget.subCategory.image == null
                  ? Image.asset(
                      'assets/images/PROF.png',
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      widget.subCategory.image!.guid!,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          NeoText(
            widget.subCategory.name!.replaceAll("amp;", " "),
            size: 12,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
