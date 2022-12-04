// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:riverrr/constant/import.dart';

class EditPeoplePage extends StatefulWidget {
  const EditPeoplePage({super.key, required this.userModel, required this.id});
  final UserResponse? userModel;
  final String id;
  @override
  State<EditPeoplePage> createState() => _EditPeoplePageState();
}

class _EditPeoplePageState extends State<EditPeoplePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode nameFn = FocusNode();
  FocusNode addressFn = FocusNode();
  FocusNode phoneFn = FocusNode();
  FocusNode emailFn = FocusNode();
  FocusNode cityFn = FocusNode();
  FocusNode zipFn = FocusNode();
  FocusNode birthDateFn = FocusNode();
  final _formKey = GlobalKey<FormState>();
  File? imageFile;

  String? dropdownvalue;
  bool isLoading = false;

  _loadingState(bool iIsLoading) {
    isLoading = iIsLoading;
    _notify();
  }

  @override
  void initState() {
    super.initState();

    log(widget.userModel!.toJson().toString());

    if (widget.userModel != null) {
      nameController.text = widget.userModel?.name ?? "";
      emailController.text = widget.userModel?.email ?? "";
      birthDateController.text = widget.userModel?.birthDate ?? "";
      phoneController.text = widget.userModel?.phone.toString() ?? "";
      addressController.text = widget.userModel?.address ?? "";
      cityController.text = widget.userModel?.city ?? "";
      zipController.text = widget.userModel?.zip.toString() ?? "";
      if (widget.userModel?.state != null && widget.userModel?.state != '') {
        dropdownvalue = widget.userModel?.state ?? "";
      }
    }
  }

  _notify() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Edit People"),
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        CustomBottomSheet().bottomBar(
                          context: context,
                          onCameraTap: () {
                            Navigator.pop(context);
                            onCameraTap();
                          },
                          onGalleryTap: () {
                            Navigator.pop(context);
                            onGalleryTap();
                          },
                        );
                      },
                      child: Container(
                        height: imageHeight,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                          border: Border.all(color: kPrimaryColor, width: 0.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFBEBEBE),
                              offset: Offset(10, 10),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(10, 10),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(300),
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                  height: imageHeight,
                                  width: imageHeight,
                                ),
                              )
                            : widget.userModel?.url != null &&
                                    widget.userModel?.url != ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(300),
                                    child: Image.network(
                                      widget.userModel?.url ?? "",
                                      fit: BoxFit.cover,
                                      height: imageHeight,
                                      width: imageHeight,
                                    ),
                                  )
                                : Icon(
                                    Icons.camera_alt,
                                    color: kPrimaryColor,
                                    size: 30,
                                  ),
                      ),
                    ),
                    TextFeildWidget(
                      controller: nameController,
                      focusNode: nameFn,
                      hint: "Name",
                      prefixIcon: Icons.person,
                      validator: (val) {
                        log(val.toString());
                        if (val == null || val.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                    ),
                    TextFeildWidget(
                      controller: emailController,
                      focusNode: emailFn,
                      hint: "Email",
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        log(val.toString());
                        if (val == null || val.isEmpty) {
                          return "Enter email";
                        } else if (val.contains('@') == false) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1947),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          var tempdate = date.toString().split(" ").first;
                          birthDateController.text = tempdate;
                          _notify();
                        }
                      },
                      child: TextFeildWidget(
                        enabled: false,
                        controller: birthDateController,
                        focusNode: birthDateFn,
                        hint: "Birthday",
                        prefixIcon: Icons.cake,
                        suffixWidget: Icon(
                          Icons.calendar_month,
                          color: kPrimaryColor,
                          size: 25,
                        ),
                        validator: (val) {
                          log(val.toString());
                          if (val == null || val.isEmpty) {
                            return "Enter Birthday";
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFeildWidget(
                      controller: phoneController,
                      focusNode: phoneFn,
                      keyboardType: TextInputType.phone,
                      hint: "Phone",
                      prefixIcon: Icons.call,
                      maxLength: 10,
                      validator: (val) {
                        log(val.toString());
                        if (val == null || val.isEmpty) {
                          return "Enter phone";
                        } else if (val.isNotEmpty && val.length < 10) {
                          return "Enter 10 digit phone number";
                        }
                        return null;
                      },
                    ),
                    TextFeildWidget(
                      controller: addressController,
                      focusNode: addressFn,
                      hint: "Address",
                      prefixIcon: Icons.location_on,
                      validator: (val) {
                        log(val.toString());
                        if (val == null || val.isEmpty) {
                          return "Enter address";
                        }
                        return null;
                      },
                    ),
                    dropdown(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFeildWidget(
                            controller: cityController,
                            focusNode: cityFn,
                            hint: "City",
                            prefixIcon: Icons.near_me,
                            validator: (val) {
                              log(val.toString());
                              if (val == null || val.isEmpty) {
                                return "Enter city";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextFeildWidget(
                            controller: zipController,
                            focusNode: zipFn,
                            hint: "Zipcode",
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.onetwothree,
                            maxLength: 6,
                            validator: (val) {
                              log(val.toString());
                              if (val == null || val.isEmpty) {
                                return "Enter zipcode";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
      bottomNavigationBar: ButtomWidget(
        text: 'Save',
        onTap: () {
          if (_formKey.currentState!.validate()) {
            validate();
          }
        },
      ),
    );
  }

  Widget dropdown() {
    return Container(
      height: hw,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          border: Border.all(
            color: kPrimaryColor,
            width: 1,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: hw,
            height: hw,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kBorderRadius),
                bottomLeft: Radius.circular(kBorderRadius),
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.location_city_outlined,
              color: kwhiteColor,
            ),
          ),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownvalue,
              hint: const Text("State"),
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: [
                'Gujarat',
                'Maharashtra',
                'Rajasthan',
                'Punjab',
                'Bihar',
              ].map((String? items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items ?? ""),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownvalue = newValue!;
                _notify();
              },
            ),
          ),
        ],
      ),
    );
  }

  validate() async {
    if (await Network.checkInternet()) {
      _loadingState(true);
      try {
        final service = ApiServices();
        UserResponse userResponse = UserResponse(
          url: widget.userModel?.url,
          name: nameController.text.trim(),
          address: addressController.text.trim(),
          birthDate: birthDateController.text.trim(),
          city: cityController.text.trim(),
          email: emailController.text.trim(),
          zip: int.parse(zipController.text),
          phone: int.parse(phoneController.text),
          state: dropdownvalue,
        );

        String saved = await service.updateUser(
            userModel: userResponse, id: widget.id, file: imageFile);
        if (saved != '') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(saved),
            ),
          );
          Navigator.pop(context);
        }
        _loadingState(false);
      } catch (e) {
        _loadingState(false);
        log(e.toString());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Internet'),
        ),
      );
    }
  }

  onCameraTap() async {
    DevicePermission.checkPermissionStatus(
      onSucess: () async {
        File? file = await Pictures()
            .getPicture(source: ImageSource.camera, context: context);

        if (file != null) {
          imageFile = file;
          _notify();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Unable to pick Image"),
            ),
          );
        }
      },
      permission: Permission.storage,
    );
  }

  onGalleryTap() {
    DevicePermission.checkPermissionStatus(
      onSucess: () async {
        File? file = await Pictures()
            .getPicture(source: ImageSource.gallery, context: context);

        if (file != null) {
          imageFile = file;
          _notify();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Unable to pick Image"),
            ),
          );
        }
      },
      permission: Permission.storage,
    );
  }
}
