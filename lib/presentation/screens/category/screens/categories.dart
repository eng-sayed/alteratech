import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../components/loadinganderror.dart';
import '../../../components/shimer_loading_items.dart';
import '../cubit/category_cubit.dart';
import '../widgets/loading_category.dart';
import '../widgets/subcategory.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with AutomaticKeepAliveClientMixin {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = CategoryCubit.get(context);
      cubit.getDataCategories(context: context);
      cubit.getDataSubCategories(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);
          return LoadingAndError(
              isError: state is CategoriesErrorState,
              isLoading: state is CategoriesLoadingState,
              child: Scaffold(
                backgroundColor: AppColors.lightGreybackgound,
                // appBar: AppBar(
                //   backgroundColor: AppColors.primiry,
                //   title: NeoText('category'.tr(),
                //       color: AppColors.white, size: 19),
                //   actions: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: CircleAvatar(
                //           backgroundColor: Colors.white,
                //           child: Image.asset(
                //             "assets/images/logo.png",
                //             //  width: 60,
                //           )),
                //     ),
                //   ],
                // ) // appBar: AppBar(
                //   backgroundColor: AppColors.primiry,
                //   title: NeoText('category'.tr(),
                //       color: AppColors.white, size: 19),
                //   actions: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: CircleAvatar(
                //           backgroundColor: Colors.white,
                //           child: Image.asset(
                //             "assets/images/logo.png",
                //             //  width: 60,
                //           )),
                //     ),
                //   ],
                // ),
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: NeoText(
                            'category'.tr(),
                            color: AppColors.black,
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          LoadingAndError(
                            isError: state is CategoriesErrorState,
                            isLoading: state is CategoriesLoadingState,
                            childLoading: LoadingCategory(),
                            childError: Center(
                              child: Text('There is an error'),
                            ),
                            child: Container(
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    color: Colors.grey.shade50,
                                    height: double.infinity,
                                    width: 120.w,
                                    child: ListView.builder(
                                      // controller: categoriesController,
                                      itemCount: cubit.categories.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            cubit.selectedId =
                                                cubit.categories[index].id!;
                                            await cubit.getDataSubCategories(
                                              context: context,
                                            );
                                          },
                                          child: Center(
                                            child: Container(
                                              color: cubit.selectedId ==
                                                      cubit.categories[index].id
                                                  ? AppColors.primiry
                                                      .withOpacity(0.3)
                                                  : AppColors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: NeoText(
                                                        cubit.categories[index]
                                                            .name!
                                                            .replaceAll(
                                                                "amp;", " "),
                                                        color:
                                                            AppColors.primiry,
                                                        size: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        maxLines: 3,
                                                        align:
                                                            TextAlign.center),
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Divider(
                                                      color: Colors.black38,
                                                      height: 0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      // scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: LoadingAndError(
                            isError: state is SubCategoriesErrorState,
                            isLoading: state is SubCategoriesLoadingState,
                            childError: Center(
                              child: Text('There is an error'),
                            ),
                            childLoading: ProductsLoadnigItem(),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: .9,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return SubCategory(
                                  subCategory: cubit.subCategories[index],
                                );
                              },
                              itemCount: cubit.subCategories.length,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
