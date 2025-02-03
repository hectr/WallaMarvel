# WallaMarvel ✨

## 🚀 New Features

The original version of WallaMarvel displayed only the first page of characters from the Marvel API.

The new version introduces two major features:

- 🦸 **Hero Detail** – A dedicated character detail page.
- 🔄 **Hero List Pagination** – The ability to load additional pages from the API.

The original codebase had significant technical debt (see the [extensive list](#tech-debt-in-original-wallamarvel)), making iteration challenging. Instead of a complete rewrite, we incrementally refactored it to improve maintainability while developing new features—just as you would in a real-world application. All development was driven through pull requests [pull requests](https://github.com/hectr/WallaMarvel/pulls?q=is%3Apr+is%3Aclosed).

## 🛠️ Refactor Overview

### 1. Project Configuration

- The project is no longer tracked in Git and is instead generated using Tuist (`tuist generate`).
- Tuist can be installed via:
    - Mise (pinned to `4.39.0`): `mise install tuist`
    - Homebrew: `brew install tuist`

### 2. Modularization

- **CocoaPods** CocoaPods has been completely removed in favor of Swift Package Manager.
- The project is now modularized using **Swift Package Manager** (SPM).
- New modules are defined in `Package.swift`.
- Modules are integrated into the app via **Tuist**'s `Project.swift` (edited using `tuist edit`).
    - So far, only the test targets from `Package.swift` are replicated in `Project.swift`.
- The modularization follows **The Dependency Rule**:
    - _Modules at the same level should not depend on each other_.
    - _A module should only depend on lower-level modules, never on higher-level ones_.
- The codebase is structured into four layers (_dependencies always point inward_):
    - `Core` ← `Domain` ← `Features` ← `Application`
- To reduce module coupling, we introduced **Contracts modules**, which serve as interface definitions (protocols) that abstract dependencies between modules.
    - So far, only `CoreDomain` has fully adopted this pattern.

### 3. Navigation

- Navigation logic is now fully decoupled from the UI, improving testability and flexibility. We introduced a **stateless `Navigator` component** that enforces **Linear Presentation Rules**:
    - _Last presented View Controller is the next presenter_.
    - _If no View Controller has been presented, Root View Controller is the next presenter_.

**Linear Presentation example:**

```
(Root) View Controller¹ ──> Child View Controller
└──> (Modal) Tab Controller ──> First Tab Controller, Second Tab Controller, Third Tab Controller
     └──> (Modal) Some Navigation Controller ──> First Stacked Controller, Second Stacked Controller
           └──> (Modal) Another View Controller²
```

¹: _View Controller_ is the root view controller of the window.
²: _Another View Controller_ is the next presenter of the window.

### 4. Networking

- Replaced `APIClient` with a generic **HTTP client** (`Client` + `NetworkProvider`) that is agnostic of the **Marvel API**.
- The `v1/public/characters` API endpoint is now defined using a **declarative** interface (`Endpoint`).

### 5. Redux Architecture

 ```
                                      4. new STATE                     6. (optional) new ACTION
          ┌────────────────────────────────────────┐   ┌────────────────────────────────────────┐
          │                                        │   │                                        │
          ▽                                        │   ▽                                        │
  ┌───────────────┐  1. user ACTION          ┌─────┴─────────┐   5. new STATE + ACTION  ┌───────┴───────┐
  │      VIEW     ├─────────────────────────▷│     STORE     ├─────────────────────────▷│ MIDDLEWARE(S) ├─┐
  └───────────────┘                          └─────┬─────────┘                          └─┬─────────────┘ ├─┐
                                                   │    △                                 └─┬─────────────┘ ├─┐
                         2. current STATE + ACTION │    │ 3. new STATE                      └─┬─────────────┘ │
                                                   ▽    │                                     └───────────────┘
                                             ┌──────────┴────┐
                                             │    REDUCER    │
                                             └───────────────┘
 ```

- The **Hero Detail** feature was implemented using a Redux-inspired architecture (`LeanRedux` module).
- To reduce boilerplate, we implemented: `@Feature` and `@Action` macros.
    - These macros automatically generate the `Action` enum and the `reduce` method, reducing boilerplate and improving maintainability.

### 6. Hero List Refactor and Pagination

- Pagination for the **Hero List** feature follows the original architecture.
    - However, we reworked the *Repository* and *Remote Data Source* and moved the implementations to the `CoreDomain` module.
    - The UI is now covered with unit tests.
    - Additionally, we addressed AutoLayout issues and resolved retain cycles in the presentation layer.

### 7. Testing

- Running tests: `tuist test --device 'iPhone 15' --os '18.0' --platform 'iOS' --no-selective-testing`
- Mock objects are generated using **Sourcery**: `Scripts/generate_mocks.sh`.
- Snapshot tests use Point-Free's `SnapshotTesting` framework.

## ⚠️ Tech Debt in Original WallaMarvel

1. Memory-Management
    1.1 `ListHeroesViewController` holds a strong reference to `ListHeroesPresenterProtocol`. `ListHeroesPresenter` in turn holds a strong reference to `ListHeroesUI`, which points to the same view controller (`ListHeroesViewController`). Because neither of these references is marked weak, they form a retain cycle.
2. Networking
    2.1 `try! JSONDecoder().decode` in `APIClient` is unsafe. If decoding fails, the app will crash.
    2.2 Forced unwrap of urlComponent!.url! also leads to a crash if the URL is invalid.
    2.3 No error handling for network failures.
3. Security (API Keys in Code)
    3.1 Storing the `privateKey` and `publicKey` in source code is a serious security concern. These should be in a secure storage or, at the very least, injected at build time and obfuscated.
4. Navigation
    4.1 In `ListHeroesViewController.tableView(_:didSelectRowAt:)`, the code creates another `ListHeroesViewController`, then pushes it.
    4.2 Tight Coupling of View and Navigation in `ListHeroesViewController`
5. Single Responsibility Principle (SRP)
    5.1 `APIClient` is handling request creation, hashing, and raw decoding with no error handling or separation of concerns.
    5.2 `ListHeroesViewController` is both building the UI and controlling navigation.
6. Late Binding
    6.1 `ListHeroesViewController.listHeroesProvider` and `ListHeroesPresenter.ui` are not set on init, but on `ListHeroesViewController.viewDidAppear`.
7. AutoLayout issues
    7.1 `ListHeroesTableViewCell` constraints break on runtime.
8. Lack of testing
