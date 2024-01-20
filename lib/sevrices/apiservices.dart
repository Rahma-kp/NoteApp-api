import 'package:dio/dio.dart';
import 'package:notesapp/model/notesmodel.dart';

class NotSevice {
  Dio dio = Dio();
  var endPointUrl =
      'https://65a753e194c2c5762da67b46.mockapi.io/notesApp/notesApp';

  Future<List<NotesModel>>  getNotes() async {
    try {
      Response response = await Dio().get(endPointUrl);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<NotesModel> notes = jsonList.map((json) {
          return NotesModel.fromJson(json);
        }).toList();
        return notes;
      } else {
        throw Exception('fainld loaded notes');
      }
    } catch (error) {
      throw Exception('Failed to load notes: $error');
    }
  }

  addNotes(NotesModel value) async {
  try {
    var response = await dio.post(endPointUrl, data: value.toJson());
    return response.data;
  } catch (e) {
    print('Error adding note: $e');
    throw Exception(e);
  }
}


  deletNotes({required id}) async {
    var deletUrl =
        'https://65a753e194c2c5762da67b46.mockapi.io/notesApp/notesApp/$id';
    try {
      await dio.delete(deletUrl);
    } catch (e) {
      throw Exception(e);
    }
  }

  editNotes({required NotesModel value, required id}) async {
    var editUrl =
        'https://65a753e194c2c5762da67b46.mockapi.io/notesApp/notesApp/$id';
    try {
      await dio.put(editUrl, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
