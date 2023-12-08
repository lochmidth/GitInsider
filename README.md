<p align="center">
  <img src="GitInsider/Assets.xcassets/AppIcon.appiconset/1024.png" alt="GitInsider App Icon" width="150" height="150">
</p>

# GitInsider

GitInsider is a social app that leverages GitHub data to connect users, explore profiles, and discover repositories. With GitInsider, you can integrate your GitHub account, search for other users, view profiles, follow/unfollow them, and explore their repositories.

## Table of Contents
- [Features](#features)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
  - [Unit Tests](#unit-tests)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Authentication](#authentication)
  - [Search Users](#search-users)
  - [Profile Exploration](#profile-exploration)
  - [Following/Unfollowing Users](#followingunfollowing-users)
  - [Repository Browsing](#repository-browsing)
- [Contributing](#contributing)
- [License](#license)

## Features

- **GitHub OAuth 2.0 Integration:** Seamlessly log in to GitInsider using your GitHub credentials.
- **User Search:** Find and connect with other GitHub users.
- **Profile Exploration:** View detailed profiles of GitHub users.
- **Follow/Unfollow:** Stay updated with the activities of users you find interesting.
- **Repository Browsing:** Explore repositories owned by other GitHub users.

### Tech Stack

- **Xcode:** Version 14.3.1
- **Language:** Swift 5.8.1
- **Minimum iOS Version:** 16.4
- **Dependency Manager:** SPM

### Architecture

![Architecture](https://miro.medium.com/v2/resize:fit:566/1*VS4lOMnFpqEAOwTdDsk4mg.jpeg)

In developing GitInsider, I used the MVVM-C (Model-View-ViewModel-Coordinator) design pattern for these key reasons:

- **Clear Separation:** MVVM-C ensures a distinct separation of concerns, simplifying development with isolated layers for UI logic (ViewModel), business logic (Model), and navigation flow (Coordinator).
- **Test-Driven Development:** The pattern's modularity facilitates effective unit testing, enabling me to write comprehensive tests for each layer and ensure the app's stability.
- **Scalability:** MVVM-C offers scalability, allowing the seamless addition of new features and easy maintenance, promoting agility in code evolution.
- **Navigation Control:** The Coordinator element provides centralized navigation control, resulting in a well-organized and efficient navigation structure within the app.

### Unit Tests

**74.3 % Unit test covarage**

I focused on testing the Model layer, ViewModel logic, and Coordinator navigation flow. This approach ensures that each layer of the application functions as expected in isolation, contributing to a robust and well-tested codebase.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed
- Have an GitHub Account for OAuth credentials

Also, make sure that these dependencies are added in your project's target:

- [Moya](https://github.com/Moya/Moya): Network abstraction layer written in Swift.
- [Kingfisher](https://github.com/onevcat/Kingfisher): Powerful and pure Swift library for downloading and caching images.
- [KeychainSwift](https://github.com/evgenyneu/keychain-swift): Helper functions for saving text in the Keychain.
- [SkeletonView](https://github.com/Juanpe/SkeletonView): An elegant way to show users that something is happening in your app.

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/lochmidth/GitInsider.git
    ```

2. Open the project in Xcode:

    ```bash
    cd GitInsider
    open GitInsider.xcodeproj
    ```
3. Add required dependencies using Swift Package Manager:

   ```bash
   - Moya
   - Kingfisher
   - KeychainSwift
   - SkeletonView
    ```

6. Build and run the project.

## Usage

###  Authentication

1. Open the app on your simulator or device.
2. Click on "Sign in with GitHub" and authorize the app using your credentials.

<p align="left">
  <img src="https://i.imgur.com/y7JEWpN.gif" alt="Auth" width="200" height="400">
</p>

---

### Search Users

1. Use the search bar to find GitHub users.
2. Click on a user to view their profile.

<p align="left">
  <img src="https://i.imgur.com/iLTwwYi.gif" alt="Search" width="200" height="400">
</p>

---

### Profile Exploration

1. On a user's profile, explore their GitHub information.
2. View their repositories, followers, and following.

<p align="left">
  <img src="https://i.imgur.com/jYTb7uK.gif" alt="Profile" width="200" height="400">
</p>

---

### Following/Unfollowing Users

1. Click the "Follow" button on a user's profile to stay updated with their activities.
2. To unfollow, click the "Unfollow" button.

<p align="left">
  <img src="https://i.imgur.com/dwPowfW.gif" alt="Follow/Unfollow" width="200" height="400">
</p>

---

### Repository Browsing

1. Explore repositories owned by a user on their profile.
2. Click on a repository to view details.

<p align="left">
  <img src="https://i.imgur.com/G9nc9HF.gif" alt="Repo" width="200" height="400">
</p>

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change. Please make sure to update tests as appropiate.

## License

This project is licensed under the [MIT License](LICENSE).
