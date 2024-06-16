import 'package:uchu/models/word_form.dart';
import 'package:uchu/models/word_form_type.dart';

import 'consts.dart';
import 'models/gender.dart';

class ExplanationHelper {
  String? genderExplanation({
    required String bare,
    required Gender correctAnswer,
  }) {
    final lastCharacter = bare.substring(bare.length - 1).toLowerCase();
    if (lastCharacter == 'ь') {
      return 'Most nouns ending in -ь are feminine, but there are many masculine ones too, so you have to learn the gender of soft-sign nouns.';
    }

    if (correctAnswer == Gender.m) {
      if (masculineNounEndings.contains(lastCharacter)) {
        return 'Masculine nouns normally end with a consonant or -й.';
      }

      if (feminineNounEndings.contains(lastCharacter)) {
        return 'Nouns ending in -а or -я which denote males are masculine. This may be the case here.';
      }
    }

    if (correctAnswer == Gender.f) {
      if (feminineNounEndings.contains(lastCharacter)) {
        return 'Feminine nouns normally end with -а or -я.';
      }

      return 'Foreign words denoting females are feminine, whatever their endings. This may be the case here.';
    }

    if (correctAnswer == Gender.n) {
      if (neuterNounEndings.contains(lastCharacter)) {
        return 'Neuter nouns generally end in -о or -е.';
      }

      if (foreignNeuterNounEndings.contains(lastCharacter)) {
        return 'If a noun ends in -и or -у or -ю, it is likely to be a foreign borrowing and to be neuter.';
      }
    }
  }

  String? sentenceExplanation(
      {required String bare, required WordForm correctAnswer}) {
    switch (correctAnswer.type) {
      case WordFormType.ruVerbGerundPast:
        String? formationExplanation;
        bool isReflexive =
            bare.endsWith('ться') && correctAnswer.bare.endsWith('вшись');
        if (isReflexive) {
          formationExplanation =
              ' Since the verb in this sentence is reflexive, you replace the "-ться" suffix with a "-вшись" suffix.';
        } else if (correctAnswer.position == 1 &&
            bare.endsWith('ть') &&
            correctAnswer.bare.endsWith('в')) {
          formationExplanation =
              ' Since the verb in this sentence is not reflexive, you replace the "-ть" suffix with a "-в" suffix. Alternatively, you could replace the "-ть" suffix with a "-вши" suffix, though this is marked (colloquial, dated, or humorous).';
        } else if (correctAnswer.position == 2 &&
            bare.endsWith('ть') &&
            correctAnswer.bare.endsWith('вши')) {
          formationExplanation =
              ' Since the verb in this sentence is not reflexive, you replace the "-ть" suffix with a "-вши" suffix. Alternatively, you could replace the "-ть" suffix with a "-в" suffix.';
        }
        return 'This word is a perfective gerund, also known as a perfective adverbial participle. Gerunds are formed from verbs and are used to describe an action, preceding the action expressed by the main verb. This gerund is perfective, meaning that the gerund denotes a result or completed action, having taken place before the main verb.${formationExplanation ?? ''}';
      case WordFormType.ruVerbGerundPresent:
        String? formationExplanation;
        bool isReflexive =
            bare.endsWith('ться') && correctAnswer.bare.endsWith('сь');
        if (isReflexive) {
          final usesSpellingRule = correctAnswer.bare.endsWith('ась');
          formationExplanation =
              ' Since the verb in this sentence is reflexive, you take the third person plural form of the verb and replace its suffix with either a "-ась" or "-ясь" suffix. Since "a" always follows "ж", "ш", "ч", or "щ", we will use ${usesSpellingRule ? '"-ась"' : '"-ясь"'} in this case.';
        }
        return 'This word is an imperfective gerund, also known as an imperfective adverbial participle. Gerunds are formed from verbs and are used to describe an action, preceding the action expressed by the main verb. This gerund is imperfective, meaning that the gerund denotes a process or incomplete action, taking place simultaneously with the main verb.${formationExplanation ?? ''}';
      case WordFormType.ruBase:
        return '';
      case WordFormType.ruAdjMNom:
        return '';
      case WordFormType.ruAdjMGen:
        return '';
      case WordFormType.ruAdjMDat:
        return '';
      case WordFormType.ruAdjMAcc:
        return '';
      case WordFormType.ruAdjMInst:
        return '';
      case WordFormType.ruAdjMPrep:
        return '';
      case WordFormType.ruAdjFNom:
        return '';
      case WordFormType.ruAdjFGen:
        return '';
      case WordFormType.ruAdjFDat:
        return '';
      case WordFormType.ruAdjFAcc:
        return '';
      case WordFormType.ruAdjFInst:
        return '';
      case WordFormType.ruAdjFPrep:
        return '';
      case WordFormType.ruAdjNNom:
        return '';
      case WordFormType.ruAdjNGen:
        return '';
      case WordFormType.ruAdjNDat:
        return '';
      case WordFormType.ruAdjNAcc:
        return '';
      case WordFormType.ruAdjNInst:
        return '';
      case WordFormType.ruAdjNPrep:
        return '';
      case WordFormType.ruAdjPlNom:
        return '';
      case WordFormType.ruAdjPlGen:
        return '';
      case WordFormType.ruAdjPlDat:
        return '';
      case WordFormType.ruAdjPlAcc:
        return '';
      case WordFormType.ruAdjPlInst:
        return '';
      case WordFormType.ruAdjPlPrep:
        return '';
      case WordFormType.ruVerbImperativeSg:
        return '';
      case WordFormType.ruVerbImperativePl:
        return '';
      case WordFormType.ruVerbPastM:
        return '';
      case WordFormType.ruVerbPastF:
        return '';
      case WordFormType.ruVerbPastN:
        return '';
      case WordFormType.ruVerbPastPl:
        return '';
      case WordFormType.ruVerbPresfutSg1:
        return '';
      case WordFormType.ruVerbPresfutSg2:
        return '';
      case WordFormType.ruVerbPresfutSg3:
        return '';
      case WordFormType.ruVerbPresfutPl1:
        return '';
      case WordFormType.ruVerbPresfutPl2:
        return '';
      case WordFormType.ruVerbPresfutPl3:
        return '';
      case WordFormType.ruVerbParticipleActivePast:
        return '';
      case WordFormType.ruVerbParticiplePassivePast:
        return '';
      case WordFormType.ruVerbParticipleActivePresent:
        return '';
      case WordFormType.ruVerbParticiplePassivePresent:
        return '';
      case WordFormType.ruNounSgNom:
        return '';
      case WordFormType.ruNounSgGen:
        return '';
      case WordFormType.ruNounSgDat:
        return '';
      case WordFormType.ruNounSgAcc:
        return '';
      case WordFormType.ruNounSgInst:
        return '';
      case WordFormType.ruNounSgPrep:
        return '';
      case WordFormType.ruNounPlNom:
        return '';
      case WordFormType.ruNounPlGen:
        return '';
      case WordFormType.ruNounPlDat:
        return '';
      case WordFormType.ruNounPlAcc:
        return '';
      case WordFormType.ruNounPlInst:
        return '';
      case WordFormType.ruNounPlPrep:
        return '';
      case WordFormType.ruAdjComparative:
        return '';
      case WordFormType.ruAdjSuperlative:
        return '';
      case WordFormType.ruAdjShortM:
        return '';
      case WordFormType.ruAdjShortF:
        return '';
      case WordFormType.ruAdjShortN:
        return '';
      case WordFormType.ruAdjShortPl:
        return '';
    }
    return 'This is the explanation for the sentence exercise.';
  }
}
