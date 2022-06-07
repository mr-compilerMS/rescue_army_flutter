import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_army/models/user.dart';
import 'package:rescue_army/utils/constants.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

enum SingingCharacter { M, F, O }

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final fNameController = TextEditingController();
  final mNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  String? phone;
  SingingCharacter? _gender;

  PickedFile? _imgae;

  @override
  void initState() {
    super.initState();
    phone = ModalRoute.of(context)!.settings.arguments as String;
  }

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("New User")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // imageNewUserScreen(),
              const SizedBox(
                height: 10,
              ),
              _buildTextField(
                myController: fNameController,
                hint: "First name",
                lable: "First name",
              ),
              // _buildTextField(
              //   myController: mNameController,
              //   hint: "middle name",
              //   lable: "middle name",
              // ),
              _buildTextField(
                myController: lNameController,
                hint: "Last name",
                lable: "Last name",
              ),
              _buildTextField(
                myController: emailController,
                hint: "Email",
                lable: "Email",
              ),
              _buildTextField(
                myController: passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Invalid Password';
                  }
                  return null;
                },
                hint: "Password",
                lable: "Password",
              ),
              _buildTextField(
                myController: passwordConfirmController,
                validator: (value) {
                  if (passwordController.text != value) {
                    return 'Password Doesn\'t Match';
                  }
                  return null;
                },
                hint: "Confirm Password",
                lable: "Confirm Password",
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: _save,
                  child: Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // top circular profile image
  Widget imageNewUserScreen() {
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
                      builder: ((builder) => editNewUserScreenPopup()));
                }),
          )
        ],
      ),
    );
  }

  // bottom popup for edit profile
  Widget editNewUserScreenPopup() {
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
      String? initialValue,
      String? Function(String?)? validator}) {
    return Container(
        //Type TextField
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32.0),
            child: Column(children: [
              TextFormField(
                validator: validator,
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
  void _save() async {
    _formKey.currentState!.validate();
    user.firstName = fNameController.text;
    user.lastName = lNameController.text;
    user.email = emailController.text;
    user.phone = phone;
    user.username = user.email;
    if (passwordConfirmController.text == passwordController.text)
      user.password = passwordController.text;
    else
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Password and confirm password does not match"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });

    if (_formKey.currentState!.validate()) {
      post(Uri.parse(Constants.API_ENDPOINT + '/auth/users/'),
          body: user.toJson(),
          headers: {
            'Content-Type': 'application/json',
          }).then((value) {
        if (value.statusCode == 200) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.signin);
        }
      });
    }
  }
}


// while saving if any value is empty
// if empty then give error for firsttime
// if not first time then do not change default value