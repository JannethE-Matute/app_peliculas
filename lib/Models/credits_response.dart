import 'dart:convert';

class CreditsResponse {
    int id;
    List<Cast> cast;
    List<Cast> crew;

    CreditsResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditsResponse.fromRawJson(String str) => CreditsResponse.fromJson(json.decode(str));

    //String toRawJson() => json.encode(toJson());

    factory CreditsResponse.fromJson(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    //     "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    // };
}

class Cast {
    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required  this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    factory Cast.fromRawJson(String str) => Cast.fromJson(json.decode(str));

    //String toRawJson() => json.encode(toJson());

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
    );

    // Map<String, dynamic> toJson() => {
    //     "adult": adult,
    //     "gender": gender,
    //     "id": id,
    //     "known_for_department": knownForDepartment,
    //     "name": name,
    //     "original_name": originalName,
    //     "popularity": popularity,
    //     "profile_path": profilePath,
    //     "cast_id": castId,
    //     "character": character,
    //     "credit_id": creditId,
    //     "order": order,
    //     "department": department,
    //     "job": job,
    // };

    get fullProfilePath {
      if (profilePath != null) {
        return 'https://image.tmdb.org/t/p/w500$profilePath';
      }
          return 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fichef.bbci.co.uk%2Fnews%2F640%2Famz%2Fworldservice%2Flive%2Fassets%2Fimages%2F2015%2F11%2F17%2F151117184748_qu_sabemos_sobre_la_comunicaciones_encriptadas_de_ei_624x351_thinkstock_nocredit.jpg&tbnid=rSvn_oczXFOQtM&vet=12ahUKEwi3nM3w4sOCAxXWBGIAHYRbB3AQMygGegQIARBa..i&imgrefurl=https%3A%2F%2Fwww.bbc.com%2Fmundo%2Fnoticias%2F2015%2F11%2F151117_tecnologia_estado_islamico_comunicacion_lb&docid=t0UnkkITEvLBNM&w=640&h=360&q=imagenes%20encriptadas&ved=2ahUKEwi3nM3w4sOCAxXWBGIAHYRbB3AQMygGegQIARBa';
    }
}
