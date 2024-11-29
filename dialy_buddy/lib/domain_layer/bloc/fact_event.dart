part of 'fact_bloc.dart';

@immutable
sealed class FactEvent {}

class GetFactEvent extends FactEvent {}

class ResetFactEvent extends FactEvent {}
