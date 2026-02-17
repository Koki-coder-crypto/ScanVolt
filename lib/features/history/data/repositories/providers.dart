import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/features/history/data/repositories/history_repository_impl.dart';
import 'package:scanvolt/features/history/domain/repositories/history_repository.dart';
import 'package:scanvolt/shared/database/providers.dart';

/// [HistoryRepository] の Riverpod プロバイダー。
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final dao = ref.watch(scanHistoryDaoProvider);
  return HistoryRepositoryImpl(dao);
});
