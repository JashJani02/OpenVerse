import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponseActions extends StatefulWidget {
  final String response;

  const ResponseActions({
    super.key,
    required this.response,
  });

  @override
  State<ResponseActions> createState() =>
      _ResponseActionsState();
}

class _ResponseActionsState
    extends State<ResponseActions> {
  bool copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(
      ClipboardData(text: widget.response),
    );

    if (!mounted) return;

    setState(() => copied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Response copied"),
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
      message:
          copied ? "Copied!" : "Copy response",
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
                  Icons.copy_all_outlined,
                  key: ValueKey("copy"),
                ),
        ),
      ),
    );
  }
}