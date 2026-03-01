# SmellSense - AI Coding Instructions

## Project Overview

Flutter mobile app (iOS/Android) for **smell training therapy** - helping users recover their sense of smell through timed training sessions with progress tracking.

**App Identity:**

- Application ID: `za.co.smellsense`
- Display Name: "SmellSense"
- Version: 1.1.0+10
- Database: `smellsense_database.db` (Floor/SQLite, version 1, no migrations)
- Theme: Light only (Material 3), no dark mode
- Localization: `en-US` only (`easy_localization` with JSON files)
- ID Generation: UUID v4 for all entity primary keys

## Architecture

### Layer Structure

```
lib/app/
├── application/providers/    # Infrastructure & app-level providers
├── assets/                   # Static data (supported scents JSON)
├── db/                       # Floor database (entities, DAOs, services)
├── pages/                    # Screen routes (each with .route.dart)
├── router/                   # go_router with typed routes
└── shared/                   # Modules, theme, utils, widgets
```

### Key Patterns

**Infrastructure Provider** (`lib/app/application/providers/infrastructure.provider.dart`)

- Bootstraps `DatabaseService` and `SupportedTrainingScentProvider`
- Access via `Infrastructure.of(context)` or `context.read<Infrastructure>()`

**Database Layer (Floor ORM)**

- Entities in `lib/app/db/entities/` with `@Entity` annotations
- DAOs in `lib/app/db/daos/` - query definitions
- Services in `lib/app/db/services/` - business logic wrapping DAOs
- **After modifying entities/DAOs**: Run `./scripts/generate_db.sh`

**Routing (go_router with code generation)**

- Routes defined in `lib/app/router/router_route_data.dart` using `@TypedGoRoute`
- Each page has a `.route.dart` file defining its `RouteData` class
- Shell routes: `SimpleShellPageRouteData` (no nav bar), `NavBarShellPageRouteData` (with nav bar)

**Domain Modules** (`lib/app/shared/modules/`)

- `TrainingScent` - scent enum with 14 supported scents (max 4 per training period)
- `TrainingPeriod`, `TrainingSession`, `TrainingSessionEntry` - core domain objects

**Persistent Storage (SharedPreferences)**

- Key: `hasScentsSelected` (boolean) - read on splash to determine if user should be redirected to scent selection
- **Known bug:** This key is never written to `true` after scent selection, so redirect always occurs

## Database Architecture

### Schema (Floor ORM / SQLite)

```
┌─────────────────────┐
│  training_period    │
├─────────────────────┤
│ id (PK, String)     │
│ start_date (DateTime)│
└─────────┬───────────┘
          │ 1:N
          ▼
┌─────────────────────┐     ┌─────────────────────┐
│  training_session   │     │   training_scent    │
├─────────────────────┤     ├─────────────────────┤
│ id (PK, String)     │     │ id (PK, String)     │
│ period_id (FK)      │     │ period_id (FK)      │
│ date (DateTime)     │     │ supported_scent_id  │
└─────────┬───────────┘     └─────────────────────┘
          │ 1:N                       │
          ▼                           │
┌─────────────────────────────────────┘
│  training_session_entry   │
├───────────────────────────┤
│ id (PK, String)           │
│ session_id (FK)           │
│ scent_id (FK)             │
│ rating (int, 1-5)         │
│ parosmia_reaction (int?)  │
│ parosmia_reaction_severity│
│ comment (String?)         │
└───────────────────────────┘
```

### Data Flow Layers

```
Page (UI) → Infrastructure.of(context) → DatabaseService → *Service → *Dao → Entity
```

**Entities** (`lib/app/db/entities/`) - Floor `@Entity` annotated classes mapping to SQLite tables. Use `@primaryKey`, `@ColumnInfo`, `@ForeignKey` annotations.

**DAOs** (`lib/app/db/daos/`) - Abstract classes with `@dao` annotation. Define queries with `@Query`, `@insert`, `@update`, `@delete`. Example:

```dart
@Query('SELECT id, period_id, date FROM training_session WHERE period_id = :periodId')
Future<List<TrainingSessionEntity>> findTrainingSessionsByPeriodId(String periodId);
```

**Services** (`lib/app/db/services/`) - Business logic layer wrapping DAOs. Services convert between Entity ↔ Module (domain model). Each service receives `SmellSenseDatabase` and dependent services via constructor injection.

**DatabaseService** - Facade aggregating all services. Provides high-level operations: `createTrainingPeriod()`, `recordTrainingSession()`, `getActiveTrainingScents()`, `getTrainingPeriods()`.

### Date Handling

- All dates use `DateFormat("yMMMEd")` for display (e.g., "Sat, Mar 1, 2026")
- `getDateOnly()` strips time components — used by DB type converter and domain model construction
- All stored dates are date-only (time zeroed to 00:00:00)

### Supported Scents (Static Data)

- Loaded from `assets/data/supported_scents.json` via `@JsonLiteral`
- `SupportedTrainingScentProvider` provides lookup by ID or name
- Links `training_scent.supported_scent_id` to static scent metadata (name, color, image)
- 14 scents total: Chamomile, Cinnamon, Citronella, Clove, Eucalyptus, Garlic, Grapefruit, Lavender, Lemon, Mint, Orange, Rose, Rosemary, Tea Tree

### Consumer Pattern (Pages)

Pages access data through `FutureBuilder` with `Infrastructure.of(context).databaseService`:

```dart
// Example from training_session.page.dart
FutureBuilder(
  future: Infrastructure.of(context).databaseService.getActiveTrainingScents(),
  builder: (context, AsyncSnapshot<List<TrainingScent>> snapshot) {
    // Handle loading, error, and data states
  },
)
```

### Error Handling

Services throw `SmellSenseDatabaseException` with detailed messages including stack traces. Use `StringBuilder` for formatted error messages.

## Navigation

### Bottom Navigation Bar (3 tabs, empty labels)

| Index | Icon          | Route                       |
| ----- | ------------- | --------------------------- |
| 0     | Home          | `/training-session-history` |
| 1     | Question mark | `/help`                     |
| 2     | Info          | `/about`                    |

Tab selection navigates via the router. Current tab is determined by URL path matching.

## Build Commands

```bash
# Full rebuild (clean, deps, icons, DB codegen)
./scripts/build.sh

# Generate Floor database files only
./scripts/generate_db.sh

# Apply Dart fixes
./scripts/fix.sh

# Run tests
flutter test
```

## Conventions

- **Localization**: Uses `easy_localization` with JSON files in `assets/i18n/`
- **State Management**: `Provider` package at app level
- **Theming**: `MaterialTheme.of(context)` for consistent styling
- **Assets**: Registered in `pubspec.yaml`, images at `assets/images/{category}/`
- **Test Structure**: Mirrors `lib/` under `test/app/` (e.g., `test/app/db/services/`)
- **IDs**: All entity IDs are UUID v4 strings

## Known Issues

1. **Midnight bug**: Training sessions crossing midnight may break history
2. **`hasScentsSelected` never written**: Splash redirect always triggers scent selection
3. **Stepper bug**: `onStepContinue` condition `_index <= 0` prevents advancing past step 1
4. **Garlic image**: `supported_scents.json` points garlic to `grapefruit.png`
5. **About page URLs**: `Uri(path:)` won't correctly launch HTTPS URLs — should use `Uri.parse()`
6. **i18n typos**: Keys use `"parsomia"` instead of `"parosmia"`; some code uses `"screens."` prefix instead of `"pages."`
7. **History chart**: `TrainingSessionHistoryChartWidget` is mostly commented out/stubbed

## Comprehensive Documentation

For detailed porting documentation including full UI specifications, complete localization reference, scent data, help/about page content, and all interaction flows, see `PROJECT.md`.

## Future Considerations (from TODO.md)

- Migration from `easy_localization` to `intl` with `.arb` files planned
- Injectable package for DI autowiring under consideration

## Project Status

⚠️ **Work in Progress**: This repository is currently incomplete and untested. It may contain runtime, architectural, or programmatic errors. The existing architecture represents the intended design direction for future iteration.
