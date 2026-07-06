import 'package:flutter/material.dart';
import '../../models/ai_model.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsController controller;

  @override
  void initState() {
    super.initState();

    controller = SettingsController();
    controller.loadApiKey();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text("Settings")),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "OpenRouter API Key",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.apiKeyController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "sk-or-v1-...",
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: controller.isLoading
    ? null
    : () async {
        final messenger = ScaffoldMessenger.of(context);

        await controller.saveApiKey();

        if (!mounted) return;

        messenger.showSnackBar(
          const SnackBar(
            content: Text("API Key Saved"),
          ),
        );
      },
                    child: controller.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Save"),
                  ),
                ),

                const SizedBox(height: 24),

                SwitchListTile(
                  title: const Text("Show only free models"),
                  value: controller.showFreeOnly,
                  onChanged: controller.toggleFreeModels,
                ),

                const SizedBox(height: 12),

                if (controller.models.isNotEmpty)
                  DropdownButtonFormField<AIModel>(
                    initialValue: controller.selectedModel,
                    decoration: const InputDecoration(
                      labelText: "Model",
                      border: OutlineInputBorder(),
                    ),
                    items: controller.visibleModels.map((model) {
                      return DropdownMenuItem<AIModel>(
                        value: model,
                        child: Text(model.name),
                      );
                    }).toList(),
                    onChanged: controller.selectModel,
                  ),

                if (controller.models.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "No models loaded.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
