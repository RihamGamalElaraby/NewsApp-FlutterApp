import 'package:flutter/material.dart';
import 'package:newsapp/Screens/webViewScreee.dart';

Widget buildArticleItem(
  article,
  context,
) =>
    InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: article['urlToImage'] != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(article['urlToImage']),
                    )
                  : null, // Handle null URL
            ),
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
                      article['title']
                          as String, // Ensure that it's cast to String
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );

Widget nyDivider() => Divider(
      height: 30,
      color: Color.fromARGB(255, 0, 0, 0),
      thickness: 1,
      indent: 5,
      endIndent: 10,
    );

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
