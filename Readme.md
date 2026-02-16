# Project Test Labamu — README

## Overview
A Flutter mobile app implementing a clean, maintainable Bloc-based architecture with offline-first behavior and clear trade-offs documented. This README covers the architecture, offline strategy, trade-offs, and instructions to run the app.

---

## Architecture (high level)
- Pattern: Layered/Clean architecture with Bloc for state management
    - Presentation: Flutter widgets, UI, routing
    - State management: flutter_bloc (Blocs/Cubits)
    - Domain: Use-cases / business logic (pure, testable)
    - Data: Repositories, data sources (remote API, local DB/cache), models and mappers
- Folder structure (recommended)
    - lib/
        - src/
            - presentation/ (widgets, pages, blocs/cubits)
            - domain/ (entities, usecases, repository interfaces)
            - data/ (models, datasources, repository implementations)
            - core/ (networking, errors, DI, utils)
            - main.dart
- Dependencies (suggested)
    - Networking: dio
    - Local persistence: hive (or sqflite for relational needs)
    - State: flutter_bloc, hydrated_bloc (optional for state persistence)
    - DI: get_it / injectable (optional)
    - Codegen: json_serializable, freezed (optional)

---

## Offline strategy
Goals: allow core functionality offline, minimize data loss, reconcile changes when online.

1. Local cache as source-of-truth
     - Persist API responses and entities in local DB (Hive/SQLite).
     - UI reads from local DB via Repositories; remote sync updates DB and emits Bloc state updates.

2. Read-first, sync-later
     - On app start: load from local DB immediately via Bloc initial state.
     - In background or on-demand: fetch remote updates and merge into local DB; Blocs react to DB changes.

3. Writes while offline
     - Queue mutations (create/update/delete) locally in a "pending_operations" store.
     - Optimistic updates: update local DB/UI immediately; mark record as pending sync.
     - Background sync worker drains queue when connectivity returns and reconciles results.

4. Conflict resolution
     - Default: server-assigned timestamps or last-write-wins.
     - For critical conflicts, surface resolution UI to user or implement domain-specific merge logic.

5. Connectivity detection
     - Use connectivity_plus to trigger syncs when network is restored.
     - Optionally schedule periodic background syncs for freshness.

6. Data pruning and size control
     - Implement TTL, LRU eviction, or manual pruning to avoid unbounded storage growth.

---

## Example data sync flow (brief)
1. User opens app -> Presentation asks ItemsBloc to load items.
2. ItemsBloc loads cached items from local DB and emits Loaded state.
3. ItemsBloc triggers background sync: repository.fetchRemoteItems()
    - If remote returns newer items, repository updates local DB and emits updates to Bloc.
4. User creates/edits an item while offline:
    - Repository writes change to local DB and appends a pending op to queue.
    - ItemsBloc emits optimistic state (shows change immediately).
5. Connectivity returns:
    - Sync worker reads pending ops, sends them to server, applies server response to local DB, clears successful ops, and emits final states via Blocs.
6. Errors:
    - If server rejects an optimistic change, repository reverts or updates local DB and Bloc emits error state to surface to user.

Minimal Bloc pseudocode (conceptual):
- Event: LoadItems -> Handler: emit(LocalLoading) -> load from DB -> emit(ItemsLoaded) -> start remote refresh -> on remote update write DB -> emit(ItemsLoaded)
- Event: AddItem -> Handler: write DB (optimistic), add pending op, emit(ItemsLoaded)

---

## Trade-offs
- Complexity vs simplicity
    - Offline-first with sync/queue increases complexity. If offline is rare, a simple cache may suffice.
- Consistency vs responsiveness
    - Optimistic updates improve UX but can cause temporary inconsistencies when server rejects changes.
- Storage choice
    - Hive: fast and simple; SQLite: better for complex relational queries.
- Battery and network use
    - Balance sync frequency with backoff, batching and user controls.
- Operational overhead
    - Background sync, crash recovery and testing require effort.

---

## How to run (local dev)
Prerequisites:
- Flutter SDK (stable channel)
- Android Studio / Xcode for emulators or devices

Basic steps:
1. git clone <repo-url> && cd project_test_labamu
2. flutter pub get
3. iOS: cd ios && pod install && cd ..
4. Codegen (if used): flutter pub run build_runner build --delete-conflicting-outputs
5. flutter run

Helpful:
- flutter analyze
- flutter test
- flutter pub outdated

Troubleshooting:
- flutter clean && flutter pub get
- iOS Pod issues: cd ios && pod repo update && pod install

---

## Tests & CI
- Unit tests: domain and data mappers
- Widget tests: core screens
- Integration/E2E: optional with integration_test
- CI: run flutter analyze and flutter test on each PR

---

If you want, I can add a small concrete Bloc + repository code example using dio + hive and a sample pending-operations schema.
