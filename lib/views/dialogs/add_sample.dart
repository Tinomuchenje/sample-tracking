import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_tracking_system_flutter/consts/constants.dart';
import 'package:sample_tracking_system_flutter/models/patient.dart';
import 'package:sample_tracking_system_flutter/models/sample.dart';
import 'package:sample_tracking_system_flutter/providers/samples_provider.dart';
import 'package:sample_tracking_system_flutter/utils/dao/laboratory_dao.dart';
import 'package:sample_tracking_system_flutter/views/patient/search_patient.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_date_form_field.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_elevated_button.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_form_dropdown.dart';
import 'package:sample_tracking_system_flutter/views/widgets/custom_text_form_field.dart';
import 'package:sample_tracking_system_flutter/views/widgets/samples_tab.dart';

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
  TextEditingController? dateController;

  @override
  Widget build(BuildContext context) {
    bool isNewForm = widget.sampleData == null;
    final Sample _sample = widget.sampleData ?? Sample();

    String _appBarText = isNewForm ? 'Add' : 'Update';
    String _saveButtonText = isNewForm ? 'Save' : 'Update';
    String? _patientInitialValue = "";

    if (widget.patient != null) {
      _patientInitialValue = widget.patient!.clientPatientId ?? "";
      _patientInitialValue = _patientInitialValue +
          ": " +
          (widget.patient!.firstname ?? "") +
          " " +
          (widget.patient!.lastname ?? "");
    } else {
      _patientInitialValue = _sample.clientPatientId;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('$_appBarText Sample'),
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
                          enabled: widget.patient == null || isNewForm,
                          initialValue: _patientInitialValue,
                          onSaved: (value) {
                            if (value != null) _sample.clientPatientId = value;
                          }),
                      _sampleTypes(_sample),
                      _testsDropdown(_sample),
                      DateFormField(
                        labelText: "Date Collected",
                        initialValue: _sample.dateCollected,
                        dateController: dateController,
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
                            labelText: "Date Synced",
                            initialValue: _sample.dateSynced),
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                            enabled: false,
                            labelText: "Lab Reference Id",
                            initialValue: _sample.labReferenceId),
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: const CustomTextFormField(
                            enabled: false,
                            labelText: "Location",
                            initialValue: "Hurungwe"),
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: CustomTextFormField(
                          labelText: "Shipment",
                          initialValue: _sample.shipmentId,
                        ),
                      ),
                      Visibility(
                        visible: !isNewForm,
                        child: const CustomTextFormField(
                            enabled: false,
                            labelText: "Client Contact",
                            initialValue: "Admin"),
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

                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const SamplesTab(),
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
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();

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
      showNotification(context);
    }
  }

  void saveOrUpdateSample(Sample _sample, BuildContext context) {
    var sampleProvider = Provider.of<SamplesProvider>(context, listen: false);

    widget.sampleData != null
        ? sampleProvider.updateSample(_sample)
        : sampleProvider.addSample(_sample);
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

    var sampleTypesMenus = sampleTypes.map((String sampleType) {
      return DropdownMenuItem<String>(
          value: sampleType, child: Text(sampleType));
    }).toList();

    return CustomFormDropdown(
        items: sampleTypesMenus,
        hint: const Text("Sample Types"),
        value: sampleType ?? _sample.sampleType,
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
      value: _test ?? _sample.labId,
      hint: const Text("Select Test"),
      items: testMenus,
      onSaved: (value) {
        _sample.labId = value.toString();
      },
      onChanged: (value) {
        _test = value as String;
      },
    );
  }

  void showNotification(BuildContext context) {
    // we should extract this into common area for forms
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sample saved"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
