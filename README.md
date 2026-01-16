<img width="393" height="841" alt="Onboarding Light" src="https://github.com/user-attachments/assets/b2204fb6-dd1b-4f13-8b78-9464536e42df" />💬 Chatly - Real-Time Chat Application
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
<table> <tr> <td><img src="https://github.com/user-attachments/assets/8418ffa2-d47b-4f47-9a13-dbda8e25052b" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/57c0d175-2ebd-4f49-b4e6-038e72c85591" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/8ef54a97-abb9-408a-9bca-80f70a9928eb" width="200" /></td> </tr> <tr> <td><img src="https://github.com/user-attachments/assets/44c4af98-2b43-4153-b3af-c52cd5419132" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/9d03016c-5771-453d-89fc-99f78817a697" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/ea8729ce-7994-4d56-97a7-e164d07b7f84" width="200" /></td> </tr> <tr> <td><img src="https://github.com/user-attachments/assets/9857dc11-3f77-472c-9a33-df80c6491ed7" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/7d480f2d-6f8f-4695-88e0-0f897f28a013" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/1a9984dd-8b20-4c80-ae66-1f3ea1b7c417" width="200" /></td> </tr> <tr> <td><img src="https://github.com/user-attachments/assets/0ad91eab-7550-4d58-b90f-b3294edd144e" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/9902da21-b888-439d-8025-923f167f0a05" width="200" /></td> <td><img src="https://github.com/user-attachments/assets/ee9e52ee-9588-44a0-b6e3-829e9354f8c5" width="200" /></td> </tr> </table>
📱 App Screens
Login/Register - Secure authentication

Home - Chat list with contacts

Chat - Real-time messaging interface

Add Contact - Search and add users by email

Settings - Theme customization

