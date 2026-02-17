import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanvolt/app/theme.dart';
import 'package:scanvolt/features/generate/domain/models/qr_content.dart';

/// QR コード生成用の動的入力フォーム。
///
/// 選択された [QrContentType] に応じてフォームフィールドが切り替わる。
class GenerateInputForm extends StatelessWidget {
  /// [GenerateInputForm] を生成する。
  const GenerateInputForm({
    required this.type,
    required this.onChanged,
    super.key,
  });

  /// 現在のコンテンツ種別。
  final QrContentType type;

  /// 入力値変更コールバック。
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      QrContentType.url => _UrlForm(onChanged: onChanged),
      QrContentType.text => _TextForm(onChanged: onChanged),
      QrContentType.wifi => _WifiForm(onChanged: onChanged),
      QrContentType.contact => _ContactForm(onChanged: onChanged),
    };
  }
}

class _UrlForm extends StatelessWidget {
  const _UrlForm({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Website URL',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'https://example.com',
          onChanged: onChanged,
          keyboardType: TextInputType.url,
          suffixWidget: _PasteButton(onPaste: onChanged),
        ),
      ],
    );
  }
}

class _TextForm extends StatelessWidget {
  const _TextForm({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Text Content',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'Enter text...',
          onChanged: onChanged,
          maxLines: 3,
        ),
      ],
    );
  }
}

class _WifiForm extends StatefulWidget {
  const _WifiForm({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  State<_WifiForm> createState() => _WifiFormState();
}

class _WifiFormState extends State<_WifiForm> {
  String _ssid = '';
  String _password = '';

  void _emitChange() {
    widget.onChanged('WIFI:T:WPA;S:$_ssid;P:$_password;;');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Network Name (SSID)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'Network name',
          onChanged: (v) {
            _ssid = v;
            _emitChange();
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Password',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'Password',
          onChanged: (v) {
            _password = v;
            _emitChange();
          },
          obscureText: true,
        ),
      ],
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  String _name = '';
  String _phone = '';
  String _email = '';

  void _emitChange() {
    final buf = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:3.0')
      ..writeln('FN:$_name');
    if (_phone.isNotEmpty) buf.writeln('TEL:$_phone');
    if (_email.isNotEmpty) buf.writeln('EMAIL:$_email');
    buf.writeln('END:VCARD');
    widget.onChanged(buf.toString());
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.textSecondary,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name', style: labelStyle),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'Full name',
          onChanged: (v) {
            _name = v;
            _emitChange();
          },
        ),
        const SizedBox(height: 16),
        Text('Phone', style: labelStyle),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'Phone number',
          onChanged: (v) {
            _phone = v;
            _emitChange();
          },
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        Text('Email', style: labelStyle),
        const SizedBox(height: 8),
        _StyledTextField(
          hintText: 'Email address',
          onChanged: (v) {
            _email = v;
            _emitChange();
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _StyledTextField extends StatelessWidget {
  const _StyledTextField({
    required this.hintText,
    required this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixWidget,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      style: const TextStyle(color: AppTheme.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.textTertiary),
        filled: true,
        fillColor: AppTheme.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: suffixWidget,
      ),
    );
  }
}

class _PasteButton extends StatelessWidget {
  const _PasteButton({required this.onPaste});

  final ValueChanged<String> onPaste;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: TextButton(
        onPressed: () async {
          final data = await Clipboard.getData(Clipboard.kTextPlain);
          if (data?.text != null) {
            onPaste(data!.text!);
          }
        },
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.primaryCyan,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text('Paste'),
      ),
    );
  }
}
