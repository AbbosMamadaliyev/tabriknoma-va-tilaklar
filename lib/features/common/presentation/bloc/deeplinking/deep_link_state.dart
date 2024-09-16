part of 'deep_link_bloc.dart';

@immutable
abstract class DeepLinkState extends Equatable {}

class DeepLinkInitState extends DeepLinkState {
  DeepLinkInitState();

  @override
  List<Object?> get props => [];
}

class ProductLinkTriggered extends DeepLinkState {
  final int id;

  ProductLinkTriggered({required this.id});

  @override
  List<Object?> get props => [id];
}

class ProductLinkTriggeredWithSlug extends DeepLinkState {
  final String slug;

  ProductLinkTriggeredWithSlug({required this.slug});

  @override
  List<Object?> get props => [slug];
}

class PaymentTriggered extends DeepLinkState {
  @override
  List<Object?> get props => [];
}
