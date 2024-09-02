import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  DataState({this.data, this.error});
}

class DataSuccessState<T> extends DataState<T> {
  DataSuccessState(T data) : super(data: data);
}

class DataErrorState<T> extends DataState<T> {
  DataErrorState(DioException error) : super(error: error);
}
