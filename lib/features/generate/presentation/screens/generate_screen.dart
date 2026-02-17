import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/generate/domain/models/qr_content.dart';
import 'package:scanvolt/features/generate/presentation/view_models/generate_view_model.dart';
import 'package:scanvolt/features/generate/presentation/widgets/generate_input_form.dart';
import 'package:scanvolt/features/generate/presentation/widgets/qr_preview_card.dart';
import 'package:share_plus/share_plus.dart';

/// QR コード生成画面。
class GenerateScreen extends ConsumerWidget {
  /// [GenerateScreen] を生成する。
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateViewModelProvider);
    final vm = ref.read(generateViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ヘッダー
              Text(
                'Generate',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),

              // タイプセレクターチップ
              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: QrContentType.values.map((type) {
                    final isSelected = state.selectedType == type;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _typeIcon(type),
                              size: 16,
                              color: isSelected
                                  ? AppTheme.darkBackground
                                  : AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 6),
                            Text(_typeLabel(type)),
                          ],
                        ),
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
                        onSelected: (_) => vm.selectType(type),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // 動的入力フォーム
              GenerateInputForm(
                type: state.selectedType,
                onChanged: (value) {
                  vm
                    ..updateInput(value)
                    ..generate();
                },
              ),
              const SizedBox(height: 32),

              // QR プレビュー
              Center(
                child: QrPreviewCard(data: state.generatedData),
              ),
              const SizedBox(height: 32),

              // Share & Save ボタン
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: state.generatedData != null
                          ? () {
                              unawaited(
                                SharePlus.instance.share(
                                  ShareParams(text: state.generatedData),
                                ),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.ios_share, size: 18),
                      label: const Text('Share'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textPrimary,
                        side: const BorderSide(color: AppTheme.textTertiary),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: state.generatedData != null
                          ? () {
                              // TODO(scanvolt): save QR image to gallery
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('QR code saved!')),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryCyan,
                        foregroundColor: AppTheme.darkBackground,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  IconData _typeIcon(QrContentType type) => switch (type) {
        QrContentType.url => Icons.link,
        QrContentType.text => Icons.description_outlined,
        QrContentType.wifi => Icons.wifi,
        QrContentType.contact => Icons.person_outline,
      };

  String _typeLabel(QrContentType type) => switch (type) {
        QrContentType.url => 'URL',
        QrContentType.text => 'Text',
        QrContentType.wifi => 'Wi-Fi',
        QrContentType.contact => 'Contact',
      };
}
