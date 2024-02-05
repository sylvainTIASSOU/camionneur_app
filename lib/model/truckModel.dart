
class TruckModel
{
  var id;
  String marque;
  String matricule;
  String plaque;
  String dimention;
  String? photo;

  TruckModel({required this.id, required this.dimention, required this.marque, required this.matricule, required this.plaque, this.photo});

  Map<String, dynamic> toMap()
  {
    return{
      'id': id,
      'dimention': dimention,
      'marque': marque,
      'matricule': matricule,
      'plaque': plaque,
      'photo': photo
    };
  }

//convert to string
  String toString()
  {
    return 'id: $id,dimention: $dimention,marque: $marque,matricule: $matricule, plaque: $plaque, photo: $photo';
  }
}