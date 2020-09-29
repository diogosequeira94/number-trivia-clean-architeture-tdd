import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const<dynamic>[]]);
}

// General Failures

class ServerException extends Failure {
  @override
  List<Object> get props =>[];
}

class CacheException extends Failure{
  @override
  List<Object> get props => [];
}