// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';

class ObjectDetectionPage extends StatefulWidget {
  const ObjectDetectionPage({super.key});

  @override
  State<ObjectDetectionPage> createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends State<ObjectDetectionPage> {
  late ModelObjectDetection _objectModel;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];
  bool firststate = false;
  bool message = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    String pathObjectDetectionModel = "assets/models/best.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
          pathObjectDetectionModel, 3, 640, 640,
          labelPath: "assets/labels/label.txt");
      print("Object detection model loaded successfully.");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  void handleTimeout() {
    setState(() {
      firststate = true;
    });
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  //running detections on image

  Future runCameraObjectDetection() async {
    print("Running object detection on image from camera...");
    setState(() {
      firststate = false;
      message = false;
    });
    //pick an image
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, maxHeight: 664, maxWidth: 664);
    objDetect = await _objectModel.getImagePrediction(
        await File(image!.path).readAsBytes(),
        minimumScore: 0.1,
        IOUThershold: 0.3);
    for (var element in objDetect) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    }
    scheduleTimeout(5 * 1000);
    setState(() {
      _image = File(image.path);
    });
    // ignore: use_build_context_synchronously
    _showDetectionResults(context);
  }

  Future runGalleryObjectDetection() async {
    print("Running object detection on image from image...");
    setState(() {
      firststate = false;
      message = false;
    });

    // Pick an image from the gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      objDetect = await _objectModel.getImagePrediction(
          await File(image.path).readAsBytes(),
          minimumScore: 0.1,
          IOUThershold: 0.3);
      for (var element in objDetect) {
        print({
          "score": element?.score,
          "className": element?.className,
          "class": element?.classIndex,
          "rect": {
            "left": element?.rect.left,
            "top": element?.rect.top,
            "width": element?.rect.width,
            "height": element?.rect.height,
            "right": element?.rect.right,
            "bottom": element?.rect.bottom,
          },
        });
      }
      scheduleTimeout(5 * 1000);
      setState(() {
        _image = File(image.path);
      });
      // ignore: use_build_context_synchronously
      _showDetectionResults(context);
    }
  }

  Future<void> _updateProductCount(Map<String, int> classCount) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    try {
      for (var entry in classCount.entries) {
        String productName = entry.key.trim(); // Extract product name
        int productCount = entry.value; // Extract product count

        // Construct the database path for the product
        String productPath = '/products/$productName';

        // Update the count value of the product in the database
        await databaseRef.child(productPath).update({
          'count': productCount,
        });
      }
    } catch (error) {
      // Handle any errors that occurred during the database update
      print('Error updating product count: $error');
      // You can also show a snackbar or dialog to inform the user about the error
    }
    // Close the modal bottom sheet
    Navigator.pop(context);
  }

  void _showDetectionResults(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          Map<String, int> classCount = {};
          for (var detection in objDetect) {
            String className = detection?.className ?? '';
            classCount[className] = (classCount[className] ?? 0) + 1;
          }

          return SingleChildScrollView(
              child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Detected Products',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            IconlyLight.delete,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  for (var entry in classCount.entries)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 44,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff1e1e1e),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    entry.key,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(entry.value.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.black)),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 43,
                          width: 165,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                foregroundColor: const Color(0xff1e1e1e),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xff1e1e1e)),
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () => Navigator.pop(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Done',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 43,
                          width: 165,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1e1e1e),
                                foregroundColor: Colors.white60,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () async {
                              _updateProductCount(classCount);
                              isLoading = true;
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Update',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Visibility(
                                  visible: isLoading,
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  runCameraObjectDetection();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 232, 238, 240),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color.fromARGB(172, 213, 215, 215),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  minimumSize: const Size(100, 45),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyLight.camera,
                      size: 20,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  runGalleryObjectDetection();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 232, 238, 240),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color.fromARGB(172, 213, 215, 215),
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  minimumSize: const Size(100, 45),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyLight.paper,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                !firststate
                    ? !message
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.black,
                          ))
                        : Center(
                            child: Text(
                              "Take a photo or choose one from the gallery.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                    : Expanded(
                        child: SizedBox(
                            height: 640,
                            child: _objectModel.renderBoxesOnImage(
                                _image!, objDetect)),
                      ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
