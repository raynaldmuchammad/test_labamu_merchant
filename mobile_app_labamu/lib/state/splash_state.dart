import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashLoading extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashLoaded extends SplashState {
  @override
  List<Object?> get props => [];
}
