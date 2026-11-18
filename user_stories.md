# User Stories — Habitt Habit Tracker

This document contains the user stories for the **Habitt** habit tracking app, developed as part of the **IBM iOS and Android Mobile App Developer Professional Certificate** capstone project.

Each user story follows the standard template:

> _As a [user role], I want [feature/goal], so that [reason]._

---

## 1. Account Registration

**As a user**, I want to register with my name, username, email, age, and country so that I can create an account and access the habit tracking features.

**Acceptance Criteria:**
1. Registration form contains fields: Name, Username, Email, Password, Age, Country.
2. All fields are validated (email format, password min 6 chars, age 10-100).
3. User can select prebuilt habits during registration.
4. On success, user is redirected to login screen with success message.
5. On failure (duplicate username/email), user sees an error message.

**Priority:** High  
**Story Points:** 5

---

## 2. Account Login

**As a user**, I want to log in using my email and password so that I can access my account and track my habits.

**Acceptance Criteria:**
1. Login form contains Email and Password fields.
2. Email is validated for format.
3. Password is validated (min 6 chars).
4. On success, user is redirected to Home screen.
5. Session is persisted — user stays logged in after app restart.

**Priority:** High  
**Story Points:** 3

---

## 3. Error Feedback on Login

**As a user**, I want to receive a message if I enter the wrong email or password so that I know my login attempt was unsuccessful.

**Acceptance Criteria:**
1. If email not found, show: "No account found. Please register first."
2. If password wrong, show: "Invalid email or password."
3. Error shown as a snackbar with red background.
4. Form remains filled so user can correct the mistake.

**Priority:** High  
**Story Points:** 2

---

## 4. View Welcome Message

**As a user**, I want to see a personalized welcome message with my name on the homepage so that I feel recognized and can confirm I am logged into the correct account.

**Acceptance Criteria:**
1. Home screen AppBar displays the logged-in user's name.
2. Name updates immediately after profile edit.
3. If no name set, fallback to "User".

**Priority:** High  
**Story Points:** 2

---

## 5. Track Daily Habits

**As a user**, I want to see my daily progress for each habit on the homepage so that I can easily monitor my progress.

**Acceptance Criteria:**
1. Home screen shows two sections: "To Do" and "Done".
2. Each habit is displayed as a colored card with its name.
3. Swipe left on a To Do habit marks it as done and moves it to Done.
4. Swipe right on a Done habit undoes it and moves it back to To Do.
5. Empty state shown when no habits exist.

**Priority:** High  
**Story Points:** 8

---

## 6. Add and Delete Habits

**As a user**, I want to add new habits and delete existing ones so that I can manage and update my habits as needed.

**Acceptance Criteria:**
1. FAB (+) on Home opens Configure Habits screen.
2. User can enter habit name and select a color.
3. "Add Habit" button creates the habit and shows it in the list.
4. Trash icon on each habit opens a confirmation dialog.
5. Confirming delete removes the habit from list and Home.

**Priority:** High  
**Story Points:** 5

---

## 7. View and Edit Personal Information

**As a user**, I want to view and update my name, username, email, age, and country on my profile page so that I can keep my information up to date.

**Acceptance Criteria:**
1. Personal Info screen shows current user data.
2. All fields are editable (name, username, email, age slider, country dropdown).
3. "Save Changes" button persists changes to local storage.
4. Updated name appears immediately in Home AppBar.
5. Duplicate username/email validation on save.

**Priority:** High  
**Story Points:** 5

---

## 8. View Weekly Report

**As a user**, I want to see a report of my weekly habit progress so that I can understand how well I am maintaining my habits.

**Acceptance Criteria:**
1. Report screen shows a matrix: habits (rows) × days Mon–Sun (columns).
2. Completed days show green check icon.
3. Incomplete days show red X icon.
4. Report reflects real-time data from habit history.
5. Empty state shown if no habits exist.

**Priority:** Medium  
**Story Points:** 5

---

## 9. Configure Notifications

**As a user**, I want to enable or disable notifications and select which habits and times to be reminded about, so that I get timely reminders throughout the day.

**Acceptance Criteria:**
1. Toggle switch to enable/disable all notifications.
2. Chips to select specific habits for notifications.
3. Chips to select times: Morning, Afternoon, Evening.
4. "Send Test Notification" button triggers a local notification immediately.
5. Settings persist across app restarts.

**Priority:** Medium  
**Story Points:** 8

---

## Summary

| # | User Story | Priority | Story Points |
| :--- | :--- | :--- | :--- |
| 1 | Account Registration | High | 5 |
| 2 | Account Login | High | 3 |
| 3 | Error Feedback on Login | High | 2 |
| 4 | View Welcome Message | High | 2 |
| 5 | Track Daily Habits | High | 8 |
| 6 | Add and Delete Habits | High | 5 |
| 7 | View and Edit Personal Info | High | 5 |
| 8 | View Weekly Report | Medium | 5 |
| 9 | Configure Notifications | Medium | 8 |
| **Total** | | | **43** |

---

## Notes

- **Sign Out** feature is covered implicitly in the authentication flow (menu → sign out → return to login).
- **Email field** is added to registration and login to meet industry best practices for user identification.
- All stories are implemented in the current app version.
