# SmellSense - Project Documentation

> **Note:** This repository is currently a work-in-progress and is incomplete. It may contain runtime, architectural, or programmatic errors. However, the general intent and structure of the existing architecture is established and documented here.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Purpose and Intent](#purpose-and-intent)
3. [Critical Features and Requirements](#critical-features-and-requirements)
4. [App Metadata and Platform Configuration](#app-metadata-and-platform-configuration)
5. [Project Framework and Architecture](#project-framework-and-architecture)
6. [Database Architecture](#database-architecture)
7. [Persistent Storage](#persistent-storage)
8. [Platform-Agnostic Data Models](#platform-agnostic-data-models)
9. [Complete Supported Scents Data](#complete-supported-scents-data)
10. [Application Models and Modules](#application-models-and-modules)
11. [UI Flows and Navigation](#ui-flows-and-navigation)
12. [User Interaction Specifications](#user-interaction-specifications)
13. [Visual Design Specifications](#visual-design-specifications)
14. [UI Components](#ui-components)
15. [Help Page Content](#help-page-content)
16. [About Page Content](#about-page-content)
17. [Bottom Navigation Bar](#bottom-navigation-bar)
18. [Date Formatting and Display](#date-formatting-and-display)
19. [Full Localization Reference](#full-localization-reference)
20. [Data Validation Rules](#data-validation-rules)
21. [Error Handling UX](#error-handling-ux)
22. [Training Session Entry Form Specification](#training-session-entry-form-specification)
23. [History Chart Specifications](#history-chart-specifications)
24. [Known Issues and Codebase Bugs](#known-issues-and-codebase-bugs)
25. [Future Considerations](#future-considerations)

---

## Project Overview

| Property        | Value                                           |
| --------------- | ----------------------------------------------- |
| **Name**        | SmellSense                                      |
| **Type**        | Mobile Application (iOS & Android)              |
| **Framework**   | Flutter 3.6.0+                                  |
| **Version**     | 1.1.0+10                                        |
| **Description** | A mobile application for smell training therapy |

SmellSense is a Flutter-based mobile application designed to aid users in recovering their sense of taste and smell through structured smell training therapy. The application leverages the brain's neuroplasticity to help users with anosmia (loss of smell) or parosmia (altered sense of smell) regain their olfactory senses.

---

## Purpose and Intent

### What is Smell Training?

Smell training is a scientifically proven method of regaining one's sense of smell by utilizing neuroplasticity - the brain's ability to form and reorganize synaptic connections in response to learning, experience, or following injury.

### Application Goals

SmellSense was designed to provide the following functionality:

1. **Facilitate Smell Training** - Guide users through structured smell training sessions as an aid to recovery for those suffering from anosmia or parosmia
2. **Timed Training Sessions** - Guide users through the smell training process with encouragements and precise timing
3. **Progress Tracking** - Maintain a comprehensive diary/record of training progress over time
4. **Educational Resources** - Provide users with resources to understand smell loss and recovery methods

### Training Protocol

In a typical smell training session:

- Users smell 4 familiar scents (traditionally Rose, Clove, Lemon, and Eucalyptus)
- Each scent is smelled for 15-30 seconds
- Users mindfully visualize and remember how each substance normally smells
- Sessions are repeated multiple times daily for optimal results
- Recovery typically occurs within 3 months of consistent training

---

## Critical Features and Requirements

### Core Features

| Feature               | Description                                                     |
| --------------------- | --------------------------------------------------------------- |
| **Scent Selection**   | Users select 4 training scents from 14 supported options        |
| **Training Sessions** | Timed sessions with encouragement prompts and progress tracking |
| **Rating System**     | 5-point scale for rating smell intensity (None → Strong)        |
| **Parosmia Tracking** | Record altered smell reactions with severity levels             |
| **Session History**   | Visual chart-based history of training progress                 |
| **Help & About**      | Educational content and contact information                     |

### Supported Scents (14 Total)

| Scent      | Display Color |
| ---------- | ------------- |
| Chamomile  | `#D48201`     |
| Cinnamon   | `#5D4037`     |
| Citronella | `#FFCB2E`     |
| Clove      | `#A1887F`     |
| Eucalyptus | `#4CAF50`     |
| Garlic     | `#8D6E63`     |
| Grapefruit | `#E57373`     |
| Lavender   | `#B39DDB`     |
| Lemon      | `#D4E157`     |
| Mint       | `#81C784`     |
| Orange     | `#FFB74D`     |
| Rose       | `#F48FB1`     |
| Rosemary   | `#9FA8DA`     |
| Tea Tree   | `#80DEEA`     |

---

## App Metadata and Platform Configuration

### Application Identity

| Property                 | Value                                     |
| ------------------------ | ----------------------------------------- |
| Application ID (Android) | `za.co.smellsense`                        |
| Bundle Name (iOS)        | `smellsense`                              |
| Display Name             | SmellSense                                |
| Version                  | 1.1.0+10 (version 1.1.0, build number 10) |
| Database File Name       | `smellsense_database.db`                  |
| Database Version         | 1 (no migrations)                         |

### Android Configuration

| Property    | Value                                  |
| ----------- | -------------------------------------- |
| Compile SDK | 35                                     |
| Min SDK     | 34                                     |
| Target SDK  | 35                                     |
| Permissions | None (no special permissions required) |

### iOS Configuration

| Property                        | Value                                                                                                                   |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Supported Orientations (iPhone) | Portrait, LandscapeLeft, LandscapeRight                                                                                 |
| Supported Orientations (iPad)   | Portrait, PortraitUpsideDown, LandscapeLeft, LandscapeRight                                                             |
| NSMicrophoneUsageDescription    | "SmellSense relies on third-party packages. It does not, in any capacity, for any reason, use the microphone directly." |
| ITSAppUsesNonExemptEncryption   | false                                                                                                                   |
| Locales in Info.plist           | `en`, `nb` (Norwegian Bokmål listed but no translation file exists)                                                     |
| Special Permissions             | None                                                                                                                    |

### Theme Mode

- **Light theme only** — no dark theme is implemented
- Brightness: `light`
- Agents porting this app should NOT implement dark mode unless specifically requested

### ID Generation

- All entity IDs (training periods, scents, sessions, entries) use **UUID v4** (random)
- Generated via the `uuid` package (`Uuid().v4()`)

---

## Project Framework and Architecture

### Technology Stack

| Component            | Technology         | Version    |
| -------------------- | ------------------ | ---------- |
| **Framework**        | Flutter            | ^3.6.0     |
| **Language**         | Dart               | SDK ^3.6.0 |
| **Database**         | Floor (SQLite ORM) | 1.5.0      |
| **Routing**          | go_router          | 14.6.0     |
| **State Management** | Provider           | 6.1.2      |
| **Localization**     | easy_localization  | 3.0.7      |
| **Charts**           | fl_chart           | 0.69.2     |
| **Fonts**            | google_fonts       | 6.2.1      |

### Third-Party Dependencies

#### Runtime Dependencies

```yaml
dependencies:
  flutter_localizations: sdk # Localizations support
  google_fonts: 6.2.1 # Google Fonts integration
  url_launcher: ^6.3.1 # URL launching
  flutter_widget_from_html: ^0.15.3 # HTML rendering
  fl_chart: ^0.69.2 # Charts and graphs
  floor: ^1.5.0 # SQLite ORM
  uuid: ^4.4.0 # UUID generation
  shared_preferences: ^2.3.3 # Local key-value storage
  go_router: ^14.6.0 # Declarative routing
  provider: ^6.1.2 # State management
  flutter_rating_bar: ^4.0.1 # Rating bar widget
  json_annotation: ^4.9.0 # JSON serialization
  sqflite: ^2.4.1 # SQLite database
  logger: ^2.5.0 # Logging utility
  intl: 0.19.0 # Internationalization
  easy_localization: ^3.0.7 # Localization helper
  easy_localization_loader: ^2.0.2 # JSON asset loader
```

#### Development Dependencies

````yaml
dev_dependencies:
  build_runner: ^2.1.11 # Code generation runner
  floor_generator: ^1.5.0 # Floor code generation
  flutter_gen_runner: ^5.8.0 # Asset code generation
  flutter_launcher_icons: ^0.14.2 # App icon generation
  flutter_lints: ^5.0.0 # Linting rules
  json_serializable: ^6.8.0 # JSON serialization codegen
  lints: ^5.1.0 # Dart linting
```text

### Project Structure

```text
lib/
├── main.dart                    # Application entry point
└── app/
    ├── app.dart                 # Root App widget
    ├── application/
    │   ├── observers/           # Application observers
    │   └── providers/           # Infrastructure providers
    │       ├── database_service.provider.dart
    │       ├── infrastructure.provider.dart
    │       └── supported_training_scent.provider.dart
    ├── assets/
    │   ├── data/                # Static data loaders
    │   ├── generated/           # flutter_gen output
    │   ├── supported_training_scent.dart
    │   └── supported_training_scent.g.dart
    ├── db/
    │   ├── smellsense.db.dart   # Database definition
    │   ├── smellsense.db.g.dart # Generated database
    │   ├── daos/                # Data Access Objects
    │   ├── entities/            # Database entities
    │   ├── services/            # Business logic services
    │   └── type-converters/     # Type converters
    ├── pages/                   # Screen routes
    │   ├── about/
    │   ├── help/
    │   ├── scent_selection/
    │   ├── splash/
    │   ├── training_session/
    │   └── training_session_history/
    ├── router/
    │   ├── router.dart          # GoRouter configuration
    │   ├── router_route_data.dart # Route definitions
    │   ├── router_transition.page.dart
    │   └── shell_routes/        # Shell route configurations
    └── shared/
        ├── modules/             # Domain models
        ├── theme/               # Theming
        ├── utils/               # Utility classes
        └── widgets/             # Reusable widgets
````

### Architecture Diagram

```text
┌─────────────────────────────────────────────────────────────────┐
│                         Application                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐       │
│  │    Pages     │◄───│   Router     │───►│   Widgets    │       │
│  └──────┬───────┘    └──────────────┘    └──────────────┘       │
│         │                                                       │
│         ▼                                                       │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                  Infrastructure                      │       │
│  │  ┌────────────────┐    ┌─────────────────────────┐   │       │
│  │  │ DatabaseService│    │SupportedTrainingScentPvd│   │       │
│  │  └───────┬────────┘    └─────────────────────────┘   │       │
│  └──────────┼───────────────────────────────────────────┘       │
│             │                                                   │
│             ▼                                                   │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                   Database Layer                     │       │
│  │  ┌─────────┐   ┌─────────┐   ┌─────────────────┐     │       │
│  │  │Services │◄──│  DAOs   │◄──│ SmellSenseDatabase│   │       │
│  │  └────┬────┘   └─────────┘   └─────────────────┘     │       │
│  │       │                                              │       │
│  │       ▼                                              │       │
│  │  ┌──────────┐                                        │       │
│  │  │ Entities │ ◄───────────── Floor ORM (SQLite)      │       │
│  │  └──────────┘                                        │       │
│  └──────────────────────────────────────────────────────┘       │
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                    Domain Layer                      │       │
│  │  ┌─────────────────┐  ┌─────────────────────────┐    │       │
│  │  │    Modules      │  │  SupportedTrainingScent │    │       │
│  │  │ (Domain Models) │  │      (Static Data)      │    │       │
│  │  └─────────────────┘  └─────────────────────────┘    │       │
│  └──────────────────────────────────────────────────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Design Patterns

| Pattern                    | Implementation                                                                  |
| -------------------------- | ------------------------------------------------------------------------------- |
| **Provider Pattern**       | Infrastructure, SharedPreferences, and DatabaseService are provided at app root |
| **Repository Pattern**     | Services abstract DAO operations and provide domain models                      |
| **Facade Pattern**         | `DatabaseService` facades all database operations                               |
| **Factory Pattern**        | `Infrastructure.getInfrastructure()` creates infrastructure singleton           |
| **Builder Pattern**        | `StringBuilder` for formatted error messages                                    |
| **Type Converter Pattern** | `DateTimeTypeConverter` for SQLite date handling                                |

---

## Database Architecture

### Framework

SmellSense uses **Floor** (version 1.5.0) as its SQLite ORM. Floor provides:

- Type-safe database operations
- Code generation for entities and DAOs
- Transaction support
- Type converters for custom types

### Database Configuration

- **Database version:** 1
- **Entities:** `TrainingScent`, `TrainingPeriod`, `TrainingSession`, `TrainingSessionEntry`
- **Type converters:** `DateTime ↔ int` (milliseconds since epoch)
- **DAO accessors:** `trainingPeriodDao`, `trainingSessionDao`, `trainingSessionEntryDao`, `trainingScentDao`

### Entity-Relationship Diagram

```text
┌─────────────────────────────┐
│      training_period        │
├─────────────────────────────┤
│ id (PK, String)             │
│ start_date (DateTime → int) │
└──────────────┬──────────────┘
               │ 1
               │
        ┌──────┴──────┐
        │             │
        ▼ N           ▼ N
┌───────────────────┐ ┌───────────────────────┐
│  training_session │ │    training_scent     │
├───────────────────┤ ├───────────────────────┤
│ id (PK, String)   │ │ id (PK, String)       │
│ period_id (FK)    │ │ period_id (FK)        │
│ date (DateTime)   │ │ supported_scent_id    │
└────────┬──────────┘ └───────────┬───────────┘
         │ 1                      │
         │                        │
         ▼ N                      │
┌─────────────────────────────────┤
│   training_session_entry        │
├─────────────────────────────────┤
│ id (PK, String)                 │
│ session_id (FK → training_session) │
│ scent_id (FK → training_scent)  │
│ rating (int, 0-4)               │
│ parosmia_reaction (int?, 0-6)   │
│ parosmia_reaction_severity (int?, 0-3) │
│ comment (String?)               │
└─────────────────────────────────┘
```

### Entities

Entity definitions correspond directly to the SQL DDL in the [Platform-Agnostic Data Models](#platform-agnostic-data-models) section. Each entity maps 1:1 to a database table:

| Entity                       | Table                    | Fields                                                                                                                                                                                          |
| ---------------------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TrainingPeriodEntity`       | `training_period`        | `id` (PK, string), `start_date` (DateTime → int)                                                                                                                                                |
| `TrainingScentEntity`        | `training_scent`         | `id` (PK, string), `supported_scent_id` (string), `period_id` (FK → training_period)                                                                                                            |
| `TrainingSessionEntity`      | `training_session`       | `id` (PK, string), `period_id` (FK → training_period), `date` (DateTime → int)                                                                                                                  |
| `TrainingSessionEntryEntity` | `training_session_entry` | `id` (PK, string), `session_id` (FK → training_session), `scent_id` (FK → training_scent), `rating` (int), `parosmia_reaction` (int?), `parosmia_reaction_severity` (int?), `comment` (string?) |

### Data Access Objects (DAOs)

Each DAO provides standard CRUD operations plus custom queries. Operations are asynchronous.

#### TrainingPeriodDao

| Operation                      | Description                                                     |
| ------------------------------ | --------------------------------------------------------------- |
| `listTrainingPeriods()`        | Returns all training periods                                    |
| `findActiveTrainingPeriod()`   | Returns most recent period (`ORDER BY start_date DESC LIMIT 1`) |
| `insertTrainingPeriod(period)` | Inserts a new training period                                   |
| `updateTrainingPeriod(period)` | Updates an existing training period                             |
| `deleteTrainingPeriod(period)` | Deletes a training period                                       |

#### TrainingScentDao

| Operation                                | Description                                    |
| ---------------------------------------- | ---------------------------------------------- |
| `findTrainingScentById(id)`              | Returns a single scent by ID                   |
| `findTrainingScentsByPeriodId(periodId)` | Returns all scents for a given training period |
| `insertTrainingScent(scent)`             | Inserts a new training scent                   |

#### TrainingSessionDao

| Operation                                  | Description                                      |
| ------------------------------------------ | ------------------------------------------------ |
| `findTrainingSessionsByPeriodId(periodId)` | Returns all sessions for a given training period |
| `insertTrainingSession(session)`           | Inserts a new training session                   |
| `deleteTrainingSession(session)`           | Deletes a training session                       |

#### TrainingSessionEntryDao

| Operation                                 | Description                                       |
| ----------------------------------------- | ------------------------------------------------- |
| `findTrainingSessionEntries(sessionId)`   | Returns all entries for a given session           |
| `insertTrainingSessionEntry(entry)`       | Inserts a new session entry                       |
| `deleteTrainingSessionEntries(sessionId)` | Deletes all entries for a session (transactional) |

### Services Layer

Services wrap DAOs and convert between Entity ↔ Module (domain model).

#### Service Hierarchy

```text
DatabaseService (Facade)
├── TrainingPeriodService
│   └── TrainingSessionService
│       └── TrainingSessionEntryService
│           └── TrainingScentService
└── TrainingScentService
```

#### DatabaseService (Facade)

Aggregates all services and provides high-level operations:

| Operation                                 | Description                                                  |
| ----------------------------------------- | ------------------------------------------------------------ |
| `createTrainingPeriod(startDate, scents)` | Creates a new training period with 4 associated scents       |
| `recordTrainingSession(session)`          | Persists a completed training session with all entries       |
| `getActiveTrainingScents()`               | Returns the 4 scents for the current active training period  |
| `getTrainingPeriods()`                    | Returns all training periods with their sessions and entries |

Internal dependencies: `TrainingPeriodService`, `TrainingScentService`, `TrainingSessionService`, `TrainingSessionEntryService`

### Type Converters

| Converter               | From       | To    | Logic                                                                                    |
| ----------------------- | ---------- | ----- | ---------------------------------------------------------------------------------------- |
| `DateTimeTypeConverter` | `DateTime` | `int` | Encodes as milliseconds since epoch; decodes via `DateTime.fromMillisecondsSinceEpoch()` |

### Infrastructure Provider

The `Infrastructure` class is the top-level dependency container, bootstrapped once at app startup and made available globally via the Provider pattern.

**Exposed services:**

- `databaseService` — facade for all database operations
- `supportedTrainingScentProvider` — static scent data lookup

**Access pattern:** Pages retrieve Infrastructure from the nearest ancestor provider in the widget tree (equivalent to React Context or a DI container).

**Bootstrap flow:**

1. App starts → `Infrastructure.getInfrastructure()` called (async)
2. Database service initialized (opens SQLite DB)
3. Supported scent provider initialized (loads static JSON)
4. Infrastructure instance provided to widget tree

### Consumer Pattern

Pages access data asynchronously through the Infrastructure provider's `databaseService`. The general pattern is:

1. **Initiate** an async data fetch (e.g., `databaseService.getActiveTrainingScents()`)
2. **While loading**: Display a circular progress indicator
3. **On error**: Display an error message with details
4. **On success**: Render the UI with the returned data

This is analogous to React's `useEffect` + loading/error/data states, or any async data-fetching pattern with explicit state handling.

---

## Persistent Storage

The app uses key-value persistent storage (SharedPreferences on Flutter; equivalent to AsyncStorage on React Native) for lightweight non-database state.

### Storage Keys

| Key                 | Type | Purpose                                                   | Read Location               | Set Location              |
| ------------------- | ---- | --------------------------------------------------------- | --------------------------- | ------------------------- |
| `hasScentsSelected` | bool | Tracks whether user has completed initial scent selection | Splash route redirect logic | **Never set (known bug)** |

### Behavior

- On splash screen, the app checks `hasScentsSelected`:
  - If `true` (or app is in debug mode) → redirect to `/training-session-history`
  - If `false` or `null` → continue splash animation → navigate to `/scent-selection`
- **Bug:** The key is never written to storage after scent selection completes. In release builds, users will always replay the scent selection flow. A correct implementation should set `hasScentsSelected = true` after successfully creating a training period.

---

## Platform-Agnostic Data Models

This section provides language-agnostic specifications for implementing the data layer in any technology stack.

### Database Schema (SQL DDL)

```sql
-- Training Period: A multi-week period during which user trains with 4 selected scents
CREATE TABLE training_period (
    id TEXT PRIMARY KEY,                    -- UUID v4
    start_date INTEGER NOT NULL             -- Unix timestamp (milliseconds)
);

-- Training Scent: Links a supported scent to a training period (max 4 per period)
CREATE TABLE training_scent (
    id TEXT PRIMARY KEY,                    -- UUID v4
    period_id TEXT NOT NULL,                -- FK → training_period.id
    supported_scent_id TEXT NOT NULL,       -- FK → static scent data (UUID from JSON)
    FOREIGN KEY (period_id) REFERENCES training_period(id)
);

-- Training Session: A single training session (typically done 2x daily)
CREATE TABLE training_session (
    id TEXT PRIMARY KEY,                    -- UUID v4
    period_id TEXT NOT NULL,                -- FK → training_period.id
    date INTEGER NOT NULL,                  -- Unix timestamp (milliseconds)
    FOREIGN KEY (period_id) REFERENCES training_period(id)
);

-- Training Session Entry: Rating for one scent in a session (4 entries per session)
CREATE TABLE training_session_entry (
    id TEXT PRIMARY KEY,                    -- UUID v4
    session_id TEXT NOT NULL,               -- FK → training_session.id
    scent_id TEXT NOT NULL,                 -- FK → training_scent.id
    rating INTEGER NOT NULL,                -- 0-4 (see Rating enum)
    parosmia_reaction INTEGER,              -- 0-6 or NULL (see Reaction enum)
    parosmia_reaction_severity INTEGER,     -- 0-3 or NULL (see Severity enum)
    comment TEXT,                           -- Optional free-text comment
    FOREIGN KEY (session_id) REFERENCES training_session(id),
    FOREIGN KEY (scent_id) REFERENCES training_scent(id)
);
```

### Data Type Interfaces (TypeScript-style)

```typescript
// Enumerations
type ScentName =
  | "chamomile"
  | "cinnamon"
  | "citronella"
  | "clove"
  | "eucalyptus"
  | "garlic"
  | "grapefruit"
  | "lavender"
  | "lemon"
  | "mint"
  | "orange"
  | "rose"
  | "rosemary"
  | "teatree";

type Rating = 0 | 1 | 2 | 3 | 4;
// 0 = none, 1 = weak, 2 = normal, 3 = strong, 4 = altered

type ParosmiaReaction = 0 | 1 | 2 | 3 | 4 | 5 | 6;
// 0 = none, 1 = angry, 2 = disgusted, 3 = unhappy, 4 = neutral, 5 = pleased, 6 = happy

type ParosmiaSeverity = 0 | 1 | 2 | 3;
// 0 = none, 1 = mild, 2 = moderate, 3 = severe

// Domain Models
interface SupportedScent {
  id: string; // UUID
  name: ScentName;
  displayColor: string; // Hex color code (e.g., "#D48201")
  displayImage: string; // Asset path
}

interface TrainingPeriod {
  id: string; // UUID
  startDate: Date;
  sessions?: TrainingSession[];
}

interface TrainingScent {
  id: string; // UUID
  name: ScentName;
}

interface TrainingSession {
  id: string; // UUID
  date: Date;
  entries: TrainingSessionEntry[];
}

interface TrainingSessionEntry {
  id: string; // UUID
  scent: TrainingScent;
  rating: Rating;
  parosmiaReaction: ParosmiaReaction;
  parosmiaSeverity: ParosmiaSeverity;
  comment?: string;
}
```

### Service Interface Contracts

```typescript
// Database Service - High-level facade for all database operations
interface DatabaseService {
  // Training Period Operations
  createTrainingPeriod(startDate: Date, scents: TrainingScent[]): Promise<void>;
  getTrainingPeriods(): Promise<TrainingPeriod[]>;
  getActiveTrainingPeriod(): Promise<TrainingPeriod>;

  // Training Session Operations
  recordTrainingSession(session: TrainingSession): Promise<void>;

  // Training Scent Operations
  getActiveTrainingScents(): Promise<TrainingScent[]>;
}

// Supported Scent Provider - Static data access
interface SupportedScentProvider {
  listSupportedScents(): SupportedScent[];
  getScentById(id: string): SupportedScent;
  getScentByName(name: ScentName): SupportedScent;
}
```

### Static Scent Data (JSON)

The 14 supported scents are defined in a static JSON file. See [Complete Supported Scents Data](#complete-supported-scents-data) for the full dataset.

---

## Complete Supported Scents Data

The complete `assets/data/supported_scents.json` file:

```json
[
  {
    "id": "f9f08e99-8c88-4c64-bd91-25bbcb4e435d",
    "name": "chamomile",
    "displayColor": "0xFFD48201",
    "displayImage": "assets/images/scents/chamomile.png"
  },
  {
    "id": "83375a4b-327f-48cf-aebe-e16a953305a7",
    "name": "cinnamon",
    "displayColor": "0xFF5D4037",
    "displayImage": "assets/images/scents/cinnamon.png"
  },
  {
    "id": "904b2a00-ab47-4c72-bc6d-8c3e167e4bb8",
    "name": "citronella",
    "displayColor": "0xFFFFCB2E",
    "displayImage": "assets/images/scents/citronella.png"
  },
  {
    "id": "b9c68369-7d71-45fe-aa20-734817bba3f8",
    "name": "clove",
    "displayColor": "0xFFA1887F",
    "displayImage": "assets/images/scents/clove.png"
  },
  {
    "id": "04299219-a7f4-4439-94e1-bb81d668fe2b",
    "name": "eucalyptus",
    "displayColor": "0xFF4CAF50",
    "displayImage": "assets/images/scents/eucalyptus.png"
  },
  {
    "id": "fd3bddd7-660c-4e72-aba3-1c76baf10355",
    "name": "garlic",
    "displayColor": "0xFF8D6E63",
    "displayImage": "assets/images/scents/garlic.png"
  },
  {
    "id": "df10b347-d6d9-48da-84c2-1bd3187343c2",
    "name": "grapefruit",
    "displayColor": "0xFFE57373",
    "displayImage": "assets/images/scents/grapefruit.png"
  },
  {
    "id": "6b118654-d501-4bb2-b174-5ca78e236dd4",
    "name": "lavender",
    "displayColor": "0xFFB39DDB",
    "displayImage": "assets/images/scents/lavender.png"
  },
  {
    "id": "dec45941-b576-4377-8dcf-5240c682493e",
    "name": "lemon",
    "displayColor": "0xFFD4E157",
    "displayImage": "assets/images/scents/lemon.png"
  },
  {
    "id": "c2e4fccd-fe00-4561-887d-ba73e466a993",
    "name": "mint",
    "displayColor": "0xFF81C784",
    "displayImage": "assets/images/scents/mint.png"
  },
  {
    "id": "5216446a-0600-46a7-ba8a-f23989bc42bd",
    "name": "orange",
    "displayColor": "0xFFFFB74D",
    "displayImage": "assets/images/scents/orange.png"
  },
  {
    "id": "02e1a6cc-a8e6-41a6-8893-4a713448c6df",
    "name": "rose",
    "displayColor": "0xFFF48FB1",
    "displayImage": "assets/images/scents/rose.png"
  },
  {
    "id": "a03d8168-07dc-4dbb-bf30-51761e8cfa4d",
    "name": "rosemary",
    "displayColor": "0xFF9FA8DA",
    "displayImage": "assets/images/scents/rosemary.png"
  },
  {
    "id": "8bed34ec-044b-4caa-a76e-265d785c710b",
    "name": "teatree",
    "displayColor": "0xFF80DEEA",
    "displayImage": "assets/images/scents/teatree.png"
  }
]
```

> **Note:** Color values use Flutter's `0xAARRGGBB` format. `0xFF` prefix = fully opaque. Convert to standard hex (e.g., `0xFFD48201` → `#D48201`) for web/RN use.
> **Known Bug:** Garlic's `displayImage` in the original JSON incorrectly points to `assets/images/grapefruit.png` instead of `assets/images/garlic.png`. The corrected version above uses the proper path.

---

## Application Models and Modules

### Domain Modules

Domain modules are located in `lib/app/shared/modules/` and represent the application's domain model.

Domain modules represent the application's core business objects. Their structure mirrors the TypeScript interfaces in the [Platform-Agnostic Data Models](#platform-agnostic-data-models) section.

#### TrainingPeriod

| Field       | Type               | Notes                                |
| ----------- | ------------------ | ------------------------------------ |
| `id`        | string             | UUID v4                              |
| `startDate` | DateTime           | When the period began                |
| `sessions`  | TrainingSession[]? | Optional list of associated sessions |

#### TrainingScent

| Field / Constant    | Type           | Notes                      |
| ------------------- | -------------- | -------------------------- |
| `maxTrainingScents` | int (static)   | Always `4`                 |
| `id`                | string         | UUID v4                    |
| `name`              | ScentName enum | One of 14 supported scents |

**ScentName enum values:** `chamomile`, `cinnamon`, `citronella`, `clove`, `eucalyptus`, `garlic`, `grapefruit`, `lavender`, `lemon`, `mint`, `orange`, `rose`, `rosemary`, `teatree`

#### TrainingSession

| Field     | Type                   | Notes                         |
| --------- | ---------------------- | ----------------------------- |
| `id`      | string                 | UUID v4                       |
| `date`    | DateTime               | When the session occurred     |
| `entries` | TrainingSessionEntry[] | One entry per scent (4 total) |

#### TrainingSessionEntry

| Field                      | Type                  | Notes                            |
| -------------------------- | --------------------- | -------------------------------- |
| `id`                       | string                | UUID v4                          |
| `scent`                    | TrainingScent         | The scent being rated            |
| `rating`                   | Rating enum           | Mutable; see Rating enum below   |
| `parosmiaReaction`         | ParosmiaReaction enum | Mutable; see Reaction enum below |
| `parosmiaReactionSeverity` | ParosmiaSeverity enum | Mutable; see Severity enum below |
| `comment`                  | string?               | Optional free-text               |

#### Rating Enum

| Label     | Display Text                             | Value |
| --------- | ---------------------------------------- | ----- |
| `none`    | "No smell at all"                        | 0     |
| `weak`    | "Slight smell"                           | 1     |
| `normal`  | "Moderate smell"                         | 2     |
| `strong`  | "Strong smell"                           | 3     |
| `altered` | "I smell something different (Parosmia)" | 4     |

#### Parosmia Severity Enum

| Label      | Value |
| ---------- | ----- |
| `none`     | 0     |
| `mild`     | 1     |
| `moderate` | 2     |
| `severe`   | 3     |

#### Parosmia Reaction Enum

| Label       | Value | Image Asset                             |
| ----------- | ----- | --------------------------------------- |
| `none`      | 0     | (none)                                  |
| `angry`     | 1     | `assets/images/reactions/angry.png`     |
| `disgusted` | 2     | `assets/images/reactions/disgusted.png` |
| `unhappy`   | 3     | `assets/images/reactions/unhappy.png`   |
| `neutral`   | 4     | `assets/images/reactions/neutral.png`   |
| `pleased`   | 5     | `assets/images/reactions/pleased.png`   |
| `happy`     | 6     | `assets/images/reactions/happy.png`     |

### Static Data: Supported Training Scents

Supported scents are loaded from a static JSON file at build time. Each scent has:

| Field          | Type       | Description                         |
| -------------- | ---------- | ----------------------------------- |
| `id`           | string     | UUID v4 identifier                  |
| `name`         | string     | Scent name (matches ScentName enum) |
| `displayColor` | color      | Hex color for UI display            |
| `displayImage` | asset path | Path to scent PNG image             |

See the [Static Scent Data (JSON)](#static-scent-data-json) section for the full JSON format.

### Provider: SupportedTrainingScentProvider

| Operation                                | Returns                  | Description             |
| ---------------------------------------- | ------------------------ | ----------------------- |
| `listSupportedTrainingScents()`          | SupportedTrainingScent[] | All 14 supported scents |
| `getSupportedTrainingScentById(id)`      | SupportedTrainingScent   | Lookup by UUID          |
| `findSupportedTrainingScentByName(name)` | SupportedTrainingScent   | Lookup by scent name    |

---

## UI Flows and Navigation

### Navigation Flow Diagram

```text
┌──────────────────────────────────────────────────────────────────────┐
│                           Application Flow                           │
└──────────────────────────────────────────────────────────────────────┘

                              ┌─────────┐
                              │  Splash │
                              └────┬────┘
                                   │
                    ┌──────────────┼──────────────┐
                    │              │              │
                    ▼              │              │
         ┌──────────────────┐     │      ┌────────┴────────┐
         │ Scent Selection  │     │      │ (if previously  │
         │ (First-time user)│     │      │  configured)    │
         └────────┬─────────┘     │      └────────┬────────┘
                  │               │               │
                  └───────────────┼───────────────┘
                                  │
                                  ▼
                    ┌─────────────────────────┐
                    │  Training Session       │
                    │  History (Home)         │◄──────────────┐
                    └────────────┬────────────┘               │
                                 │                            │
              ┌──────────────────┼──────────────────┐         │
              │                  │                  │         │
              ▼                  ▼                  ▼         │
        ┌───────────┐    ┌─────────────┐    ┌───────────┐     │
        │   Help    │    │   About     │    │ Training  │     │
        └───────────┘    └─────────────┘    │  Session  │     │
                                            └─────┬─────┘     │
                                                  │           │
                                                  └───────────┘

┌─────────────────────────────────────────────────────────────────┐
│                     Navigation Bar Routes                       │
│  ┌──────────────────┐  ┌────────────┐  ┌─────────────┐          │
│  │ Training History │  │    Help    │  │    About    │          │
│  │      (Home)      │  │            │  │             │          │
│  └──────────────────┘  └────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────────────────────┘
```

### Router Configuration

SmellSense uses **go_router** with code generation for type-safe routing.

#### Route Structure

The router uses a nested shell route pattern with two shell types:

```text
BaseShellRoute
├── SimpleShellRoute (no navigation bar)
│   ├── /splash        → SplashPage
│   ├── /scent-selection → ScentSelectionPage
│   └── /training-session → TrainingSessionPage
└── NavBarShellRoute (with bottom navigation bar)
    ├── /training-session-history → TrainingSessionHistoryPage
    ├── /help             → HelpPage
    └── /about            → AboutPage
```

#### Route Definitions

| Route                             | Path                        | Shell  | Description                |
| --------------------------------- | --------------------------- | ------ | -------------------------- |
| `SplashRouteData`                 | `/splash`                   | Simple | App splash/intro screen    |
| `ScentSelectionRouteData`         | `/scent-selection`          | Simple | First-time scent selection |
| `TrainingSessionRouteData`        | `/training-session`         | Simple | Active training session    |
| `TrainingSessionHistoryRouteData` | `/training-session-history` | NavBar | Home/history screen        |
| `HelpRouteData`                   | `/help`                     | NavBar | Help & FAQ                 |
| `AboutRouteData`                  | `/about`                    | NavBar | About & contacts           |

#### Shell Routes

**SimpleShellPageRouteData** - Used for fullscreen pages without navigation:

- Splash screen
- Scent selection
- Training session

**NavBarShellPageRouteData** - Used for main app pages with bottom navigation:

- Training Session History (Home)
- Help
- About

#### Route Data Behavior

Each route builds its page wrapped in a slide-up page transition (see [Page Transition Implementation](#page-transition-implementation)).

#### Navigation with Redirect

The splash route includes conditional redirect logic:

- If `hasScentsSelected` preference is `true` → redirect to `/training-session-history`
- Otherwise → continue to splash screen (which eventually navigates to `/scent-selection`)

---

## User Interaction Specifications

This section details the exact user interactions and state transitions throughout the application.

### Splash Screen Flow

```text
State: INTRO_LOGO
┌─────────────────────────────────────────────────┐
│                                                 │
│  [Logo fades in over 3s, scales 1x → 1.5x]      │
│  [Idle for 0.5s]                                │
│  [Logo fades out over 0.8s]                     │
│                                                 │
│  → Auto-transition to INTRO_MESSAGE             │
└─────────────────────────────────────────────────┘

State: INTRO_MESSAGE
┌─────────────────────────────────────────────────┐
│                                                 │
│  "Let's start by selecting your training        │
│   scents."                                      │
│                                                 │
│  [Text fades in over 2s]                        │
│  [Idle for 2s]                                  │
│  [Text fades out over 0.7s]                     │
│                                                 │
│  → Navigate to Scent Selection OR History       │
│    (based on hasScentsSelected preference)      │
└─────────────────────────────────────────────────┘
```

### Scent Selection Flow

```text
State: SELECTING
┌─────────────────────────────────────────────────┐
│  Selected: 0/4                                  │
│                                                 │
│  User taps checkbox:                            │
│  ├─ If selected < 4: Toggle scent selection     │
│  └─ If selected = 4 AND adding new:             │
│       → Show snackbar "You can only select      │
│         up to 4 scents" for 2 seconds           │
│       → Checkbox remains unchecked              │
│                                                 │
│  [Next] button:                                 │
│  ├─ Disabled (grayed out) when selected < 4    │
│  └─ Enabled when selected = 4                  │
└─────────────────────────────────────────────────┘

State: SUBMITTING (when Next pressed)
┌─────────────────────────────────────────────────┐
│  [Loading overlay appears]                      │
│  [Create training period in database]           │
│  [Navigate to Training Session History]         │
└─────────────────────────────────────────────────┘
```

### Training Session Entry Flow

For EACH of the 4 scents in sequence:

```text
State: TIMER_COUNTDOWN
┌─────────────────────────────────────────────────┐
│  [Scent image displayed]                        │
│                                                 │
│  [Circular progress indicator counting down]    │
│  [Timer value displayed: 15 → 0 seconds]        │
│                                                 │
│  [Encouragement message displayed]              │
│  (Rotates through 4 messages)                   │
│                                                 │
│  → When timer reaches 0, transition to RATING   │
└─────────────────────────────────────────────────┘

State: RATING
┌─────────────────────────────────────────────────┐
│  "How intense is the smell of this substance?"  │
│                                                 │
│  [Vertical rating bar with 5 text options]      │
│  ○ 1 - No smell at all                         │
│  ○ 2 - I smell something different (Parosmia)  │
│  ○ 3 - Slight smell                            │
│  ○ 4 - Moderate smell                          │
│  ○ 5 - Strong smell                            │
│                                                 │
│  [Comment Form: Parosmia reaction dropdown]     │
│  [Comment Form: Severity dropdown]              │
│  [Comment Form: Additional comments text field] │
│                                                 │
│  User uses stepper [Continue] to proceed        │
│  User uses stepper [Cancel] to go back          │
└─────────────────────────────────────────────────┘
```

### Encouragement Messages (Cycled During Timer)

1. "Try to remember exactly how this substance should smell"
2. "Imagine yourself holding the real thing in your hands...the look, colours, texture and smell."
3. "Can you recall your last vivid memory of this smell?"
4. "What positive associations can you make with this smell?"

### Stepper Navigation Behavior

- **Continue**: Advances to next scent (or completes session on last scent)
- **Cancel**: Returns to previous scent (disabled on first scent)
- **Step Tap**: Allows jumping to any previously visited step

---

## Visual Design Specifications

### Color Palette

| Token                | Hex Value | Usage                                 |
| -------------------- | --------- | ------------------------------------- |
| `primary`            | `#006689` | Primary actions, links, active states |
| `primaryContainer`   | `#4DA7D2` | Primary element backgrounds           |
| `secondary`          | `#854E5F` | Secondary actions, accents            |
| `secondaryContainer` | `#FFC2D3` | Secondary backgrounds                 |
| `tertiary`           | `#4C6079` | Tertiary elements                     |
| `surface`            | `#F0F0F0` | Main background color                 |
| `surfaceContainer`   | `#EBEEF2` | Card backgrounds                      |
| `error`              | `#BA1A1A` | Error states, destructive actions     |
| `onPrimary`          | `#FFFFFF` | Text/icons on primary color           |
| `onSurface`          | `#181C1F` | Primary text color                    |
| `onSurfaceVariant`   | `#3F484E` | Secondary text color                  |
| `outline`            | `#6F787F` | Borders, dividers                     |

### Typography Scale

| Style            | Font      | Size | Weight | Usage                  |
| ---------------- | --------- | ---- | ------ | ---------------------- |
| `headlineLarge`  | Roboto    | 32px | 400    | Page titles            |
| `headlineMedium` | Roboto    | 24px | 400    | Section headers        |
| `headlineSmall`  | Roboto    | 18px | 100    | Card titles, subtitles |
| `titleLarge`     | Roboto    | 24px | 400    | Dialog titles          |
| `titleMedium`    | Roboto    | 20px | 200    | List item titles       |
| `titleSmall`     | Roboto    | 16px | 100    | Small titles           |
| `bodyLarge`      | Open Sans | 16px | 400    | Primary body text      |
| `bodyMedium`     | Open Sans | 14px | 400    | Secondary body text    |
| `bodySmall`      | Open Sans | 12px | 400    | Captions, hints        |

### Screen Layouts

#### Splash Screen

```text
┌────────────────────────────────────────┐
│                                        │
│                                        │
│                                        │
│           ┌──────────────┐             │
│           │              │             │
│           │    [Logo]    │             │
│           │    60x60     │             │
│           │              │             │
│           └──────────────┘             │
│              SmellSense                │
│          (Smell in gray,               │
│           Sense in primary + bold)     │
│                                        │
│                                        │
│                                        │
└────────────────────────────────────────┘
```

#### Scent Selection Screen

```text
┌────────────────────────────────────────┐
│                                        │
│  "Select four of your desired          │
│   training scents"                     │
│  [headlineMedium, centered]            │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │ ☐ Chamomile        [#D48201]     │  │
│  │ ☐ Cinnamon         [#5D4037]     │  │
│  │ ☐ Citronella       [#FFCB2E]     │  │
│  │ ☐ Clove            [#A1887F]     │  │
│  │ ☐ Eucalyptus       [#4CAF50]     │  │
│  │ ☐ Garlic           [#8D6E63]     │  │
│  │ ☐ Grapefruit       [#E57373]     │  │
│  │ ☐ Lavender         [#B39DDB]     │  │
│  │ ☐ Lemon            [#D4E157]     │  │
│  │ ☐ Mint             [#81C784]     │  │
│  │ ☐ Orange           [#FFB74D]     │  │
│  │ ☐ Rose             [#F48FB1]     │  │
│  │ ☐ Rosemary         [#9FA8DA]     │  │
│  │ ☐ Tea Tree         [#80DEEA]     │  │
│  └──────────────────────────────────┘  │
│  [Scrollable list, 48px item height]   │
│                                        │
│                        ┌────────────┐  │
│                        │    Next    │  │
│                        └────────────┘  │
│                   [OutlinedButton]     │
└────────────────────────────────────────┘
```

#### Training Session Screen

```text
┌────────────────────────────────────────┐
│  ┌───────────────────────────────────┐ │
│  │ ● Chamomile ◄── Current step      │ │
│  │   ┌─────────────────────────────┐ │ │
│  │   │      [Scent Image]          │ │ │
│  │   │                             │ │ │
│  │   │   ┌───────────────────┐     │ │ │
│  │   │   │  [Timer: 15s]     │     │ │ │
│  │   │   │  [Progress Ring]  │     │ │ │
│  │   │   └───────────────────┘     │ │ │
│  │   │                             │ │ │
│  │   │  "Try to remember exactly   │ │ │
│  │   │   how this substance..."    │ │ │
│  │   │                             │ │ │
│  │   │  [Cancel] [Continue]        │ │ │
│  │   └─────────────────────────────┘ │ │
│  │ ○ Cinnamon                        │ │
│  │ ○ Lavender                        │ │
│  │ ○ Lemon                           │ │
│  └───────────────────────────────────┘ │
│  [Vertical Stepper]                    │
└────────────────────────────────────────┘
```

#### Training Session History Screen

```text
┌────────────────────────────────────────┐
│                                        │
│  "Training Session History"            │
│  [titleMedium, centered, 20px pad]     │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │                                  │  │
│  │     [Bar Chart Area]             │  │
│  │     Sessions over time           │  │
│  │     Grouped by scent             │  │
│  │                                  │  │
│  └──────────────────────────────────┘  │
│                                        │
│                                        │
├────────────────────────────────────────┤
│  [Home]      [Help]      [About]      │
│  [Bottom Navigation Bar]              │
└────────────────────────────────────────┘
```

### Component Specifications

#### Checkbox List Item

- Height: 48px
- Checkbox: Rounded rectangle shape
- Scent name color: Matches scent's `displayColor`
- Font weight: 500 (medium)
- Padding: Default list tile padding

#### Rating Bar

- Direction: Vertical
- Item count: 5 options (0-4)
- Each item: Text label from localization
- Glow effect on selection
- Unrated color: Primary at 50% alpha

#### Timer Widget

- Circular progress indicator
- Stroke cap: Round
- Text overlay: Current seconds remaining
- Replaces itself with rating form when complete

#### Button Styles

- **Text Button**: Filled with primary color, white text, 4px border radius
- **Outlined Button**: Primary border, transparent background, 4px border radius
- **Disabled state**: 40% alpha on border/text

### Page Transitions

- **Default transition**: Slide up from bottom
- **Duration**: Platform default (~300ms)
- **Easing**: Platform default (ease-in-out)

---

## UI Components

### Pages

#### SplashPage (`/splash`)

**Purpose:** Welcome screen with animated logo and introduction text

**Features:**

- Animated logo with scale and fade effects
- Sequential intro messages
- Auto-redirects to scent selection or home

**Animations:**

- `ScaleAnimate`: Logo scaling effect (1x → 1.5x over 5 seconds)
- `FadeAnimate`: Text fade in/out with idle period

#### ScentSelectionPage (`/scent-selection`)

**Purpose:** First-time setup page for selecting 4 training scents

**Features:**

- 14 supported scents displayed in a scrollable list
- Maximum 4 scent selection limit with snackbar feedback
- Next button enabled only when 4 scents selected
- Creates training period in database on submission

**Widgets Used:**

- `ScentSelectionCheckboxGroupWidget` - Checkbox list with color-coded scent names

#### TrainingSessionPage (`/training-session`)

**Purpose:** Guided smell training session

**Features:**

- Stepper-based navigation through selected scents
- Timed training per scent (15 seconds default)
- Encouragement prompts during training
- Rating bar for smell intensity
- Parosmia reaction tracking
- Comment field for additional notes

**Widgets Used:**

- `TrainingSessionStepperWidget` - Vertical stepper navigation
- `TrainingSessionEntryWidget` - Individual scent training interface
- `TimerWidget` - Countdown timer with encouragements
- `RatingBarWidget` - 5-point rating input
- `CommentFormWidget` - Text input for comments

#### TrainingSessionHistoryPage (`/training-session-history`)

**Purpose:** Home screen showing training progress over time

**Features:**

- Chart visualization of training sessions
- Historical data by training period

**Widgets Used:**

- `TrainingSessionHistoryChartWidget` - Bar chart using fl_chart

#### HelpPage (`/help`)

**Purpose:** FAQ and training guidance

**Features:**

- Scrollable help content (16px padding, `SingleChildScrollView`)
- 4 question/answer sections, 16px vertical spacing between each
- Content is hardcoded in English (not localized)

**Widgets Used:**

- `HelpParagraphWidget` - Styled question/answer sections (`headlineMedium` bold title + `bodySmall` body text)

See [Help Page Content](#help-page-content) for the full Q&A text.

#### AboutPage (`/about`)

**Purpose:** Application info and contacts

**Features:**

- Creator information with section headings (`titleMedium`)
- Tappable external links (Facebook, resource sites)
- Plain-text email addresses (not tappable)

See [About Page Content](#about-page-content) for the full content and URLs.

### Reusable Widgets

#### Animators (`lib/app/shared/widgets/animators/`)

##### FadeAnimate

A widget that fades its child in, holds, then fades out.

| Parameter         | Type     | Description                           |
| ----------------- | -------- | ------------------------------------- |
| `fadeInDuration`  | Duration | Time to fade in (e.g., 2 seconds)     |
| `idleDuration`    | Duration | Time to hold visible (e.g., 1 second) |
| `fadeOutDuration` | Duration | Time to fade out (e.g., 700ms)        |
| `onComplete`      | callback | Called when full fade cycle completes |
| `child`           | Widget   | The content to animate                |

##### ScaleAnimate

A widget that scales its child from an initial size to a final size.

| Parameter      | Type     | Description                          |
| -------------- | -------- | ------------------------------------ |
| `initialScale` | float    | Starting scale factor (e.g., 1.0)    |
| `finalScale`   | float    | Ending scale factor (e.g., 1.5)      |
| `duration`     | Duration | Animation duration (e.g., 5 seconds) |
| `onComplete`   | callback | Called when scaling completes        |
| `child`        | Widget   | The content to animate               |

#### LoaderWidget

Animated circular progress indicator with color-cycling animation.

#### CheckboxGroup

Form field widget for multi-select checkbox groups.

#### AppBar Widget

Custom app bar implementation.

### Page Transition Implementation

All page navigations use a custom slide-up transition:

- **Animation type:** Slide transition
- **Start position:** Off-screen bottom (0, 1)
- **End position:** Normal position (0, 0)
- **Effect:** New page slides up from the bottom of the screen

### Theming

#### Material Theme

SmellSense uses a custom Material 3 theme generated from Material Theme Builder.

**Color Scheme:**

See the full color palette in the [Visual Design Specifications](#visual-design-specifications) section. Key values:

- Brightness: light
- Primary: `#006689` (deep blue)
- Primary Container: `#4DA7D2`
- Secondary: `#854E5F` (rose)
- Secondary Container: `#FFC2D3`
- Tertiary: `#4C6079`
- Surface: `#F0F0F0`
- Error: `#BA1A1A`

**Typography:**

- Display Font: Roboto
- Body Font: Open Sans

**Text Theme Customization:**

See the full typography scale in the [Visual Design Specifications](#visual-design-specifications) section.

**Widget Theme Data:**

- Custom `TextButtonThemeData`
- Custom `OutlinedButtonThemeData`
- Custom `CheckboxThemeData`
- Custom `ListTileThemeData`
- Custom `SnackBarThemeData`

#### Theme Usage

Components access the theme through the nearest ancestor context (equivalent to a theme provider/hook). The theme object exposes:

- `textTheme` — typography styles
- `colorScheme` — semantic colors
- `themeData` — full theme configuration including widget-level overrides

### Localization

**Strategy:** `easy_localization` with JSON asset files

**Supported Locales:**

- `en-US` (English, United States)

**Usage:**

Translation keys follow a dot-delimited path structure. Examples:

- `pages.scent_selection.select_scents_headline` → page-specific text
- `shared.scent_name.chamomile` → shared scent name lookup (dynamic key based on scent name)
- `shared.next_button_text` → shared UI text

**Localization File Structure:**

```json
{
  "pages": {
    "scent_selection": { ... },
    "splash": { ... },
    "training_session": { ... },
    "training_session_history": { ... }
  },
  "shared": {
    "next_button_text": "Next",
    "scent_name": { ... }
  }
}
```

---

## Help Page Content

The Help page displays 4 hardcoded Q&A sections. This content is **not localized** — it is embedded directly in the help page component. A port should replicate this content exactly.

**Layout:**

- Full-screen scrollable view with 16px padding on all sides
- Vertical list of Q&A sections with 16px spacing between each
- Each section: bold `headlineMedium` title + `bodySmall` body text
- Left-aligned text, no interactivity

**Q&A Entries:**

### Q1: What is smell training?

> Smell training engages an innate function of the brain known as Neuroplasticity, 'the brain's ability to form and reorganize synaptic connections, especially in response to learning, experiencing, or following injury.' - Google Dictionary.

### Q2: I'm ready to begin my training. What do I do?

> In a smell training session, a set of four familiar scents (typically Rose, Clove, Lemon, and Eucalyptus) are smelled, in turn, for a period of 20-30 seconds, whilst mindfully visualizing and remembering how each substance would have smelled prior to the smell loss. Repeating the training multiple times daily often produces better results.

### Q3: Over how long a period do I need to smell train in order for my sense of smell to fully recover/return to normal?

> Recovery periods naturally differ from person to person, but research suggests that the average treatment would last for ~3 months. Much depends on the underlying cause of your loss of smell and the severity thereof. Most people will become aware of positive changes within 3 months of starting smell training. Occasionally, it is possible that you may regain the smell of a desired scent, but it does not feel 'correct'. Do not be concerned - this is a positive sign that recovery is underway and that you should continue your training regimen as per usual.

### Q4: I don't have the official SmellSense kit. Am I still able to use the SmellSense mobile application to train?

> Yes! The official SmellSense kit is built simply for your convenience, and the scents supplied are those that are known to be most effective for smell training according to the most up-to-date research. You can simply make up your own set of scents on which to smell train. Be sure to use a set of recognizable smells that remain consistently strong over the period of training. Typically, studies use a representative substance from each of the 'notes' of smell: Floral - eg. Rose, Fruity - eg. Lemon, Spicy - eg. Clove, Aromatic - eg. Eucalyptus. We wish you all the best with your recovery! For more information and resources, refer to the About screen from the main menu.

---

## About Page Content

The About page displays static information about the app creator, contact details, and external resources.

**Layout:**

- Centered column layout with 8px padding
- Sections separated by vertical padding (20px before headings, 5px between items)
- Section headings use `titleMedium` style
- Body text uses `bodyMedium` style, center-aligned
- Tappable links styled in blue, font weight 300, 14px font size

### Section: About Us

**Heading:** "About Us" (`titleMedium`, 20px top/bottom padding)

**Body:** "SmellSense is a private initiative started by ENT surgeon and specialist, Dr. Martin Young." (`bodyMedium`, center-aligned)

### Section: Contacts

**Heading:** "Contacts" (`titleMedium`, 20px top padding, 10px bottom padding)

| Item     | Display Text                                                    | Type                      | URL/Value                                              |
| -------- | --------------------------------------------------------------- | ------------------------- | ------------------------------------------------------ |
| Facebook | "Facebook: " + "SmellSense" (blue link)                         | Tappable external link    | `https://www.facebook.com/SmellSense-345235540113222/` |
| Email    | "Email: knysnaent&#64;gmail.com"                                | Plain text (not tappable) | N/A                                                    |
| Support  | "Support and development enquiries: smellsenseza&#64;gmail.com" | Plain text (not tappable) | N/A                                                    |

> **Bug note:** The Facebook link uses `Uri(path:)` instead of `Uri.parse()`, which won't correctly launch HTTPS URLs. A port should use proper URL opening.

### Section: Resources

**Heading:** "Resources" (`titleMedium`, 20px top padding, 10px bottom padding)

| Display Text              | Type                   | URL                              |
| ------------------------- | ---------------------- | -------------------------------- |
| "Fifth Sense" (blue link) | Tappable external link | `https://www.fifthsense.org.uk/` |
| "Abscent" (blue link)     | Tappable external link | `https://abscent.org/`           |

---

## Bottom Navigation Bar

The main app shell uses a bottom navigation bar with 3 tabs. Labels are intentionally empty strings.

| Index | Icon                    | Label        | Route                       |
| ----- | ----------------------- | ------------ | --------------------------- |
| 0     | Home (house icon)       | `""` (empty) | `/training-session-history` |
| 1     | Question mark (rounded) | `""` (empty) | `/help`                     |
| 2     | Info (circle-i)         | `""` (empty) | `/about`                    |

**Behavior:**

- Current tab is determined by matching the current URL path
- Tab selection triggers navigation via the router (not local state switching)
- The navigation bar wraps child pages in a `Scaffold` — each tab page is rendered as the body content
- Unknown routes throw an exception

**Index-to-Route Mapping:**

```text
Index 0 → /training-session-history (Home/History page)
Index 1 → /help (Help FAQ page)
Index 2 → /about (About & contacts page)
```

---

## Date Formatting and Display

All user-facing dates use the `yMMMEd` format from the `intl` package.

**Format pattern:** `yMMMEd`
**Example output:** `Sat, Mar 1, 2026`

**Date utility functions:**

| Function             | Purpose                                                         | Example                                       |
| -------------------- | --------------------------------------------------------------- | --------------------------------------------- |
| `date()`             | Returns today's date with time stripped (year, month, day only) | `DateTime.now()` → `2026-03-01 00:00:00`      |
| `getDateOnly(date)`  | Strips time component from any date                             | `2026-03-01 14:30:00` → `2026-03-01 00:00:00` |
| `toDateString(date)` | Formats a date for display                                      | `2026-03-01` → `"Sat, Mar 1, 2026"`           |

**Usage in the app:**

- **Database type converter:** All dates stored/retrieved from the database pass through `getDateOnly()`, ensuring times are always zeroed
- **Training period start dates:** Stripped to date-only when creating domain models from entities
- **Display:** Wherever a date is shown to the user, it is formatted via `toDateString()`

---

## Full Localization Reference

The app uses a single locale (`en-US`) with JSON-based localization. Below is the **complete** localization file content. A port must include all of these strings.

**File:** `assets/i18n/en-US.json`

```json
{
  "pages": {
    "scent_selection": {
      "scent_selection_checkbox_group": {
        "selection_limit_reached_snackbar_message": "You can only select up to 4 scents"
      },
      "select_scents_headline": "Select four of your desired training scents"
    },
    "splash": {
      "intro_start_scent_selection_title": "Let's start by selecting your training scents."
    },
    "training_session": {
      "training_session_entry": {
        "comment_form": {
          "additional_comments_field_hint": "Additionally...",
          "additional_comments_field_label": "Any additional comments?",
          "parosmia_reaction": {
            "angry": "Angry",
            "disgusted": "Disgusted",
            "happy": "Happy",
            "neutral": "Neutral",
            "pleased": "Pleased",
            "unhappy": "Unhappy"
          },
          "parosmia_reaction_field_label": "How did you react after smelling this scent?",
          "parosmia_severity": {
            "mild": "Mild",
            "moderation": "Moderate",
            "severe": "Severe"
          },
          "parosmia_severity_field_label": "How severe was your reaction to the smell of this scent?",
          "parsomia_reaction_field_hint": "I reacted...",
          "parsomia_severity_field_hint": "The severity..."
        },
        "rating_bar": {
          "rating_bar": {
            "option": [
              "1 - No smell at all",
              "2 - I smell something different (Parosmia)",
              "3 - Slight smell",
              "4 - Moderate smell",
              "5 - Strong smell"
            ]
          }
        },
        "rating_title": "How intense is the smell of this substance?",
        "timer_encouragements": {
          "0": "Try to remember exactly how this substance should smell",
          "1": "Imagine yourself holding the real thing in your hands...the look, colours, texture and smell.",
          "2": "Can you recall your last vivid memory of this smell?",
          "3": "What positive associations can you make with this smell?"
        }
      }
    },
    "training_session_history": {
      "title": "Training Session History",
      "training_session_history_chart": {
        "no_data_to_show": "No training history data to show."
      }
    }
  },
  "shared": {
    "next_button_text": "Next",
    "scent_name": {
      "chamomile": "Chamomile",
      "cinnamon": "Cinnamon",
      "citronella": "Citronella",
      "clove": "Clove",
      "eucalyptus": "Eucalyptus",
      "garlic": "Garlic",
      "grapefruit": "Grapefruit",
      "lavender": "Lavender",
      "lemon": "Lemon",
      "mint": "Mint",
      "orange": "Orange",
      "rose": "Rose",
      "rosemary": "Rosemary",
      "teatree": "Tea Tree"
    }
  }
}
```

**Key path conventions:**

- Page-specific strings: `pages.<page_name>.<component>.<key>`
- Shared strings: `shared.<key>`
- Scent names are looked up dynamically: `shared.scent_name.<scent_name_lowercase>`
- Array-like values use object keys (`"0"`, `"1"`, etc.) rather than JSON arrays, except for `rating_bar.option` which is a true array

> **Bug note:** The hint field keys use `"parsomia_reaction_field_hint"` and `"parsomia_severity_field_hint"` (typo: "parsomia" instead of "parosmia"). A port should use the corrected spelling `"parosmia_*"` but must match whatever keys exist in the localization file.

---

## Data Validation Rules

### Scent Selection

| Rule             | Validation                        | Error Handling                                               |
| ---------------- | --------------------------------- | ------------------------------------------------------------ |
| Minimum scents   | Exactly 4 scents must be selected | "Next" button disabled until 4 selected                      |
| Maximum scents   | Maximum 4 scents allowed          | Snackbar: "You can only select up to 4 scents" (2s duration) |
| Scent uniqueness | No duplicate scents               | Enforced by checkbox toggle behavior                         |

### Training Session Entry

| Field             | Required | Validation                     | Default            |
| ----------------- | -------- | ------------------------------ | ------------------ |
| Rating            | Yes      | Must be 0-4                    | None (must select) |
| Parosmia Reaction | No       | Must be 0-6 if provided        | None               |
| Parosmia Severity | No       | Must be 0-3 if provided        | None               |
| Comment           | No       | Free text, multiline (3 lines) | Empty              |

### Training Session Completion

| Rule             | Validation                                                          |
| ---------------- | ------------------------------------------------------------------- |
| All scents rated | Each of the 4 scents must have a rating before session can be saved |
| Session date     | Automatically set to current date/time at session start             |

### Training Period

| Rule              | Validation                                                              |
| ----------------- | ----------------------------------------------------------------------- |
| Start date        | Set to current date when period is created                              |
| Active period     | Only the most recent period (by start_date DESC) is considered "active" |
| Scent association | Exactly 4 TrainingScent records linked to each period                   |

---

## Error Handling UX

### Database Errors

| Scenario                         | User-Facing Behavior                          |
| -------------------------------- | --------------------------------------------- |
| Failed to create training period | Display error text in place of content        |
| Failed to load training scents   | Display "Error: [message]" with error details |
| Failed to load training history  | Display empty chart with message              |
| Failed to save training session  | Display error, allow retry                    |

### Loading States

| Component                  | Loading Indicator                                                                     |
| -------------------------- | ------------------------------------------------------------------------------------- |
| App initialization         | Centered animated circular progress (color cycles between primary and darker primary) |
| Scent selection submission | Overlay with circular progress indicator                                              |
| Training session data load | Centered circular progress indicator                                                  |
| History page load          | Standard layout with empty chart while loading                                        |

### Empty States

| Screen                    | Empty State Display                                        |
| ------------------------- | ---------------------------------------------------------- |
| Training Session History  | "No training history data to show." centered in chart area |
| No active training period | Redirect to scent selection                                |

### Navigation Errors

| Scenario         | User-Facing Behavior                                                          |
| ---------------- | ----------------------------------------------------------------------------- |
| Unknown route    | Error page with "An unknown navigation error occurred."                       |
| Router exception | Error page showing "GoRouter encountered an error." with error message in red |

---

## Training Session Entry Form Specification

### Form Structure (In Order)

```text
┌─────────────────────────────────────────┐
│ 1. SCENT IMAGE                          │
│    [PNG image of current scent]         │
│                                         │
│ 2. TIMER (15 seconds)                   │
│    [Circular progress + countdown]      │
│    [Encouragement text below]           │
│                                         │
│    ─── Timer completes, replaced by ─── │
│                                         │
│ 3. RATING QUESTION                      │
│    "How intense is the smell of this    │
│     substance?"                         │
│                                         │
│ 4. RATING BAR (Vertical)                │
│    ○ 1 - No smell at all               │
│    ○ 2 - I smell something different   │
│    ○ 3 - Slight smell                  │
│    ○ 4 - Moderate smell                │
│    ○ 5 - Strong smell                  │
│                                         │
│ 5. PAROSMIA REACTION (Dropdown)         │
│    Label: "How did you react after      │
│            smelling this scent?"        │
│    Options: [Reaction emoji images]     │
│    - (none)                             │
│    - Angry                              │
│    - Disgusted                          │
│    - Unhappy                            │
│    - Neutral                            │
│    - Pleased                            │
│    - Happy                              │
│                                         │
│ 6. PAROSMIA SEVERITY (Dropdown)         │
│    Label: "How severe was your          │
│            reaction to the smell?"      │
│    Options:                             │
│    - (none)                             │
│    - Mild                               │
│    - Moderate                           │
│    - Severe                             │
│                                         │
│ 7. ADDITIONAL COMMENTS (Text Field)     │
│    Label: "Any additional comments?"    │
│    Hint: "Additionally..."              │
│    Max lines: 3                         │
│                                         │
└─────────────────────────────────────────┘
```

### Field Dependencies

- Parosmia fields (reaction, severity) are always displayed
- No conditional logic - all fields shown regardless of rating selection
- Fields marked as optional can be left empty/unselected

---

## History Chart Specifications

### Chart Type

Grouped Bar Chart (using fl_chart / equivalent charting library)

### Data Structure

```text
X-Axis: Training session dates (chronological)
Y-Axis: Rating values (0-4 scale)
Bars: Grouped by scent for each session
      - 4 bars per session (one per training scent)
      - Each bar colored with the scent's displayColor
```

### Visual Specifications

| Property     | Value                                  |
| ------------ | -------------------------------------- |
| Max Y value  | 4 (max rating)                         |
| Bar width    | 7px                                    |
| Bar grouping | Bars for same session grouped together |
| Bar colors   | Each scent uses its `displayColor`     |
| Background   | Transparent                            |

### Interactions

| Interaction         | Behavior                            |
| ------------------- | ----------------------------------- |
| Tap on bar group    | Highlight group, show average value |
| Bar highlight color | Yellow (#FFFF00)                    |
| Tap elsewhere       | Reset to normal view                |

### Axis Labels

| Axis            | Label Format          |
| --------------- | --------------------- |
| X-Axis (Bottom) | Session date or index |
| Y-Axis (Left)   | Rating values 0-4     |
| Right/Top       | Hidden                |

### Empty State

When no training sessions exist:

- Display text: "No training history data to show."
- Centered in chart area

---

## Known Issues and Codebase Bugs

> **Important for porting agents:** These bugs exist in the Flutter source. A React Native port should **fix** these issues rather than replicate them.

1. **Midnight Training Session Bug**
   - **Issue:** Training sessions that start before midnight and end after midnight may break training history
   - **Potential Remediations:**
     - Use the session commit date as the session date
     - Prompt user to restart or cancel sessions crossing midnight

2. **`hasScentsSelected` Never Written**
   - **Issue:** The `hasScentsSelected` persistent storage key is read on splash but never set to `true` after scent selection
   - **Impact:** In release builds, users will always replay the splash/scent-selection flow on every app launch
   - **Fix:** Set `hasScentsSelected = true` after successfully creating a training period

3. **Stepper Cannot Advance Past Step 1**
   - **Issue:** `onStepContinue` condition `_index <= 0` prevents advancing past step index 1
   - **Impact:** Users can only complete training for the first 2 scents
   - **Fix:** Change condition to `_index < scents.length - 1`

4. **Garlic Image Path in JSON**
   - **Issue:** Garlic's `displayImage` in `supported_scents.json` points to `assets/images/grapefruit.png` instead of `assets/images/garlic.png`
   - **Fix:** Corrected in the [Complete Supported Scents Data](#complete-supported-scents-data) section

5. **About Page URL Launch Broken**
   - **Issue:** External links use `Uri(path:)` instead of `Uri.parse()`, which won't correctly launch HTTPS URLs
   - **Fix:** Use proper URL parsing when opening external links

6. **Localization Key Mismatches**
   - **Issue:** Several i18n key references in code don't match the JSON file:
     - Code references `"parsomia_reaction_field_hint"` (typo: "parsomia" vs "parosmia")
     - Code references `"parsomia_severity_field_hint"` (same typo)
     - Some code uses `"screens.training_session..."` prefix but JSON uses `"pages.training_session..."`
   - **Fix:** Use consistent key paths matching the [Full Localization Reference](#full-localization-reference)

7. **History Chart Incomplete**
   - **Issue:** `TrainingSessionHistoryChartWidget` is mostly commented out/stubbed — chart rendering is not fully implemented
   - **Fix:** Implement chart per the [History Chart Specifications](#history-chart-specifications) section

---

## Future Considerations

From `TODO.md`:

1. **Replace SVG assets** with PNG/JPG equivalents
2. **Dependency Injection** - Implement `injectable` package for autowired service constructor injection
3. **Localization Migration** - Migrate from `easy_localization` to official `intl` package with ARB files

---

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

---

## Developer Scripts

| Script                           | Purpose                       |
| -------------------------------- | ----------------------------- |
| `scripts/build.sh`               | Full application rebuild      |
| `scripts/generate_db.sh`         | Generate Floor database files |
| `scripts/fix.sh`                 | Run dart fix                  |
| `scripts/connect_wifi_device.sh` | Connect to device over Wi-Fi  |
| `scripts/sync_db_from_device.sh` | Sync database from device     |

---

## Assets

### Images

- **Branding:** `assets/images/branding/logo.png`
- **Scents:** `assets/images/scents/{scent_name}.png` (14 images)
- **Reactions:** `assets/images/reactions/{reaction}.png` (6 images)

### Data

- **Supported Scents:** `assets/data/supported_scents.json`

### Localization Files

- **English (US):** `assets/i18n/en-US.json`

---

Last Updated: March 2026
