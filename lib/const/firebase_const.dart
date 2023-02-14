import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const sellerCollection = "sellerCollection";
const chatsCollection = "Chats";
const messagesCollection = "messages";
const ordersCollection = "orders";
const vegetableCollection = "Vegetables";
const fruitsCollection = "Fruits";
