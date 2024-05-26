import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uchu/extensions/list_extension.dart';
import 'package:uchu/models/answer.dart';
import 'package:uchu/models/gender.dart';
import 'package:uchu/models/noun.dart';
import 'package:uchu/models/question.dart';
import 'package:uchu/models/sentence.dart';
import 'package:uchu/models/word.dart';
import 'package:uchu/models/word_form.dart';

class Exercise<A extends Answer, Q extends Question<A>> extends Equatable {
  const Exercise({
    required this.question,
    required this.answers,
  });
  final Q question;
  final List<A>? answers;

  ExerciseType get type {
    if (A == Gender && Q == Noun) {
      return ExerciseType.determineNounGender;
    }

    if (A == WordForm && Q == Sentence) {
      return ExerciseType.determineWordForm;
    }

    throw UnsupportedError(
        'ExerciseType not yet defined for Answer type: $A and Question type: $Q');
  }

  bool get isCorrectAnswer {
    assert(answers != null);
    return question.answerSynonyms.duplicates(answers!).isNotEmpty;
  }

  bool get isIncorrectAnswer {
    assert(answers != null);
    return question.answerSynonyms.duplicates(answers!).isEmpty;
  }

  Exercise<A, Q> withAnswers(List<A> answers) {
    return Exercise<A, Q>(question: question, answers: answers);
  }

  @visibleForTesting
  factory Exercise.testValue({
    required Q question,
    required List<A> answers,
    Word? word,
    required String explanation,
  }) {
    word ??= Word.testValue();
    return Exercise(
      question: question,
      answers: answers,
    );
  }

  @override
  List<Object?> get props => [
        question,
        answers,
      ];
}

enum ExerciseType {
  determineNounGender,
  determineWordForm,
}
