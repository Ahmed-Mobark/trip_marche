import 'package:equatable/equatable.dart';
import '../../data/models/home_banner_model.dart';

enum HomeBannersStatus { initial, loading, success, failure }

class HomeBannersState extends Equatable {
  const HomeBannersState({
    this.status = HomeBannersStatus.initial,
    this.banners = const [],
    this.errorMessage,
  });

  final HomeBannersStatus status;
  final List<HomeBannerModel> banners;
  final String? errorMessage;

  HomeBannersState copyWith({
    HomeBannersStatus? status,
    List<HomeBannerModel>? banners,
    String? errorMessage,
  }) {
    return HomeBannersState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, banners, errorMessage];
}
