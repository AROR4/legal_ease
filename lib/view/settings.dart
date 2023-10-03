import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_xlider/flutter_xlider.dart';


class UserSettings {
  String name;
  bool isDarkMode;
  String selectedLanguage;
  bool enableFingerprint;

  UserSettings({
    required this.name,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.enableFingerprint,
  });
}

class Settings extends StatefulWidget {
  final String name;
  final bool isDarkMode;
  final String selectedLanguage;
  final bool enableFingerprint;
  const Settings({super.key,
  required this.name,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.enableFingerprint,});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  late UserSettings userSettings;

@override
  void initState() {
    super.initState();
    userSettings = UserSettings(
      name: widget.name,
      isDarkMode: widget.isDarkMode,
      selectedLanguage: widget.selectedLanguage,
      enableFingerprint: widget.enableFingerprint,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // iconTheme: IconThemeData.fallback(),
        // backgroundColor: Color.fromARGB(255, 241, 243, 247),
        title: Text(
          "Settings",
          style: TextStyle(
            // fontFamily: "Roboto Mono",
            // fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // color: Color.fromARGB(255, 241, 243, 247),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSettingCard(
                        "Theme",
                        userSettings.isDarkMode ? "Dark" : "Light",
                        () => _toggleTheme(),
                      ),
                      // 16.heightBox,
                      _buildSettingCard(
                        "Language",
                        userSettings.selectedLanguage,
                        () => _showLanguageDialog(),
                      ),
                      // 16.heightBox,
                      _buildFingerprintCard(),
                    ],
                  ).py32(),
                ),
              ),
            ),
          ),
        ],
      ),
    );



    
  }

Widget _buildSettingCard(String title, String subtitle, Function() onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  Widget _buildFingerprintCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 3,
      child: ListTile(
        title: Text("Enable Fingerprint"),
        trailing: Switch(
          value: userSettings.enableFingerprint,
          onChanged: (value) {
            setState(() {
              userSettings.enableFingerprint = value;
            });
            // Add any additional functionality if needed when the switch is toggled.
          },
        ),
      ),
    );
  }

  Future<void> _showNameDialog() async {
    final TextEditingController nameController =
        TextEditingController(text: userSettings.name);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Name"),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userSettings.name = nameController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _toggleTheme() {
    setState(() {
      userSettings.isDarkMode = !userSettings.isDarkMode;
    });
  }

  Future<void> _showLanguageDialog() async {
    String selectedLanguage = userSettings.selectedLanguage;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption("English", selectedLanguage),
              _buildLanguageOption("Spanish", selectedLanguage),
              _buildLanguageOption("French", selectedLanguage),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language, String selectedLanguage) {
    return ListTile(
      title: Text(language),
      onTap: () {
        setState(() {
          userSettings.selectedLanguage = language;
        });
        Navigator.of(context).pop();
      },
      trailing: language == selectedLanguage ? Icon(Icons.check) : null,
    );
  }

}

