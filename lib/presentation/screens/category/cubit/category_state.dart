part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoriesLoadingState extends CategoryState {}

class CategoriesSuccesState extends CategoryState {}

class CategoriesErrorState extends CategoryState {}

class SubCategoriesLoadingState extends CategoryState {}

class SubCategoriesSuccesState extends CategoryState {}

class SubCategoriesErrorState extends CategoryState {}
