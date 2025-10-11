const String gradeCurricularCompletaJson = '''
{
  "curso": "Análise e Desenvolvimento de Sistemas",
  "ano": 2025,
  "turno": "diurno",
  "disciplinas": {
    "semestre1": {
      "algLogProg": {
        "nome": "ALGORITMOS E LÓGICA DE PROGRAMAÇÃO",
        "professor": "LUCAS B",
        "sala": "L1/S12",
        "diaSemana": 2,
        "horaInicio": "08:30",
        "horaFim": "11:10",
        "professorId": "fFLB1uzplCTQTbkBsUHhsat9COI3"
      },
      "progMI": {
        "nome": "PROGRAMAÇÃO M I",
        "professor": "GERALDO",
        "sala": "L1",
        "diaSemana": 3,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "iS97Tp1PHsObrwqhMdCXZyS27g52"
      },
      "ingles1": {
        "nome": "INGLÊS I",
        "professor": "ANNA",
        "sala": "S20",
        "diaSemana": 4,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "GAVFn5wLVzPLVLjTk9XLSDRUez72"
      },
      "admGeral": {
        "nome": "ADMINISTRAÇÃO GERAL",
        "professor": "SUZANA",
        "sala": "S11",
        "diaSemana": 4,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "bpi3yMtkSsNjeGi7Au82t0fXYB52"
      },
      "matDisc": {
        "nome": "MATEMÁTICA DISCRETA",
        "professor": "JUNIOR",
        "sala": "S22",
        "diaSemana": 5,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "aYz4bBVZ9tdfRQfIpmSLAKOvzk22"
      },
      "labHard": {
        "nome": "LABORATÓRIO DE HARDWARE",
        "professor": "CARLOS E",
        "sala": "S20",
        "diaSemana": 6,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "4GsjZFqmu9QgZGNPQOyrSjeuFim1"
      },
      "aoComp": {
        "nome": "ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES",
        "professor": "CARLOS E",
        "sala": "S16",
        "diaSemana": 6,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "4GsjZFqmu9QgZGNPQOyrSjeuFim1"
      }
    },
    "semestre2": {
      "contab": {
        "nome": "CONTAB",
        "professor": "SUZANA",
        "sala": "S16",
        "diaSemana": 2,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "bpi3yMtkSsNjeGi7Au82t0fXYB52"
      },
      "comExp": {
        "nome": "COM EXP",
        "professor": "CARLOS N",
        "sala": "S11",
        "diaSemana": 2,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "WabN1xIiA7UfJ0LHg3NnFcmKvnG3"
      },
      "lingProg": {
        "nome": "LING PROG",
        "professor": "FERNANDO P",
        "sala": "L6",
        "diaSemana": 3,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "r4i8LsY9CGQi7yLZeMvAbQaqDe73"
      },
      "ingles2": {
        "nome": "INGLES II",
        "professor": "MICHELLE",
        "sala": "S21",
        "diaSemana": 3,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "GOt4eEUrnkQCXOHWmuryv8U0iJY2"
      },
      "calculo": {
        "nome": "CALCULO",
        "professor": "JUNIOR",
        "sala": "L2/S23",
        "diaSemana": 4,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "aYz4bBVZ9tdfRQfIpmSLAKOvzk22"
      },
      "sistInf": {
        "nome": "SIST INF",
        "professor": "CARLOS E.",
        "sala": "S16",
        "diaSemana": 5,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "4GsjZFqmu9QgZGNPQOyrSjeuFim1"
      },
      "engSoft1": {
        "nome": "ENG SOFT I",
        "professor": "PLOTZE",
        "sala": "L1/S19",
        "diaSemana": 6,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "ewMeCug1oocs4MgsECrPB514IZn1"
      }
    },
    "semestre3": {
      "econFin": {
        "nome": "ECON E FIN",
        "professor": "FERNANDINA",
        "sala": "S11",
        "diaSemana": 2,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "Gr4Ur6RnEARjKdKEJKzqiIyNUL32"
      },
      "estatAp": {
        "nome": "ESTAT AP",
        "professor": "VALÉRIA",
        "sala": "S10",
        "diaSemana": 2,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "dCsfOyCBNMPwE6It4DkcsQhIQdq2"
      },
      "so1": {
        "nome": "SO I",
        "professor": "MARCO A",
        "sala": "S5",
        "diaSemana": 3,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "8FTxjenTEXQTwEIIc7ev9tNEBou1"
      },
      "engSoft2": {
        "nome": "ENG SOFT II",
        "professor": "PLOTZE",
        "sala": "LR",
        "diaSemana": 4,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "ewMeCug1oocs4MgsECrPB514IZn1"
      },
      "socTec": {
        "nome": "SOC TEC",
        "professor": "SANTA FÉ",
        "sala": "S15",
        "diaSemana": 4,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "0ic5DtQjEifkZtQizdYBaHkiBy33"
      },
      "ihc": {
        "nome": "IHC",
        "professor": "FABRICIO",
        "sala": "L5",
        "diaSemana": 5,
        "horaInicio": "09:30",
        "horaFim": "11:10",
        "professorId": "HAU5Z3fyiKbPigCVxFAUSojGj0m1"
      },
      "ingles3": {
        "nome": "INGLES III",
        "professor": "MICHELLE",
        "sala": "S21",
        "diaSemana": 5,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "GOt4eEUrnkQCXOHWmuryv8U0iJY2"
      }
    },
    "semestre4": {
      "engSoft3": {
        "nome": "ENG SOFT III",
        "professor": "FABRICIO",
        "sala": "L5",
        "diaSemana": 2,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "HAU5Z3fyiKbPigCVxFAUSojGj0m1"
      },
      "progOO": {
        "nome": "PROG O.O",
        "professor": "GABRIEL",
        "sala": "LA/S4",
        "diaSemana": 3,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "kYsTpXPyw2XiWjrbARmqp0WZyQg2"
      },
      "mpct": {
        "nome": "MPCT",
        "professor": "CLAUDIA",
        "sala": "LA/S23",
        "diaSemana": 3,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "uCQpKTlqiyPzqBtbdoSSJiHMQng1"
      },
      "ingles4": {
        "nome": "INGLES IV",
        "professor": "ANNA",
        "sala": "S23",
        "diaSemana": 4,
        "horaInicio": "09:30",
        "horaFim": "11:10",
        "professorId": "GAVFn5wLVzPLVLjTk9XLSDRUez72"
      },
      "pDispMoveis": {
        "nome": "P DISP MOVEIS",
        "professor": "PLOTZE",
        "sala": "LR",
        "diaSemana": 4,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "ewMeCug1oocs4MgsECrPB514IZn1"
      },
      "pDispMoveisQui": {
        "nome": "P DISP MOVEIS",
        "professor": "PLOTZE",
        "sala": "LR",
        "diaSemana": 5,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "ewMeCug1oocs4MgsECrPB514IZn1"
      },
      "bd4": {
        "nome": "BD",
        "professor": "GERALDO",
        "sala": "LA/S",
        "diaSemana": 5,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "iS97Tp1PHsObrwqhMdCXZyS27g52"
      },
      "so2": {
        "nome": "SO II",
        "professor": "MARCO A",
        "sala": "LR",
        "diaSemana": 6,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "8FTxjenTEXQTwEIIc7ev9tNEBou1"
      }
    },
    "semestre5": {
      "labBd": {
        "nome": "LAB BD",
        "professor": "GERALDO",
        "sala": "LA",
        "diaSemana": 2,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "iS97Tp1PHsObrwqhMdCXZyS27g52"
      },
      "segInf": {
        "nome": "SEG INF",
        "professor": "CARLOS E.",
        "sala": "L3/S16",
        "diaSemana": 3,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "4GsjZFqmu9QgZGNPQOyrSjeuFim1"
      },
      "progAplic": {
        "nome": "PROG APLIC",
        "professor": "JUNIOR",
        "sala": "LR",
        "diaSemana": 3,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "aYz4bBVZ9tdfRQfIpmSLAKOvzk22"
      },
      "redesComp": {
        "nome": "REDES COMP",
        "professor": "MARCO A",
        "sala": "S5",
        "diaSemana": 4,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "8FTxjenTEXQTwEIIc7ev9tNEBou1"
      },
      "progWeb": {
        "nome": "PROG WEB",
        "professor": "GABRIEL",
        "sala": "L5",
        "diaSemana": 5,
        "horaInicio": "07:40",
        "horaFim": "09:20",
        "professorId": "kYsTpXPyw2XiWjrbARmqp0WZyQg2"
      },
      "ingles5": {
        "nome": "INGLÊS V",
        "professor": "ANNA",
        "sala": "S20/L1",
        "diaSemana": 5,
        "horaInicio": "09:30",
        "horaFim": "11:10",
        "professorId": "GAVFn5wLVzPLVLjTk9XLSDRUez72"
      },
      "progWeb2": {
        "nome": "PROG WEB",
        "professor": "GABRIEL",
        "sala": "L5",
        "diaSemana": 5,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "kYsTpXPyw2XiWjrbARmqp0WZyQg2"
      },
      "labEngSoft": {
        "nome": "LAB ENG SOFT",
        "professor": "MAKINO",
        "sala": "LA",
        "diaSemana": 6,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "dcru6jK5ZDN5duXsyxg39EuH5H12"
      }
    },
    "semestre6": {
      "intArtif": {
        "nome": "INT ARTIF",
        "professor": "GABRIEL",
        "sala": "L6",
        "diaSemana": 2,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "kYsTpXPyw2XiWjrbARmqp0WZyQg2"
      },
      "pRecProf": {
        "nome": "P REC PROF",
        "professor": "ADRIANO",
        "sala": "S12",
        "diaSemana": 2,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "iKohUguPE2bBjenYrK8j4gxKR2k1"
      },
      "gestEquipes": {
        "nome": "GEST EQUIPES",
        "professor": "SUZANA",
        "sala": "S11",
        "diaSemana": 3,
        "horaInicio": "09:30",
        "horaFim": "11:10",
        "professorId": "bpi3yMtkSsNjeGi7Au82t0fXYB52"
      },
      "empreend": {
        "nome": "EMPREEND",
        "professor": "SUZANA",
        "sala": "S11",
        "diaSemana": 3,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "bpi3yMtkSsNjeGi7Au82t0fXYB52"
      },
      "gestGovTi": {
        "nome": "GEST GOV TI",
        "professor": "FABRICIO",
        "sala": "LA",
        "diaSemana": 4,
        "horaInicio": "09:30",
        "horaFim": "13:00",
        "professorId": "HAU5Z3fyiKbPigCVxFAUSojGj0m1"
      },
      "gestProj": {
        "nome": "GEST PROJ",
        "professor": "ADRIANO",
        "sala": "L6",
        "diaSemana": 5,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "iKohUguPE2bBjenYrK8j4gxKR2k1"
      },
      "ingles6": {
        "nome": "INGLES VI",
        "professor": "ANNA",
        "sala": "S20/L1",
        "diaSemana": 5,
        "horaInicio": "11:20",
        "horaFim": "13:00",
        "professorId": "GAVFn5wLVzPLVLjTk9XLSDRUez72"
      },
      "topEspInf": {
        "nome": "TOP ESP INF",
        "professor": "FABRICIO",
        "sala": "L6",
        "diaSemana": 6,
        "horaInicio": "07:40",
        "horaFim": "11:10",
        "professorId": "HAU5Z3fyiKbPigCVxFAUSojGj0m1"
      }
    }
  }
}
''';
