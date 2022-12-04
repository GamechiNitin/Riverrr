import 'package:riverrr/constant/import.dart';

class CustomBottomSheet {
  bottomBar(
      {required BuildContext context,
      VoidCallback? onGalleryTap,
      VoidCallback? onCameraTap}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: kwhiteColor,

      // backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSheetBorderRadius),
          topRight: Radius.circular(kSheetBorderRadius),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          padding:
              const EdgeInsets.only(right: 25, left: 25, top: 16, bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.close,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Text(
                'Upload Image',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 24,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconCardWidget(
                    icon: Icons.file_copy,
                    text: "Gallery",
                    onTap: onGalleryTap,
                  ),
                  IconCardWidget(
                    icon: Icons.camera_alt,
                    text: 'Camera',
                    onTap: onCameraTap,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  logOut({required BuildContext context, required VoidCallback onTap}) {
    return showModalBottomSheet(
      context: context,
      // backgroundColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: kwhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSheetBorderRadius),
          topRight: Radius.circular(kSheetBorderRadius),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.close,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Log out',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 24,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 14,
                    ),
              ),
              const SizedBox(height: 10),
              ButtomWidget(
                text: 'Yes',
                onTap: onTap,
              ),
            ],
          ),
        );
      },
    );
  }
}

class IconCardWidget extends StatelessWidget {
  const IconCardWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        width: iconH,
        height: iconH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: klightBlack,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: kPrimaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
