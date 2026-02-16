import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class MainLoading extends MainState {
  @override
  List<Object?> get props => [];
}

class MainLoaded extends MainState {
  @override
  List<Object?> get props => [];
}

class BoardingLoaded extends MainState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends MainState {
  @override
  List<Object?> get props => [];
}
