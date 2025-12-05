;;; ============================================================
;;; instancies.clp
;;; JOC DE PROVES I DADES DEL SISTEMA (CIUTAT SIMULADA)
;;; Total Instàncies: > 100
;;; Estructura: 4 Barris (Centre, Antic, Universitat, Alta)
;;; ============================================================

(definstances dades-globals

    ;;; ============================================================
    ;;; 1. JOCS DE PROVA: SOL·LICITANTS (6 Casos Estratègics)
    ;;; ============================================================

    ;;; CAS 1: FAMÍLIA GARCIA (Busca escola i parc al Centre)
    ([sol-test-familia] of FamiliaBiparental
        (nom "Familia Garcia")
        (edat 40)
        (numeroPersones 4)
        (numeroFills 2)
        (edatsFills 6 10)
        (pressupostMaxim 1800.0)
        (pressupostMinim 800.0)
        (margeEstricte no)
        (teVehicle si)
        (teMascotes si)
        (tipusMascota "Gos")
        (numeroMascotes 1)
        (necessitaAccessibilitat no)
        (requereixTransportPublic no)
        (treballaACiutat si))

    ;;; CAS 2: GRUP ESTUDIANTS (Busca Universitat i preu baix)
    ([sol-test-estudiants] of GrupEstudiants
        (nom "Grup Universitat")
        (edat 20)
        (numeroPersones 3)
        (numeroFills 0)
        (pressupostMaxim 900.0)
        (pressupostMinim 0.0)
        (margeEstricte si)
        (teVehicle no)
        (teMascotes no)
        (necessitaAccessibilitat no)
        (requereixTransportPublic si)
        (estudiaACiutat si))

    ;;; CAS 3: MARIA JUBILADA (Busca accessibilitat i salut)
    ([sol-test-jubilada] of PersonaGran
        (nom "Maria Antonia")
        (edat 82)
        (numeroPersones 1)
        (numeroFills 0)
        (pressupostMaxim 1200.0)
        (pressupostMinim 500.0)
        (margeEstricte no)
        (teVehicle no)
        (teMascotes si)
        (tipusMascota "Gat")
        (numeroMascotes 1)
        (necessitaAccessibilitat si)
        (requereixTransportPublic no)
        (treballaACiutat no))

    ;;; CAS 4: PARELLA TRANQUIL·LA (Odia el soroll/Discoteca)
    ([sol-test-silenci] of ParellaSenseFills
        (nom "Parella Tranquil·la")
        (edat 35)
        (numeroPersones 2)
        (numeroFills 0)
        (pressupostMaxim 1500.0)
        (pressupostMinim 0.0)
        (margeEstricte no)
        (teVehicle si)
        (teMascotes no)
        (necessitaAccessibilitat no)
        (requereixTransportPublic no)
        (evitaServei [servei-discoteca])) 

    ;;; CAS 5: SR. RIQUESA (Busca luxe a la Zona Alta)
    ([sol-test-executiu] of Individu
        (nom "Sr. Riquesa")
        (edat 45)
        (numeroPersones 1)
        (numeroFills 0)
        (pressupostMaxim 5000.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (teVehicle si)
        (teMascotes no)
        (necessitaAccessibilitat si)
        (requereixTransportPublic no)
        (treballaACiutat si))

    ;;; CAS 6: CAÇADOR GANGUES (Prova de preus sospitosos)
    ([sol-test-ofertes] of Individu
        (nom "Caçador Gangues")
        (edat 30)
        (numeroPersones 1)
        (numeroFills 0)
        (pressupostMaxim 1000.0)
        (pressupostMinim 400.0) 
        (margeEstricte si)
        (teVehicle no)
        (teMascotes no)
        (necessitaAccessibilitat no)
        (requereixTransportPublic si))

    ;;; ============================================================
    ;;; 2. ESTRUCTURA DE LA CIUTAT (4 BARRIS)
    ;;; ============================================================

    ;;; --- ZONA 1: EIXAMPLE (CENTRE) ---
    ;;; Coordenades: X[900-1100], Y[900-1100]
    ;;; Característiques: Molts serveis, ben comunicat, dens.
    
    ;;; Serveis Centre
    ([loc-s-metro-centre] of Localitzacio (adreca "Metro Centre") (districte Eixample) (coordenadaX 1000.0) (coordenadaY 1000.0))
    ([loc-s-escola] of Localitzacio (adreca "Escola Publica") (districte Eixample) (coordenadaX 950.0) (coordenadaY 1050.0))
    ([loc-s-cap] of Localitzacio (adreca "CAP Salut") (districte Eixample) (coordenadaX 1050.0) (coordenadaY 950.0))
    ([loc-s-super] of Localitzacio (adreca "Supermercat") (districte Eixample) (coordenadaX 1020.0) (coordenadaY 1020.0))
    ([loc-s-parc] of Localitzacio (adreca "Parc Central") (districte Eixample) (coordenadaX 980.0) (coordenadaY 980.0))

    ([servei-metro] of EstacioMetro (nomServei "L3 Verda") (teLocalitzacio [loc-s-metro-centre]))
    ([servei-escola] of Escola (nomServei "Escola Balmes") (teLocalitzacio [loc-s-escola]))
    ([servei-cap] of CentreSalut (nomServei "CAP Eixample") (teLocalitzacio [loc-s-cap]))
    ([servei-super] of Supermercat (nomServei "BonPreu") (teLocalitzacio [loc-s-super]))
    ([servei-parc] of Parc (nomServei "Parc Joan Miro") (teLocalitzacio [loc-s-parc]))

    ;;; Habitatges Centre (Per a Família i Jubilada)
    ([loc-h-centre-1] of Localitzacio (adreca "C/ Arago 1") (districte Eixample) (coordenadaX 960.0) (coordenadaY 1040.0)) ; A prop escola
    ([loc-h-centre-2] of Localitzacio (adreca "C/ Balmes 5") (districte Eixample) (coordenadaX 1040.0) (coordenadaY 960.0)) ; A prop CAP
    ([loc-h-centre-3] of Localitzacio (adreca "Gran Via 10") (districte Eixample) (coordenadaX 1005.0) (coordenadaY 1005.0))
    ([loc-h-centre-4] of Localitzacio (adreca "C/ Diputacio 20") (districte Eixample) (coordenadaX 990.0) (coordenadaY 1010.0))
    ([loc-h-centre-5] of Localitzacio (adreca "C/ Consell 30") (districte Eixample) (coordenadaX 1080.0) (coordenadaY 1080.0))

    ([hab-familia-ideal] of Pis (teLocalitzacio [loc-h-centre-1]) (superficieHabitable 110.0) (numeroDormitoris 4) (teAscensor si) (tePiscinaComunitaria si) (permetMascotes si) (tePlacaAparcament si) (moblat si) (nivellSoroll "Baix") (consumEnergetic "B"))
    ([hab-jubilada-ok] of Pis (teLocalitzacio [loc-h-centre-2]) (superficieHabitable 60.0) (numeroDormitoris 2) (plantaPis 0) (teAscensor no) (permetMascotes si) (nivellSoroll "Baix"))
    ([hab-jubilada-fail] of Pis (teLocalitzacio [loc-h-centre-3]) (superficieHabitable 65.0) (plantaPis 4) (teAscensor no) (permetMascotes si))
    ([hab-centre-normal-1] of Pis (teLocalitzacio [loc-h-centre-4]) (superficieHabitable 80.0) (numeroDormitoris 3) (teAscensor si) (moblat si))
    ([hab-centre-normal-2] of Atic (teLocalitzacio [loc-h-centre-5]) (superficieHabitable 90.0) (numeroDormitoris 2) (teAscensor si) (teTerrassaOBalco si))


    ;;; --- ZONA 2: ZONA UNIVERSITÀRIA (LES CORTS) ---
    ;;; Coordenades: X[2000-2200], Y[2000-2200]
    ;;; Característiques: Universitats, pisos estudiants, lluny del centre.

    ;;; Serveis Universitat
    ([loc-s-uni] of Localitzacio (adreca "Campus Nord") (districte LesCorts) (coordenadaX 2100.0) (coordenadaY 2100.0))
    ([loc-s-metro-uni] of Localitzacio (adreca "Metro Zona Univ") (districte LesCorts) (coordenadaX 2150.0) (coordenadaY 2150.0))
    ([loc-s-bar] of Localitzacio (adreca "Bar Facultat") (districte LesCorts) (coordenadaX 2110.0) (coordenadaY 2090.0))

    ([servei-uni] of Universitat (nomServei "UPC") (teLocalitzacio [loc-s-uni]))
    ([servei-metro-u] of EstacioMetro (nomServei "L3 Zona Univ") (teLocalitzacio [loc-s-metro-uni]))
    ([servei-bar] of Bar (nomServei "El Frankfurt") (teLocalitzacio [loc-s-bar]))

    ;;; Habitatges Estudiants
    ([loc-h-uni-1] of Localitzacio (adreca "Avda Diagonal 1") (districte LesCorts) (coordenadaX 2120.0) (coordenadaY 2120.0))
    ([loc-h-uni-2] of Localitzacio (adreca "C/ Jordi Girona") (districte LesCorts) (coordenadaX 2050.0) (coordenadaY 2050.0))
    ([loc-h-uni-3] of Localitzacio (adreca "C/ Dels Pins") (districte LesCorts) (coordenadaX 2180.0) (coordenadaY 2180.0))

    ([hab-estudiants-ok] of Pis (teLocalitzacio [loc-h-uni-1]) (superficieHabitable 80.0) (numeroDormitoris 3) (teAscensor si) (moblat si) (permetMascotes no) (consumEnergetic "D"))
    ([hab-estudiants-fail] of Pis (teLocalitzacio [loc-h-uni-2]) (superficieHabitable 85.0) (numeroDormitoris 3) (moblat no) (teAscensor si))
    ([hab-uni-extra] of Pis (teLocalitzacio [loc-h-uni-3]) (superficieHabitable 70.0) (numeroDormitoris 2) (moblat si) (teAscensor no))


    ;;; --- ZONA 3: BARRI ANTIC (CIUTAT VELLA) ---
    ;;; Coordenades: X[1200-1400], Y[500-700]
    ;;; Característiques: Oci nocturn (soroll), carrers estrets, turístic.

    ;;; Serveis Antic
    ([loc-s-disco] of Localitzacio (adreca "Zona Oci") (districte CiutatVella) (coordenadaX 1300.0) (coordenadaY 600.0))
    ([loc-s-museu] of Localitzacio (adreca "Museu Historia") (districte CiutatVella) (coordenadaX 1250.0) (coordenadaY 650.0))

    ([servei-discoteca] of Discoteca (nomServei "Disco Inferno") (teLocalitzacio [loc-s-disco]))
    ([servei-cultura] of Teatre (nomServei "Teatre Principal") (teLocalitzacio [loc-s-museu]))

    ;;; Habitatges Antic
    ([loc-h-antic-1] of Localitzacio (adreca "C/ Escudellers") (districte CiutatVella) (coordenadaX 1305.0) (coordenadaY 605.0)) ; AL COSTAT DISCO
    ([loc-h-antic-2] of Localitzacio (adreca "Placa Reial") (districte CiutatVella) (coordenadaX 1280.0) (coordenadaY 620.0))
    ([loc-h-antic-3] of Localitzacio (adreca "Ramblas") (districte CiutatVella) (coordenadaX 1350.0) (coordenadaY 550.0))

    ([hab-sorollos] of Pis (teLocalitzacio [loc-h-antic-1]) (superficieHabitable 70.0) (plantaPis 1) (teAscensor si) (nivellSoroll "Alt") (esExterior si))
    ([hab-antic-2] of Pis (teLocalitzacio [loc-h-antic-2]) (superficieHabitable 50.0) (plantaPis 3) (teAscensor no) (nivellSoroll "Alt"))
    ([hab-zulo] of Estudi (teLocalitzacio [loc-h-antic-3]) (superficieHabitable 20.0) (numeroDormitoris 0) (teAscensor no) (moblat no))


    ;;; --- ZONA 4: ZONA ALTA (SARRIÀ/PEDRALBES) ---
    ;;; Coordenades: X[500-800], Y[2500-2800]
    ;;; Característiques: Cases grans, luxe, cotxe necessari, parcs grans.

    ;;; Serveis Alta
    ([loc-s-club] of Localitzacio (adreca "Club Tennis") (districte Sarria) (coordenadaX 600.0) (coordenadaY 2600.0))
    ([loc-s-autopista] of Localitzacio (adreca "Ronda Dalt") (districte Sarria) (coordenadaX 500.0) (coordenadaY 2800.0))

    ([servei-club] of Gimnas (nomServei "Royal Club") (teLocalitzacio [loc-s-club]))
    ([servei-autopista] of Autopista (nomServei "Sortida 5") (teLocalitzacio [loc-s-autopista]))

    ;;; Habitatges Alta
    ([loc-h-alta-1] of Localitzacio (adreca "Avda Pedralbes") (districte Sarria) (coordenadaX 650.0) (coordenadaY 2650.0))
    ([loc-h-alta-2] of Localitzacio (adreca "C/ Major Sarria") (districte Sarria) (coordenadaX 700.0) (coordenadaY 2550.0))
    ([loc-h-alta-3] of Localitzacio (adreca "C/ Muntanya") (districte Sarria) (coordenadaX 550.0) (coordenadaY 2700.0))

    ([hab-luxe] of HabitatgeUnifamiliar (teLocalitzacio [loc-h-alta-1]) (superficieHabitable 250.0) (numeroDormitoris 5) (teTerrassaOBalco si) (tePiscinaComunitaria si) (tePlacaAparcament si) (teAireCondicionat si) (teVistes si) (moblat si) (nivellSoroll "Baix") (consumEnergetic "A"))
    ([hab-alta-2] of Atic (teLocalitzacio [loc-h-alta-2]) (superficieHabitable 150.0) (numeroDormitoris 3) (teAscensor si) (teTerrassaOBalco si) (tePlacaAparcament si))
    ([hab-alta-3] of HabitatgeUnifamiliar (teLocalitzacio [loc-h-alta-3]) (superficieHabitable 180.0) (numeroDormitoris 4) (teAscensor no) (tePlacaAparcament si))


    ;;; ============================================================
    ;;; 3. OFERTES (LINK HABITATGES)
    ;;; ============================================================

    ;;; Ofertes Casos Clau
    ([oferta-familia] of Oferta (teHabitatge [hab-familia-ideal]) (preuMensual 1600.0) (disponible si))
    ([oferta-estudiants] of Oferta (teHabitatge [hab-estudiants-ok]) (preuMensual 850.0) (disponible si))
    ([oferta-estudiants-fail] of Oferta (teHabitatge [hab-estudiants-fail]) (preuMensual 800.0) (disponible si))
    ([oferta-jubilada] of Oferta (teHabitatge [hab-jubilada-ok]) (preuMensual 900.0) (disponible si))
    ([oferta-jubilada-fail] of Oferta (teHabitatge [hab-jubilada-fail]) (preuMensual 800.0) (disponible si))
    ([oferta-disco] of Oferta (teHabitatge [hab-sorollos]) (preuMensual 1000.0) (disponible si))
    ([oferta-luxe] of Oferta (teHabitatge [hab-luxe]) (preuMensual 4500.0) (disponible si))
    ([oferta-sospitosa] of Oferta (teHabitatge [hab-zulo]) (preuMensual 200.0) (disponible si))

    ;;; Ofertes Secundàries
    ([oferta-c-1] of Oferta (teHabitatge [hab-centre-normal-1]) (preuMensual 1200.0) (disponible si))
    ([oferta-c-2] of Oferta (teHabitatge [hab-centre-normal-2]) (preuMensual 1400.0) (disponible si))
    ([oferta-u-1] of Oferta (teHabitatge [hab-uni-extra]) (preuMensual 750.0) (disponible si))
    ([oferta-a-1] of Oferta (teHabitatge [hab-antic-2]) (preuMensual 850.0) (disponible si))
    ([oferta-al-1] of Oferta (teHabitatge [hab-alta-2]) (preuMensual 2500.0) (disponible si))
    ([oferta-al-2] of Oferta (teHabitatge [hab-alta-3]) (preuMensual 3000.0) (disponible si))


    ;;; ============================================================
    ;;; 4. INSTÀNCIES DE FARCIMENT (PER ARRIBAR A ~100)
    ;;; Escampades pels 4 barris per donar "vida" a la ciutat
    ;;; ============================================================

    ;;; FARCIMENT EIXAMPLE (CENTRE)
    ([loc-f-e1] of Localitzacio (adreca "Eixample F1") (districte Eixample) (coordenadaX 920.0) (coordenadaY 1010.0))
    ([loc-f-e2] of Localitzacio (adreca "Eixample F2") (districte Eixample) (coordenadaX 930.0) (coordenadaY 1020.0))
    ([loc-f-e3] of Localitzacio (adreca "Eixample F3") (districte Eixample) (coordenadaX 940.0) (coordenadaY 1030.0))
    ([hab-f-e1] of Pis (teLocalitzacio [loc-f-e1]) (superficieHabitable 70.0) (numeroDormitoris 2) (teAscensor si) (preuMensual 1100.0))
    ([hab-f-e2] of Pis (teLocalitzacio [loc-f-e2]) (superficieHabitable 75.0) (numeroDormitoris 3) (teAscensor si) (preuMensual 1200.0))
    ([hab-f-e3] of Pis (teLocalitzacio [loc-f-e3]) (superficieHabitable 60.0) (numeroDormitoris 2) (teAscensor no) (preuMensual 900.0))
    ([of-f-e1] of Oferta (teHabitatge [hab-f-e1]) (preuMensual 1100.0) (disponible si))
    ([of-f-e2] of Oferta (teHabitatge [hab-f-e2]) (preuMensual 1200.0) (disponible si))
    ([of-f-e3] of Oferta (teHabitatge [hab-f-e3]) (preuMensual 900.0) (disponible si))

    ;;; FARCIMENT UNIVERSITAT
    ([loc-f-u1] of Localitzacio (adreca "Uni F1") (districte LesCorts) (coordenadaX 2080.0) (coordenadaY 2080.0))
    ([loc-f-u2] of Localitzacio (adreca "Uni F2") (districte LesCorts) (coordenadaX 2090.0) (coordenadaY 2090.0))
    ([loc-f-u3] of Localitzacio (adreca "Uni F3") (districte LesCorts) (coordenadaX 2100.0) (coordenadaY 2130.0))
    ([hab-f-u1] of Pis (teLocalitzacio [loc-f-u1]) (superficieHabitable 80.0) (numeroDormitoris 3) (moblat si) (preuMensual 800.0))
    ([hab-f-u2] of Pis (teLocalitzacio [loc-f-u2]) (superficieHabitable 90.0) (numeroDormitoris 4) (moblat si) (preuMensual 900.0))
    ([hab-f-u3] of Estudi (teLocalitzacio [loc-f-u3]) (superficieHabitable 40.0) (numeroDormitoris 1) (moblat si) (preuMensual 600.0))
    ([of-f-u1] of Oferta (teHabitatge [hab-f-u1]) (preuMensual 800.0) (disponible si))
    ([of-f-u2] of Oferta (teHabitatge [hab-f-u2]) (preuMensual 900.0) (disponible si))
    ([of-f-u3] of Oferta (teHabitatge [hab-f-u3]) (preuMensual 600.0) (disponible si))

    ;;; FARCIMENT ANTIC
    ([loc-f-a1] of Localitzacio (adreca "Antic F1") (districte CiutatVella) (coordenadaX 1310.0) (coordenadaY 580.0))
    ([loc-f-a2] of Localitzacio (adreca "Antic F2") (districte CiutatVella) (coordenadaX 1320.0) (coordenadaY 590.0))
    ([loc-f-a3] of Localitzacio (adreca "Antic F3") (districte CiutatVella) (coordenadaX 1330.0) (coordenadaY 600.0))
    ([hab-f-a1] of Pis (teLocalitzacio [loc-f-a1]) (superficieHabitable 50.0) (teAscensor no) (nivellSoroll "Alt"))
    ([hab-f-a2] of Atic (teLocalitzacio [loc-f-a2]) (superficieHabitable 60.0) (teAscensor si) (teTerrassaOBalco si))
    ([hab-f-a3] of Pis (teLocalitzacio [loc-f-a3]) (superficieHabitable 70.0) (teAscensor no))
    ([of-f-a1] of Oferta (teHabitatge [hab-f-a1]) (preuMensual 750.0) (disponible si))
    ([of-f-a2] of Oferta (teHabitatge [hab-f-a2]) (preuMensual 1100.0) (disponible si))
    ([of-f-a3] of Oferta (teHabitatge [hab-f-a3]) (preuMensual 850.0) (disponible si))

    ;;; FARCIMENT ALTA
    ([loc-f-al1] of Localitzacio (adreca "Alta F1") (districte Sarria) (coordenadaX 600.0) (coordenadaY 2700.0))
    ([loc-f-al2] of Localitzacio (adreca "Alta F2") (districte Sarria) (coordenadaX 620.0) (coordenadaY 2720.0))
    ([hab-f-al1] of HabitatgeUnifamiliar (teLocalitzacio [loc-f-al1]) (superficieHabitable 200.0) (tePiscinaComunitaria si))
    ([hab-f-al2] of Pis (teLocalitzacio [loc-f-al2]) (superficieHabitable 120.0) (teAscensor si) (tePlacaAparcament si))
    ([of-f-al1] of Oferta (teHabitatge [hab-f-al1]) (preuMensual 3200.0) (disponible si))
    ([of-f-al2] of Oferta (teHabitatge [hab-f-al2]) (preuMensual 1900.0) (disponible si))

    ;;; Més farciment genèric
    ([loc-g1] of Localitzacio (adreca "Gen 1") (districte Sants) (coordenadaX 800.0) (coordenadaY 800.0))
    ([hab-g1] of Pis (teLocalitzacio [loc-g1]) (superficieHabitable 70.0) (teAscensor si))
    ([of-g1] of Oferta (teHabitatge [hab-g1]) (preuMensual 950.0) (disponible si))

    ([loc-g2] of Localitzacio (adreca "Gen 2") (districte Sants) (coordenadaX 810.0) (coordenadaY 810.0))
    ([hab-g2] of Pis (teLocalitzacio [loc-g2]) (superficieHabitable 60.0) (teAscensor no))
    ([of-g2] of Oferta (teHabitatge [hab-g2]) (preuMensual 700.0) (disponible si))

    ([loc-g3] of Localitzacio (adreca "Gen 3") (districte Gracia) (coordenadaX 1000.0) (coordenadaY 1200.0))
    ([hab-g3] of Pis (teLocalitzacio [loc-g3]) (superficieHabitable 80.0) (teAscensor si))
    ([of-g3] of Oferta (teHabitatge [hab-g3]) (preuMensual 1100.0) (disponible si))

    ([loc-g4] of Localitzacio (adreca "Gen 4") (districte Gracia) (coordenadaX 1020.0) (coordenadaY 1220.0))
    ([hab-g4] of Duplex (teLocalitzacio [loc-g4]) (superficieHabitable 100.0) (teAscensor si))
    ([of-g4] of Oferta (teHabitatge [hab-g4]) (preuMensual 1500.0) (disponible si))

)