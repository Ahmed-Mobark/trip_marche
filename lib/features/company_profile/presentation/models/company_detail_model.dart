import 'package:flutter/material.dart';

class CompanyDetailModel {
  const CompanyDetailModel({
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final String value;
  final Widget? trailing;
}
