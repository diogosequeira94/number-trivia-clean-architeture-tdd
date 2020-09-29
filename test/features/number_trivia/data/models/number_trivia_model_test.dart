import 'dart:convert';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';


// Simple test to check if NumberTriviaModel extends NumberTrivia

void main(){
  final testNumberTriviaModel = NumberTriviaModel(
      text: 'Test Text', number: 1);

  test('should be a subclass of NumberTrivia entity',
      () async {
        //assert
        expect(testNumberTriviaModel, isA<NumberTrivia>());
      },
  );
  
  group('fromJson', () {
    test(
        'should return a valid model when the JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia.json'));
          // act
          final result = NumberTriviaModel.fromJson(jsonMap);
          // assert
          expect(result, testNumberTriviaModel);
        },
      );

    test(
      'should return a valid model when the JSON number is an double',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, testNumberTriviaModel);
      },
     );
    });
}