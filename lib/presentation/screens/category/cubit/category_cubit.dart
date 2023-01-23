import 'dart:developer';

import 'package:alteratech/domain/repository/home_repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/category/woocategory.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);
  int selectedId = 0;
  List<WooProductCategory> subCategories = [];
  List<WooProductCategory> categories = [];
  getDataCategories({
    required BuildContext context,
  }) async {
    categories = [];
    emit(CategoriesLoadingState());
    var response = await HomeRepository.getCategory(context);
    if (response != null) {
      categories = response;
      selectedId = categories.first.id ?? 0;
      log('categories' + categories.length.toString());
      emit(CategoriesSuccesState());
    } else {
      emit(CategoriesErrorState());
    }
  }

  getDataSubCategories({
    required BuildContext context,
  }) async {
    subCategories = [];
    emit(SubCategoriesLoadingState());
    var response =
        await HomeRepository.getSubCategory(context, parent: selectedId);
    if (response != null) {
      subCategories = response;
      if (subCategories.isEmpty) {
        final cat =
            categories.firstWhere((element) => element.id == selectedId);
        subCategories.add(cat);
      }

      log('subCategories' + subCategories.length.toString());
      emit(SubCategoriesSuccesState());
    } else {
      emit(SubCategoriesErrorState());
    }
  }
}
