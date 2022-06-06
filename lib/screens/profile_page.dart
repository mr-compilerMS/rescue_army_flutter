import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_army/models/user.dart';
import 'package:rescue_army/services/auth/app_auth_provider.dart';
import 'package:rescue_army/stores/app_store.dart';
import 'package:rescue_army/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

enum SingingCharacter { M, F, O }

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var fName = "Vaibhav";
  var mName = "Ravindra";
  var lName = "Dange";
  var email = "vaibhavdange01@gmail.com";
  var gender = "m";

  final fNameController = TextEditingController();
  final mNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();

  SingingCharacter? _gender;

  PickedFile? _imgae;

  @override
  void initState() {
    super.initState();
    _initiateForm();
  }

  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Your Profile")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            imageProfile(),
            const SizedBox(
              height: 10,
            ),
            _buildTextField(
              myController: fNameController,
              hint: "first name",
              lable: "first name",
            ),
            _buildTextField(
              myController: mNameController,
              hint: "middle name",
              lable: "middle name",
            ),
            _buildTextField(
              myController: lNameController,
              hint: "last name",
              lable: "last name",
            ),
            _buildTextField(
              myController: emailController,
              hint: "Email",
              lable: "Email",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Gender",
            ),
            _buildRadioButtonMale(),
            _buildRadioButtonFemale(),
            _buildRadioButtonOther(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => _save(),
              child: Container(
                  width: 150,
                  height: 50,
                  // color: Colors.deepPurple,
                  alignment: Alignment.center,
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // top circular profile image
  Widget imageProfile() {
    var profile = user.avatar != null
        ? (Constants.API_ENDPOINT + "" + user.avatar!).circularNetworkImage()
        : 'assets/images/profile.jpg'.circularAssetImage();
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            child: profile,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: _imgae == null
                      ? const AssetImage('assets/images/profile.jpg')
                      : FileImage(File(_imgae!.path)) as ImageProvider,
                  fit: BoxFit.fill),
              // image: AssetImage('assets/images/profile.jpg'),),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Color.fromARGB(255, 181, 219, 250),
                  size: 35,
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: ((builder) => editProfilePopup()));
                }),
          )
        ],
      ),
    );
  }

  // bottom popup for edit profile
  Widget editProfilePopup() {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text("Select profile image "),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                label: const Text(
                  "Gallery",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                icon: const Icon(
                  Icons.image,
                  size: 40,
                ),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(
                width: 30,
              ),
              TextButton.icon(
                label: const Text(
                  "Camera",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 40,
                ),
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _imagePicker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imgae = pickedFile;
      }
    });
  }

  void disposeControlers() {
    // Clean up the controller when the widget is disposed.
    fNameController.dispose();
    mNameController.dispose();
    lNameController.dispose();
    super.dispose();
  }

  // Textfield code
  Widget _buildTextField(
      {TextEditingController? myController,
      String? hint,
      String? lable,
      String? initialValue}) {
    return Container(
        //Type TextField
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32.0),
            child: Column(children: [
              TextFormField(
                controller: myController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: hint,
                    labelText: lable),
              ),
            ])));
  }

  // Radio button for male
  Widget _buildRadioButtonMale() {
    return Container(
      child: ListTile(
        title: Text("Male"),
        leading: Radio<SingingCharacter>(
          value: SingingCharacter.M,
          groupValue: _gender,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRadioButtonFemale() {
    return Container(
      child: ListTile(
        title: Text("Female"),
        leading: Radio<SingingCharacter>(
          value: SingingCharacter.F,
          groupValue: _gender,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRadioButtonOther() {
    return Container(
      child: ListTile(
        title: Text("Other"),
        leading: Radio<SingingCharacter>(
          value: SingingCharacter.O,
          groupValue: _gender,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
      ),
    );
  }

  User user = User();
  // Inatializing the previous values of user information
  void _initiateForm() async {
    var u = AppStore().user;
    if (u != null) user = u;
    user = await AppAuthProvider().currentUser ?? user;

    fNameController.text = user.firstName ?? "";
    mNameController.text = user.middleName ?? "";
    lNameController.text = user.lastName ?? "";
    switch (user.gender) {
      case 'M':
        _gender = SingingCharacter.M;
        break;
      case 'F':
        _gender = SingingCharacter.M;
        break;
      default:
        _gender = SingingCharacter.O;
    }
    setState(() {});
  }

  // Code for saving the data in database below
  void _save() {
    fName = fNameController.text;
    mName = mNameController.text;
    lName = lNameController.text;
    email = lNameController.text;

    print(_gender);
    print(fName);
    print(mName);
    print(lName);
  }
}


// while saving if any value is empty
// if empty then give error for firsttime
// if not first time then do not change default value