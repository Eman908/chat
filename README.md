💬 Chatly - Real-Time Chat Application
📱 About The App
A Flutter-based Real-Time Chat Application built with Clean Architecture that allows users to authenticate, search for other users by email, create chats, and exchange messages in real-time. The app focuses on seamless real-time communication, user-friendly interface, and scalable Firebase integration.

✨ Features
🔐 Complete Authentication
Email/Password Registration & Login

Secure Firebase Authentication

Persistent login sessions

Profile management

👥 User Management
Search users by email address

Add new contacts

Prevent duplicate chat creation

Current user validation

💬 Real-Time Chat
Create instant chats with users

Send and receive messages in real-time

Message timestamp display

Online/Offline status (coming soon)

📱 Chat Interface
Chat bubbles with sender/receiver distinction

Message timestamps with AM/PM format

Scroll to latest messages

Message input with emoji support

🎨 Theme Management
Light/Dark theme switching

System theme detection

Consistent design language

📦 Packages Used
firebase_core - Firebase integration

firebase_auth - Authentication

cloud_firestore - Real-time database

flutter_bloc - State management

injectable - Dependency injection

get_it - Service locator

shared_preferences - Local storage

intl - Date/time formatting

emoji_picker_flutter - Emoji keyboard

provider - Theme management

🧠 Architecture & State Management
Clean Architecture
Data Layer (Repositories, Firebase Services, Models)

Domain Layer (Entities, Use Cases, Repository Interfaces)

Presentation Layer (UI, Cubits, Widgets)

State Management
Cubit for predictable state handling

Reactive streams for real-time updates

Separation of business logic and UI

Dependency Injection
Injectable for modular and testable structure

Service locator pattern with GetIt

Easy mocking for testing

Firebase Integration
Firestore for real-time data sync

Firebase Auth for authentication

Document references with type safety

🛠️ Tech Stack
Flutter & Dart - Cross-platform development

Firebase - Backend-as-a-Service

Cubit - State Management

Clean Architecture - Scalable code structure

Firestore - Real-time database

Dependency Injection - Injectable & GetIt

Material Design 3 - Modern UI components

📸 App Screenshots
<table> <tr> <td><img src="https://github.com/user-attachments/assets/5ff0fee6-f843-4a8e-bdfc-58b65365b3f0" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/96ea76ea-f8d3-4faf-8783-ba1eb8091b1e" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/b8c3d648-bfde-4646-a7db-4e5c26a700b2" width="200" /></td> </tr> <tr> <td><img src="https://github.com/user-attachments/assets/fa961403-c758-4c86-834c-f3ab2ed64f5a" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/2a17c4c7-2ef5-493f-9572-9d2ec78d4ef0" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/bebeaa29-6711-4833-997c-e66e7ecd6717" width="200" /></td> </tr> <tr> <td><img src="https://github.com/user-attachments/assets/b848ffb2-f426-49a7-8ea6-05bf8422b131" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/b3b4b684-985b-4c41-a660-0f18a95f662d" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/b6956d7f-f5e8-4f4e-9f6d-cffdae276d89" width="200" /></td> </tr> <tr> <td><img src="https://github.com/user-attachments/assets/df70c8ba-58cc-4789-84e8-7b78b83811d0" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/1f430af6-df37-4b53-b2fe-197702f4391e" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/dd6b5f25-8570-4ecf-a929-3b3464fb0a3d" width="200" /></td> </tr> </table>
📱 App Screens
Login/Register - Secure authentication

Home - Chat list with contacts

Chat - Real-time messaging interface

Add Contact - Search and add users by email

Settings - Theme customization

