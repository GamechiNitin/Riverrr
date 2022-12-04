import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverrr/constant/import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  TextEditingController searchController = TextEditingController();
  FocusNode searchFn = FocusNode();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('people').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Riverrr"),
        actions: [
          PopupMenuButton<SortBY>(
            onSelected: (SortBY value) {
              if (value == SortBY.sourceCode) {
                LocalData.launchURL();
              }
              if (value == SortBY.logOut) {
                CustomBottomSheet().logOut(
                  context: context,
                  onTap: () {
                    LocalData.logOut(context);
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortBY>>[
              const PopupMenuItem<SortBY>(
                value: SortBY.sourceCode,
                child: Text('Source Code'),
              ),
              const PopupMenuItem<SortBY>(
                value: SortBY.logOut,
                child: Text('Log Out'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                child: const Center(
                  child: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return snapshot.data != null
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      UserResponse userModel = UserResponse.fromJson(data);

                      return Dismissible(
                        key: Key(data['name']),
                        background: slideRightBackground(),
                        secondaryBackground: slideLeftBackground(),
                        confirmDismiss: (config) async {
                          if (config == DismissDirection.startToEnd) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditPeoplePage(
                                  userModel: userModel,
                                  id: document.id,
                                ),
                              ),
                            );
                          }
                          if (config == DismissDirection.endToStart) {
                            final service = ApiServices();
                            String response =
                                await service.deleteUser(document.id);
                            if (response != '') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response),
                                ),
                              );
                            }
                          }
                          return null;
                        },
                        //  key: Key(itemsList[index]),
                        child: HomeCardWidget(
                          url: data['url'] != null && data['url'] != ''
                              ? data['url']
                              : "https://picsum.photos/200/300",
                          name: data['name'] != null && data['name'] != ''
                              ? data['name']
                              : "",
                          email: data['email'] != null && data['email'] != ''
                              ? data['email']
                              : '',
                          address:
                              data['address'] != null && data['address'] != ''
                                  ? data['address']
                                  : '',
                          phone: data['phone'] != null
                              ? data['phone'].toString()
                              : '',
                          state: data['state'] != null && data['state'] != ''
                              ? data['state']
                              : '',
                          city: data['city'] != null && data['city'] != ''
                              ? data['city']
                              : '',
                          bod: data['birthDate'] != null &&
                                  data['birthDate'] != ''
                              ? data['birthDate']
                              : "",
                          zip:
                              data['zip'] != null ? data['zip'].toString() : '',
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPeoplePage(),
            ),
          );
        },
        tooltip: 'Add People',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.redAccent,
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(height: 8),
            Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
