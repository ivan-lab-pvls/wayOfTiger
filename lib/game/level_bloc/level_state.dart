part of 'level_bloc.dart';

@immutable
sealed class LevelState {}

final class LevelInitial extends LevelState {}

final class LevelLoadingState extends LevelState {}

final class LevelLoadedState extends LevelState {
  final List<LevelModel> levels;
  final int maxOpenedLevel;

  LevelLoadedState({required this.levels, required this.maxOpenedLevel});
}
