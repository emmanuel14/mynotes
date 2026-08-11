import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';
import 'package:mynotes/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {

  final notes = FirebaseFirestore.instance.collection('notes');

  Future<CloudNote> getNote({required String documentId}) async {
    try {
      final snapshot = await notes.doc(documentId).get();
      if (snapshot.exists){
        return CloudNote.fromSnapshot(snapshot as QueryDocumentSnapshot<Map<String, dynamic>>);
      } else {
        throw CouldNotFindNoteException();
      }
    } catch (e) {
      throw CouldNotGetNoteException();
    }
  }

  void createNewNote({required String ownerUserId, required String text}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: text,
    });
  }

  static final FirebaseCloudStorage _shared = 
  FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}