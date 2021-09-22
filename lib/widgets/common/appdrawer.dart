import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors
            .blue.shade700, //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            const SizedBox(
              width: 60,
              height: 60,
              child: CircleAvatar(
                backgroundColor: Color(0xF352FFE2),
                // backgroundImage: AssetImage('images/happy.jpg')
              ),
            ),
            const SizedBox(
              height: 22,
              width: 40,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                'Hey Prithvi',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Text(
                'Your Location- Mumbai',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            ListTile(
              tileColor: Color(0xF352FFE2),
              title: const Text('Your Orders'),
              trailing: Icon(
                Icons.add_to_home_screen,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: Colors.lightBlueAccent,
              title: const Text('About Us'),
              trailing: const Icon(
                Icons.login_rounded,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              tileColor: Color(0xF352FFE2),
              title: const Text('Contact Us'),
              trailing: Icon(
                Icons.payment_rounded,
              ),
              onTap: () {},
            ),
            ListTile(
              tileColor: Colors.lightBlueAccent,
              title: const Text('Logout'),
              trailing: Icon(
                Icons.logout_rounded,
              ),
              onTap: () {
                //Navigator.push( context,
                //MaterialPageRoute(builder: (context) =>  Login()),
                //);
              },
            ),
          ],
        ),
      ),
    );
  }
}
