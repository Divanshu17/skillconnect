# 🛠️ SkillConnect: On-Demand Service Marketplace

**Connecting skilled professionals with clients in real-time**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.19-blue)](https://flutter.dev)
[![Dart SDK](https://img.shields.io/badge/Dart-3.3-blue)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-11.6.0-orange)](https://firebase.google.com)  
[![Play Store](https://img.shields.io/badge/Google_Play-COMING_SOON-green)](https://play.google.com)
[![App Store](https://img.shields.io/badge/App_Store-COMING_SOON-blue)](https://www.apple.com/app-store/)

---

## 🌟 Overview

**SkillConnect** is a real-time, location-based service marketplace that connects skilled professionals with clients needing their services — think **TaskRabbit meets Uber**.

### 🎯 Target Users
- 👨‍🔧 Skilled professionals (electricians, plumbers, tutors, etc.)
- 🏠 Homeowners & businesses
- 🚀 Gig economy workers

### 🔑 Key Highlights
- ✅ Real-time provider tracking
- ✅ In-app chat with media sharing
- ✅ Secure escrow payments
- ✅ AI-powered service matching

---

## 🚀 Features

<details>
<summary><strong>🔐 Authentication & User Management</strong></summary>

- Firebase Authentication (Email, Phone, Google)
- Multi-role system: Client / Provider / Admin
- Profile verification (ID, Certificates)
- Account recovery
- Role-based access control

</details>

<details>
<summary><strong>📍 Location & Mapping</strong></summary>

- Google Maps SDK integration
- Real-time tracking
- Geofencing support
- Address autocomplete
- Distance-based pricing

</details>

<details>
<summary><strong>👨‍💼 Service Provider Tools</strong></summary>

- Service portfolio management
- Calendar for availability
- Booking management
- Earnings dashboard
- Performance metrics

</details>

<details>
<summary><strong>👤 Client Features</strong></summary>

- Service search with filters
- Instant bookings
- Booking history
- Save favorite providers
- Emergency toggle

</details>

<details>
<summary><strong>💬 Messaging & Notifications</strong></summary>

- Real-time chat
- Push & in-app notifications
- Media sharing (images, documents)
- Chat history

</details>

<details>
<summary><strong>💳 Payments</strong></summary>

- Stripe Connect integration
- Escrow-based system
- Multi-currency support
- Invoice generation
- Payout scheduling

</details>

<details>
<summary><strong>⭐ Ratings & Reviews</strong></summary>

- Two-way rating system
- Detailed review forms
- Moderation support
- Provider badges & rewards
- Analytics for reviews

</details>

---

## 🛠️ Tech Stack

| Component         | Technology              | Version  |
|------------------|--------------------------|----------|
| Framework         | Flutter                  | 3.19     |
| Language          | Dart                     | 3.3      |
| Backend           | Firebase                 | 11.6.0   |
| Database          | Firestore                | 4.8.0    |
| Auth              | Firebase Auth            | 4.6.0    |
| Storage           | Firebase Storage         | 12.0.0   |
| Maps              | Google Maps SDK          | 6.2.0    |
| State Management  | Provider                 | 6.1.1    |
| Analytics         | Firebase Analytics       | 11.6.0   |

### 🧱 UI Components
- Custom Design System
- Material 3 Widgets
- Responsive Layout Builder
- Dark/Light Mode support
- Animated transitions

---

## 🧑‍💻 Installation

### 📦 Prerequisites

- Flutter SDK >= 3.19
- Dart >= 3.3
- Android Studio / Xcode
- Firebase Project with API keys

### ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/Divanshu17/skillconnect.git
   cd skillconnect
2. Install Flutter dependencies
bash
Copy
Edit
flutter pub get

3. Set up Firebase
You must set up Firebase manually for both Android and iOS.

Go to Firebase Console

Create a new project

Register your Android app (e.g., com.example.skillconnect)

Download the google-services.json file and place it in:

bash
Copy
Edit
android/app/google-services.json
