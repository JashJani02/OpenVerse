# OpenVerse - Tech Stack (Phase 1)

## Project Goal

Phase 1 focuses on building a clean, scalable Flutter application capable of interacting with cloud-based Large Language Models through OpenRouter.

The primary objective is **not** to build every feature immediately, but to establish a robust architecture that can seamlessly evolve into a complete AI workspace supporting multiple providers, local LLMs, and multimodal AI.

---

# Technology Stack

## Framework

| Technology | Purpose                                |
| ---------- | -------------------------------------- |
| Flutter    | Cross-platform application development |
| Dart       | Programming language                   |

---

## State Management

| Technology | Purpose                                 |
| ---------- | --------------------------------------- |
| Riverpod   | Dependency Injection & State Management |

Why Riverpod?

* Compile-time safety
* Excellent scalability
* Easy dependency injection
* Testable architecture
* Minimal boilerplate

---

## Routing

| Technology | Purpose                |
| ---------- | ---------------------- |
| GoRouter   | Declarative navigation |

---

## Networking

| Technology | Purpose                           |
| ---------- | --------------------------------- |
| Dio        | HTTP requests & API communication |

Future Uses:

* OpenRouter API
* Ollama API
* LM Studio
* Image APIs
* Video APIs

---

## Local Database

| Technology | Purpose                                  |
| ---------- | ---------------------------------------- |
| Isar       | Offline chat storage & local persistence |

Stores:

* Conversations
* Messages
* Cached responses
* User preferences
* Selected provider
* Selected model

---

## Key-Value Storage

| Technology        | Purpose                          |
| ----------------- | -------------------------------- |
| SharedPreferences | Lightweight application settings |

Stores:

* Theme mode
* API keys (until secure storage is introduced)
* Last selected model
* Last selected provider
* UI preferences

---

## Secure Storage *(Future Upgrade)*

| Technology             | Purpose                                      |
| ---------------------- | -------------------------------------------- |
| flutter_secure_storage | Secure storage for API keys & sensitive data |

> **Note:** During Phase 1, SharedPreferences is acceptable for development. Before a production release, sensitive values such as API keys should be migrated to secure storage.

---

## Markdown Rendering

| Technology       | Purpose             |
| ---------------- | ------------------- |
| flutter_markdown | Render AI responses |

Supports:

* Headings
* Lists
* Tables
* Links
* Blockquotes

---

## Code Highlighting

| Technology        | Purpose                             |
| ----------------- | ----------------------------------- |
| flutter_highlight | Syntax highlighting for code blocks |

---

## Utilities

| Technology | Purpose                         |
| ---------- | ------------------------------- |
| intl       | Date & time formatting          |
| uuid       | Unique IDs for chats & messages |
| logger     | Logging & debugging             |
| collection | Collection utilities            |

---

# Architecture

OpenVerse follows a feature-first architecture with separation between presentation, business logic, data access, and infrastructure.

```text
Presentation

↓

Controllers

↓

Repositories

↓

Providers

↓

Network / Database
```

This ensures:

* Better scalability
* Easier testing
* Provider independence
* Future extensibility

---

# Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── api_constants.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── storage/
│   │   ├── isar_service.dart
│   │   └── preferences_service.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   └── typography.dart
│   ├── utils/
│   └── services/
│
├── features/
│   │
│   ├── chat/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │
│   │   └── presentation/
│   │       ├── controllers/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── providers/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── settings/
│   │   ├── presentation/
│   │   └── data/
│   │
│   └── home/
│       └── presentation/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   ├── providers/
│   └── extensions/
│
└── main.dart
```

---

# Provider Architecture

The UI should never communicate directly with OpenRouter.

Instead, all providers will implement a common abstraction.

```text
UI

↓

Repository

↓

AI Provider Interface

↓

OpenRouter Provider
```

Future providers:

```text
AI Provider

├── OpenRouter
├── Ollama
├── LM Studio
├── Gemini
├── OpenAI
├── Anthropic
└── Others...
```

Adding a new provider should not require changes to the UI layer.

---

# Phase 1 Features

* OpenRouter Integration
* Streaming Responses
* Markdown Rendering
* Code Highlighting
* Chat History
* Local Conversation Storage
* Multiple Conversations
* Model Selection
* Provider Selection *(OpenRouter only for now)*
* Light/Dark Theme
* Copy Message
* Stop Generation
* Regenerate Response
* Delete Conversation
* Rename Conversation

---

# Development Principles

* Offline-first architecture
* Feature-first folder structure
* Provider-agnostic design
* Repository pattern
* Modular widgets
* Clean separation of concerns
* Minimal external dependencies
* Production-ready coding standards

---

# Future Expansion

The Phase 1 architecture is intentionally designed to support future enhancements without major refactoring.

Planned additions include:

* Ollama Integration
* LM Studio
* Multiple Cloud Providers
* Image Generation
* Video Generation
* Voice Support
* PDF Chat
* AI Agents
* RAG
* Plugin System
* Authentication
* Cloud Synchronization

The core architecture established in Phase 1 should remain unchanged as these capabilities are introduced.
