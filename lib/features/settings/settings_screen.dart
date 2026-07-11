import 'package:flutter/material.dart';

import '../../models/ai_model.dart';
import '../../models/provider_type.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  late final SettingsController controller;

  @override
  void initState() {
    super.initState();

    controller = SettingsController();
    controller.initialize();
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
          appBar: AppBar(
            title: const Text("Settings"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "AI Provider",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                SegmentedButton<ProviderType>(
                  segments: const [
                    ButtonSegment(
                      value: ProviderType.openRouter,
                      label: Text("OpenRouter"),
                      icon: Icon(Icons.cloud),
                    ),
                    ButtonSegment(
                      value: ProviderType.ollama,
                      label: Text("Ollama"),
                      icon: Icon(Icons.computer),
                    ),
                  ],
                  selected: {
                    controller.providerType,
                  },
                  onSelectionChanged: (value) async {
                    await controller.setProvider(
                      value.first,
                    );
                  },
                ),

                const SizedBox(height: 28),

                if (controller.providerType ==
                    ProviderType.openRouter) ...[
                  const Text(
                    "OpenRouter API Key",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller:
                        controller.apiKeyController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(
                      border:
                          OutlineInputBorder(),
                      hintText:
                          "sk-or-v1-xxxxxxxx",
                    ),
                  ),
                ],

                if (controller.providerType ==
                    ProviderType.ollama) ...[
                  const Text(
                    "Ollama Base URL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: controller
                        .ollamaUrlController,
                    decoration:
                        const InputDecoration(
                      border:
                          OutlineInputBorder(),
                      hintText:
                          "http://localhost:11434",
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed:
                        controller.isLoading
                            ? null
                            : () async {
                                await controller
                                    .saveSettings();

                                if (!mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Settings Saved",
                                    ),
                                  ),
                                );
                              },
                    icon:
                        const Icon(Icons.save),
                    label:
                        const Text("Save Settings"),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed:
                        controller.isLoading
                            ? null
                            : () async {
                                await controller
                                    .loadModels();

                                if (!mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Models Loaded",
                                    ),
                                  ),
                                );
                              },
                    icon: const Icon(
                      Icons.download,
                    ),
                    label:
                        const Text("Load Models"),
                  ),
                ),

                if (controller.providerType ==
                    ProviderType.openRouter) ...[
                  const SizedBox(height: 24),

                  SwitchListTile(
                    contentPadding:
                        EdgeInsets.zero,
                    title: const Text(
                      "Show only free models",
                    ),
                    value:
                        controller.showFreeOnly,
                    onChanged: controller
                        .toggleFreeModels,
                  ),
                ],

                const SizedBox(height: 20),

                if (controller.models.isNotEmpty)
  DropdownButtonFormField<AIModel>(
    value: controller.visibleModels.any(
            (m) => m.id == controller.selectedModel?.id)
        ? controller.visibleModels.firstWhere(
            (m) => m.id == controller.selectedModel!.id,
          )
        : null,
    decoration: const InputDecoration(
      labelText: "Select Model",
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
                    padding:
                        EdgeInsets.only(top: 24),
                    child: Center(
                      child: Text(
                        "No models loaded.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
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