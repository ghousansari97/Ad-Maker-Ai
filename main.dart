import 'package:flutter/material.dart';

void main() {
  runApp(const AdMakerAI());
}

class AdMakerAI extends StatelessWidget {
  const AdMakerAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdMaker AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AdMaker AI')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'AI Video Ad Maker',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Apne business ke liye professional short video advertisement banayein.',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateAdScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Padding(
                padding: EdgeInsets.all(14),
                child: Text('Create New Advertisement'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessName = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _product = TextEditingController();
  final _offer = TextEditingController();

  String category = 'Retail';
  String language = 'Roman Urdu';
  String duration = '30 sec';
  String style = 'Promotional';
  String voice = 'Male';

  @override
  void dispose() {
    _businessName.dispose();
    _address.dispose();
    _phone.dispose();
    _product.dispose();
    _offer.dispose();
    super.dispose();
  }

  Widget field(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Required' : null,
      ),
    );
  }

  Widget dropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void generatePreview() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewScreen(
          businessName: _businessName.text.trim(),
          product: _product.text.trim(),
          language: language,
          duration: duration,
          style: style,
          voice: voice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Ad')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            field('Business Name', _businessName),
            field('Business Address', _address),
            field('Phone Number', _phone, keyboardType: TextInputType.phone),
            field('Product / Service', _product),
            field('Special Offer', _offer),
            dropdown('Business Category', category,
                ['Retail', 'Restaurant', 'Salon', 'Real Estate', 'Education', 'Other'],
                (v) => setState(() => category = v!)),
            dropdown('Language', language,
                ['Urdu', 'Roman Urdu', 'English'],
                (v) => setState(() => language = v!)),
            dropdown('Duration', duration,
                ['15 sec', '30 sec', '45 sec'],
                (v) => setState(() => duration = v!)),
            dropdown('Style', style,
                ['Professional', 'Cinematic', 'Luxury', 'Local Business', 'Promotional'],
                (v) => setState(() => style = v!)),
            dropdown('Voice', voice,
                ['Male', 'Female'],
                (v) => setState(() => voice = v!)),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: generatePreview,
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Text('Generate Ad'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String businessName;
  final String product;
  final String language;
  final String duration;
  final String style;
  final String voice;

  const PreviewScreen({
    super.key,
    required this.businessName,
    required this.product,
    required this.language,
    required this.duration,
    required this.style,
    required this.voice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ad Preview')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: const Center(
                  child: Text(
                    'VIDEO PREVIEW\\n\\nAI video rendering will be connected in the next phase.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$businessName • $product\\n$language • $duration • $style • $voice',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
