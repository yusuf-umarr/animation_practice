// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:van_anime/views/component/person_detail.dart';

@immutable
class Person {
  final String name, emoji;
  final int age;
  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const poeple = [
  Person(name: "John", age: 20, emoji: "👨🏿"),
  Person(name: "Ade", age: 30, emoji: "👮‍♀️"),
  Person(name: "Femi", age: 40, emoji: "👨🏾‍🍳"),
];

class ExampleFour extends StatelessWidget {
  const ExampleFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("People"),
      ),
      body: ListView.builder(
          itemCount: poeple.length,
          itemBuilder: (context, index) {
            final person = poeple[index];
            return ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonDetail(person: person))),
              leading: Hero(
                tag: person.emoji,
                child: Text(
                  person.emoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              title: Hero(tag: person.name, child: Text(person.name)),
              subtitle:
                  Hero(tag: person.age, child: Text("${person.age} years old")),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          }),
    );
  }
}
