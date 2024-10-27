import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../general/Service.dart';

class GoodReads extends Service {
  // Members
  late final _bookHeaders;

  // Private constructor
  GoodReads._() {
    _bookHeaders = {
      "User-Agent": env["USER_AGENTS_GOODREADS"] ?? ""
    };
  }

  // Singleton instance
  static final GoodReads _instance = GoodReads._();

  // Accessor for the singleton instance
  static GoodReads get instance => _instance;

  // Private methods
  Future<List<Map<String, dynamic>>> _getBooks(String bookName) async {
    try {
      final url = "https://www.goodreads.com/search?q=$bookName";
      final response = await http.get(Uri.parse(url), headers: _bookHeaders);

      if (response.statusCode == 200) {
        final document = parse(response.body);

        var options = <Map<String, dynamic>>[];
        for (var book in document.querySelectorAll("tr[itemtype='http://schema.org/Book']")) {
          final titleElement = book.querySelector("a.bookTitle");
          final authorElement = book.querySelector("a.authorName");
          final ratingText = book.querySelector("span.minirating")?.text.trim() ?? "avg rating —";

          if (titleElement != null && authorElement != null) {
            options.add({
              "name": titleElement.text.trim(),
              "link": "https://www.goodreads.com${book.querySelector('a.bookTitle')?.attributes['href'] ?? ''}",
              "author": authorElement.text.trim(),
              "rating": ratingText.split("avg rating —")[0].trim(),
            });
          }
        }
        return options;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> _searchBook(Map<String, dynamic> book) async {
    try {
      final response =
          await http.get(Uri.parse(book["link"]), headers: _bookHeaders);

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final scriptTag =
            document.querySelector("script[type='application/ld+json']");
        final jsonData = json.decode(scriptTag?.text ?? "{}");
        final pagesFormat =
            document.querySelector("p[data-testid='pagesFormat']");

        return {
          "name": book["name"],
          "author": book["author"],
          "link": book["link"],
          "rating": book["rating"],
          "numPages": pagesFormat?.text.trim().split(" ")[0],
          "publicationInfo": document
              .querySelector("p[data-testid='publicationInfo']")
              ?.text
              .trim()
              .split("First published ")
              .last,
          "description": document.querySelector("span.Formatted")?.text.trim(),
          "bookFormat": jsonData["bookFormat"],
          "language": jsonData["inLanguage"]
        };
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  // Public methods
  @override
  Future<List<Map<String, dynamic>>> getOptions(String bookName) async {
    return instance._getBooks(bookName);
  }

  @override
  Future<Map<String, dynamic>> getInfo(Map<String, dynamic> book) async {
    return instance._searchBook(book);
  }

  @override
  Future<List<Map<String, dynamic>>> getRecommendations(int bookId) async {
    return [];
  }
}
