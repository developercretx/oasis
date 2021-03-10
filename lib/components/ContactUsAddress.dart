import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsAddress extends StatelessWidget {
  final Map details;

  const ContactUsAddress({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF403d3d),
              backgroundImage: AssetImage("images/circle.png"),
            ),
            title: Text(
              details['title'] ?? 'N/A',
              style: TextStyle(fontFamily: 'book', color: Colors.white),
            ),
            subtitle: Text(
              details['desc'] ?? 'N/A',
              style: TextStyle(fontFamily: 'thin', color: Colors.white),
            ),
          ),
          Container(
            height: height * 0.1,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: details['phone'] != null
                        ? () async {
                            await launch('tel:' + details['phone']);
                          }
                        : null,
                    child: Text(
                      'Call',
                      style: TextStyle(
                        fontFamily: 'thin',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: details['mail'] != null
                        ? () async {
                            await launch('mailto:' + details['mail']);
                          }
                        : null,
                    child: Text(
                      'Mail',
                      style: TextStyle(
                          fontFamily: 'thin',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
