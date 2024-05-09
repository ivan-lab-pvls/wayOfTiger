import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiger_fortune/data/data_manager.dart';

import '../../data/models/level_model/level_model.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  LevelBloc() : super(LevelInitial()) {
    on<LevelLoadEvent>(onInitLevels);
  }

  onInitLevels(LevelLoadEvent event, Emitter<LevelState> emit) async {
    emit(LevelLoadingState());
    await DataManager.loadProgress();
    DataManager.initializeLevels();
    List<LevelModel> levels = DataManager.levels;
    int maxOpenedLevelIndex = DataManager.maxOpenedLevel;
    emit(LevelLoadedState(levels: levels, maxOpenedLevel: maxOpenedLevelIndex));
  }
}
