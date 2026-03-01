# SmellSense - Project Documentation

> **Note:** This repository is currently a work-in-progress and is incomplete. It may contain runtime, architectural, or programmatic errors. However, the general intent and structure of the existing architecture is established and documented here.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Purpose and Intent](#purpose-and-intent)
3. [Critical Features and Requirements](#critical-features-and-requirements)
4. [Project Framework and Architecture](#project-framework-and-architecture)
5. [Database Architecture](#database-architecture)
6. [Application Models and Modules](#application-models-and-modules)
7. [UI Flows and Navigation](#ui-flows-and-navigation)
8. [UI Components](#ui-components)
9. [Known Issues](#known-issues)
10. [Future Considerations](#future-considerations)

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

```yaml
dev_dependencies:
  build_runner: ^2.1.11 # Code generation runner
  floor_generator: ^1.5.0 # Floor code generation
  flutter_gen_runner: ^5.8.0 # Asset code generation
  flutter_launcher_icons: ^0.14.2 # App icon generation
  flutter_lints: ^5.0.0 # Linting rules
  json_serializable: ^6.8.0 # JSON serialization codegen
  lints: ^5.1.0 # Dart linting
```

### Project Structure

```
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
```

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         Application                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐       │
│  │    Pages     │◄───│   Router     │───►│   Widgets    │       │
│  └──────┬───────┘    └──────────────┘    └──────────────┘       │
│         │                                                        │
│         ▼                                                        │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                  Infrastructure                       │       │
│  │  ┌────────────────┐    ┌─────────────────────────┐   │       │
│  │  │ DatabaseService│    │SupportedTrainingScentPvd│   │       │
│  │  └───────┬────────┘    └─────────────────────────┘   │       │
│  └──────────┼───────────────────────────────────────────┘       │
│             │                                                    │
│             ▼                                                    │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                   Database Layer                      │       │
│  │  ┌─────────┐   ┌─────────┐   ┌─────────────────┐     │       │
│  │  │Services │◄──│  DAOs   │◄──│ SmellSenseDatabase│   │       │
│  │  └────┬────┘   └─────────┘   └─────────────────┘     │       │
│  │       │                                               │       │
│  │       ▼                                               │       │
│  │  ┌──────────┐                                         │       │
│  │  │ Entities │ ◄───────────── Floor ORM (SQLite)      │       │
│  │  └──────────┘                                         │       │
│  └──────────────────────────────────────────────────────┘       │
│                                                                  │
│  ┌──────────────────────────────────────────────────────┐       │
│  │                    Domain Layer                       │       │
│  │  ┌─────────────────┐  ┌─────────────────────────┐    │       │
│  │  │    Modules      │  │  SupportedTrainingScent │    │       │
│  │  │ (Domain Models) │  │      (Static Data)      │    │       │
│  │  └─────────────────┘  └─────────────────────────┘    │       │
│  └──────────────────────────────────────────────────────┘       │
│                                                                  │
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

```dart
@Database(version: 1, entities: [
  TrainingScentEntity,
  TrainingPeriodEntity,
  TrainingSessionEntity,
  TrainingSessionEntryEntity
])
@TypeConverters([DateTimeTypeConverter])
abstract class SmellSenseDatabase extends FloorDatabase {
  TrainingPeriodDao get trainingPeriodDao;
  TrainingSessionDao get trainingSessionDao;
  TrainingSessionEntryDao get trainingSessionEntryDao;
  TrainingScentDao get trainingScentDao;
}
```

### Entity-Relationship Diagram

```
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

#### TrainingPeriodEntity

```dart
@Entity(tableName: 'training_period')
class TrainingPeriodEntity {
  @primaryKey
  @ColumnInfo(name: 'id')
  final String id;

  @ColumnInfo(name: 'start_date')
  final DateTime startDate;
}
```

#### TrainingScentEntity

```dart
@Entity(tableName: 'training_scent')
class TrainingScentEntity {
  @primaryKey
  @ColumnInfo(name: 'id')
  final String id;

  @ColumnInfo(name: 'supported_scent_id')
  final String supportedScentId;

  @ForeignKey(
    childColumns: ['period_id'],
    parentColumns: ['id'],
    entity: TrainingPeriodEntity,
  )
  @ColumnInfo(name: 'period_id')
  final String periodId;
}
```

#### TrainingSessionEntity

```dart
@Entity(tableName: 'training_session')
class TrainingSessionEntity {
  @primaryKey
  final String id;

  @ForeignKey(
    entity: TrainingPeriodEntity,
    parentColumns: ['id'],
    childColumns: ['period_id'],
  )
  @ColumnInfo(name: 'period_id')
  final String periodId;

  @ColumnInfo(name: 'date')
  final DateTime date;
}
```

#### TrainingSessionEntryEntity

```dart
@Entity(tableName: 'training_session_entry')
class TrainingSessionEntryEntity {
  @primaryKey
  @ColumnInfo(name: 'id')
  final String id;

  @ForeignKey(entity: TrainingSessionEntity, ...)
  @ColumnInfo(name: 'session_id')
  final String sessionId;

  @ForeignKey(entity: TrainingScentEntity, ...)
  @ColumnInfo(name: 'scent_id')
  final String scentId;

  @ColumnInfo(name: 'rating')
  final int rating;

  @ColumnInfo(name: 'parosmia_reaction')
  final int? parosmiaReaction;

  @ColumnInfo(name: 'parosmia_reaction_severity')
  final int? parosmiaReactionSeverity;

  @ColumnInfo(name: 'comment')
  final String? comment;
}
```

### Data Access Objects (DAOs)

#### TrainingPeriodDao

```dart
@dao
abstract class TrainingPeriodDao {
  @Query('SELECT id, start_date FROM training_period')
  Future<List<TrainingPeriodEntity>?> listTrainingPeriods();

  @Query('SELECT ... ORDER BY start_date DESC LIMIT 1')
  Future<TrainingPeriodEntity?> findActiveTrainingPeriod();

  @insert
  Future<void> insertTrainingPeriod(TrainingPeriodEntity period);

  @update
  Future<void> updateTrainingPeriod(TrainingPeriodEntity period);

  @delete
  Future<void> deleteTrainingPeriod(TrainingPeriodEntity period);
}
```

#### TrainingScentDao

```dart
@dao
abstract class TrainingScentDao {
  @Query("SELECT ... WHERE id = :id")
  Future<TrainingScentEntity?> findTrainingScentById(String id);

  @Query('SELECT ... WHERE period_id = :periodId')
  Future<List<TrainingScentEntity>?> findTrainingScentsByPeriodId(String periodId);

  @insert
  Future<void> insertTrainingScent(TrainingScentEntity scent);
}
```

#### TrainingSessionDao

```dart
@dao
abstract class TrainingSessionDao {
  @Query('SELECT ... WHERE period_id = :periodId')
  Future<List<TrainingSessionEntity>> findTrainingSessionsByPeriodId(String periodId);

  @insert
  Future<void> insertTrainingSession(TrainingSessionEntity session);

  @delete
  Future<void> deleteTrainingSession(TrainingSessionEntity session);
}
```

#### TrainingSessionEntryDao

```dart
@dao
abstract class TrainingSessionEntryDao {
  @Query('SELECT ... WHERE session_id = :sessionId')
  Future<List<TrainingSessionEntryEntity>> findTrainingSessionEntries(String sessionId);

  @insert
  Future<void> insertTrainingSessionEntry(TrainingSessionEntryEntity entry);

  @transaction
  Future<void> deleteTrainingSessionEntries(String sessionId);
}
```

### Services Layer

Services wrap DAOs and convert between Entity ↔ Module (domain model).

#### Service Hierarchy

```
DatabaseService (Facade)
├── TrainingPeriodService
│   └── TrainingSessionService
│       └── TrainingSessionEntryService
│           └── TrainingScentService
└── TrainingScentService
```

#### DatabaseService (Facade)

```dart
class DatabaseService {
  late final TrainingPeriodService _trainingPeriodService;
  late final TrainingScentService _trainingScentService;
  late final TrainingSessionService _trainingSessionService;
  late final TrainingSessionEntryService _trainingSessionEntryService;

  // High-level operations
  Future<void> createTrainingPeriod(DateTime startDate, List<TrainingScent> scents);
  Future<void> recordTrainingSession(TrainingSession session);
  Future<List<TrainingScent>> getActiveTrainingScents();
  Future<List<TrainingPeriod>> getTrainingPeriods();
}
```

### Type Converters

```dart
class DateTimeTypeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) => value.millisecondsSinceEpoch;
}
```

### Infrastructure Provider

```dart
class Infrastructure {
  late final DatabaseService databaseService;
  late final SupportedTrainingScentProvider supportedTrainingScentProvider;

  // Context-based access
  Infrastructure.of(BuildContext context) {
    Infrastructure infrastructure = context.read<Infrastructure>();
    databaseService = infrastructure.databaseService;
    supportedTrainingScentProvider = infrastructure.supportedTrainingScentProvider;
  }

  // Bootstrap method (called once at app startup)
  static Future<Infrastructure> getInfrastructure() async {
    final databaseService = await DatabaseServiceProvider.create();
    return Infrastructure(
      databaseService: databaseService,
      supportedTrainingScentProvider: SupportedTrainingScentProvider(),
    );
  }
}
```

### Consumer Pattern

Pages access data through `FutureBuilder` with `Infrastructure.of(context).databaseService`:

```dart
FutureBuilder(
  future: Infrastructure.of(context).databaseService.getActiveTrainingScents(),
  builder: (context, AsyncSnapshot<List<TrainingScent>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return MyWidget(scents: snapshot.data!);
  },
)
```

---

## Application Models and Modules

### Domain Modules

Domain modules are located in `lib/app/shared/modules/` and represent the application's domain model.

#### TrainingPeriod

```dart
class TrainingPeriod {
  final String id;
  final DateTime startDate;
  final List<TrainingSession>? sessions;
}
```

#### TrainingScent

```dart
enum TrainingScentName {
  chamomile, cinnamon, citronella, clove, eucalyptus,
  garlic, grapefruit, lavender, lemon, mint,
  orange, rose, rosemary, teatree
}

class TrainingScent {
  static const maxTrainingScents = 4;
  final String id;
  final TrainingScentName name;
}
```

#### TrainingSession

```dart
class TrainingSession {
  final String id;
  final DateTime date;
  final List<TrainingSessionEntry> entries;
}
```

#### TrainingSessionEntry

```dart
class TrainingSessionEntry {
  final String id;
  final TrainingScent scent;
  TrainingSessionEntryRating rating;
  TrainingSessionEntryParosmiaReaction parosmiaReaction;
  TrainingSessionEntryParosmiaSeverity parosmiaReactionSeverity;
  String? comment;
}
```

#### Rating Enum

```dart
enum TrainingSessionEntryRating {
  none("none", 0),
  weak("weak", 1),
  normal("normal", 2),
  strong("strong", 3),
  altered("altered", 4);
}
```

#### Parosmia Reaction Enums

```dart
enum TrainingSessionEntryParosmiaSeverity {
  none(0), mild(1), moderate(2), severe(3);
}

enum TrainingSessionEntryParosmiaReaction {
  none(0), angry(1), disgusted(2), unhappy(3),
  neutral(4), pleased(5), happy(6);
}
```

### Static Data: Supported Training Scents

Supported scents are loaded from JSON at compile time using `@JsonLiteral`:

```dart
@JsonLiteral('../../../assets/data/supported_scents.json')
List<Map<String, String>> get supportedScentsData => _$supportedScentsDataJsonLiteral;

class SupportedTrainingScent {
  final String id;
  final String name;
  final Color displayColor;
  final Image displayImage;
}
```

### Provider: SupportedTrainingScentProvider

```dart
class SupportedTrainingScentProvider {
  List<SupportedTrainingScent> listSupportedTrainingScents();
  SupportedTrainingScent getSupportedTrainingScentById(String id);
  SupportedTrainingScent findSupportedTrainingScentByName(String name);
}
```

---

## UI Flows and Navigation

### Navigation Flow Diagram

```
┌──────────────────────────────────────────────────────────────────────┐
│                           Application Flow                            │
└──────────────────────────────────────────────────────────────────────┘

                              ┌─────────┐
                              │  Splash │
                              └────┬────┘
                                   │
                    ┌──────────────┼──────────────┐
                    │              │              │
                    ▼              │              │
         ┌──────────────────┐     │     ┌────────┴────────┐
         │ Scent Selection  │     │     │ (if previously  │
         │ (First-time user)│     │     │  configured)    │
         └────────┬─────────┘     │     └────────┬────────┘
                  │               │              │
                  └───────────────┼──────────────┘
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
        ┌───────────┐    ┌─────────────┐    ┌───────────┐    │
        │   Help    │    │   About     │    │ Training  │    │
        └───────────┘    └─────────────┘    │  Session  │    │
                                            └─────┬─────┘    │
                                                  │          │
                                                  └──────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                       Navigation Bar Routes                          │
│  ┌──────────────────┐  ┌────────────┐  ┌─────────────┐              │
│  │ Training History │  │    Help    │  │    About    │              │
│  │    (Home) 🏠     │  │     ❓     │  │      ℹ️     │              │
│  └──────────────────┘  └────────────┘  └─────────────┘              │
└─────────────────────────────────────────────────────────────────────┘
```

### Router Configuration

SmellSense uses **go_router** with code generation for type-safe routing.

#### Route Structure

```dart
@TypedShellRoute<BaseShellRouteData>(
  routes: [
    // Simple Shell (no navigation bar)
    TypedShellRoute<SimpleShellPageRouteData>(
      routes: [
        TypedGoRoute<SplashRouteData>(path: '/splash', name: 'splash'),
        TypedGoRoute<ScentSelectionRouteData>(path: '/scent-selection'),
        TypedGoRoute<TrainingSessionRouteData>(path: '/training-session'),
      ],
    ),
    // NavBar Shell (with navigation bar)
    TypedShellRoute<NavBarShellPageRouteData>(
      routes: [
        TypedGoRoute<TrainingSessionHistoryRouteData>(path: '/training-session-history'),
        TypedGoRoute<HelpRouteData>(path: '/help'),
        TypedGoRoute<AboutRouteData>(path: '/about'),
      ],
    )
  ],
)
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

#### Route Data Example

```dart
class TrainingSessionRouteData extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return PageTransition(
      page: const TrainingSessionPage(),
    );
  }
}
```

#### Navigation with Redirect

```dart
class SplashRouteData extends GoRouteData {
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    bool hasScentsSelected = prefs?.getBool('hasScentsSelected') ?? false;
    if (hasScentsSelected) {
      return TrainingSessionHistoryRouteData().location;
    }
    return location;
  }
}
```

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

- Scrollable help content
- Question/answer format

**Widgets Used:**

- `HelpParagraphWidget` - Styled question/answer sections

#### AboutPage (`/about`)

**Purpose:** Application info and contacts

**Features:**

- Creator information
- Contact details (Facebook, Email, Phone)
- External link launching

### Reusable Widgets

#### Animators (`lib/app/shared/widgets/animators/`)

**FadeAnimate**

```dart
FadeAnimate(
  fadeInDuration: Duration(seconds: 2),
  idleDuration: Duration(seconds: 1),
  fadeOutDuration: Duration(milliseconds: 700),
  onComplete: () { /* callback */ },
  child: MyWidget(),
)
```

**ScaleAnimate**

```dart
ScaleAnimate(
  initialScale: 1.0,
  finalScale: 1.5,
  duration: Duration(seconds: 5),
  onComplete: () { /* callback */ },
  child: MyWidget(),
)
```

#### LoaderWidget

Animated circular progress indicator with color-cycling animation.

#### CheckboxGroup

Form field widget for multi-select checkbox groups.

#### AppBar Widget

Custom app bar implementation.

### Page Transitions

Custom slide-up transition for page navigation:

```dart
class PageTransition<T extends Widget> extends CustomTransitionPage<T> {
  PageTransition({required T page}) : super(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1),  // Start from bottom
          end: Offset(0, 0),    // End at normal position
        ).animate(animation),
        child: child,
      );
    },
    child: page,
  );
}
```

### Theming

#### Material Theme

SmellSense uses a custom Material 3 theme generated from Material Theme Builder.

**Color Scheme:**

```dart
ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff006689),        // Deep blue
  primaryContainer: Color(0xff4da7d2),
  secondary: Color(0xff854e5f),      // Rose
  secondaryContainer: Color(0xffffc2d3),
  tertiary: Color(0xff4c6079),
  surface: Color(0xFFF0F0F0),
  error: Color(0xffba1a1a),
  // ... additional scheme colors
)
```

**Typography:**

- Display Font: Roboto
- Body Font: Open Sans

**Text Theme Customization:**

```dart
headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w100)
headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)
headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)
titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)
titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w200)
titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400)
```

**Widget Theme Data:**

- Custom `TextButtonThemeData`
- Custom `OutlinedButtonThemeData`
- Custom `CheckboxThemeData`
- Custom `ListTileThemeData`
- Custom `SnackBarThemeData`

#### Theme Usage

```dart
MaterialTheme theme = MaterialTheme.of(context);
TextTheme textTheme = theme.textTheme;
ColorScheme colorScheme = theme.colorScheme;
ThemeData themeData = theme.themeData;
```

### Localization

**Strategy:** `easy_localization` with JSON asset files

**Supported Locales:**

- `en-US` (English, United States)

**Usage:**

```dart
'pages.scent_selection.select_scents_headline'.tr()
'shared.scent_name.${scent.name}'.tr()
```

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

## Known Issues

1. **Midnight Training Session Bug**
   - **Issue:** Training sessions that start before midnight and end after midnight may break training history
   - **Potential Remediations:**
     - Use the session commit date as the session date
     - Prompt user to restart or cancel sessions crossing midnight

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

### Localization

- **English (US):** `assets/i18n/en-US.json`

---

_Last Updated: March 2026_
