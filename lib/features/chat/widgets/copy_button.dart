import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatefulWidget {
  final String text;

  const CopyButton({
    super.key,
    required this.text,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(
      ClipboardData(text: widget.text),
    );

    if (!mounted) return;

    setState(() => copied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Copied to clipboard"),
        duration: Duration(seconds: 1),
      ),
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (mounted) {
      setState(() => copied = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: copied ? "Copied!" : "Copy code",
      child: IconButton(
        splashRadius: 18,
        iconSize: 18,
        color: copied ? Colors.green : Colors.white70,
        onPressed: _copy,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: copied
              ? const Icon(
                  Icons.check,
                  key: ValueKey("done"),
                )
              : const Icon(
                  Icons.copy_outlined,
                  key: ValueKey("copy"),
                ),
        ),
      ),
    );
  }
}