import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:folio/logic/user.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Portfolio {
  final String tittle, description, technologies, date, email;
  final List<Asset> images;
  List<String> imageUrls = <String>[];

  // final List<String> imageUrls ;

  String docid;
  User user;
  Portfolio(
      {@required this.tittle,
      @required this.description,
      @required this.technologies,
      @required this.date,
      @required this.email,
      @required this.images
      // @required this.imageUrls,

      });
  // final portfolio = Firestore.instance.collection('portfolio');
  // final collRef = Firestore.instance.collection('gameLevels');
  Future<dynamic> postImage(Asset image, String name) async {
    String path = "users_food_images/$name";

    final StorageReference storageReference =
        FirebaseStorage().ref().child(path);
    final StorageUploadTask uploadTask = storageReference
        .putData((await image.getByteData()).buffer.asUint8List());
    var value = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = value.toString();
    print("url ${url.toString()}");
    return url;
    //   _imageFile =File(images[0].toString())  ;
    //    StorageReference storageReference = FirebaseStorage.instance
    //      .ref() ;
    //     //  .child('chats/${Path.basename(_image.path)}}');
    //  StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    //  await uploadTask.onComplete;
    //  print('File Uploaded');
    //  storageReference.getDownloadURL().then((fileURL) {

    //      imageUrls[1] = fileURL;

    //  });
    //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //   StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    //   StorageUploadTask uploadTask =
    // reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    //   StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    //   print(storageTaskSnapshot.ref.getDownloadURL());
    //   return storageTaskSnapshot.ref.getDownloadURL();
  }

  bool uploadportfolio() {
    bool state = false;
    for (var imageFile in images) {
      postImage(imageFile, imageFile.name).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          // Portfolio x = Portfolio(tittle: tittle, description: description, technologies: technology, date: date,email: "email");
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance.collection('images').document(documnetID).setData({
            'urls': imageUrls,
            'full_name': tittle,
            'description': description,
            'technologies': technologies,
            'date': date,
            'email': email,
          }).then((_) {
            state = true;
          });
        }
      }).catchError((err) {
        print(err.toString());
        return err.toString();
      });
    }
    return state;
  }

  // Future<String> addportofolio() async {
  //   // String email;
  //   // User p;
  //   await portfolio
  //       .add({
  //         'full_name': tittle,
  //         'description': description,
  //         'age': technologies,
  //         'date': date,
  //         'email': email,
  //         // 'usl':imageUrls
  //       })
  //       .then((value) {docid = value.documentID ;
  //       // print(docid);
  //       }  )
  //       .catchError((error) => print("Failed to add user: $error"));

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // void inputData() async {
  //   final FirebaseUser user =
  //       await auth.currentUser().then((FirebaseUser user) {
  //     final userid = user.uid;
  //     email = userid;
  //     // rest of the code|  do stuff
  //   });
  //   // here you write the codes to input the data into firestore
  // }

  // Call the user's CollectionReference to add a new user
  // return docid;
  // }
}
