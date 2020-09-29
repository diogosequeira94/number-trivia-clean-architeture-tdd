import 'package:clean_architecture_tdd_course/core/error/failures.dart';
import 'package:clean_architecture_tdd_course/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, GetConcreteNumberTriviaParams> {
  final NumberTriviaRepository repository;

  // api.com/42 -> concrete number
  // api.com/random -> random number

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(
      GetConcreteNumberTriviaParams  params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class GetConcreteNumberTriviaParams  extends Equatable {
  final int number;

  GetConcreteNumberTriviaParams ({@required this.number});

  @override
  List<Object> get props => [number];

}