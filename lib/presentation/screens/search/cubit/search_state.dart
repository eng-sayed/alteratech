part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchSuceed extends SearchState {}

class SearchFail extends SearchState {}
