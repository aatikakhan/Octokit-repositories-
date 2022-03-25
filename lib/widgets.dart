import 'package:flutter/material.dart';

import 'data_repository.dart';

Widget listwidget(List<DataModel>? entries) {
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: entries!.length,
    itemBuilder: (BuildContext context, int i) {
      return ExpansionTile(
        textColor: Colors.black,
        leading: Image.asset('assets/icons/fork-black-16.png'),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(entries[i].owner!.login!),
        ),
        subtitle: Text(
          '${entries[i].name}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        childrenPadding: const EdgeInsets.only(left: 72, bottom: 8),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entries[i].description.toString()),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  Text(entries[i].language.toString()),
                  const SizedBox(width: 32),
                  Image.asset('assets/icons/star-yellow-16.png'),
                  Text(entries[i].stargazersCount.toString()),
                  const SizedBox(width: 32),
                  Image.asset('assets/icons/fork-black-16.png'),
                  Text(entries[i].forksCount.toString()),
                  const SizedBox(width: 32),
                ],
              ),
            ],
          ),
        ],
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}
