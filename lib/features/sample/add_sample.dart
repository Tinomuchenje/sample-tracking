import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/features/home/home_page.dart';
import 'package:sample_tracking_system_flutter/features/sample/state/samples_provider.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';

import 'package:sample_tracking_system_flutter/features/patient/search_patient.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_date_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_elevated_button.dart';
import 'package:sample_tracking_system_flutter/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/widgets/notification_service.dart';

class AddorUpdateSampleDialog extends StatefulWidget {
  final Patient? patient;
  final Sample? sampleData;
  const AddorUpdateSampleDialog({Key? key, this.sampleData, this.patient})
      : super(key: key);

  @override
  State<AddorUpdateSampleDialog> createState() =>
      _AddorUpdateSampleDialogState();
}

class _AddorUpdateSampleDialogState extends State<AddorUpdateSampleDialog> {
  final _formKey = GlobalKey<FormState>();
  LaboratoryDao laboratoryDao = LaboratoryDao();

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.sampleData == null;
    final Sample _sample = widget.sampleData ?? Sample();
    String? _patientInitialValue = "";
    String? _patientId = "";
    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';

    if (widget.patient != null) {
      _patientId = widget.patient!.clientPatientId;
      _patientInitialValue = _patientInitialValue +
          // ": " +
          (widget.patient!.firstName) +
          " " +
          (widget.patient!.lastName);
    }

    bool enablePatientField = false;
    if (_patientId.isEmpty) {
      enablePatientField = true;
    }
    if (_patientId.isEmpty && _sample.clientPatientId.isNotEmpty) {
      enablePatientField = false;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('$_appBarText Sample for $_patientInitialValue'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  child: Column(
                    children: <Widget>[
                      CustomTextFormField(
                          labelText: "Patient",
                          enabled: enablePatientField,
                          initialValue: _patientId.isEmpty
                              ? _sample.clientPatientId
                              : _patientId,
                          onSaved: (value) {
                            if (value != null) _sample.clientPatientId = value;
                          }),
                      CustomTextFormField(
                          labelText: "Client Sample Id",
                          initialValue: _sample.clientSampleId,
                          onSaved: (value) {
                            if (value != null) _sample.clientSampleId = value;
                          }),
                      _sampleTypes(_sample),
                      _testsDropdown(_sample),
                      DateFormField(
                        labelText: "Date Collected",
                        initialValue: _sample.dateCollected.isEmpty
                            ? null
                            : _sample.dateCollected,
                        onSaved: (value) {
                          if (value != null) {
                            _sample.dateCollected = value.toString();
                          }
                        },
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                          enabled: false,
                          labelText: "Status",
                          initialValue: _sample.status,
                        ),
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                            enabled: false,
                            labelText: "Location",
                            initialValue: "Hurungwe"),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: CustomElevatedButton(
                              displayText: _saveButtonText,
                              fillcolor: true,
                              press: () {
                                if (!_formKey.currentState!.validate()) return;

                                saveSampleForm(_sample, context);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => HomePage(
                                      pageIndex: 2,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: CustomElevatedButton(
                              displayText: "$_saveButtonText & New",
                              fillcolor: true,
                              press: () {
                                if (!_formKey.currentState!.validate()) return;
                                saveSampleForm(_sample, context);

                                showSearch(
                                    context: context,
                                    delegate: PatientSearch());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void saveSampleForm(Sample _sample, BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      saveOrUpdateSample(_sample, context);
      NotificationService.success(context, "Sample saved");
    }
  }

  void saveOrUpdateSample(Sample _sample, BuildContext context) {
    Provider.of<SamplesProvider>(context, listen: false).addSample(_sample);
  }

  _sampleTypes(Sample _sample) {
    var sampleType;

    var sampleTypes = [
      "Nasal swab",
      "Dried Blood Spot",
      "Nasopharyngeal",
      "Aspirate",
      "Red blood cells",
      "Cervical swab",
      "Blood plasma",
      "Bocal swab",
      "Throat Swab",
      "Fluid",
      "Whole blood",
      "DBS",
      "Nasopharyngeal swab",
      "Sputum",
      "Biopsy",
      "csf",
    ];

    var sampleTypesMenus = sampleTypes
        .map((String sampleType) {
          return DropdownMenuItem<String>(
              value: sampleType, child: Text(sampleType));
        })
        .toSet()
        .toList();

    return CustomFormDropdown(
        items: sampleTypesMenus,
        labelText: "Sample Types",
        value: sampleType ?? _sample.sampleType.isEmpty
            ? null
            : _sample.sampleType,
        onChanged: (value) {
          sampleType = value.toString();
        },
        onSaved: (value) {
          _sample.sampleType = value.toString();
        });
  }

  _testsDropdown(Sample _sample) {
    var _test;

    var testMenus = [
      const DropdownMenuItem<String>(
        value: "Viral Load",
        child: Text("Viral Load"),
      ),
      const DropdownMenuItem<String>(
        value: "Tuberculousis",
        child: Text("Tuberculousis"),
      ),
      const DropdownMenuItem<String>(
        value: "Covid",
        child: Text("Covid"),
      ),
    ];

    return CustomFormDropdown(
      value: _test ?? _sample.labId.isEmpty ? null : _sample.labId,
      labelText: "Select Test",
      items: testMenus,
      onSaved: (value) {
        _sample.labId = value.toString();
      },
      onChanged: (value) {
        _test = value as String;
      },
    );
  }
}
