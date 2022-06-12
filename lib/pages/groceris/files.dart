/* Grocery list card */

/* 
Card(
                    elevation: 7,
                    shadowColor: Color.fromARGB(96, 0, 0, 0),
                    child: ListTile(
                      leading: Image.network(
                        grocery.image,
                        width: 70,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            grocery.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Text(grocery.description),
                        ],
                      ),
                      subtitle: Text("GHC " + grocery.price),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  );
 */


/* Grocery shop details */
/* 
GestureDetector(
                          onTap: () {
                            print(grocery.name + " tapped");
                          },
                          child: Card(
                            elevation: 7,
                            shadowColor: const Color.fromARGB(96, 0, 0, 0),
                            child: ListTile(
                              leading: Image.network(
                                grocery.image,
                                width: 70,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    grocery.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(grocery.description),
                                ],
                              ),
                              subtitle: Text("GHC " + grocery.price),
                              trailing: const Icon(Icons.arrow_right),
                            ),
                          ),
                        );
 */