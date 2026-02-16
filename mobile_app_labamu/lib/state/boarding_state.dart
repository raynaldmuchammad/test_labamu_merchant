import 'package:equatable/equatable.dart';

abstract class BoardingState extends Equatable {
  const BoardingState();
}

class BoardingLoading extends BoardingState {
  @override
  List<Object?> get props => [];
}

class BoardingLoaded extends BoardingState {
  final int pageIndex;
  final bool isLastPage;

  BoardingLoaded({required this.pageIndex, required this.isLastPage});

  @override
  List<Object?> get props => [pageIndex, isLastPage];
}
