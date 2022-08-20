import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYIMmE0bLUSDD7LII20c-b06qmFH_ZWUqUQA&usqp=CAU"),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Chats",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.camera_alt,
                size: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.edit,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Search"),
                  ],
                ),
              ),
              Container(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildStory();
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  itemCount: 7,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return buildChatItem();
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: 7,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: const [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYIMmE0bLUSDD7LII20c-b06qmFH_ZWUqUQA&usqp=CAU"),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 5, end: 5),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Abdo Alhady",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Hello my name is Abdo Alhady mostafa",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Text("02:00 pm"),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildStory() {
    return Container(
      width: 60,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: const [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYIMmE0bLUSDD7LII20c-b06qmFH_ZWUqUQA&usqp=CAU"),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: 5, end: 5),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            "Abdo Al Hady Mostafa",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
