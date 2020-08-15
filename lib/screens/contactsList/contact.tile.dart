import 'package:flutter/material.dart';

import 'contact.model.dart';

class ContactTile extends StatefulWidget {
  final ContactModel contact;
  final Function(ContactModel) onEdit;
  ContactTile(this.contact, {this.onEdit});
  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  final List<Color> _iconsGradient = [Color(0xFFfe0291), Color(0xFFad7afa)];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: size.width * .7,
              height: 80.0,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 16.0,
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0.0, 16.0),
                      spreadRadius: -5.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.contact.name,
                    style: TextStyle(
                        color: Colors.grey[500], fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.contact.phone,
                    style: TextStyle(color: Colors.grey[400]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _iconsGradient,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: widget.contact.imageUrl != null ?
                imageCover(widget.contact.imageUrl) : letterCover(widget.contact.name),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: _iconsGradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Icon(Icons.edit, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget imageCover(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }

  Widget letterCover(String name) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: _iconsGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Text(widget.contact.name[0] + widget.contact.name.split(" ").last[0],
        style: TextStyle(color: Colors.white, fontSize: 22)
        
        ),
      )
    );
  }
}
