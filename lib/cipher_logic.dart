// =============================================================================
// Vigenère Cipher Logic Functions
// =============================================================================

/// Converts an alphabetical character to its numeric value (0=A, 25=Z).
/// Returns -1 if the character is not a lowercase letter.
int charToNumericValue(String char) {
  if (char.isEmpty) return -1;
  final code = char.runes.first;

  // Check for lowercase alphabet range (as per Week 1-2: Dart types and variables)
  if (code >= 'a'.runes.first && code <= 'z'.runes.first) {
    return code - 'a'.runes.first;
  }
  return -1;
}

/// Converts a numeric value (0-25) back to an alphabetical character,
/// preserving the original case (upper/lower).
String numericValueToChar(int value, bool isUpperCase) {
  // Using concepts from Week 1: Dart operators and control flows
  if (value < 0 || value > 25) {
    return ''; // Invalid value
  }

  final base = isUpperCase ? 'A'.runes.first : 'a'.runes.first;
  return String.fromCharCode(base + value);
}

/// Validates if a character is an English alphabet letter
bool isAlphabetic(String char) {
  if (char.isEmpty) return false;
  final code = char.runes.first;
  return (code >= 'A'.runes.first && code <= 'Z'.runes.first) ||
      (code >= 'a'.runes.first && code <= 'z'.runes.first);
}

/// Main Vigenère Cipher function
/// text: The input text (plaintext for encrypt, ciphertext for decrypt)
/// key: The keyword used for shifting
/// encryptMode: true for Encryption (P + K), false for Decryption (P - K)
String vigenereCipher(String text, String key, bool encryptMode) {
  // Input validation (Week 1: Control flows)
  if (text.isEmpty) return "";

  // Clean the key - remove non-alphabetic characters and convert to lowercase
  // Using String manipulation from Week 1-2
  final cleanKey = key.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();

  if (cleanKey.isEmpty) {
    return "Error: Key must contain at least one alphabetical character";
  }

  // Using StringBuffer for efficient string building (Week 2: Functions)
  final result = StringBuffer();
  var keyIndex = 0;

  // Loop through each character in the input text
  for (int i = 0; i < text.length; i++) {
    final char = text[i];

    // Check if character is alphabetic using our helper function
    if (!isAlphabetic(char)) {
      // Non-alphabetic characters pass through unchanged
      result.write(char);
      continue;
    }

    // Preserve original case (Week 1: Dart types)
    final isUpperCase = (char.runes.first >= 'A'.runes.first &&
        char.runes.first <= 'Z'.runes.first);

    // Convert both text and key characters to numeric values (0-25)
    final textValue = charToNumericValue(char.toLowerCase());
    final keyChar = cleanKey[keyIndex % cleanKey.length];
    final keyValue = charToNumericValue(keyChar);

    int newValue;

    // Apply Vigenère cipher formula
    if (encryptMode) {
      // Encryption: C = (P + K) mod 26
      newValue = (textValue + keyValue) % 26;
    } else {
      // Decryption: P = (C - K) mod 26
      // Add 26 to ensure non-negative before modulo
      newValue = (textValue - keyValue + 26) % 26;
    }

    // Convert back to character and append to result
    result.write(numericValueToChar(newValue, isUpperCase));

    // Only advance key index for alphabetic characters
    keyIndex++;
  }

  return result.toString();
}

/// Helper function to demonstrate the cipher process step by step
/// This can be used for educational purposes
String explainVigenereCipher(String text, String key, bool encryptMode) {
  final cleanKey = key.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();
  final explanation = StringBuffer();

  explanation.writeln("Vigenère Cipher Process:");
  explanation.writeln("Input text: $text");
  explanation.writeln("Clean key: $cleanKey");
  explanation.writeln("Mode: ${encryptMode ? 'Encryption' : 'Decryption'}");
  explanation.writeln("---");

  var keyIndex = 0;

  for (int i = 0; i < text.length; i++) {
    final char = text[i];

    if (!isAlphabetic(char)) {
      explanation.writeln("'$char' → Non-alphabetic → '$char'");
      continue;
    }

    final isUpperCase = (char.runes.first >= 'A'.runes.first &&
        char.runes.first <= 'Z'.runes.first);
    final textValue = charToNumericValue(char.toLowerCase());
    final keyChar = cleanKey[keyIndex % cleanKey.length];
    final keyValue = charToNumericValue(keyChar);

    final operation = encryptMode ?
    "$textValue + $keyValue = ${textValue + keyValue} mod 26" :
    "$textValue - $keyValue + 26 = ${textValue - keyValue + 26} mod 26";

    final newValue = encryptMode ?
    (textValue + keyValue) % 26 :
    (textValue - keyValue + 26) % 26;

    final resultChar = numericValueToChar(newValue, isUpperCase);

    explanation.writeln("'$char' (${isUpperCase ? 'upper' : 'lower'}) → $operation → $newValue → '$resultChar'");

    keyIndex++;
  }

  return explanation.toString();
}
