# 💰 Finance Manager / Expense Tracker (iOS)

A modern fintech-style **Expense Tracker iOS application** built using **Swift (UIKit)** with **MVVM architecture**, designed to manage personal finances with clean UI, smooth UX, and real-world app behavior.

---

## 🚀 Features

### 🔐 Authentication Module
- Sign In / Sign Up flow
- Field validations (email, password, confirm password)
- Password rules (minimum 8 characters)
- Toggle between Sign In & Sign Up
- Show/Hide password functionality (eye icon)
- Session management (auto logout after 30 minutes of inactivity)
- Persistent login state (user remains logged in after app restart until session expires)
- User data stored locally (UserDefaults)

---

### 👤 Profile Module

* Preview & Edit profile sections
* Toggle between Preview and Edit views
* Update user details (name, email)
* Dynamic UI updates after saving
* Attributed labels (e.g., **Total Spendings: $2000** with styling)
* Input validation with error handling
* Reset form after submission

---

### 🏠 Home Dashboard

* Dynamic greeting (e.g., *Hey, Raghavendra*)
* Gradient-based finance card (custom UIView)
* Card updates dynamically based on user data
* Weekly / Monthly toggle (custom segmented UI)
* Expense list using UITableView
* Smooth scroll with ScrollView integration
* TableView inside ScrollView (height handled dynamically)

---

### 💳 Add Transaction Module

* Add Income / Expense toggle (custom buttons)
* Fields:

  * Category
  * Amount
  * Date
  * Notes
* Real-time amount formatting (e.g., `$1000`, `$10,000`)
* Number pad input for amount
* Validation before submission
* Data passed back using NotificationCenter
* Updates Home screen instantly

---

### 📊 Expense Management

* Default weekly & monthly data
* User-added expenses stored separately
* Merged display (default + user data)
* Weekly / Monthly filtering logic
* MVVM-based data handling
* Dynamic table updates

---

### 💱 Currency Module

* Available currencies list
* Enable/Disable currencies
* Custom UI cards with gradients & inner shadows
* MVVM implementation for currencies

---

### 📈 Credit Score (CIBIL)

* Custom circular progress (CAShapeLayer)
* Random score generation on button click
* “Check CIBIL” button with cooldown logic
* Simulated real-world behavior (time-based restriction)

---

### 🎨 UI/UX Highlights

* Gradient-based cards & backgrounds
* Dark theme fintech UI
* Custom reusable components
* Inner shadows & glow effects
* Smooth animations & transitions
* Keyboard handling for forms
* Responsive AutoLayout design

---

## 🧠 Architecture

* MVVM (Model-View-ViewModel)
* Clean separation of concerns
* ViewModels handle business logic
* ViewControllers handle UI
* NotificationCenter for screen communication

---

## 💾 Data Handling

* Local storage using UserDefaults
* Session tracking with login timestamp
* Auto logout after session expiry
* In-memory data handling for transactions

---

## ⚙️ Setup Instructions

1. Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/Expense-Tracker-iOS.git
```

2. Open project in Xcode

3. Run on simulator or real device

---

## 📱 Screenshots

### 🔹 Authentication (Sign In / Sign Up)

<img width="326" height="643" alt="Screenshot 2026-04-09 at 9 24 05 PM" src="https://github.com/user-attachments/assets/b8d60e20-0f65-45de-8538-7d3589464471" />
<img width="328" height="642" alt="Screenshot 2026-04-09 at 9 24 56 PM" src="https://github.com/user-attachments/assets/b1376830-9b08-4520-b3a5-215fbf548804" />


### 🔹 Home Dashboard

<img width="331" height="650" alt="Screenshot 2026-04-09 at 9 03 05 PM" src="https://github.com/user-attachments/assets/aad23d71-17a1-4680-912b-1aa8ee6b5d15" />
<img width="320" height="673" alt="Screenshot 2026-04-09 at 9 17 19 PM" src="https://github.com/user-attachments/assets/204093cd-27d0-46c7-a3eb-7f3725e61e85" />

### 🔹 Add Transaction

<img width="333" height="628" alt="Screenshot 2026-04-09 at 9 18 19 PM" src="https://github.com/user-attachments/assets/702f2b91-efe7-4547-a73b-8fc76ae7e74f" />


### 🔹 Profile (Preview & Edit)
<img width="331" height="636" alt="Screenshot 2026-04-09 at 9 19 11 PM" src="https://github.com/user-attachments/assets/ddf045fd-5654-466f-9778-048d739f2edc" />
<img width="330" height="639" alt="Screenshot 2026-04-09 at 9 19 42 PM" src="https://github.com/user-attachments/assets/3185144a-a8fb-441b-be35-89b162f907a1" />



### 🔹 Currency & Credit Score

<img width="330" height="639" alt="Screenshot 2026-04-09 at 9 19 42 PM" src="https://github.com/user-attachments/assets/f4d7f2b9-0524-4c8d-9177-9b644f80e423" />

---

## 🛠 Tech Stack

* Swift
* UIKit
* AutoLayout
* MVVM Architecture
* UserDefaults
* Core Animation (CAGradientLayer, CAShapeLayer)

---

## ✨ Key Highlights

* Real-time currency formatting while typing
* Dynamic UI updates across screens
* Clean MVVM structure
* Custom UI components (cards, toggles, shadows)
* Session-based authentication logic
* Fintech-style modern design

---

## 📦 Future Enhancements

* Charts & Graphs (Pie / Bar)
* CoreData / SQLite storage
* API integration
* Category icons & dropdown picker
* Multi-currency conversion

---

## 🎯 Assignment Submission

This project was developed as part of an assignment to demonstrate:

* UI/UX design skills
* Code structure & scalability
* Real-world app implementation
* Problem-solving ability

---
