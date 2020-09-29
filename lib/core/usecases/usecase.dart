import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, GetConcreteNumberTriviaParams > {
  Future<Either<Failure, Type>> call(GetConcreteNumberTriviaParams params);
  // Generic abstract class for all the UsesCases in the App, returns either Failure or a specific return type
}

class NoParams extends Equatable{
  @override
  List<Object> get props => [];
}