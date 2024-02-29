(*
  This paclet provides a simple interface to the YAML library for importing and exporting YAML files.
  It has two functions: ImportYAML and ExportYAML.
  ImportYAML[file] imports a YAML file and returns a Dataset.
  ExportYAML[file, data] exports a Dataset to a YAML file.
*)

BeginPackage["WolframExternalFunctions`YAML`"]

ImportYAML::usage = "ImportYAML[file] imports a YAML file and returns a Dataset"
ExportYAML::usage = "ExportYAML[file, data] exports a Dataset to a YAML file"

Begin["`Private`"]

$ThisDirectory = DirectoryName[$InputFileName];

GetExternalSession[id_String, dependencies_List] := 
 Module[{env, session},
  env = {"Python", "ID" -> id, 
    "Evaluator" -> <|"Dependencies" -> dependencies, 
      "EnvironmentName" -> id|>};
  session = 
   SelectFirst[ExternalSessions[], #["ID"] == id &, 
    StartExternalSession[env]]
  ]

ImportYAML[file_] := Module[{session, result},
    session = GetExternalSession["PyYAML", {"PyYAML"}];
    ExternalEvaluate[session, File[ FileNameJoin[{$ThisDirectory,"yaml.py"}]]];
    result = ExternalEvaluate[session, "importyaml"->file];
    Dataset[result]
]  

ExportYAML[file_, data_] := Module[{session, result},
    session = GetExternalSession["PyYAML", {"PyYAML"}];
    ExternalEvaluate[session, File[ FileNameJoin[{$ThisDirectory,"yaml.py"}]]];
    result = ExternalEvaluate[session, "exportyaml"->{file,Normal[data]}];
    
]  

End[]

EndPackage[]
