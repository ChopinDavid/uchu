import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uchu/screens/exercise_page.dart';
import 'package:uchu/services/shared_preferences_service.dart';

import 'blocs/exercise/exercise_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key, @visibleForTesting ExerciseBloc? exerciseBloc})
      : _exerciseBloc = exerciseBloc ?? ExerciseBloc() {
    _exerciseBloc.add(ExerciseRetrieveExerciseEvent());
  }

  final ExerciseBloc _exerciseBloc;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GetIt.instance.get<SharedPreferencesService>(),
      child: Consumer<SharedPreferencesService>(
        builder: (context, sharedPreferencesService, child) {
          final themeMode = sharedPreferencesService.getThemeMode();
          return MaterialApp(
            home: BlocProvider<ExerciseBloc>.value(
              value: _exerciseBloc,
              child: const ExercisePage(),
            ),
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
