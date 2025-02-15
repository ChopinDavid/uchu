import 'package:flutter_test/flutter_test.dart';
import 'package:grammatika/models/exercise.dart';
import 'package:grammatika/models/gender.dart';
import 'package:grammatika/models/noun.dart';
import 'package:grammatika/models/sentence.dart';
import 'package:grammatika/models/word_form.dart';

main() {
  group('type', () {
    test(
        'returns ExerciseType.determineNounGender when A is Gender and Q is Noun',
        () {
      expect(
        Exercise<Gender, Noun>(question: Noun.testValue(), answers: null).type,
        ExerciseType.determineNounGender,
      );
    });

    test(
        'returns ExerciseType.determineWordForm when A is WordForm and Q is Sentence',
        () {
      expect(
        Exercise<WordForm, Sentence>(
                question: Sentence.testValue(), answers: null)
            .type,
        ExerciseType.determineWordForm,
      );
    });
  });

  group('withAnswers', () {
    test('returns new instance with passed answers', () {
      final question = Noun.testValue();
      final expected = Exercise<Gender, Noun>.testValue(
          question: question, answers: [question.correctAnswer]);
      expect(
          Exercise<Gender, Noun>.testValueSimple(question: expected.question)
              .withAnswers(expected.answers!),
          expected);
    });
  });
}
