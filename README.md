# 🩺 Sukari — Daily Diabetes Management App

> *"Sukari"* — inspired by the Arabic word for diabetes (سكري), symbolizing our focus on blood sugar management and supporting individuals living with diabetes.

A cross-platform mobile application built with **Flutter + Flask + MySQL** that helps diabetic patients track their health daily while connecting them with their doctors.

**End-of-studies project — M'hamed Bougara University, Boumerdés | Academic Year 2024-2025**

---

## ✨ Features

### 👤 Patient Interface
- 🔐 Secure account creation and login (patient / doctor roles)
- 🩸 Blood glucose logging and monitoring with charts and trends
- 🍽️ Meal tracking with calorie and carb calculation
- 💊 Medication and insulin intake tracking
- ⏰ Reminders for medication, meals, blood sugar checks
- 🚨 Emergency alerts for abnormal glucose levels with location sharing
- 📍 Find doctors near me
- 💬 Secure messaging with assigned doctor
- 🏆 Health challenges participation
- 🤰 Pregnancy progress tracking (gestational diabetes)
- 📊 Health data visualization with interactive charts
- 📞 Emergency contact management

### 🩺 Doctor Interface
- 👨‍⚕️ Professional profile creation with verification
- 📋 Patient file management
- 📅 Appointment scheduling and management
- 🔔 Real-time alerts and notifications
- 📝 Medical guidance and prescription issuance
- 📚 Post educational health articles
- ❓ Patient FAQ answering
- 🏆 Create health challenges for patients

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| Backend | Python (Flask) |
| Database | MySQL |
| API | RESTful API (HTTP: GET, POST, PUT, DELETE) |
| IDE | Visual Studio Code |
| Version Control | GitHub |
| Target Platforms | Android & iOS |

---

## 📁 Project Structure

```
sukari/
├── frontend/                  ← Flutter mobile app (Dart)
│   ├── lib/
│   │   ├── screens/           ← UI screens (login, dashboard, glucose, meals...)
│   │   ├── widgets/           ← Reusable UI components
│   │   ├── models/            ← Data models
│   │   ├── services/          ← API calls and business logic
│   │   └── main.dart          ← App entry point
│   └── pubspec.yaml           ← Flutter dependencies
│
├── backend/                   ← Flask Python API
│   ├── app.py                 ← Main Flask application
│   ├── routes/                ← API endpoints
│   ├── models/                ← Database models
│   └── requirements.txt       ← Python dependencies
│
├── database/
│   └── schema.sql             ← MySQL database schema
│
├── rapport_pfe.pdf            ← Full PFE dissertation
└── README.md
```

---

## 🗄️ Database Schema (Key Tables)

```sql
-- Users / Accounts
accounts, patients, doctors

-- Health tracking
blood_glucose_records, meals, medications, physical_activity

-- Communication
messages, contacts, notifications, appointments

-- Features
challenges, articles, prescriptions, prescriptions_medical
```

---

## 🚀 How to Run Locally

### Prerequisites
- **Flutter SDK** — [flutter.dev](https://flutter.dev/docs/get-started/install)
- **Python 3.10+** — [python.org](https://python.org)
- **MySQL** — via XAMPP or standalone
- **VS Code** with Flutter + Dart extensions

---

### Step 1 — Clone the repo
```bash
git clone https://github.com/Sarahsser/sukari-diabetes-app.git
cd sukari-diabetes-app
```

---

### Step 2 — Set up the database
1. Start MySQL (via XAMPP or standalone)
2. Open phpMyAdmin or MySQL Workbench
3. Create a database called `sukari_db`
4. Run the schema:
```bash
mysql -u root -p sukari_db < database/schema.sql
```

---

### Step 3 — Set up the backend (Flask)
```bash
cd backend
pip install -r requirements.txt
```

Create a `.env` file in `backend/` with your DB credentials:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=sukari_db
SECRET_KEY=your_secret_key
```

Run the Flask server:
```bash
python app.py
```
The API will be available at `http://localhost:5000`

---

### Step 4 — Set up the frontend (Flutter)
```bash
cd frontend
flutter pub get
```

Update the API base URL in `lib/services/api_service.dart`:
```dart
const String baseUrl = 'http://YOUR_LOCAL_IP:5000';
```
> Use your machine's local IP (e.g. `192.168.1.x`), not `localhost`, so the phone can reach the server.

Run the app:
```bash
flutter run
```

Or open in VS Code → press **F5** with an emulator or physical device connected.

---

### Step 5 — Test with a demo account

After the DB is set up, register as a **Patient** or **Doctor** directly from the app's sign-up screen.

---

## 👥 Team

| Name | Role |
|---|---|
| BAGHDALI Rihem | Developer |
| BOUSSAHA Nihel | Developer |
| DJARI Sarah Serine | Developer |
| SERAF Mohammed | Developer |

**Supervised by:** Miss BOUGHANEM Hadjer  
**University:** M'hamed Bougara University — Boumerdés, Faculty of Sciences  
**Speciality:** Information Systems and Software Engineering  

---

## 🎬 Demo

[![Sukari App Presentation](https://img.youtube.com/vi/6Z6zDW6rgns/maxresdefault.jpg)](https://youtu.be/6Z6zDW6rgns))


---

## 📄 Report

> 📄 [Read the full PFE report](./Rapport_Projet_Sukari.pdf)

---

## 👩‍💻 Author's GitHub

**Sarah** — [@Sarahsser](https://github.com/Sarahsser)
