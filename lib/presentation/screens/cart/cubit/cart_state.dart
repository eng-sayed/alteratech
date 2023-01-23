part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartGetDataLoading extends CartState {}

class CartGetDataSuccess extends CartState {}

class CartGetDataError extends CartState {}

class CartRemoveFromCartSuccess extends CartState {}

class CartRemoveFromCartLoading extends CartState {}

class CartAddToCartSuccess extends CartState {}

class UploadCartGetLoading extends CartState {}

class UploadCartGetSuccess extends CartState {}
