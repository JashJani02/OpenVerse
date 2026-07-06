# OpenVerse Roadmap

> **Project Goal:** Build a modern, cross-platform AI workspace capable of seamlessly switching between cloud and local AI providers through a unified interface.

---

# Development Philosophy

OpenVerse will be developed **vertically**.

Rather than implementing multiple incomplete features simultaneously, each milestone will be completed to a production-ready state before moving on to the next.

Development priorities:

* Clean Architecture
* Offline-first
* Provider-agnostic design
* Modular codebase
* Production-quality UI
* Future scalability

---

# Phase 1 — Cloud Foundation (OpenRouter)

## Objective

Build a stable AI chat application powered by OpenRouter while establishing the architecture required for future provider expansion.

---

## Milestone 1.1 — Project Foundation

### Goals

* Create Flutter project
* Configure project architecture
* Setup Riverpod
* Configure GoRouter
* Configure Dio
* Setup Isar database
* Setup SharedPreferences
* Configure Material 3 Theme
* Dark & Light Theme
* Global error handling
* Logging utilities

### Deliverable

A clean and scalable project skeleton ready for feature development.

---

## Milestone 1.2 — Core Chat UI

### Goals

* Home Screen
* Chat Screen
* Conversation List
* Navigation
* Responsive Layout
* Desktop Navigation
* Mobile Navigation
* Empty State
* Loading States

### Deliverable

Complete chat interface without AI integration.

---

## Milestone 1.3 — OpenRouter Integration

### Goals

* API Key Management
* Provider Service
* Model Fetching
* Streaming Responses
* Error Handling
* Request Timeout
* Retry Mechanism

### Deliverable

Functional AI chat using OpenRouter.

---

## Milestone 1.4 — Conversation Management

### Goals

* Create Conversation
* Rename Conversation
* Delete Conversation
* Search Conversations
* Persist Chats
* Persist Messages
* Local Storage

### Deliverable

Offline chat persistence using Isar.

---

## Milestone 1.5 — Chat Experience

### Goals

* Markdown Rendering
* Code Highlighting
* Copy Message
* Regenerate Response
* Stop Generation
* Auto Scroll
* Typing Indicator
* Streaming Animation
* Message Timestamps

### Deliverable

Modern AI chat experience.

---

## Milestone 1.6 — Settings

### Goals

* Theme Selection
* Model Selection
* Provider Selection
* API Key Configuration
* Clear Chat History
* Application Information

### Deliverable

Complete settings module.

---

## Phase 1 Deliverables

* OpenRouter Integration
* Streaming Chat
* Multiple Conversations
* Local Database
* Markdown Support
* Code Highlighting
* Material 3 UI
* Responsive Layout
* Provider Architecture
* Offline Chat History

---

# Phase 2 — Local AI Support

## Objective

Expand OpenVerse beyond cloud inference by introducing local model execution through Ollama and LM Studio while keeping the same user experience.

The existing UI should require little to no modification.

---

## Milestone 2.1 — Provider Abstraction

### Goals

* Finalize AI Provider Interface
* Repository Abstraction
* Provider Factory
* Connection Manager
* Unified Response Model

### Deliverable

Provider-independent architecture.

---

## Milestone 2.2 — Ollama Integration

### Goals

* Detect Ollama Instance
* Connect to Local Server
* Retrieve Installed Models
* Model Selection
* Streaming Responses
* Error Handling
* Health Checks
* Connection Status

### Deliverable

Fully functional Ollama support.

---

## Milestone 2.3 — LM Studio Integration

### Goals

* Detect LM Studio Server
* Connect via OpenAI-Compatible API
* Fetch Available Models
* Model Selection
* Streaming Support
* Connection Status

### Deliverable

LM Studio works alongside OpenRouter and Ollama.

---

## Milestone 2.4 — Unified Provider Switching

### Goals

* Provider Dropdown
* Automatic Model Refresh
* Remember Last Provider
* Remember Last Model
* Provider Status Indicators

### Deliverable

Seamless switching between providers.

---

## Milestone 2.5 — Local Model Experience

### Goals

* Display Installed Models
* Model Information
* Context Window
* Parameter Count
* Quantization Details (if available)
* Connection Diagnostics

### Deliverable

A polished local-model management experience.

---

## Milestone 2.6 — Performance Improvements

### Goals

* Streaming Optimization
* Faster Message Rendering
* Improved Memory Management
* Request Queue
* Better Error Recovery

### Deliverable

Stable long-running conversations.

---

## Phase 2 Deliverables

### Supported Providers

* OpenRouter
* Ollama
* LM Studio

### Features

* Provider Switching
* Local Model Discovery
* Local Streaming
* Automatic Connection Detection
* Unified Chat Experience
* Offline AI Support
* Cloud + Local Inference

---

# Phase Completion Summary

## End of Phase 1

Users can:

* Chat using OpenRouter
* Switch between supported cloud models
* Store conversations locally
* Enjoy a polished chat experience

---

## End of Phase 2

Users can:

* Use OpenRouter
* Use Ollama
* Use LM Studio
* Switch providers instantly
* Continue conversations regardless of provider
* Work completely offline using local models

---

# Success Criteria

By the end of Phase 2, OpenVerse should provide a seamless AI chat experience where the underlying inference provider is abstracted away from the user.

Whether a response comes from OpenRouter, Ollama, or LM Studio, the interface, workflows, and user experience should remain consistent, establishing the foundation for future multimodal capabilities and additional providers.
