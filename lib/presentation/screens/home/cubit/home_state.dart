part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomePageGetProductsErrorState extends HomeState {}

class HomePageGetProductsLoadingState extends HomeState {}

class HomePageGetProductsSucessState extends HomeState {}

class HomePageGetAdsLoadingState extends HomeState {}

class HomePageGetAdsErrorState extends HomeState {}

class HomePageGetAdsSuccessState extends HomeState {}
