import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';


import '../../../providers/tts_provider.dart';
import '../../../widgets/tts_toggle_button.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  String? selectedState;
  String? selectedScheme;
  bool declarationAccepted = false;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakScreen());
  }

  void _speakScreen() {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    final l = AppLocalizations.of(context)!;
    tts.speak([
      l.sim1_form_appBarSub,
      l.sim1_form_simulationNote,
      l.sim1_form_scamAlert,
      l.sim1_form_partAHeader,
      l.sim1_form_partBHeader,
      l.sim1_form_partCHeader,
      l.sim1_form_partDHeader,
      l.sim1_form_partEHeader,
      l.sim1_form_declarationHint,
      l.sim1_form_submitBtn,
    ].join(' '));
  }

  void _speakDialog(String text) {
    final tts = context.read<TtsProvider>();
    if (!tts.enabled) return;
    tts.speak(text);
  }

  @override
  void dispose() {
    context.read<TtsProvider>().stop();
    super.dispose();
  }

  void _showWarning(String title, String message,
      {IconData icon = Icons.warning_amber_rounded}) {
    _speakDialog('$title. $message');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(width: 10),
            Expanded(
                child: Text(title, style: const TextStyle(fontSize: 18))),
          ],
        ),
        content:
        Text(message, style: const TextStyle(fontSize: 16, height: 1.6)),
        actions: [
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_circle_outline),
            label: Text(AppLocalizations.of(context)!.sim1_common_iUnderstand,
                style: const TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }

  void _submitForm() {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.sim1_form_validationError),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!declarationAccepted) {
      _showWarning(
        l.sim1_form_declarationRequired,
        l.sim1_form_declarationRequiredMsg,
        icon: Icons.info_outline,
      );
      return;
    }

    _speakDialog(l.sim1_form_confirmSpeak);

    showDialog(
      context: context,
      builder: (context) {
        final l = AppLocalizations.of(context)!;
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.help_outline, color: Colors.blue, size: 28),
              const SizedBox(width: 10),
              Text(l.sim1_form_confirmTitle,
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.sim1_form_confirmBody,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Text(
                  l.sim1_form_confirmWarning,
                  style: const TextStyle(fontSize: 14, height: 1.6),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.sim1_common_cancel,
                  style: const TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sim1-call');
              },
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(l.sim1_form_submitBtn,
                  style: const TextStyle(
                      fontSize: 16, color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Divider(color: Colors.blue.shade200, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    String? warningTitle,
    String? warningMessage,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        style: const TextStyle(fontSize: 17),
        onTap: warningMessage != null
            ? () => _showWarning(warningTitle ?? '⚠', warningMessage)
            : null,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(fontSize: 15),
          prefixIcon: Icon(icon, size: 22),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final List<String> stateList = l.sim1_form_stateList.split(',');
    final List<String> schemeList = l.sim1_form_schemeList.split('|');

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.sim1_form_appBarTitle,
                style:
                const TextStyle(fontSize: 12, color: Colors.white70)),
            Text(l.sim1_form_appBarSub,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TtsToggleButton(onToggled: _speakScreen),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Emblem_of_India.svg/800px-Emblem_of_India.svg.png',
              height: 36,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.account_balance, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.blue.shade600],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.sim1_form_headerTitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l.sim1_form_simulationNote,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),

              // Scam alert
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.red.shade200, width: 1.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.gpp_bad, color: Colors.red, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l.sim1_form_scamAlert,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),

              // Part A: Scheme
              _sectionHeader(l.sim1_form_partAHeader, Icons.assignment),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: DropdownButtonFormField<String>(
                  value: selectedScheme,
                  decoration: InputDecoration(
                    labelText: l.sim1_form_selectSchemeLabel,
                    labelStyle: const TextStyle(fontSize: 15),
                    prefixIcon:
                    const Icon(Icons.list_alt, size: 22),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                  ),
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black87),
                  items: schemeList
                      .map((s) => DropdownMenuItem(
                      value: s.trim(), child: Text(s.trim())))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => selectedScheme = val),
                  validator: (val) =>
                  val == null ? l.sim1_form_selectSchemeError : null,
                ),
              ),

              // Part B: Personal
              _sectionHeader(l.sim1_form_partBHeader, Icons.person),
              _buildField(
                controller: nameController,
                label: l.sim1_form_fullNameLabel,
                icon: Icons.person_outline,
                hint: l.sim1_form_fullNameHint,
                validator: (v) => v == null || v.trim().length < 3
                    ? l.sim1_form_fullNameError
                    : null,
              ),
              _buildField(
                controller: fatherNameController,
                label: l.sim1_form_fatherNameLabel,
                icon: Icons.family_restroom,
                hint: l.sim1_form_fatherNameHint,
                validator: (v) => v == null || v.trim().length < 3
                    ? l.sim1_form_fatherNameError
                    : null,
              ),
              _buildField(
                controller: mobileController,
                label: l.sim1_form_mobileLabel,
                icon: Icons.phone_android,
                hint: l.sim1_form_mobileHint,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 10,
                validator: (v) => v == null || v.length != 10
                    ? l.sim1_form_mobileError
                    : null,
              ),

              // Part C: Aadhaar
              _sectionHeader(l.sim1_form_partCHeader, Icons.badge),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border:
                  Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l.sim1_form_aadhaarLesson,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.orange,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              _buildField(
                controller: aadhaarController,
                label: l.sim1_form_aadhaarLabel,
                icon: Icons.credit_card,
                hint: l.sim1_form_aadhaarHint,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 12,
                warningTitle: l.sim1_form_cautionTitle,
                warningMessage: l.sim1_form_aadhaarWarning,
                validator: (v) => v == null || v.length != 12
                    ? l.sim1_form_aadhaarError
                    : null,
              ),

              // Part D: Bank
              _sectionHeader(
                  l.sim1_form_partDHeader, Icons.account_balance),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border:
                  Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l.sim1_form_bankLesson,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.orange,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              _buildField(
                controller: bankController,
                label: l.sim1_form_bankLabel,
                icon: Icons.account_balance_wallet,
                hint: l.sim1_form_bankHint,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                warningTitle: l.sim1_form_cautionTitle,
                warningMessage: l.sim1_form_bankWarning,
                validator: (v) => v == null || v.trim().length < 9
                    ? l.sim1_form_bankError
                    : null,
              ),
              _buildField(
                controller: ifscController,
                label: l.sim1_form_ifscLabel,
                icon: Icons.code,
                hint: l.sim1_form_ifscHint,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[A-Za-z0-9]')),
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return l.sim1_form_ifscErrorEmpty;
                  }
                  if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$')
                      .hasMatch(v.toUpperCase())) {
                    return l.sim1_form_ifscErrorInvalid;
                  }
                  return null;
                },
              ),

              // Part E: Address
              _sectionHeader(
                  l.sim1_form_partEHeader, Icons.location_on),
              _buildField(
                controller: villageController,
                label: l.sim1_form_villageLabel,
                icon: Icons.home,
                hint: l.sim1_form_villageHint,
                validator: (v) => v == null || v.trim().isEmpty
                    ? l.sim1_form_villageError
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: DropdownButtonFormField<String>(
                  value: selectedState,
                  decoration: InputDecoration(
                    labelText: l.sim1_form_stateLabel,
                    labelStyle: const TextStyle(fontSize: 15),
                    prefixIcon: const Icon(Icons.map, size: 22),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                  ),
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black87),
                  items: stateList
                      .map((s) => DropdownMenuItem(
                      value: s.trim(), child: Text(s.trim())))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => selectedState = val),
                  validator: (val) =>
                  val == null ? l.sim1_form_stateError : null,
                ),
              ),

              // Declaration
              _sectionHeader(
                  l.sim1_form_declarationHeader, Icons.verified_user),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  l.sim1_form_declarationText,
                  style:
                  const TextStyle(fontSize: 14, height: 1.7),
                ),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: declarationAccepted,
                onChanged: (val) => setState(
                        () => declarationAccepted = val ?? false),
                title: Text(
                  l.sim1_form_declarationCheckbox,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 24),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _submitting ? null : _submitForm,
                  icon: _submitting
                      ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.send, size: 22),
                  label: Text(
                    _submitting
                        ? l.sim1_form_submitting
                        : l.sim1_form_submitBtn,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Footer
              Center(
                child: Text(
                  l.sim1_form_footer,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey, height: 1.6),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}