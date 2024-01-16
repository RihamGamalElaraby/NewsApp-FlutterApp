import 'package:flutter/material.dart';

Widget buildArticleItem() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://mediaaws.almasryalyoum.com/news/large/2024/01/15/2299547_0.jpg'))),
        ),
        SizedBox(
          width: 100,
        ),
        Expanded(
          child: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.brown[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '2024-01-16T08:26:00Z',
                  style: TextStyle(
                      color: Colors.brown[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        )
      ]),
    );

Widget nyDivider() => Divider(
      height: 30,
      color: Color.fromARGB(255, 0, 0, 0),
      thickness: 1,
      indent: 5,
      endIndent: 10,
    );
