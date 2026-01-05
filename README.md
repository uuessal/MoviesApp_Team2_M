# 🎬 Movieisme App

## App Statement
Movieisme is an iOS application designed for movie lovers to explore movie details, view cast and directors, read and write reviews, and save favorite movies. The app allows users to interact with movie data and share their opinions.

---

## 📱 Platform & Technologies
- iOS
- SwiftUI
- MVVM Architecture
- URLSession (async/await)
- Airtable REST API

---

## 🏗 Architecture (MVVM)
The project follows the MVVM architecture to ensure separation of concerns:

- **Models:** Handle app data such as Movies, Actors, Directors, Reviews, Users, and Saved Movies.
- **Views:** SwiftUI views responsible for UI presentation.
- **ViewModels:** Manage business logic, API calls, and state updates.
- **Networking:** Centralized API handling using a reusable APIClient.

---

## 🌐 API Integration
The app integrates with the Airtable REST API using a centralized networking layer.

### APIClient Features
- GET requests
- POST requests
- PUT requests
- DELETE requests
- JSON encoding/decoding
- Authorization using Bearer Token

---

## 🔁 CRUD Operations

### Create
- Add a movie review
- Save a movie to favorites

**API Endpoints:**
- POST `/reviews`
- POST `/saved_movies`

---

### Read
- Fetch movies list
- Fetch movie details
- Fetch actors, directors, and reviews
- Fetch user profile data

**API Endpoints:**
- GET `/movies`
- GET `/movies/{id}`
- GET `/actors`
- GET `/directors`
- GET `/reviews`
- GET `/users`

---

### Update
- Update user profile information
- Update saved movies list

**API Endpoints:**
- PUT `/users/{id}`
- PUT `/saved_movies/{id}`

---

### Delete
- Delete a movie review

**API Endpoints:**
- DELETE `/reviews/{id}`

---

## 🚨 Error Handling & User Feedback
- Loading indicators during API calls
- Error messages displayed when requests fail
- Success alerts for actions such as deleting reviews or updating profiles

---

## 🔐 Security
- API keys are stored securely using `.xcconfig` files
- Sensitive information is not hardcoded in the project

---

## ▶️ How to Run the Project
1. Clone the repository
2. Open the project in Xcode
3. Add your Airtable API Key to `Secret.xcconfig`
4. Run the app on an iOS Simulator or real device

---

## 👥 Team 2

Lojaen Jehad Ayash
Wessal Hashim Alharbi
Shahd Hassan Muharraq 
