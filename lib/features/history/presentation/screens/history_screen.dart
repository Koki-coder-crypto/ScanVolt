import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/core/constants/app_icons.dart';
import 'package:scanvolt/features/history/presentation/view_models/history_view_model.dart';
import 'package:scanvolt/features/history/presentation/widgets/history_empty_state.dart';
import 'package:scanvolt/features/history/presentation/widgets/history_list_item.dart';
import 'package:scanvolt/features/scan/domain/models/scan_result.dart';

/// 履歴フィルターの種類。
enum _HistoryFilter { all, urls, text, wifi, contact }

/// スキャン履歴画面。
class HistoryScreen extends ConsumerStatefulWidget {
  /// [HistoryScreen] を生成する。
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _searchController = TextEditingController();
  _HistoryFilter _activeFilter = _HistoryFilter.all;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ScanResult> _applyFilters(List<ScanResult> scans) {
    var filtered = scans;

    // フィルターチップ適用
    filtered = switch (_activeFilter) {
      _HistoryFilter.all => filtered,
      _HistoryFilter.urls =>
        filtered.where((s) => s.dataType == ScanDataType.url).toList(),
      _HistoryFilter.text =>
        filtered.where((s) => s.dataType == ScanDataType.text).toList(),
      _HistoryFilter.wifi =>
        filtered.where((s) => s.dataType == ScanDataType.wifi).toList(),
      _HistoryFilter.contact =>
        filtered.where((s) => s.dataType == ScanDataType.contact).toList(),
    };

    // 検索フィルター適用
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (s) => s.rawValue.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final historyState = ref.watch(historyViewModelProvider);
    final filteredScans = _applyFilters(historyState.scans);

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ヘッダー
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.tune,
                      colorFilter: const ColorFilter.mode(
                        AppTheme.textSecondary,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {
                      // TODO(scanvolt): show filter menu
                    },
                  ),
                ],
              ),
            ),

            // 検索バー
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search scans...',
                  hintStyle: const TextStyle(color: AppTheme.textTertiary),
                  prefixIcon:
                      SvgPicture.asset(
                        AppIcons.search,
                        colorFilter: const ColorFilter.mode(
                          AppTheme.textTertiary,
                          BlendMode.srcIn,
                        ),
                        width: 24,
                        height: 24,
                      ),
                  filled: true,
                  fillColor: AppTheme.darkSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            // フィルターチップ
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: _HistoryFilter.values.map((filter) {
                  final isSelected = _activeFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(_filterLabel(filter)),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppTheme.darkBackground
                            : AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      selectedColor: AppTheme.primaryCyan,
                      backgroundColor: AppTheme.darkSurface,
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primaryCyan
                            : AppTheme.textTertiary,
                      ),
                      showCheckmark: false,
                      onSelected: (_) =>
                          setState(() => _activeFilter = filter),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),

            // リスト or 空表示
            Expanded(
              child: historyState.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryCyan,
                      ),
                    )
                  : filteredScans.isEmpty
                      ? const HistoryEmptyState()
                      : ListView.separated(
                          itemCount: filteredScans.length,
                          separatorBuilder: (_, index) => const Divider(
                            height: 1,
                            indent: 76,
                            color: AppTheme.darkCard,
                          ),
                          itemBuilder: (context, index) {
                            final scan = filteredScans[index];
                            return HistoryListItem(
                              result: scan,
                              onToggleFavorite: () {
                                unawaited(
                                  ref
                                      .read(historyViewModelProvider.notifier)
                                      .toggleFavorite(
                                        scan.id,
                                        isFavorite: !scan.isFavorite,
                                      ),
                                );
                              },
                              onDelete: () {
                                unawaited(
                                  ref
                                      .read(historyViewModelProvider.notifier)
                                      .deleteScan(scan.id),
                                );
                              },
                              onTap: () {
                                // TODO(scanvolt): show detail view
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  String _filterLabel(_HistoryFilter filter) => switch (filter) {
        _HistoryFilter.all => 'All',
        _HistoryFilter.urls => 'URLs',
        _HistoryFilter.text => 'Text',
        _HistoryFilter.wifi => 'Wi-Fi',
        _HistoryFilter.contact => 'Contact',
      };
}
