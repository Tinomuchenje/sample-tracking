import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/views/authentication/authentication_controller.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/client_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/district_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/province_model.dart';
import 'package:sample_tracking_system_flutter/views/authentication/data/models/user_details.dart';
import 'package:sample_tracking_system_flutter/views/authentication/user_types_constants.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_multiselect_dropdown.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/notification_service.dart';
import 'package:search_choices/search_choices.dart';

import 'data/access_levels.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final _formKey = GlobalKey<FormState>();
  List<String> authorities = [];
  late AccessLevel accessLevelProvider;
   late UserDetails _userDetails;

  @override
  Widget build(BuildContext context) {
    accessLevelProvider = Provider.of<AccessLevel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(children: [
                CustomTextFormField(
                  labelText: 'First Name',
                  onSaved: (value) {
                    if (value != null) _userDetails.firstName = value;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Last Name',
                  onSaved: (value) {
                    if (value != null) _userDetails.lastName = value;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Email address',
                  hintText: 'yourname@brti.co.zw',
                  onSaved: (value) {
                    if (value != null) _userDetails.email = value;
                  },
                  customValidator: (value) {
                    if (value == null) {
                      return 'Field is required';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Password',
                  onSaved: (value) {
                    if (value != null) _userDetails.password = value;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Repeat Password',
                  customValidator: (value) {
                    if (value != _userDetails.password) {
                      return 'Password do not match';
                    }
                  },
                ),
                _selectAuthorities(context),
                _selectAccessLevel(),
                Visibility(
                  visible: accessLevelProvider.isClient,
                  child: Consumer<AccessLevel>(
                    builder: (context, access, child) {
                      return _selectClient(access.clients);
                    },
                  ),
                ),
                Visibility(
                  visible: accessLevelProvider.isDistrict,
                  child: Consumer<AccessLevel>(
                    builder: (context, access, child) {
                      return _selectDistricts(access.districts);
                    },
                  ),
                ),
                Visibility(
                  visible: accessLevelProvider.isProvince,
                  child: Consumer<AccessLevel>(
                    builder: (context, access, child) {
                      return _selectProvince(access.provinces);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    press: () async {
                      if (!_formKey.currentState!.validate()) return;

                      await AuthenticationController()
                          .registerAccount(_userDetails)
                          .then((success) {
                        if (success) {
                          NotificationService.success(
                              context, "User registered successfully");
                        } else {
                          NotificationService.error(
                              context, "Failed to register user");
                        }
                      });
                    },
                    displayText: 'Create Account',
                    fillcolor: true,
                  ),
                ),
              ])),
        ),
      ),
    );
  }

  CustomFormDropdown _selectAccessLevel() {
    const province = 'Province';
    const district = 'District';
    const client = 'Client';

    String selectedLevel = 'Nothing Selected';
    List<String> levels = ['Nothing Selected', province, district, client];

    var displayOptions = levels.map((level) {
      return DropdownMenuItem<String>(value: level, child: Text(level));
    }).toList();

    return CustomFormDropdown(
      items: displayOptions,
      onChanged: (value) {
        value as String;
        _userDetails.accessLevel = value;
        setAccessLevel(value, province, district, client);
      },
      onSaved: (value) {},
      value: selectedLevel,
      labelText: 'Access level',
    );
  }

  void setAccessLevel(
      String value, String province, String district, String client) {
    print(district);
    print(province);
    print(client);
    print(value);
    if (value == province) {
      accessLevelProvider.isProvince = true;
      return;
    }

    if (value == district) {
      accessLevelProvider.isDistrict = true;
      return;
    }

    if (value == client) {
      accessLevelProvider.isClient = true;
      return;
    }
  }

  Padding _selectAuthorities(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding / 2, bottom: defaultPadding / 2),
      child: TextFormField(
        controller: TextEditingController(text: authorities.take(3).join(', ')),
        keyboardType: TextInputType.none,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
          border: OutlineInputBorder(),
          labelText: 'Roles',
        ),
        onTap: () {
          _showMultiSelect(context);
        },
      ),
    );
  }

  List<MultiSelectDialogItem<String>> _buildMulitiselect(
      Map<String, String> values) {
    List<MultiSelectDialogItem<String>> displayOptions = [];

    for (String option in values.keys) {
      displayOptions.add(MultiSelectDialogItem(option, values[option] ?? ''));
    }

    return displayOptions;
  }

  void _showMultiSelect(BuildContext context) async {
    final valueToPopulate = {
      healthWorker: 'Health worker',
      courier: 'Courier',
      hub: 'Hub',
    };

    List<MultiSelectDialogItem<String>> items = [];

    for (String option in valueToPopulate.keys) {
      items.add(MultiSelectDialogItem(option, valueToPopulate[option] ?? ''));
    }

    final selectedValues = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return CustomMultiSelectDialog(
          items: items,
          title: 'Select roles',
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        _userDetails.authorities = selectedValues.toList();
      });
    }
  }

  Widget _selectClient(List<Client> clients) {
    var selectedValue;

    List<DropdownMenuItem> items = clients
        .map((client) => DropdownMenuItem<String>(
              value: client.name,
              child: Text(client.name),
            ))
        .toList();

    return SearchChoices.single(
        hint: const Text('Select Client'),
        value: selectedValue,
        items: items,
        displayClearIcon: false,
        isCaseSensitiveSearch: false,
        onChanged: (value) {
          _userDetails.accessId = value;
        });
  }

  Widget _selectDistricts(List<District> districts) {
    var selectedValue;

    List<DropdownMenuItem> items = districts
        .map((district) => DropdownMenuItem<String>(
              value: district.name,
              child: Text(district.name),
            ))
        .toList();

    return SearchChoices.single(
        hint: const Text('Select District'),
        value: selectedValue,
        items: items,
        displayClearIcon: false,
        isCaseSensitiveSearch: false,
        onChanged: (value) {
          _userDetails.accessId = value;
        });
  }

  Widget _selectProvince(List<Province> provinces) {
    List<DropdownMenuItem> items = provinces
        .map((province) => DropdownMenuItem<String>(
              value: province.name,
              child: Text(province.name),
            ))
        .toList();

    return SearchChoices.single(
        hint: const Text('Select Province'),
        value: _userDetails.accessId,
        items: items,
        displayClearIcon: false,
        isCaseSensitiveSearch: false,
        onChanged: (value) {
          _userDetails.accessId = value;
        });
  }
}
