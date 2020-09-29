import 'package:clean_architecture_tdd_course/core/network/network_info.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock
    implements NetworkInfo {}

void main(){
  NumberTriviaRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', (){
    final testNumber = 1;
    final testNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: testNumber);
    final NumberTrivia testNumberTrivia = testNumberTriviaModel;
    test('should check if the device is online',
        () async {
            //arrange
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
            //act
          repositoryImpl.getConcreteNumberTrivia(testNumber);
            // assert
            verify(mockNetworkInfo.isConnected);
          },
        );

    group('device is online', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful',
            () async {
              //arrange
              when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => testNumberTriviaModel);
              //act
              final result = await repositoryImpl.getConcreteNumberTrivia(testNumber);
              // assert
              verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
              expect(result, equals(Right(testNumberTrivia)));
        },
      );

      test('should cache the data locally when the call to remote data source is successful',
            () async {
              //arrange
              when(mockRemoteDataSource.getConcreteNumberTrivia(any))
                  .thenAnswer((_) async => testNumberTriviaModel);
              //act
              await repositoryImpl.getConcreteNumberTrivia(testNumber);
              // assert
              verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
              verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));
        },
      );
    });

    group('device is offline', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}