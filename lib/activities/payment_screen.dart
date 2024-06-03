import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/activities/complete_screen.dart';
import 'package:intl/intl.dart';



class PaymentScreen extends StatefulWidget {
  final double totalAmount;

  const PaymentScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMode;
  TextEditingController mobileNumberController = TextEditingController();

  Future<void> initiatePayment(String phoneNumber) async{
    final consumerKey = dotenv.env['DARAJA_CONSUMER_KEY'];
    final consumerSecret = dotenv.env['DARAJA_CONSUMER_SECRET'];
    final auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

    final tokenResponse = await http.get(
      Uri.parse('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'),
      headers: {'Authorization': 'Basic $auth'},
    );
    final accessToken = jsonDecode(tokenResponse.body)['access_token'];

    // Generate the password for the request
    // String timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    // String password = base64Encode(utf8.encode('174379' + 'your_lipa_na_mpesa_online_passkey' + timestamp));


String generatePassword(String shortCode, String passKey, String timestamp) {
  final password = base64Encode(utf8.encode('$shortCode$passKey$timestamp'));
  return password;
}

String getTimestamp() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyyMMddHHmmss');
  return formatter.format(now);
}

final String timestamp = getTimestamp();
final String password = generatePassword("174379", "your_pass_key", timestamp);



    final paymentResponse = await http.post(
      Uri.parse('https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "BusinessShortCode": "174379",
        "Password": password,
        "Timestamp": timestamp,
        "TransactionType": "CustomerPayBillOnline",
        "Amount": widget.totalAmount,
        "PartyA": phoneNumber,
        "PartyB": "174379",
        "PhoneNumber": phoneNumber,
        "CallBackURL": "your_callback_url",
        "AccountReference": "account_reference",
        "TransactionDesc": "Payment description"
      }),
    );

    if (paymentResponse.statusCode == 200) {
      print('Payment initiated successfully');
      _showPaymentPrompt(context, phoneNumber);
    } else {
      print('Failed to initiate payment: ${paymentResponse.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initiate payment. Please try again.')),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout Page',
          style: TextStyle(
            color: Color(0xFF03787C),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/pay.png'),
            Text(
              'Please Select Payment Mode',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF03787C),
              ),
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              value: _selectedPaymentMode,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMode = newValue;
                  if (_selectedPaymentMode == 'Mobile Money') {
                    _showMobileNumberInputPopup(context);
                  }
                });
              },
              items: <String>['Cash', 'Mobile Money']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF03787C),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Total Amount: \KES ${widget.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Color(0xFF03787C)),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Continue Shopping',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                backgroundColor: Color(0xFF03787C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Confirm Payment',
                      style: TextStyle(
                        color: Color(0xFF03787C),
                        fontSize: 17,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to pay \KES ${widget.totalAmount.toStringAsFixed(2)}?',
                      style: TextStyle(
                        color: Color(0xFF03787C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF03787C),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); 
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopAgain(),
                              ),
                              );
                        },
                        child: Text(
                          'Pay',
                          style: TextStyle(
                            color: Color(0xFF03787C),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'CheckOut',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                backgroundColor: Color(0xFF03787C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileNumberInputPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String mobileNumber = '';
        return AlertDialog(
          title: Text('Enter Mobile Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: '+2547000000000',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextStyle(
                  color: Color(0xFF03787C),
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  mobileNumber = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {

                  if (mobileNumber.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mobile number cannot be empty.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } 
                  
                   else if (mobileNumber.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Mobile number must be at least 10 characters long.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  else {
                    Navigator.pop(context);
                    _showPaymentPrompt(context, mobileNumber);
                  }
                },
                child: Text(
                  'Confirm Number',
                  style: TextStyle(
                    color: Color(0xFF03787C),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

void _showPaymentPrompt(BuildContext context, String mobileNumber) async {
  try {
    await initiatePayment(mobileNumber);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Payment Prompt',
          style: TextStyle(
            color: Color(0xFF03787C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'A payment prompt has been sent to the number $mobileNumber. Please check and pay KES ${widget.totalAmount.toStringAsFixed(2)} only.',
          style: TextStyle(
            color: Color(0xFF03787C),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopAgain(),
                ),
              ).then((_) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Payment Successful',
                      style: TextStyle(
                        color: Color(0xFF03787C),
                        fontSize: 17,
                      ),
                    ),
                    content: Text(
                      'Your payment of \KES ${widget.totalAmount.toStringAsFixed(2)} was successful.',
                      style: TextStyle(
                        color: Color(0xFF03787C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopAgain(),
                            ),
                          );
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Color(0xFF03787C),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Payment Failed',
          style: TextStyle(
            color: Color(0xFF03787C),
            fontSize: 17,
          ),
        ),
        content: Text(
          'Your payment of \KES ${widget.totalAmount.toStringAsFixed(2)} failed. Please try again later.',
          style: TextStyle(
            color: Color(0xFF03787C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF03787C),
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  @override
  void dispose() {
   
    mobileNumberController.dispose();
    super.dispose();
  }
}


void main() {
  runApp(MaterialApp(
    home: PaymentScreen(totalAmount: 1000.0),
  ));
}