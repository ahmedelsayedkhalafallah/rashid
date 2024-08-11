import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:user_repository/user_repository.dart';

import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'components/drawer_tile.dart';

class DrawerScreen extends StatefulWidget {
  MyUser? myUser;
  DrawerScreen({super.key, required this.myUser});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.height * 0.2),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 500,
                      maxWidth: 500,
                      imageQuality: 40);
                  if (image != null) {
                    CroppedFile? croppedFile = await ImageCropper().cropImage(
                      sourcePath: image.path,
                      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Theme.of(context).colorScheme.primary,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        IOSUiSettings(
                          title: 'Cropper',
                        ),
                      ],
                    );
                    if (croppedFile != null) {
                      setState(() {
                        context.read<UpdateUserInfoBloc>().add(UploadPicture(
                            imageFilePath: croppedFile.path,
                            userId: context
                                .read<MyUserBloc>()
                                .state
                                .myUser!
                                .userId));
                      });
                    }
                  }
                },
                child: (widget.myUser!.profilePictureUrl == ""
                    ? CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/no-profile-image.png'),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(widget.myUser!.profilePictureUrl))),
              ),

              DrawerTile(
                iconData: Icons.login,
                text: "Logout",
                onPress: () {
                  context.read<SignInBloc>().add(SignOutEvent());
                },
              ),

              // Transform(
              //                           alignment: Alignment.center,
              //                           transform: Matrix4.rotationY(math.pi),
              //                           child: IconButton(
              //                               onPressed: () {
              //                                 context
              //                                     .read<SignInBloc>()
              //                                     .add(SignOutEvent());
              //                               },
              //                               icon: Icon(
              //                                 Icons.login,
              //                               ))),
            ],
          ),
        ),
      ),
    );
  }
}
