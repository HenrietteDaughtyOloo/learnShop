import 'package:flutter/material.dart';
import 'package:shop/activities/complete_screen.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;

  const PaymentScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMode;
  TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Page',
        style: TextStyle(
          color: Color(0xFF03787C),
          fontSize: 26,
          fontWeight: FontWeight.bold
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
              style: 
              TextStyle(
                fontSize: 24,
                color: Color(0xFF03787C),

                ),
            ),
            SizedBox(height: 30,
            
            ),
            DropdownButton<String>(
              value: _selectedPaymentMode,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMode = newValue;
                  if (_selectedPaymentMode == 'Mobile Money') {
                    // Show pop-up for mobile number input
                    _showMobileNumberInputPopup(context);
                  }
                });
              },
              items: <String>['Cash', 'Mobile Money', 'Debit Card']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, 
                                    
              style: 
              TextStyle(
                fontSize: 20,
                color: Color(0xFF03787C),)


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
              
              child: Text('Continue Shopping',
                        style: TextStyle(color: Colors.white, fontSize: 17,),
              ),
              style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 15),

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
                    title: Text('Confirm Payment',
                        style: TextStyle(color: Color(0xFF03787C), fontSize: 17,),
                    
                    ),
                    content: Text(
                        'Are you sure you want to pay \KES ${widget.totalAmount.toStringAsFixed(2)}?', 
                        style: TextStyle(color: Color(0xFF03787C), fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                        

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                        style: TextStyle(color: Color(0xFF03787C), fontSize: 17,),
                        
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Pay',
                        style: TextStyle(color: Color(0xFF03787C), fontSize: 17,),
                        
                        ),
                      ),
                    ],
                  ),
                );
              },

              child: Text('CheckOut',
                        style: TextStyle(color: Colors.white, fontSize: 17,),
              ),

              style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: 45, right: 45, top: 15, bottom: 15),
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
                decoration: InputDecoration(labelText: 'Mobile Number',
                hintText: '+2547000000000',
                hintStyle: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,),
                ),
                style: TextStyle(color: Color(0xFF03787C),fontWeight: FontWeight.bold),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  mobileNumber = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showPaymentPrompt(context, mobileNumber);
                },
                child: Text('Confirm Number',
                style: TextStyle(color: Color(0xFF03787C),fontWeight: FontWeight.normal),
                
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentPrompt(BuildContext context, String mobileNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Prompt',
                style: TextStyle(color: Color(0xFF03787C),fontWeight: FontWeight.bold),
        ),
        content: Text('A payment prompt has been sent to the number${mobileNumber}. Please check and pay up KES ${widget.totalAmount.toStringAsFixed(2)} only.',
                style: TextStyle(color: Color(0xFF03787C),fontWeight: FontWeight.bold),
        
        ),
        actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopAgain(), // Navigate to CompleteScreen
              ),
            );
          },
          child: Text('OK'),
          
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    mobileNumberController.dispose();
    super.dispose();
  }
}
