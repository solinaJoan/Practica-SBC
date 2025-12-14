;;; ============================================================
;;; instancies.clp - 100 instàncies optimitzades
;;; Sistema Expert de Recomanació d'Habitatges
;;; ============================================================

;;; ============================================================
;;; SOL·LICITANTS (6 instàncies)
;;; ============================================================

(definstances solicitants
    ;;; SOL·LICITANT 1: COMPRADOR SEGONA RESIDÈNCIA
    ;;; Busca habitatge gran, amb bones prestacions, pot reformar
    ;;; Evita zones sorolloses, prefereix tranquil·litat i bones vistes
    (sol-segona-residencia of CompradorSegonaResidencia
        (nom "Sr. Martínez")
        (edat 52)
        (numeroPersones 2)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (segonaResidencia si)
        (estudiaACiutat no)
        (treballaACiutat no)
        (pressupostMaxim 3500.0)
        (pressupostMinim 2000.0)
        (margeEstricte no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "")
        (evitaServei discoteca-razzmatazz bar-blai)
        (prefereixServei parc-guell jardi-turo-parc restaurant-sarria))
    
    ;;; SOL·LICITANT 2: PERSONA GRAN
    ;;; Necessita accessibilitat, salut propera, tranquil·litat
    ;;; Evita soroll, prefereix comerços i serveis de salut a prop
    (sol-persona-gran of PersonaGran
        (nom "Sra. Montserrat")
        (edat 72)
        (numeroPersones 1)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (segonaResidencia no)
        (estudiaACiutat no)
        (treballaACiutat no)
        (pressupostMaxim 1500.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (teVehicle no)
        (requereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "")
        (evitaServei discoteca-razzmatazz bar-verdi)
        (prefereixServei farmacia-eixample cap-eixample mercat-ninot))
    
    ;;; SOL·LICITANT 3: PARELLA ADULTA SENSE FILLS
    ;;; Busca confort, bones comunicacions, zones d'oci
    ;;; Prefereix restaurants, teatres i zones tranquil·les
    (sol-parella-adulta of ParellaSenseFills
        (nom "Marc i Laura")
        (edat 38)
        (numeroPersones 2)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (segonaResidencia no)
        (estudiaACiutat no)
        (treballaACiutat si)
        (pressupostMaxim 1800.0)
        (pressupostMinim 1200.0)
        (margeEstricte no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota "Gos")
        (evitaServei)
        (prefereixServei parc-joan-miro teatre-lliure restaurant-gracia gimnas-dir))
    
    ;;; SOL·LICITANT 4: GRUP ESTUDIANTS
    ;;; Necessita moblat, transport públic, prop universitat
    ;;; Prefereix zones amb oci jove i vida nocturna
    (sol-estudiants of GrupEstudiants
        (nom "Grup UPC - 4 estudiants")
        (edat 21)
        (numeroPersones 4)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (segonaResidencia no)
        (estudiaACiutat si)
        (treballaACiutat no)
        (pressupostMaxim 1700.0)
        (pressupostMinim 1200.0)
        (margeEstricte si)
        (teVehicle no)
        (requereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "")
        (evitaServei)
        (prefereixServei universitat-upc metro-zona-universitaria bar-verdi cinema-verdi gimnas-university))
    
    ;;; SOL·LICITANT 5: FAMÍLIA AMB FILLS
    ;;; Necessita escoles properes, espai, zones verdes
    ;;; Evita zones sorolloses, prefereix parcs i escoles
    (sol-familia of ParellaAmbFills
        (nom "Família Sánchez")
        (edat 40)
        (numeroPersones 4)
        (numeroFills 2)
        (edatsFills 6 9)
        (teAvis no)
        (segonaResidencia no)
        (estudiaACiutat no)
        (treballaACiutat si)
        (pressupostMaxim 2200.0)
        (pressupostMinim 1600.0)
        (margeEstricte no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota "Gat")
        (evitaServei discoteca-razzmatazz bar-blai)
        (prefereixServei escola-corts parc-cervantes zona-esportiva-corts supermercat-corts))
    
    ;;; SOL·LICITANT 6: JOVE INDIVIDU
    ;;; Pressupost ajustat, prefereix zones amb oci i vida
    ;;; Prefereix transport públic i zones amb ambient jove
    (sol-jove of Joves
        (nom "Anna")
        (edat 26)
        (numeroPersones 1)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (segonaResidencia no)
        (estudiaACiutat no)
        (treballaACiutat si)
        (pressupostMaxim 1100.0)
        (pressupostMinim 800.0)
        (margeEstricte si)
        (teVehicle no)
        (requereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "")
        (evitaServei)
        (prefereixServei metro-diagonal bar-verdi cinema-verdi gimnas-dir restaurant-gracia))
)
;;; ============================================================
;;; LOCALITZACIONS (10 instàncies)
;;; ============================================================

(definstances localitzacions
    ;; Zona Eixample (cèntrica, ben comunicada)
    (loc-eixample-1 of Localitzacio 
        (adreca "C/ Mallorca 150") (barri "Eixample Esquerra") 
        (districte "Eixample") (codiPostal "08036")
        (coordenadaX 100.0) (coordenadaY 200.0))
    
    (loc-eixample-2 of Localitzacio 
        (adreca "C/ Consell de Cent 200") (barri "Eixample Dreta") 
        (districte "Eixample") (codiPostal "08011")
        (coordenadaX 120.0) (coordenadaY 210.0))
    
    ;; Zona Gràcia (bohèmia, amb zones verdes)
    (loc-gracia-1 of Localitzacio 
        (adreca "C/ Verdi 45") (barri "Vila de Gràcia") 
        (districte "Gràcia") (codiPostal "08012")
        (coordenadaX 110.0) (coordenadaY 250.0))
    
    (loc-gracia-2 of Localitzacio 
        (adreca "Travessera de Gràcia 88") (barri "Gràcia") 
        (districte "Gràcia") (codiPostal "08012")
        (coordenadaX 115.0) (coordenadaY 260.0))
    
    ;; Zona Sarrià (residencial, tranquil·la)
    (loc-sarria-1 of Localitzacio 
        (adreca "Passeig Bonanova 50") (barri "Sarrià") 
        (districte "Sarrià-Sant Gervasi") (codiPostal "08017")
        (coordenadaX 80.0) (coordenadaY 280.0))
    
    (loc-sarria-2 of Localitzacio 
        (adreca "C/ Muntaner 450") (barri "Sant Gervasi") 
        (districte "Sarrià-Sant Gervasi") (codiPostal "08022")
        (coordenadaX 85.0) (coordenadaY 290.0))
    
    ;; Zona Les Corts (familiar, amb serveis)
    (loc-corts-1 of Localitzacio 
        (adreca "Travessera Les Corts 150") (barri "Les Corts") 
        (districte "Les Corts") (codiPostal "08028")
        (coordenadaX 70.0) (coordenadaY 220.0))
    
    (loc-corts-2 of Localitzacio 
        (adreca "Av. Diagonal 600") (barri "Les Corts") 
        (districte "Les Corts") (codiPostal "08021")
        (coordenadaX 75.0) (coordenadaY 225.0))
    
    ;; Zona Universitària
    (loc-university of Localitzacio 
        (adreca "Av. Diagonal 690") (barri "Pedralbes") 
        (districte "Les Corts") (codiPostal "08034")
        (coordenadaX 60.0) (coordenadaY 240.0))
    
    ;; Zona Poble Sec (jove, amb oci)
    (loc-poble-sec of Localitzacio 
        (adreca "C/ Blai 25") (barri "Poble Sec") 
        (districte "Sants-Montjuïc") (codiPostal "08004")
        (coordenadaX 95.0) (coordenadaY 180.0))
)

;;; ============================================================
;;; SERVEIS (60 instàncies)
;;; ============================================================

(definstances serveis
    ;;; --- TRANSPORT PÚBLIC (12) ---
    (metro-diagonal of EstacioMetro 
        (nomServei "Metro Diagonal L3/L5") (teLocalitzacio loc-eixample-1)
        (horariObertura "05:00") (horariTancament "00:00"))
    
    (metro-fontana of EstacioMetro 
        (nomServei "Metro Fontana L3") (teLocalitzacio loc-gracia-1)
        (horariObertura "05:00") (horariTancament "00:00"))
    
    (metro-lesseps of EstacioMetro 
        (nomServei "Metro Lesseps L3") (teLocalitzacio loc-gracia-2)
        (horariObertura "05:00") (horariTancament "00:00"))
    
    (metro-zona-universitaria of EstacioMetro 
        (nomServei "Metro Zona Universitària L3") (teLocalitzacio loc-university)
        (horariObertura "05:00") (horariTancament "00:00"))
    
    (bus-eixample-1 of ParadaBus 
        (nomServei "Parada Bus 7") (teLocalitzacio loc-eixample-1)
        (horariObertura "06:00") (horariTancament "23:00"))
    
    (bus-eixample-2 of ParadaBus 
        (nomServei "Parada Bus 24") (teLocalitzacio loc-eixample-2)
        (horariObertura "06:00") (horariTancament "23:00"))
    
    (bus-gracia of ParadaBus 
        (nomServei "Parada Bus 22") (teLocalitzacio loc-gracia-1)
        (horariObertura "06:00") (horariTancament "23:00"))
    
    (bus-corts of ParadaBus 
        (nomServei "Parada Bus 54") (teLocalitzacio loc-corts-1)
        (horariObertura "06:00") (horariTancament "23:00"))
    
    (tren-sarria of EstacioTren 
        (nomServei "FGC Sarrià") (teLocalitzacio loc-sarria-1)
        (horariObertura "05:30") (horariTancament "23:30"))
    
    (tren-les-corts of EstacioTren 
        (nomServei "FGC Les Tres Torres") (teLocalitzacio loc-corts-2)
        (horariObertura "05:30") (horariTancament "23:30"))
    
    (autopista-ronda of Autopista 
        (nomServei "Accés Ronda de Dalt") (teLocalitzacio loc-sarria-2)
        (horariObertura "00:00") (horariTancament "23:59"))
    
    (autopista-diagonal of Autopista 
        (nomServei "Accés Ronda Litoral") (teLocalitzacio loc-corts-2)
        (horariObertura "00:00") (horariTancament "23:59"))
    
    ;;; --- EDUCACIÓ (10) ---
    (escola-eixample of Escola 
        (nomServei "CEIP Pau Claris") (teLocalitzacio loc-eixample-1)
        (horariObertura "09:00") (horariTancament "17:00"))
    
    (escola-gracia of Escola 
        (nomServei "CEIP Vila de Gràcia") (teLocalitzacio loc-gracia-1)
        (horariObertura "09:00") (horariTancament "17:00"))
    
    (escola-corts of Escola 
        (nomServei "CEIP Les Corts") (teLocalitzacio loc-corts-1)
        (horariObertura "09:00") (horariTancament "17:00"))
    
    (llar-infants-eixample of LlarInfants 
        (nomServei "Llar d'Infants Eixample") (teLocalitzacio loc-eixample-2)
        (horariObertura "08:00") (horariTancament "18:00"))
    
    (llar-infants-gracia of LlarInfants 
        (nomServei "Llar d'Infants Gràcia") (teLocalitzacio loc-gracia-2)
        (horariObertura "08:00") (horariTancament "18:00"))
    
    (institut-eixample of Institut 
        (nomServei "Institut Verdaguer") (teLocalitzacio loc-eixample-1)
        (horariObertura "08:00") (horariTancament "15:00"))
    
    (institut-gracia of Institut 
        (nomServei "Institut Gràcia") (teLocalitzacio loc-gracia-1)
        (horariObertura "08:00") (horariTancament "15:00"))
    
    (universitat-upc of Universitat 
        (nomServei "UPC Campus Nord") (teLocalitzacio loc-university)
        (horariObertura "08:00") (horariTancament "21:00"))
    
    (universitat-ub of Universitat 
        (nomServei "UB Diagonal") (teLocalitzacio loc-eixample-2)
        (horariObertura "08:00") (horariTancament "21:00"))
    
    (universitat-esade of Universitat 
        (nomServei "ESADE Sant Cugat Access") (teLocalitzacio loc-sarria-1)
        (horariObertura "08:00") (horariTancament "21:00"))
    
    ;;; --- SALUT (8) ---
    (hospital-clinic of Hospital 
        (nomServei "Hospital Clínic") (teLocalitzacio loc-eixample-1)
        (horariObertura "00:00") (horariTancament "23:59"))
    
    (cap-eixample of CentreSalut 
        (nomServei "CAP Casanova") (teLocalitzacio loc-eixample-2)
        (horariObertura "08:00") (horariTancament "20:00"))
    
    (cap-gracia of CentreSalut 
        (nomServei "CAP Larrard") (teLocalitzacio loc-gracia-1)
        (horariObertura "08:00") (horariTancament "20:00"))
    
    (cap-sarria of CentreSalut 
        (nomServei "CAP Sarrià") (teLocalitzacio loc-sarria-1)
        (horariObertura "08:00") (horariTancament "20:00"))
    
    (farmacia-eixample of Farmacia 
        (nomServei "Farmàcia Diagonal") (teLocalitzacio loc-eixample-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    (farmacia-gracia of Farmacia 
        (nomServei "Farmàcia Gràcia") (teLocalitzacio loc-gracia-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    (farmacia-sarria of Farmacia 
        (nomServei "Farmàcia Sarrià") (teLocalitzacio loc-sarria-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    (farmacia-corts of Farmacia 
        (nomServei "Farmàcia Les Corts") (teLocalitzacio loc-corts-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    ;;; --- COMERÇOS (10) ---
    (supermercat-eixample-1 of Supermercat 
        (nomServei "Mercadona Mallorca") (teLocalitzacio loc-eixample-1)
        (horariObertura "09:00") (horariTancament "21:30"))
    
    (supermercat-eixample-2 of Supermercat 
        (nomServei "Caprabo Consell de Cent") (teLocalitzacio loc-eixample-2)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    (supermercat-gracia of Supermercat 
        (nomServei "Bonpreu Gràcia") (teLocalitzacio loc-gracia-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    (supermercat-sarria of Supermercat 
        (nomServei "Caprabo Sarrià") (teLocalitzacio loc-sarria-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    (mercat-ninot of Mercat 
        (nomServei "Mercat del Ninot") (teLocalitzacio loc-eixample-2)
        (horariObertura "08:00") (horariTancament "20:00"))
    
    (mercat-llibertat of Mercat 
        (nomServei "Mercat de la Llibertat") (teLocalitzacio loc-gracia-1)
        (horariObertura "08:00") (horariTancament "20:00"))
    
    (centre-comercial-diagonal of CentreComercial 
        (nomServei "L'Illa Diagonal") (teLocalitzacio loc-corts-2)
        (horariObertura "10:00") (horariTancament "22:00"))
    
    (centre-comercial-pedralbes of CentreComercial 
        (nomServei "Centre Pedralbes") (teLocalitzacio loc-sarria-2)
        (horariObertura "10:00") (horariTancament "22:00"))
    
    (hipermercat-diagonal of Hipermercat 
        (nomServei "Carrefour Diagonal") (teLocalitzacio loc-corts-2)
        (horariObertura "09:00") (horariTancament "22:00"))
    
    (supermercat-corts of Supermercat 
        (nomServei "Bonpreu Les Corts") (teLocalitzacio loc-corts-1)
        (horariObertura "09:00") (horariTancament "21:00"))
    
    ;;; --- ZONES VERDES (8) ---
    (parc-ciutadella of Parc 
        (nomServei "Parc de la Ciutadella") (teLocalitzacio loc-poble-sec)
        (horariObertura "10:00") (horariTancament "20:00"))
    
    (parc-guell of Parc 
        (nomServei "Park Güell") (teLocalitzacio loc-gracia-2)
        (horariObertura "08:00") (horariTancament "21:00"))
    
    (jardi-turo-parc of Jardi 
        (nomServei "Jardins Turó Parc") (teLocalitzacio loc-sarria-1)
        (horariObertura "10:00") (horariTancament "20:00"))
    
    (parc-cervantes of Parc 
        (nomServei "Parc de Cervantes") (teLocalitzacio loc-corts-2)
        (horariObertura "10:00") (horariTancament "20:00"))
    
    (zona-esportiva-corts of ZonaEsportiva 
        (nomServei "Poliesportiu Les Corts") (teLocalitzacio loc-corts-1)
        (horariObertura "07:00") (horariTancament "23:00"))
    
    (parc-joan-miro of Parc 
        (nomServei "Parc Joan Miró") (teLocalitzacio loc-eixample-2)
        (horariObertura "10:00") (horariTancament "20:00"))
    
    (jardi-sarria of Jardi 
        (nomServei "Jardins Vila Amèlia") (teLocalitzacio loc-sarria-2)
        (horariObertura "10:00") (horariTancament "20:00"))
    
    (zona-esportiva-gracia of ZonaEsportiva 
        (nomServei "Poliesportiu Gràcia") (teLocalitzacio loc-gracia-1)
        (horariObertura "07:00") (horariTancament "23:00"))
    
    ;;; --- OCI (12) ---
    (bar-verdi of Bar 
        (nomServei "Bar Verdi") (teLocalitzacio loc-gracia-1)
        (horariObertura "18:00") (horariTancament "02:00"))
    
    (bar-blai of Bar 
        (nomServei "Bar Blai Tonight") (teLocalitzacio loc-poble-sec)
        (horariObertura "19:00") (horariTancament "02:30"))
    
    (restaurant-gracia of Restaurant 
        (nomServei "Restaurant La Pepita") (teLocalitzacio loc-gracia-1)
        (horariObertura "13:00") (horariTancament "23:30"))
    
    (restaurant-eixample of Restaurant 
        (nomServei "Restaurant Caelis") (teLocalitzacio loc-eixample-1)
        (horariObertura "13:00") (horariTancament "23:00"))
    
    (restaurant-sarria of Restaurant 
        (nomServei "Restaurant Botafumeiro") (teLocalitzacio loc-sarria-1)
        (horariObertura "13:00") (horariTancament "00:00"))
    
    (cinema-verdi of Cinema 
        (nomServei "Cinemes Verdi") (teLocalitzacio loc-gracia-1)
        (horariObertura "16:00") (horariTancament "01:00"))
    
    (cinema-yelmo of Cinema 
        (nomServei "Yelmo Icaria") (teLocalitzacio loc-poble-sec)
        (horariObertura "11:00") (horariTancament "01:00"))
    
    (teatre-lliure of Teatre 
        (nomServei "Teatre Lliure") (teLocalitzacio loc-gracia-1)
        (horariObertura "18:00") (horariTancament "23:00"))
    
    (discoteca-razzmatazz of Discoteca 
        (nomServei "Razzmatazz") (teLocalitzacio loc-poble-sec)
        (horariObertura "00:00") (horariTancament "06:00"))
    
    (gimnas-dir of Gimnas 
        (nomServei "DIR Diagonal") (teLocalitzacio loc-eixample-1)
        (horariObertura "06:00") (horariTancament "23:00"))
    
    (gimnas-holmes of Gimnas 
        (nomServei "Holmes Place") (teLocalitzacio loc-sarria-1)
        (horariObertura "06:30") (horariTancament "22:30"))
    
    (gimnas-university of Gimnas 
        (nomServei "Gim UPC") (teLocalitzacio loc-university)
        (horariObertura "07:00") (horariTancament "22:00"))
)

;;; ============================================================
;;; HABITATGES (24 instàncies)
;;; ============================================================

(definstances habitatges
    ;;; --- HABITATGES PER SEGONA RESIDÈNCIA (3) ---
    (hab-costa-brava of HabitatgeUnifamiliar 
        (teLocalitzacio loc-sarria-1)
        (superficieHabitable 180.0) (superficieTerrassa 60.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 2) (numeroDormitorisSimples 2)
        (numeroBanys 3) (plantaPis 0)
        (anyConstruccio 2010) (estatConservacio "Bo") (consumEnergetic "B")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor no) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria si) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Mar") (tePlacaAparcament si) (numeroPlacesAparcament 2)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-atic-luxe of Atic 
        (teLocalitzacio loc-sarria-2)
        (superficieHabitable 150.0) (superficieTerrassa 80.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 2) (numeroDormitorisSimples 1)
        (numeroBanys 2) (plantaPis 8)
        (anyConstruccio 2018) (estatConservacio "Excel·lent") (consumEnergetic "A")
        (moblat no) (ambElectrodomestics no) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria si) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament si) (numeroPlacesAparcament 2)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-reformar-bonanova of Pis 
        (teLocalitzacio loc-sarria-1)
        (superficieHabitable 130.0) (superficieTerrassa 15.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 2) (numeroDormitorisSimples 1)
        (numeroBanys 2) (plantaPis 3)
        (anyConstruccio 1970) (estatConservacio "AReformar") (consumEnergetic "D")
        (moblat no) (ambElectrodomestics no) (permetMascotes si)
        (teAscensor si) (teAireCondicionat no) (teCalefaccio no)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Muntanya") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat no) (esExterior si) (orientacioSolar "Matí")
        (nivellSoroll "Baix"))
    
    ;;; --- HABITATGES PER PERSONES GRANS (4) ---
    (hab-avis-accessible-1 of Pis 
        (teLocalitzacio loc-eixample-1)
        (superficieHabitable 90.0) (superficieTerrassa 10.0)
        (numeroDormitoris 2) (numeroDormitorisDobles 1) (numeroDormitorisSimples 1)
        (numeroBanys 2) (plantaPis 1)
        (anyConstruccio 2000) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes no) (tipusVistes "") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-avis-accessible-2 of Pis 
        (teLocalitzacio loc-gracia-1)
        (superficieHabitable 85.0) (superficieTerrassa 8.0)
        (numeroDormitoris 2) (numeroDormitorisDobles 1) (numeroDormitorisSimples 1)
        (numeroBanys 1) (plantaPis 2)
        (anyConstruccio 1995) (estatConservacio "Bo") (consumEnergetic "D")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Parc") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Migdia")
        (nivellSoroll "Baix"))
    
    (hab-avis-sarria-1 of Pis 
        (teLocalitzacio loc-sarria-1)
        (superficieHabitable 100.0) (superficieTerrassa 12.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 1) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 1)
        (anyConstruccio 1985) (estatConservacio "Bo") (consumEnergetic "D")
        (moblat no) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Jardi") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-avis-corts of Pis 
        (teLocalitzacio loc-corts-1)
        (superficieHabitable 95.0) (superficieTerrassa 10.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 1) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 0)
        (anyConstruccio 1990) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes no) (tipusVistes "") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Migdia")
        (nivellSoroll "Mig"))
    
    ;;; --- HABITATGES PER PARELLES (4) ---
    (hab-parella-eixample-1 of Pis 
        (teLocalitzacio loc-eixample-2)
        (superficieHabitable 85.0) (superficieTerrassa 10.0)
        (numeroDormitoris 2) (numeroDormitorisDobles 1) (numeroDormitorisSimples 1)
        (numeroBanys 1) (plantaPis 4)
        (anyConstruccio 2005) (estatConservacio "Excel·lent") (consumEnergetic "B")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster no)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Matí")
        (nivellSoroll "Mig"))
    
    (hab-parella-gracia of Duplex 
        (teLocalitzacio loc-gracia-1)
        (superficieHabitable 100.0) (superficieTerrassa 20.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 2) (numeroDormitorisSimples 1)
        (numeroBanys 2) (plantaPis 5)
        (anyConstruccio 2010) (estatConservacio "Excel·lent") (consumEnergetic "A")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Parc") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-parella-corts of Pis 
        (teLocalitzacio loc-corts-1)
        (superficieHabitable 75.0) (superficieTerrassa 8.0)
        (numeroDormitoris 2) (numeroDormitorisDobles 1) (numeroDormitorisSimples 1)
        (numeroBanys 1) (plantaPis 2)
        (anyConstruccio 1998) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat no) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster no)
        (teVistes no) (tipusVistes "") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Tarda")
        (nivellSoroll "Mig"))
    
    (hab-parella-sarria of Atic 
        (teLocalitzacio loc-sarria-1)
        (superficieHabitable 120.0) (superficieTerrassa 40.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 2) (numeroDormitorisSimples 1)
        (numeroBanys 2) (plantaPis 7)
        (anyConstruccio 2015) (estatConservacio "Excel·lent") (consumEnergetic "A")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria si) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Muntanya") (tePlacaAparcament si) (numeroPlacesAparcament 2)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    ;;; --- HABITATGES PER ESTUDIANTS (5) ---
    (hab-estudiants-1 of Pis 
        (teLocalitzacio loc-university)
        (superficieHabitable 80.0) (superficieTerrassa 0.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 0) (numeroDormitorisSimples 4)
        (numeroBanys 2) (plantaPis 3)
        (anyConstruccio 2000) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat si) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat no) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco no) (teTraster no)
        (teVistes no) (tipusVistes "") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Migdia")
        (nivellSoroll "Mig"))
    
    (hab-estudiants-2 of Pis 
        (teLocalitzacio loc-gracia-2)
        (superficieHabitable 90.0) (superficieTerrassa 5.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 1) (numeroDormitorisSimples 3)
        (numeroBanys 2) (plantaPis 2)
        (anyConstruccio 1995) (estatConservacio "Bo") (consumEnergetic "D")
        (moblat si) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat no) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster no)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Matí")
        (nivellSoroll "Alt"))
    
    (hab-estudiants-3 of Pis 
        (teLocalitzacio loc-eixample-1)
        (superficieHabitable 85.0) (superficieTerrassa 0.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 0) (numeroDormitorisSimples 3)
        (numeroBanys 1) (plantaPis 5)
        (anyConstruccio 1990) (estatConservacio "Acceptable") (consumEnergetic "E")
        (moblat si) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat no) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco no) (teTraster no)
        (teVistes no) (tipusVistes "") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat si) (esExterior no) (orientacioSolar "Mai")
        (nivellSoroll "Alt"))
    
    (hab-estudiants-4 of Pis 
        (teLocalitzacio loc-poble-sec)
        (superficieHabitable 75.0) (superficieTerrassa 0.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 0) (numeroDormitorisSimples 3)
        (numeroBanys 1) (plantaPis 1)
        (anyConstruccio 1985) (estatConservacio "Acceptable") (consumEnergetic "E")
        (moblat si) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor no) (teAireCondicionat no) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco no) (teTraster no)
        (teVistes no) (tipusVistes "") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat no) (esExterior si) (orientacioSolar "Tarda")
        (nivellSoroll "Alt"))
    
    (hab-estudiants-5 of Pis 
        (teLocalitzacio loc-gracia-1)
        (superficieHabitable 95.0) (superficieTerrassa 10.0)
        (numeroDormitoris 5) (numeroDormitorisDobles 0) (numeroDormitorisSimples 5)
        (numeroBanys 2) (plantaPis 4)
        (anyConstruccio 2005) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat si) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat no) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster no)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament no) (numeroPlacesAparcament 0)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Mig"))
    
    ;;; --- HABITATGES PER FAMÍLIES (8) ---
    (hab-familia-1 of Pis 
        (teLocalitzacio loc-corts-1)
        (superficieHabitable 110.0) (superficieTerrassa 15.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 2) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 3)
        (anyConstruccio 2008) (estatConservacio "Excel·lent") (consumEnergetic "B")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Parc") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-familia-2 of Duplex 
        (teLocalitzacio loc-corts-2)
        (superficieHabitable 130.0) (superficieTerrassa 20.0)
        (numeroDormitoris 5) (numeroDormitorisDobles 2) (numeroDormitorisSimples 3)
        (numeroBanys 3) (plantaPis 6)
        (anyConstruccio 2012) (estatConservacio "Excel·lent") (consumEnergetic "A")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria si) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament si) (numeroPlacesAparcament 2)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-familia-3 of Pis 
        (teLocalitzacio loc-gracia-2)
        (superficieHabitable 105.0) (superficieTerrassa 12.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 2) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 2)
        (anyConstruccio 2000) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Parc") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Migdia")
        (nivellSoroll "Baix"))
    
    (hab-familia-4 of HabitatgeUnifamiliar 
        (teLocalitzacio loc-sarria-2)
        (superficieHabitable 200.0) (superficieTerrassa 50.0)
        (numeroDormitoris 5) (numeroDormitorisDobles 3) (numeroDormitorisSimples 2)
        (numeroBanys 3) (plantaPis 0)
        (anyConstruccio 2015) (estatConservacio "Excel·lent") (consumEnergetic "A")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor no) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Jardi") (tePlacaAparcament si) (numeroPlacesAparcament 3)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-familia-5 of Pis 
        (teLocalitzacio loc-eixample-2)
        (superficieHabitable 115.0) (superficieTerrassa 10.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 2) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 5)
        (anyConstruccio 2005) (estatConservacio "Bo") (consumEnergetic "B")
        (moblat no) (ambElectrodomestics si) (permetMascotes no)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Mig"))
    
    (hab-familia-6 of Duplex 
        (teLocalitzacio loc-corts-1)
        (superficieHabitable 125.0) (superficieTerrassa 18.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 2) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 7)
        (anyConstruccio 2010) (estatConservacio "Excel·lent") (consumEnergetic "A")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria si) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Ciutat") (tePlacaAparcament si) (numeroPlacesAparcament 2)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "TotElDia")
        (nivellSoroll "Baix"))
    
    (hab-familia-7 of Pis 
        (teLocalitzacio loc-gracia-1)
        (superficieHabitable 100.0) (superficieTerrassa 12.0)
        (numeroDormitoris 3) (numeroDormitorisDobles 2) (numeroDormitorisSimples 1)
        (numeroBanys 2) (plantaPis 4)
        (anyConstruccio 1998) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat no) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes si) (tipusVistes "Parc") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Migdia")
        (nivellSoroll "Baix"))
    
    (hab-familia-8 of Pis 
        (teLocalitzacio loc-eixample-1)
        (superficieHabitable 120.0) (superficieTerrassa 15.0)
        (numeroDormitoris 4) (numeroDormitorisDobles 2) (numeroDormitorisSimples 2)
        (numeroBanys 2) (plantaPis 1)
        (anyConstruccio 2003) (estatConservacio "Bo") (consumEnergetic "C")
        (moblat no) (ambElectrodomestics si) (permetMascotes si)
        (teAscensor si) (teAireCondicionat si) (teCalefaccio si)
        (tePiscinaComunitaria no) (teTerrassaOBalco si) (teTraster si)
        (teVistes no) (tipusVistes "") (tePlacaAparcament si) (numeroPlacesAparcament 1)
        (teArmariEncastat si) (esExterior si) (orientacioSolar "Matí")
        (nivellSoroll "Mig"))
)

;;; ============================================================
;;; OFERTES (6 instàncies - una per cada sol·licitant)
;;; ============================================================

(definstances ofertes
    ;;; OFERTA 1: Per Segona Residència (Comprador amb bon pressupost)
    (oferta-segona-residencia of Oferta 
        (teHabitatge hab-costa-brava)
        (preuMensual 2500.0)
        (dataPublicacio "2024-01-15")
        (disponible si))
    
    ;;; OFERTA 2: Per Persona Gran (Accessible, salut a prop)
    (oferta-avis-1 of Oferta 
        (teHabitatge hab-avis-accessible-1)
        (preuMensual 1200.0)
        (dataPublicacio "2024-01-20")
        (disponible si))
    
    ;;; OFERTA 3: Per Parella Adulta (Confortable, ben situada)
    (oferta-parella-1 of Oferta 
        (teHabitatge hab-parella-eixample-1)
        (preuMensual 1300.0)
        (dataPublicacio "2024-01-18")
        (disponible si))
    
    ;;; OFERTA 4: Per Estudiants (Moblat, prop universitat)
    (oferta-estudiants-1 of Oferta 
        (teHabitatge hab-estudiants-1)
        (preuMensual 1400.0)
        (dataPublicacio "2024-01-25")
        (disponible si))
    
    ;;; OFERTA 5: Per Família amb fills (Espaiosa, escoles properes)
    (oferta-familia-1 of Oferta 
        (teHabitatge hab-familia-1)
        (preuMensual 1800.0)
        (dataPublicacio "2024-01-22")
        (disponible si))
    
    ;;; OFERTA 6: Per Jove/Individu (Assequible, ben comunicat)
    (oferta-jove-1 of Oferta 
        (teHabitatge hab-parella-corts)
        (preuMensual 950.0)
        (dataPublicacio "2024-01-28")
        (disponible si))
    
    ;;; --- OFERTES ADDICIONALS PER MÉS VARIETAT ---
    
    (oferta-avis-2 of Oferta 
        (teHabitatge hab-avis-accessible-2)
        (preuMensual 1150.0)
        (dataPublicacio "2024-01-21")
        (disponible si))
    
    (oferta-avis-3 of Oferta 
        (teHabitatge hab-avis-sarria-1)
        (preuMensual 1600.0)
        (dataPublicacio "2024-01-19")
        (disponible si))
    
    (oferta-avis-4 of Oferta 
        (teHabitatge hab-avis-corts)
        (preuMensual 1350.0)
        (dataPublicacio "2024-01-23")
        (disponible si))
    
    (oferta-parella-2 of Oferta 
        (teHabitatge hab-parella-gracia)
        (preuMensual 1500.0)
        (dataPublicacio "2024-01-17")
        (disponible si))
    
    (oferta-parella-3 of Oferta 
        (teHabitatge hab-parella-sarria)
        (preuMensual 2100.0)
        (dataPublicacio "2024-01-16")
        (disponible si))
    
    (oferta-estudiants-2 of Oferta 
        (teHabitatge hab-estudiants-2)
        (preuMensual 1600.0)
        (dataPublicacio "2024-01-26")
        (disponible si))
    
    (oferta-estudiants-3 of Oferta 
        (teHabitatge hab-estudiants-3)
        (preuMensual 1350.0)
        (dataPublicacio "2024-01-27")
        (disponible si))
    
    (oferta-estudiants-4 of Oferta 
        (teHabitatge hab-estudiants-4)
        (preuMensual 1200.0)
        (dataPublicacio "2024-01-24")
        (disponible si))
    
    (oferta-estudiants-5 of Oferta 
        (teHabitatge hab-estudiants-5)
        (preuMensual 1700.0)
        (dataPublicacio "2024-01-29")
        (disponible si))
    
    (oferta-familia-2 of Oferta 
        (teHabitatge hab-familia-2)
        (preuMensual 2200.0)
        (dataPublicacio "2024-01-20")
        (disponible si))
    
    (oferta-familia-3 of Oferta 
        (teHabitatge hab-familia-3)
        (preuMensual 1850.0)
        (dataPublicacio "2024-01-21")
        (disponible si))
    
    (oferta-familia-4 of Oferta 
        (teHabitatge hab-familia-4)
        (preuMensual 3500.0)
        (dataPublicacio "2024-01-15")
        (disponible si))
    
    (oferta-familia-5 of Oferta 
        (teHabitatge hab-familia-5)
        (preuMensual 1950.0)
        (dataPublicacio "2024-01-22")
        (disponible si))
    
    (oferta-familia-6 of Oferta 
        (teHabitatge hab-familia-6)
        (preuMensual 2100.0)
        (dataPublicacio "2024-01-23")
        (disponible si))
    
    (oferta-familia-7 of Oferta 
        (teHabitatge hab-familia-7)
        (preuMensual 1700.0)
        (dataPublicacio "2024-01-24")
        (disponible si))
    
    (oferta-familia-8 of Oferta 
        (teHabitatge hab-familia-8)
        (preuMensual 2000.0)
        (dataPublicacio "2024-01-25")
        (disponible si))
    
    (oferta-segona-residencia-2 of Oferta 
        (teHabitatge hab-atic-luxe)
        (preuMensual 3200.0)
        (dataPublicacio "2024-01-14")
        (disponible si))
    
    (oferta-segona-residencia-3 of Oferta 
        (teHabitatge hab-reformar-bonanova)
        (preuMensual 1800.0)
        (dataPublicacio "2024-01-13")
        (disponible si))
)
