import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boxer/core/services/client_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Function to add a client to Firestore
Future<void> addClient(ClientModel client) async {
  try {
    DocumentReference docRef = _firestore.collection('clients').doc();
    await docRef.set(client.toJson());
  } catch (e) {
    throw Exception("Failed to add client: $e");
  }
}

// Function to retrieve a list of clients from Firestore
Future<List<ClientModel>> getClients() async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection('clients').get();
    return querySnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return ClientModel.fromJson(data)..id = doc.id;
    }).toList();
  } catch (e) {
    throw Exception("Failed to retrieve clients: $e");
  }
}

// Function to update a client's details
Future<void> updateClient(ClientModel client) async {
  try {
    if (client.id.isNotEmpty) {
      await _firestore.collection('clients').doc(client.id).update(client.toJson());
    } else {
      throw Exception("Client ID is empty, cannot update.");
    }
  } catch (e) {
    throw Exception("Failed to update client: $e");
  }
}

// Function to delete a client
Future<void> deleteClient(String clientId) async {
  try {
    await _firestore.collection('clients').doc(clientId).delete();
  } catch (e) {
    throw Exception("Failed to delete client: $e");
  }
}
