// import 'dart:collection';

// void main() {
//   List<int> list1 = [
//     1,
//     2,
//   ];
//   List<Map<String, dynamic>> list2 = [
//     {
//       "a": [1, 2],
//     },
//     {
//       "a": [3, 4]
//     },
//     {
//       "a": [1, 2, 3],
//     },
//   ];
// // List<int> filteredList = list2.where((element) => list1.contains(element)).toList();
// // List filteres=list2.where((element)=> element.a.length==2).toList();
// // print(filteres); // Output: [2, 4]
//   print(list2[0]['a'].contains(list1));
//   // print(list2.where((element) => element['a'].every((e) => e == list1[0])));
//   print(list2.where((element) => element['a'].containsAll([1, 12])).toList());
//   List<int> s = [1, 2];
//   // print(list1.containsAll(s));
//   // List<int> list1 = [1, 2, 3, 4, 5];
//   // List<int> list2 = [2, 4, 6];

//   // bool containsAll = true;

//   // for (var value in list2) {
//   //   if (!list1.contains(value)) {
//   //     print(value);
//   //     break;
//   //   }
//   // }
//   // print(containsAll); // Output: false
// }
void main() {
  var set = {'apple', 'banana', 'orange', 'pear'};
  var list1 = ['apple', 'banana'];
  var list2 = ['apple', 'cherry'];
  var sam = Set.of(list1);
  print(sam);
  print(set.containsAll(list1)); // true
  print(set.containsAll(list2)); // false
}
