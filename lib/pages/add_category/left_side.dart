import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryLeftSide extends StatefulWidget {
  const CategoryLeftSide({Key? key}) : super(key: key);

  @override
  State<CategoryLeftSide> createState() => _CategoryLeftSideState();
}

class _CategoryLeftSideState extends State<CategoryLeftSide> {
  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  String selctFile = '';
  XFile? file;
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;
  TextEditingController category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(120.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Category",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "The safest site on the web for storing your data!",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: category,
                decoration: const InputDecoration(
                    label: Text("Category Name"),
                    hintText: "Please write your Category Name"),
              ),
              const SizedBox(height: 24),
              selctFile.isEmpty
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        selectedImageInBytes!,
                        width: 150,
                        height: 150,
                      ),
                    ),
              MaterialButton(
                onPressed: () {
                  selectFile(true);
                },
                height: 52,
                elevation: 24,
                color: const Color(0xFF03DAC5),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Pick Image"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              MaterialButton(
                onPressed: () {
                  uploadFile();
                  Navigator.pop(context);
                },
                minWidth: double.infinity,
                height: 52,
                elevation: 24,
                color: const Color(0xFF03DAC5),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    ));
  }

  selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });

      fileResult.files.forEach((element) {
        setState(() {
          pickedImagesInBytes.add(element.bytes!);

          imageCounts += 1;
        });
      });
    }
    print(selctFile);
  }

  Future<String> uploadFile() async {
    String imageUrl = '';
    DocumentReference addPost = FirebaseFirestore.instance
        .collection('category')
        .doc(category.text.toString());
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('category')
          .child('/$selctFile');

      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      // uploadTask = ref.putFile(File(file!.path));
      uploadTask = ref.putData(selectedImageInBytes!, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      addPost.set({
        'image': imageUrl,
        "name": category.text.toString(),
        "time": DateTime.now().toIso8601String().toString(),
      });
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

// addCategory() async {
//   CollectionReference addPost =
//       FirebaseFirestore.instance.collection('category');
//   var imageName = basename(pickedImage!.path);
//   Uint8List imageData = await XFile(pickedImage!.path).readAsBytes();
//   var ref = FirebaseStorage.instance.ref('images/$imageName');
//   await ref.putData(imageData);
//   String imageUrl = await ref.getDownloadURL();
//   addPost.add({'image': imageUrl, "name": category.text.toString()});
// }
}
