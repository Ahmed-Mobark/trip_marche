import 'package:equatable/equatable.dart';
import 'package:trip_marche/features/company_profile/data/models/vendor_profile_model.dart';

abstract class VendorProfileState extends Equatable {
  const VendorProfileState();

  VendorProfileState copy();

  @override
  List<Object?> get props => [];
}

class VendorProfileInitial extends VendorProfileState {
  const VendorProfileInitial();

  @override
  VendorProfileInitial copy() => this;
}

class VendorProfileLoading extends VendorProfileState {
  const VendorProfileLoading();

  @override
  VendorProfileLoading copy() => this;
}

class VendorProfileSuccess extends VendorProfileState {
  const VendorProfileSuccess(this.profile);

  final VendorProfileModel profile;

  @override
  VendorProfileSuccess copy() => VendorProfileSuccess(profile);

  @override
  List<Object?> get props => [profile];
}

class VendorProfileError extends VendorProfileState {
  const VendorProfileError(this.message);

  final String message;

  @override
  VendorProfileError copy() => VendorProfileError(message);

  @override
  List<Object?> get props => [message];
}
