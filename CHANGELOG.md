# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2022-06-22

### Added

- List of superheroes.

## [2.0.0] - 2025-01-31

### Added

- WallaMarvelPackage.
- LeanRedux target.
- SnapshotTesting dependency.
- `onFirstAppear` view modifier.
- Kingfisher dependency to Swift package.
- Added mock generation script.
- Routing target.
- Navigator component.
- Hero Detail feature.

### Changed

- Bump Deployment Target to iOS 15.
- Bump Swift Language Version to 6.0.
- Modularization uses Contracts frameworks. 

### Removed

- Kingfisher dependency from Podfile.

### Fixed

- Kingfisher build [issue](https://github.com/onevcat/Kingfisher/issues/2052).
- Concurrency warnings.

## [2.0.0] - 2025-01-2

### Added

- `@Feature` and `@Action macros.
- HeroList pagination.
- HeroList unit tests.

### Fixed

- Mock generation (Layered Modules).

### Changed

- Module Layers: Core, Domain, Features.
- Merged Domain and Data modules into CoreDomain.
- Xcode project generated with Tuist.
- Snapshot Tests named after the recording device.

### Removed

- Hero Detail feature boilerplate.
- CocoaPods: Podfile, Podfile.lock, xcodeproj configuration.

## [Unreleased]

### Added

- README.md.
- PersistentStoreProtocol.swift.

### Fixed

- Removed `Dependencies` from .gitignore. 
