import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ukhsc_mobile_app/core/logger.dart';

class StorageService {
  final _storage = FlutterSecureStorage();
  final _logger = AppLogger.getLogger('storage');
  final _storageSchemaVersion = 1;

  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> migrateSchema() async {
    final hasSchemaVersion = await _storage.containsKey(key: 'schema_version');
    if (!hasSchemaVersion) {
      _logger.warning('Schema version not found, trying to migrate...');
      final all = await _storage.readAll();
      if (all.isEmpty) {
        _logger.warning('No data found, skipping migration...');
        await _saveSchemaVersion();
        return;
      }
    }

    if (await _isSchemaOutdated()) {
      _logger.warning('Schema version is outdated, trying to migrate...');
      // TODO: in the future, we can implement a migration strategy (if we have version 2)
      await _storage.deleteAll();
      await _saveSchemaVersion();
      _logger.warning('Schema version migrated to $_storageSchemaVersion');
    }

    _logger.fine('Schema version is up-to-date');
  }

  Future<void> _saveSchemaVersion() async {
    await _storage.write(
        key: 'schema_version', value: _storageSchemaVersion.toString());
  }

  Future<bool> _isSchemaOutdated() async {
    final schemaVersion = await _storage.read(key: 'schema_version');
    _logger.fine('Current schema version: $schemaVersion');
    return schemaVersion != _storageSchemaVersion.toString();
  }
}
