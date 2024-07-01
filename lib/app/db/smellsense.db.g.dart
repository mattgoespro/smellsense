// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smellsense.db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $SmellSenseDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $SmellSenseDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $SmellSenseDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<SmellSenseDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorSmellSenseDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $SmellSenseDatabaseBuilderContract databaseBuilder(String name) =>
      _$SmellSenseDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $SmellSenseDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$SmellSenseDatabaseBuilder(null);
}

class _$SmellSenseDatabaseBuilder
    implements $SmellSenseDatabaseBuilderContract {
  _$SmellSenseDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $SmellSenseDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $SmellSenseDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<SmellSenseDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$SmellSenseDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$SmellSenseDatabase extends SmellSenseDatabase {
  _$SmellSenseDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TrainingPeriodDao? _trainingPeriodDaoInstance;

  TrainingSessionDao? _trainingSessionDaoInstance;

  TrainingSessionEntryDao? _trainingSessionEntryDaoInstance;

  TrainingScentDao? _trainingScentDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TrainingScentEntity` (`id` TEXT NOT NULL, `period_id` TEXT NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TrainingPeriodEntity` (`id` TEXT NOT NULL, `start_date` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TrainingSessionEntity` (`id` TEXT NOT NULL, `period_id` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TrainingSessionEntryEntity` (`id` TEXT NOT NULL, `session_id` TEXT NOT NULL, `scent_id` TEXT NOT NULL, `rating` INTEGER NOT NULL, `comment` TEXT, `parosmia_reaction` INTEGER, `parosmia_reaction_severity` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TrainingPeriodDao get trainingPeriodDao {
    return _trainingPeriodDaoInstance ??=
        _$TrainingPeriodDao(database, changeListener);
  }

  @override
  TrainingSessionDao get trainingSessionDao {
    return _trainingSessionDaoInstance ??=
        _$TrainingSessionDao(database, changeListener);
  }

  @override
  TrainingSessionEntryDao get trainingSessionEntryDao {
    return _trainingSessionEntryDaoInstance ??=
        _$TrainingSessionEntryDao(database, changeListener);
  }

  @override
  TrainingScentDao get trainingScentDao {
    return _trainingScentDaoInstance ??=
        _$TrainingScentDao(database, changeListener);
  }
}

class _$TrainingPeriodDao extends TrainingPeriodDao {
  _$TrainingPeriodDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _trainingPeriodEntityInsertionAdapter = InsertionAdapter(
            database,
            'TrainingPeriodEntity',
            (TrainingPeriodEntity item) => <String, Object?>{
                  'id': item.id,
                  'start_date': _dateTimeTypeConverter.encode(item.startDate)
                },
            changeListener),
        _trainingPeriodEntityUpdateAdapter = UpdateAdapter(
            database,
            'TrainingPeriodEntity',
            ['id'],
            (TrainingPeriodEntity item) => <String, Object?>{
                  'id': item.id,
                  'start_date': _dateTimeTypeConverter.encode(item.startDate)
                },
            changeListener),
        _trainingPeriodEntityDeletionAdapter = DeletionAdapter(
            database,
            'TrainingPeriodEntity',
            ['id'],
            (TrainingPeriodEntity item) => <String, Object?>{
                  'id': item.id,
                  'start_date': _dateTimeTypeConverter.encode(item.startDate)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TrainingPeriodEntity>
      _trainingPeriodEntityInsertionAdapter;

  final UpdateAdapter<TrainingPeriodEntity> _trainingPeriodEntityUpdateAdapter;

  final DeletionAdapter<TrainingPeriodEntity>
      _trainingPeriodEntityDeletionAdapter;

  @override
  Stream<List<TrainingPeriodEntity>> listTrainingPeriods() {
    return _queryAdapter.queryListStream(
        'SELECT id, start_date FROM TrainingPeriod',
        mapper: (Map<String, Object?> row) => TrainingPeriodEntity(
            id: row['id'] as String,
            startDate: _dateTimeTypeConverter.decode(row['start_date'] as int)),
        queryableName: 'TrainingPeriod',
        isView: false);
  }

  @override
  Future<TrainingPeriodEntity?> findCurrentTrainingPeriod() async {
    return _queryAdapter.query(
        'SELECT id, start_date FROM TrainingPeriod ORDER BY start_date DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => TrainingPeriodEntity(
            id: row['id'] as String,
            startDate:
                _dateTimeTypeConverter.decode(row['start_date'] as int)));
  }

  @override
  Future<TrainingPeriodEntity?> findTrainingPeriodById(String id) async {
    return _queryAdapter.query(
        'SELECT id, start_date FROM TrainingPeriod WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TrainingPeriodEntity(
            id: row['id'] as String,
            startDate: _dateTimeTypeConverter.decode(row['start_date'] as int)),
        arguments: [id]);
  }

  @override
  Future<void> insertTrainingPeriod(TrainingPeriodEntity period) async {
    await _trainingPeriodEntityInsertionAdapter.insert(
        period, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTrainingPeriod(TrainingPeriodEntity period) async {
    await _trainingPeriodEntityUpdateAdapter.update(
        period, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTrainingPeriod(TrainingPeriodEntity period) async {
    await _trainingPeriodEntityDeletionAdapter.delete(period);
  }
}

class _$TrainingSessionDao extends TrainingSessionDao {
  _$TrainingSessionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _trainingSessionEntityInsertionAdapter = InsertionAdapter(
            database,
            'TrainingSessionEntity',
            (TrainingSessionEntity item) =>
                <String, Object?>{'id': item.id, 'period_id': item.periodId});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TrainingSessionEntity>
      _trainingSessionEntityInsertionAdapter;

  @override
  Stream<List<TrainingSessionEntryEntity>> findTrainingSessionsByPeriodId(
      String periodId) {
    return _queryAdapter.queryListStream(
        'SELECT id, period_id FROM TrainingSession as ts INNER JOIN TrainingPeriod as tsp ON ts.period_id = tsp.id WHERE tsp.id = ?1',
        mapper: (Map<String, Object?> row) => TrainingSessionEntryEntity(
            id: row['id'] as String,
            sessionId: row['session_id'] as String,
            scentId: row['scent_id'] as String,
            rating: row['rating'] as int,
            comment: row['comment'] as String?,
            parosmiaReactionSeverity:
                row['parosmia_reaction_severity'] as String?,
            parosmiaReaction: row['parosmia_reaction'] as int?),
        arguments: [periodId],
        queryableName: 'TrainingSession',
        isView: false);
  }

  @override
  Future<void> insertTrainingSession(TrainingSessionEntity session) async {
    await _trainingSessionEntityInsertionAdapter.insert(
        session, OnConflictStrategy.abort);
  }
}

class _$TrainingSessionEntryDao extends TrainingSessionEntryDao {
  _$TrainingSessionEntryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _trainingSessionEntryEntityInsertionAdapter = InsertionAdapter(
            database,
            'TrainingSessionEntryEntity',
            (TrainingSessionEntryEntity item) => <String, Object?>{
                  'id': item.id,
                  'session_id': item.sessionId,
                  'scent_id': item.scentId,
                  'rating': item.rating,
                  'comment': item.comment,
                  'parosmia_reaction': item.parosmiaReaction,
                  'parosmia_reaction_severity': item.parosmiaReactionSeverity
                },
            changeListener),
        _trainingSessionEntryEntityDeletionAdapter = DeletionAdapter(
            database,
            'TrainingSessionEntryEntity',
            ['id'],
            (TrainingSessionEntryEntity item) => <String, Object?>{
                  'id': item.id,
                  'session_id': item.sessionId,
                  'scent_id': item.scentId,
                  'rating': item.rating,
                  'comment': item.comment,
                  'parosmia_reaction': item.parosmiaReaction,
                  'parosmia_reaction_severity': item.parosmiaReactionSeverity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TrainingSessionEntryEntity>
      _trainingSessionEntryEntityInsertionAdapter;

  final DeletionAdapter<TrainingSessionEntryEntity>
      _trainingSessionEntryEntityDeletionAdapter;

  @override
  Future<List<TrainingSessionEntryEntity>>
      findTrainingSessionEntriesBySessionId(String sessionId) async {
    return _queryAdapter.queryList(
        'SELECT id, session_id, date, scent, rating, comment, severity, response FROM TrainingSessionEntry as tse INNER JOIN TrainingSession as ts ON ts.id = tse.session_id WHERE ts.id = ?1',
        mapper: (Map<String, Object?> row) => TrainingSessionEntryEntity(id: row['id'] as String, sessionId: row['session_id'] as String, scentId: row['scent_id'] as String, rating: row['rating'] as int, comment: row['comment'] as String?, parosmiaReactionSeverity: row['parosmia_reaction_severity'] as String?, parosmiaReaction: row['parosmia_reaction'] as int?),
        arguments: [sessionId]);
  }

  @override
  Future<void> insertTrainingSessionEntries(
      TrainingSessionEntryEntity entry) async {
    await _trainingSessionEntryEntityInsertionAdapter.insert(
        entry, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTrainingSessionEntry(
      TrainingSessionEntryEntity entry) async {
    await _trainingSessionEntryEntityDeletionAdapter.delete(entry);
  }

  @override
  Future<void> deleteTrainingSessionEntriesBySessionId(String sessionId) async {
    if (database is sqflite.Transaction) {
      await super.deleteTrainingSessionEntriesBySessionId(sessionId);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$SmellSenseDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.trainingSessionEntryDao
            .deleteTrainingSessionEntriesBySessionId(sessionId);
      });
    }
  }
}

class _$TrainingScentDao extends TrainingScentDao {
  _$TrainingScentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _trainingScentEntityInsertionAdapter = InsertionAdapter(
            database,
            'TrainingScentEntity',
            (TrainingScentEntity item) => <String, Object?>{
                  'id': item.id,
                  'period_id': item.periodId,
                  'name': item.name
                }),
        _trainingScentEntityUpdateAdapter = UpdateAdapter(
            database,
            'TrainingScentEntity',
            ['id'],
            (TrainingScentEntity item) => <String, Object?>{
                  'id': item.id,
                  'period_id': item.periodId,
                  'name': item.name
                }),
        _trainingScentEntityDeletionAdapter = DeletionAdapter(
            database,
            'TrainingScentEntity',
            ['id'],
            (TrainingScentEntity item) => <String, Object?>{
                  'id': item.id,
                  'period_id': item.periodId,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TrainingScentEntity>
      _trainingScentEntityInsertionAdapter;

  final UpdateAdapter<TrainingScentEntity> _trainingScentEntityUpdateAdapter;

  final DeletionAdapter<TrainingScentEntity>
      _trainingScentEntityDeletionAdapter;

  @override
  Future<List<TrainingScentEntity>?> findTrainingScentsByPeriod(
      String periodId) async {
    return _queryAdapter.queryList(
        'SELECT id, name FROM TrainingScent WHERE period_id = ?1',
        mapper: (Map<String, Object?> row) => TrainingScentEntity(
            id: row['id'] as String,
            periodId: row['period_id'] as String,
            name: row['name'] as String),
        arguments: [periodId]);
  }

  @override
  Future<void> insertTrainingScent(TrainingScentEntity scent) async {
    await _trainingScentEntityInsertionAdapter.insert(
        scent, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTrainingScent(TrainingScentEntity scent) async {
    await _trainingScentEntityUpdateAdapter.update(
        scent, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTrainingScent(TrainingScentEntity scent) async {
    await _trainingScentEntityDeletionAdapter.delete(scent);
  }
}

// ignore_for_file: unused_element
final _dateTimeTypeConverter = DateTimeTypeConverter();
