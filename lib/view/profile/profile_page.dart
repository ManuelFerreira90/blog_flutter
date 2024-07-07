import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/themes/style/theme_colors.dart';
import 'package:blog_mobile/view/auth/components/auth_button.dart';
import 'package:blog_mobile/view/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    super.key,
    required this.userLogged,
  });

  User userLogged;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: widget.userLogged.image != null
                            ? Colors.transparent
                            : Colors.black12,
                        child: widget.userLogged.image != null
                            ? Image.network(widget.userLogged.image!)
                            : const Icon(Icons.person),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.userLogged.firstame ?? 'no name',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.userLogged.lastName ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          widget.userLogged.userName != null
                              ? Text(
                                  '@${widget.userLogged.userName}',
                                )
                              : const Text('no username'),
                          const SizedBox(
                            height: 5,
                          ),
                          AuthButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                        userLogged: widget.userLogged),
                                  ),
                                );
                                setState(() {});
                              },
                              title: 'edit profile',
                              fontSize: 12,
                              size: const Size(1, 30))
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: ThemeColors.colorDiviser,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(widget.userLogged.email ?? 'no email'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Username'),
                        subtitle:
                            Text(widget.userLogged.userName ?? 'no username'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.flag),
                        title: const Text('Country'),
                        subtitle:
                            Text(widget.userLogged.country ?? 'no location'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('Phone'),
                        subtitle: Text(widget.userLogged.phone ?? 'no phone'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
