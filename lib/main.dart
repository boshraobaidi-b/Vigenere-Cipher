import 'package:flutter/material.dart';
import 'cipher_logic.dart';

void main() {
  runApp(const CipherApp());
}

class CipherApp extends StatelessWidget {
  const CipherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoGuard Pro',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const CipherHomePage(),
    );
  }
}

class CipherHomePage extends StatefulWidget {
  const CipherHomePage({super.key});

  @override
  State<CipherHomePage> createState() => _CipherHomePageState();
}

class _CipherHomePageState extends State<CipherHomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _resultText = "Your encrypted text will appear here...";
  bool _isEncryptMode = true;

  void _processCipher() {
    if (_textController.text.isEmpty) {
      setState(() {
        _resultText = "🔍 Please enter some text to process.";
      });
      return;
    }

    if (_keyController.text.isEmpty) {
      setState(() {
        _resultText = "🔑 Please enter a cipher key.";
      });
      return;
    }

    final processedText = vigenereCipher(
      _textController.text,
      _keyController.text,
      _isEncryptMode,
    );

    setState(() {
      _resultText = processedText;
    });
  }

  void _clearAll() {
    setState(() {
      _textController.clear();
      _keyController.clear();
      _resultText = "Your encrypted text will appear here...";
    });
  }

  void _swapText() {
    setState(() {
      final temp = _textController.text;
      _textController.text = _resultText;
      _resultText = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔥 ENHANCED HEADER SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple.shade700,
                    Colors.purple.shade600,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // App Icon & Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'CryptoGuard Pro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Military-grade Vigenère Cipher Encryption',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 10),

                  // 🎯 MODE SELECTION CARD
                  Card(
                    elevation: 8,
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.blue.shade50,
                            Colors.purple.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              'OPERATION MODE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Encrypt Button
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isEncryptMode = true;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                        gradient: _isEncryptMode
                                            ? LinearGradient(
                                          colors: [
                                            Colors.green.shade600,
                                            Colors.green.shade400,
                                          ],
                                        )
                                            : null,
                                        color: _isEncryptMode ? null : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: _isEncryptMode
                                              ? Colors.green.shade400
                                              : Colors.grey[300]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.lock,
                                            color: _isEncryptMode
                                                ? Colors.white
                                                : Colors.green,
                                            size: 24,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'ENCRYPT',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: _isEncryptMode
                                                  ? Colors.white
                                                  : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                // Decrypt Button
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isEncryptMode = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                        gradient: !_isEncryptMode
                                            ? LinearGradient(
                                          colors: [
                                            Colors.blue.shade600,
                                            Colors.blue.shade400,
                                          ],
                                        )
                                            : null,
                                        color: !_isEncryptMode ? null : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: !_isEncryptMode
                                              ? Colors.blue.shade400
                                              : Colors.grey[300]!,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.lock_open,
                                            color: !_isEncryptMode
                                                ? Colors.white
                                                : Colors.blue,
                                            size: 24,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'DECRYPT',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: !_isEncryptMode
                                                  ? Colors.white
                                                  : Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 📝 INPUT TEXT CARD
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.text_fields,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'INPUT TEXT',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _textController,
                            maxLines: 4,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Enter your secret message here...',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🔑 KEY INPUT CARD
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.vpn_key,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'CIPHER KEY',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _keyController,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Enter your secret key...',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🚀 ACTION BUTTONS
                  Row(
                    children: [
                      // Process Button
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _isEncryptMode
                                  ? [Colors.green.shade600, Colors.green.shade400]
                                  : [Colors.blue.shade600, Colors.blue.shade400],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: (_isEncryptMode
                                    ? Colors.green
                                    : Colors.blue)
                                    .withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _processCipher,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _isEncryptMode
                                      ? Icons.lock
                                      : Icons.lock_open,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isEncryptMode
                                      ? 'ENCRYPT MESSAGE'
                                      : 'DECRYPT MESSAGE',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const SizedBox(width: 8),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: IconButton(
                          onPressed: _clearAll,
                          icon: Icon(
                            Icons.cleaning_services,
                            color: Colors.red.shade700,
                            size: 24,
                          ),
                          tooltip: 'Clear All',
                        ),
                      ),
                      // Swap Button
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: IconButton(
                          onPressed: _swapText,
                          icon: Icon(
                            Icons.swap_horiz,
                            color: Colors.orange.shade700,
                            size: 24,
                          ),
                          tooltip: 'Swap Input/Output',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 📊 RESULT CARD
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _isEncryptMode
                                    ? Icons.enhanced_encryption
                                    : Icons.no_encryption,
                                color: _isEncryptMode ? Colors.green : Colors.blue,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isEncryptMode
                                    ? 'ENCRYPTED RESULT'
                                    : 'DECRYPTED RESULT',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _isEncryptMode
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'VIGENÈRE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                            ),
                            child: SelectableText(
                              _resultText,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 💡 INFO CARD
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.deepPurple.shade50,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '💡 Vigenère Cipher uses a keyword to create unbreakable encryption. '
                                  'Keep your key secret for maximum security!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.deepPurple,
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
    );
  }
}
