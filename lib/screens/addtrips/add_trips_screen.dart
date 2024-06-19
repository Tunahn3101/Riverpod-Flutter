import 'dart:io';

import 'package:bottombar/common/app_size.dart';
import 'package:bottombar/riverpod/input_notifier.dart';
import 'package:bottombar/screens/addtrips/input_textfield.dart';
import 'package:bottombar/screens/image_view/full_image_screen.dart';
import 'package:bottombar/screens/maps/google_map_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../map/map_screen.dart';
import 'models/input_text_model.dart';

class AddTripsScreen extends ConsumerStatefulWidget {
  const AddTripsScreen({super.key});

  @override
  _AddTripsScreenState createState() => _AddTripsScreenState();
}

class _AddTripsScreenState extends ConsumerState<AddTripsScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  LocationData? currentLocation;

  void optionPickImage(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade100,
      context: context,
      builder: (builder) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.5,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage(context, ImageSource.camera, ref);
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 50,
                      ),
                      Text('Camera'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pickImage(context, ImageSource.gallery, ref);
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.image,
                        size: 50,
                      ),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(
      BuildContext context, ImageSource source, WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      ref.read(selectedImageProvider.notifier).state = imageFile;
      Navigator.pop(context);
    }
  }

  Future<void> _getLocation() async {
    final location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
      locationController.text =
          '${locationData.latitude}, ${locationData.longitude}';
    });
    // Navigate to the MapScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(currentLocation: locationData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<String> genderItems = ['Male', 'Female', 'Other'];
    String? selectedValue;

    final formKey = GlobalKey<FormState>();

    String? validateName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Name cannot be empty';
      }
      return null;
    }

    String? validateDescription(String? value) {
      if (value == null || value.isEmpty) {
        return 'Description cannot be empty';
      }
      return null;
    }

    String? validateLocation(String? value) {
      if (value == null || value.isEmpty) {
        return 'Location cannot be empty';
      }
      return null;
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: AppSize.uiPadding,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              InputTextField(
                validator: validateName,
                labletext: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 10),
              InputTextField(
                validator: validateDescription,
                labletext: 'Description',
                controller: descriptionController,
              ),
              const SizedBox(height: 10),
              InputTextField(
                validator: validateLocation,
                labletext: 'Location',
                controller: locationController,
              ),
              ElevatedButton(
                onPressed: _getLocation,
                child: const Text('Get Location'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                hint: const Text(
                  'Select Your Gender',
                  style: TextStyle(fontSize: 14),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                  return null;
                },
                onChanged: (value) {
                  selectedValue = value.toString();
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  final selectedImage = ref.watch(selectedImageProvider);

                  return selectedImage != null
                      ? Container(
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(selectedImage),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FullImageScreen(imageFile: selectedImage),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Icon(Icons.image, size: 50),
                        );
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  optionPickImage(context, ref);
                },
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final selectedImage =
                        ref.read(selectedImageProvider.notifier).state;
                    final imagePath = selectedImage?.path;

                    final input = InputTextModel(
                      name: nameController.text,
                      description: descriptionController.text,
                      location: locationController.text,
                      gender: selectedValue!,
                      imagePath:
                          imagePath, // imagePath có thể là null nếu không chọn ảnh
                    );

                    ref.read(inputProvider.notifier).addInput(input);

                    // Clear text fields and the selected image after adding
                    nameController.clear();
                    descriptionController.clear();
                    locationController.clear();
                    ref.read(selectedImageProvider.notifier).state = null;

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Trip added successfully')),
                    );
                  }
                },
                child: const Text('Add'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoogleMapPage(),
                        ));
                  },
                  child: const Text('Open google map'))
            ],
          ),
        ),
      ),
    );
  }
}
