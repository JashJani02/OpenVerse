# OpenVerse

> **One AI Workspace. Every Model. Anywhere.**

OpenVerse is a cross-platform AI workspace built with Flutter that provides a unified interface for interacting with both local and cloud-based AI models. The application is designed around a provider-based architecture, allowing users to seamlessly switch between inference providers without changing their workflow.

The long-term vision is to evolve OpenVerse into a complete multimodal AI workspace supporting text, images, audio, video, documents, local knowledge bases, and AI agents while maintaining a clean and scalable architecture.

---

# Core Philosophy

* Offline-first architecture
* Multi-provider support
* Provider-agnostic UI
* Modular and scalable codebase
* Desktop-first experience with full mobile support
* No vendor lock-in
* Future-proof architecture for multimodal AI

---

# Technology Stack

## Frontend

* Flutter
* Dart

## State Management

* Riverpod

## Routing

* GoRouter

## Networking

* Dio

## Local Database

* Isar *(Preferred)*
* Hive *(Fallback if simplicity is preferred initially)*

## Local Preferences

* SharedPreferences

## Markdown Rendering

* flutter_markdown

## Syntax Highlighting

* flutter_highlight

---

# Initial Scope (MVP)

The first release focuses entirely on **text generation** using cloud models via OpenRouter.

Features include:

* Multi-conversation support
* Streaming responses
* Markdown rendering
* Code block highlighting
* Copy response
* Edit prompt
* Regenerate response
* Stop generation
* Conversation history
* Search conversations
* Theme support
* Model selection
* Provider selection
* Settings page
* Offline chat persistence

---

# Architecture

The application will follow a provider abstraction model.

```
Chat UI

     │

AI Provider Interface

     │

 ┌───────────────┐
 │               │
 │               │
OpenRouter   Ollama
```

The UI must never directly communicate with a specific provider.

Instead, every provider will implement the same interface.

Future providers should be pluggable without modifying existing UI code.

---

# Planned Provider Support

## Phase 1

* OpenRouter

## Phase 2

* Ollama

## Future

* LM Studio
* llama.cpp
* OpenAI
* Anthropic
* Gemini
* Groq
* Together AI
* DeepInfra
* Fireworks AI

---

# Development Phases

## Phase 0 — Foundation

Goal:
Create a scalable project foundation before implementing features.

Tasks:

* Flutter project setup
* Folder structure
* Riverpod configuration
* GoRouter configuration
* Material 3 theme
* Network layer
* Local database setup
* Repository pattern
* Provider abstraction
* Dependency injection
* Global error handling
* Logging utilities

Deliverable:

A clean project skeleton ready for feature development.

---

## Phase 1 — OpenRouter Text Chat

Goal:
Ship a fully functional AI chat application.

Features:

* OpenRouter integration
* Streaming responses
* Chat screen
* Markdown rendering
* Code highlighting
* Copy response
* Stop generation
* Regenerate response
* Conversation history
* Chat persistence
* Model selector
* Settings page

Deliverable:

Stable AI chat application powered by OpenRouter.

---

## Phase 2 — Chat Experience

Goal:
Polish the overall user experience.

Features:

* Search chats
* Pin chats
* Rename chats
* Delete chats
* Export chats
* Import chats
* Better code block UI
* Keyboard shortcuts
* Desktop optimizations
* Usage statistics
* Token estimation
* Cost estimation
* Performance improvements

Deliverable:

Production-quality chat experience.

---

## Phase 3 — Local LLM Support

Goal:
Introduce offline AI inference.

Providers:

* Ollama

Features:

* Automatic Ollama detection
* Installed model discovery
* Local model selection
* Provider switching
* Health checks
* Connection status

Deliverable:

Users can switch between cloud and local models without changing the UI.

---

## Phase 4 — Additional Providers

Goal:
Expand cloud provider support.

Potential Providers:

* OpenAI
* Anthropic
* Gemini
* Together AI
* Groq
* DeepInfra
* Fireworks AI

Deliverable:

OpenVerse becomes a universal AI client.

---

## Phase 5 — Multimodal AI

Goal:
Expand beyond text generation.

Features:

* Text → Image
* Image Understanding
* Image Editing
* Document Upload
* OCR
* PDF Chat
* Speech-to-Text
* Text-to-Speech
* Video Generation

Deliverable:

Unified multimodal AI workspace.

---

## Phase 6 — AI Workspace

Goal:
Transform OpenVerse into a complete AI productivity platform.

Features:

* RAG
* Knowledge Bases
* Web Search
* AI Agents
* Tool Calling
* Plugin System
* Workspaces
* Projects
* Prompt Library

Deliverable:

A complete AI workspace capable of handling complex workflows.

---

# Suggested Project Structure

```
lib/

core/
│
├── config/
├── constants/
├── errors/
├── network/
├── services/
├── storage/
├── theme/
├── utils/
└── routing/

features/

├── chat/
├── providers/
├── models/
├── settings/
├── onboarding/
└── home/

shared/

├── widgets/
├── models/
├── repositories/
└── extensions/

main.dart
```

---

# Data Layer

The project will use a repository-based architecture.

```
UI

↓

Controller

↓

Repository

↓

Provider

↓

API / Local Model

↓

Response
```

This keeps business logic independent from UI and allows providers to be swapped easily.

---

# Local Storage Strategy

The application will be offline-first.

Store locally:

* Conversations
* Messages
* User preferences
* Selected provider
* Selected model
* Theme
* Prompt history
* Cached responses

No cloud dependency will exist during the MVP.

---

# Design Goals

* Minimal
* Fast
* Responsive
* Keyboard-friendly
* Desktop optimized
* Material 3
* Beautiful animations
* Consistent spacing
* Modern typography

---

# Future Features

* Prompt Library
* Chat Templates
* Workspace System
* AI Personas
* Plugin Marketplace
* MCP Support
* Vision Models
* Video Models
* Voice Assistant
* Local Embeddings
* Semantic Search
* Cloud Synchronization
* Authentication
* Collaborative Chats

---

# Development Principles

* Keep UI independent from providers.
* Avoid hardcoding provider-specific logic.
* Prefer composition over inheritance.
* Build vertically before expanding horizontally.
* Every completed feature should be production-ready before moving to the next.
* Design today for future providers, but only implement what is currently needed.
* Maintain clean architecture and modular code organization.

---

# Version Roadmap

## v0.1

Project foundation

## v0.2

OpenRouter chat

## v0.3

Improved chat experience

## v0.4

Ollama integration

## v0.5

Multiple AI providers

## v0.6

Multimodal support

## v1.0

OpenVerse AI Workspace
