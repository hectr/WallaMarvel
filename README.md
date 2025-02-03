# WallaMarvel ✨

## 🚀 New Features

The original version of WallaMarvel displayed only the first page of characters from the Marvel API.

The new version introduces two major features:

- **Hero Detail** – A dedicated character detail page.
- **Hero List Pagination** – The ability to load additional pages from the API.

The original codebase had significant technical debt (see the **Tech Debt in Original WallaMarvel** section), making iteration challenging. Instead of a complete rewrite, we incrementally refactored it to improve maintainability while developing new features — just as you would in a real-world application. All development was driven through pull requests [pull requests](https://github.com/hectr/WallaMarvel/pulls?q=is%3Apr+is%3Aclosed).

## 🛠️ Refactor Overview

### 1. Project Configuration

- Project is now generated with **Tuist** (`tuist generate`).
- Installation Methods:
    - Mise (pinned to `4.39.0`): `mise install tuist`
    - Homebrew: `brew install tuist`

### 2. Modularization

- **CocoaPods removed** – replaced with **Swift Package Manager** (SPM).
- **Contracts (Interfaces)** introduced to reduce module coupling.
    - So far, only `CoreDomain` has fully adopted this pattern.
- Four-layer architecture - **Core** ← **Domain** ← **Features** ← **Application**
- Layers follow the **Dependency Rules**.

**Dependency Rules**:

   - _Modules at the same level should not depend on each other_.
   - _A module should only depend on lower-level modules, never on higher-level ones_.

### 3. Navigation

- **Stateless `Navigator`** component - ensures testability and flexibility.
- `Navigator` enforces the **Linear Presentation Rules**: 
 
**Linear Presentation Rules**:

- _Last presented View Controller is the next presenter_.
- _If no View Controller has been presented, Root View Controller is the next presenter_.

**Example**:

```
(Root) View Controller¹ ──> Child View Controller
└──> (Modal) Tab Controller ──> First Tab Controller, Second Tab Controller, Third Tab Controller
    └──> (Modal) Some Navigation Controller ──> First Stacked Controller, Second Stacked Controller
        └──> (Modal) Another View Controller²
```
¹: _View Controller_ is the root view controller of the window.
²: _Another View Controller_ is the next presenter of the window.

### 4. Networking

- Replaced `APIClient` with a generic **HTTP client**.
- Endpoints can be **declaratively defined** now.

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

- Implemented **Redux-inspired** `LeanRedux` module for state management.
- Auto-generating `Actions` and `Reducers` with `@Feature` and `@Action` **macros**.

### 6. Hero List Refactor and Pagination

- **New Pagination logic** on top of existing feature - keeping original structure but reworking Repository & Data Source.
- **AutoLayout issues** and **memory leaks** resolved.
- **Unit tests** added.

### 7. Testing

- **Run tests with**: `tuist test --device 'iPhone 15' --os '18.0' --platform 'iOS' --no-selective-testing`
- **Mocks generated using Sourcery**: `Scripts/generate_mocks.sh`.
- **Views tested with SnapshotTesting**.

## ⚠️ Tech Debt in Original WallaMarvel

### 1. Memory-Management Issue
- Retain cycle in `ListHeroesViewController` & `ListHeroesPresenter`.
- Strong reference to UI not marked weak, causing leaks.
    
### 2. Networking Issues
- Unsafe decoding (`try! JSONDecoder().decode`).
- Forced unwraps in URL requests (`urlComponent!.url!`).
- No error handling for failed API calls.
    
### 3. Security Risks
- API keys hardcoded in the source code.
- Should be stored securely & injected at build time.
    
### 4. Navigation Issues
- Selecting a hero reloads the list screen instead of opening details.
- View controllers tightly coupled with navigation logic.

### 5. Single Responsibility Principle (SRP)
- `APIClient` does too much (request creation, hashing, decoding).
- `ListHeroesViewController` handles both UI & navigation.
    
### 6. Late Binding Issue
- `ListHeroesViewController` dependencies are not set in the initializer but later in `viewDidLoad`.

### 7. AutoLayout issues
- Constraints breaking in `ListHeroesTableViewCell`.
    
### 8. Lack of testing
- No unit tests.
