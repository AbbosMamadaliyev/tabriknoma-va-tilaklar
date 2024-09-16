part of 'internet_bloc.dart';

@immutable
class InternetState extends Equatable {
  final bool isConnected;
  final FormzSubmissionStatus status;

  const InternetState({
    required this.status,
    this.isConnected = true,
  });

  InternetState copyWith({
    FormzSubmissionStatus? status,
    bool? isConnected,
  }) =>
      InternetState(
        status: status ?? this.status,
        isConnected: isConnected ?? this.isConnected,
      );

  @override
  List<Object?> get props => [isConnected, status];
}
