import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_marche/core/widgets/app_trip_search_text_field.dart';
import 'package:trip_marche/core/widgets/curved_sheet_sort_filter_row.dart';
import 'package:trip_marche/features/my_trips/presentation/cubit/my_trips_list_cubit.dart';

class SearchResultSearchBar extends StatefulWidget {
  const SearchResultSearchBar({
    super.key,
    required this.initialQuery,
    this.scrollController,
  });

  final String initialQuery;
  final ScrollController? scrollController;

  @override
  State<SearchResultSearchBar> createState() => _SearchResultSearchBarState();
}

class _SearchResultSearchBarState extends State<SearchResultSearchBar> {
  static const Duration _debounce = Duration(milliseconds: 500);

  late final TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  void _scrollToTop() {
    final c = widget.scrollController;
    if (c != null && c.hasClients) {
      c.jumpTo(0);
    }
  }

  void _runSearch() {
    _debounceTimer?.cancel();
    if (!mounted) {
      return;
    }
    FocusScope.of(context).unfocus();
    _scrollToTop();
    context.read<MyTripsListCubit>().applySearchQuery(_controller.text);
  }

  void _scheduleDebouncedSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, () {
      if (!mounted) {
        return;
      }
      _scrollToTop();
      context.read<MyTripsListCubit>().applySearchQuery(_controller.text);
    });
  }

  void _onFieldChanged(String _) {
    _scheduleDebouncedSearch();
  }

  void _onClear() {
    _debounceTimer?.cancel();
    _controller.clear();
    _scrollToTop();
    context.read<MyTripsListCubit>().applySearchQuery('');
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTripSearchTextField(
      controller: _controller,
      onChanged: _onFieldChanged,
      onSubmitted: (_) => _runSearch(),
      onClear: _onClear,
    );
  }
}

class SearchResultActionRow extends StatelessWidget {
  const SearchResultActionRow({
    super.key,
    this.onSortTap,
    this.onFilterTap,
  });

  final VoidCallback? onSortTap;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return CurvedSheetSortFilterRow(
      onSortTap: onSortTap,
      onFilterTap: onFilterTap,
    );
  }
}
