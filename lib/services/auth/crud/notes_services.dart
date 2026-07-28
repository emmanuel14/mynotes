import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class DatabaseAlreadyOpenException implements Exception {}
class UnableToGetDocumentsDirectoryException implements Exception {}

class NotesServices {
  Database? _db;
  Future<void> open() async{
    if (_db != null) {
      throw DatabaseAlreadyOpenException() ;
    }
    try{
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

    // create the users table  

    const createUsersTable = '''CREATE TABLE IF NOT EXISTS "users" (
      "id"	INTEGER NOT NULL,
      "email"	TEXT NOT NULL UNIQUE,
      PRIMARY KEY("id" AUTOINCREMENT)
    );''';

    await db.execute(createUsersTable);

    const createNotesTable = '''CREATE TABLE IF NOT EXISTS "notes" (
      "id"	INTEGER NOT NULL,
      "user_id"	INTEGER NOT NULL,
      "text"	TEXT,
      "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
      PRIMARY KEY("id" AUTOINCREMENT),
      FOREIGN KEY("user_id") REFERENCES "users"("id")
    );''';

    await db.execute(createNotesTable);

    } on MissingPlatformDirectoryException{
      throw UnableToGetDocumentsDirectoryException();
    }
  }a
}

@immutable
class DataBaseUser{
  final int id;
  final String email;
  const DataBaseUser({
    required this.id,
    required this.email,
  });

  DataBaseUser.fromRow(Map<String, Object?> map)
      : id = map['idColumn'] as int,
        email = map['emailColumn'] as String;

 @override
  String toString() => 'Person, ID = $id, email = $email';   

  @override
  bool operator ==(covariant DataBaseUser other) => id == other.id;
  
  @override
  int get hashCode => id.hashCode; 
}

class DataBaseNote{
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;  

  DataBaseNote({
    required this.id,
    required this.userId,
    required this.text,
    required this.isSyncedWithCloud,
  });

  DataBaseNote.fromRow(Map<String, Object?> map)
      : id = map['idColumn'] as int,
        userId = map['userIdColumn'] as int,
        text = map['textColumn'] as String,
        isSyncedWithCloud =
         (map['isSyncedWithCloudColumn'] as int) == 1 ? true : false;

@override
  String toString() => 'Note, ID = $id, userId = $userId, isSyncedWithCloud = $isSyncedWithCloud, text = $text';

  @override
  bool operator ==(covariant DataBaseNote other) => id == other.id;
  
  @override
  int get hashCode => id.hashCode; 

}

const dbName = 'notes.db';
const notesTable = 'notes';
const usersTable = 'users';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';