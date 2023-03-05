import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DepremModel {
  int id;
  String? tarih;
  String? saat;
  String? enlem;
  String? boylam;
  String? derinlik;
  String? buyukluk;
  String? yer;
  DepremModel({
    required this.id,
    this.tarih,
    this.saat,
    this.enlem,
    this.boylam,
    this.derinlik,
    this.buyukluk,
    this.yer,
  });

  @override
  String toString() {
    return 'DepremModel(id: $id, tarih: $tarih, saat: $saat, enlem: $enlem, boylam: $boylam, derinlik: $derinlik, buyukluk: $buyukluk, yer: $yer)';
  }

  DepremModel copyWith({
    int? id,
    String? tarih,
    String? saat,
    String? enlem,
    String? boylam,
    String? derinlik,
    String? buyukluk,
    String? yer,
  }) {
    return DepremModel(
      id: id ?? this.id,
      tarih: tarih ?? this.tarih,
      saat: saat ?? this.saat,
      enlem: enlem ?? this.enlem,
      boylam: boylam ?? this.boylam,
      derinlik: derinlik ?? this.derinlik,
      buyukluk: buyukluk ?? this.buyukluk,
      yer: yer ?? this.yer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tarih': tarih,
      'saat': saat,
      'enlem': enlem,
      'boylam': boylam,
      'derinlik': derinlik,
      'buyukluk': buyukluk,
      'yer': yer,
    };
  }

  factory DepremModel.fromMap(Map<String, dynamic> map) {
    return DepremModel(
      id: map['id'] as int,
      tarih: map['tarih'] != null ? map['tarih'] as String : null,
      saat: map['saat'] != null ? map['saat'] as String : null,
      enlem: map['enlem'] != null ? map['enlem'] as String : null,
      boylam: map['boylam'] != null ? map['boylam'] as String : null,
      derinlik: map['derinlik'] != null ? map['derinlik'] as String : null,
      buyukluk: map['buyukluk'] != null ? map['buyukluk'] as String : null,
      yer: map['yer'] != null ? map['yer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepremModel.fromJson(String source) => DepremModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant DepremModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.tarih == tarih &&
      other.saat == saat &&
      other.enlem == enlem &&
      other.boylam == boylam &&
      other.derinlik == derinlik &&
      other.buyukluk == buyukluk &&
      other.yer == yer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tarih.hashCode ^
      saat.hashCode ^
      enlem.hashCode ^
      boylam.hashCode ^
      derinlik.hashCode ^
      buyukluk.hashCode ^
      yer.hashCode;
  }
}
