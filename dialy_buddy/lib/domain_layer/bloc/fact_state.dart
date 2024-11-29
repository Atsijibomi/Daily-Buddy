part of 'fact_bloc.dart';

@immutable
sealed class FactState extends Equatable {
  const FactState();
}

final class FactInitial extends FactState {
  @override
  List<Object?> get props => [];
}

class FactLoading extends FactState {
  @override
  List<Object?> get props => [];
}

class FactLoaded extends FactState {
  final Fact fact;

  const FactLoaded({required this.fact});
  
  @override
  List<Object?> get props => [fact];
}

class FactError extends FactState {
  final String message;

  const FactError({required this.message});
  
  @override
  List<Object?> get props => [message];
}
