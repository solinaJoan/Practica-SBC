;;; ============================================================
;;; instancies.clp
;;; JOC DE PROVES I DADES DEL SISTEMA (CIUTAT SIMULADA)
;;; Total Instàncies: ~100
;;; Estructura: 4 Barris amb coordenades coherents
;;; CORRECCIÓ: districte i barri com a STRING (amb cometes)
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
    ;;; Coordenades coherents: ciutat 3km x 3km
    ;;; ============================================================

    ;;; --- ZONA 1: EIXAMPLE (CENTRE) ---
    ;;; Coordenades: X[1000-1500], Y[1000-1500]
    ;;; Característiques: Molts serveis, ben comunicat, dens.
    
    ;;; Serveis Centre
    ([loc-s-metro-centre] of Localitzacio (adreca "Metro Centre") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1250.0) (coordenadaY 1250.0))
    ([loc-s-escola] of Localitzacio (adreca "Escola Publica") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1200.0) (coordenadaY 1300.0))
    ([loc-s-cap] of Localitzacio (adreca "CAP Salut") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1300.0) (coordenadaY 1200.0))
    ([loc-s-super] of Localitzacio (adreca "Supermercat") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1270.0) (coordenadaY 1270.0))
    ([loc-s-parc] of Localitzacio (adreca "Parc Central") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1230.0) (coordenadaY 1230.0))
    ([loc-s-farmacia-centre] of Localitzacio (adreca "Farmacia Centre") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1260.0) (coordenadaY 1240.0))
    ([loc-s-mercat-centre] of Localitzacio (adreca "Mercat Sant Antoni") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1220.0) (coordenadaY 1280.0))

    ([servei-metro] of EstacioMetro (nomServei "L3 Verda") (teLocalitzacio [loc-s-metro-centre]))
    ([servei-escola] of Escola (nomServei "Escola Balmes") (teLocalitzacio [loc-s-escola]))
    ([servei-cap] of CentreSalut (nomServei "CAP Eixample") (teLocalitzacio [loc-s-cap]))
    ([servei-super] of Supermercat (nomServei "BonPreu") (teLocalitzacio [loc-s-super]))
    ([servei-parc] of Parc (nomServei "Parc Joan Miro") (teLocalitzacio [loc-s-parc]))
    ([servei-farmacia-centre] of Farmacia (nomServei "Farmacia 24h") (teLocalitzacio [loc-s-farmacia-centre]))
    ([servei-mercat-centre] of Mercat (nomServei "Mercat Sant Antoni") (teLocalitzacio [loc-s-mercat-centre]))

    ;;; Habitatges Centre (Per a Família i Jubilada)
    ([loc-h-centre-1] of Localitzacio (adreca "C/ Arago 1") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1210.0) (coordenadaY 1290.0))
    ([loc-h-centre-2] of Localitzacio (adreca "C/ Balmes 5") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1290.0) (coordenadaY 1210.0))
    ([loc-h-centre-3] of Localitzacio (adreca "Gran Via 10") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1255.0) (coordenadaY 1255.0))
    ([loc-h-centre-4] of Localitzacio (adreca "C/ Diputacio 20") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1240.0) (coordenadaY 1260.0))
    ([loc-h-centre-5] of Localitzacio (adreca "C/ Consell 30") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1330.0) (coordenadaY 1330.0))

    ([hab-familia-ideal] of Pis (teLocalitzacio [loc-h-centre-1]) (superficieHabitable 110.0) (numeroDormitoris 4) (numeroBanys 2) (teAscensor si) (tePiscinaComunitaria si) (permetMascotes si) (tePlacaAparcament si) (moblat si) (nivellSoroll "Baix") (consumEnergetic "B"))
    ([hab-jubilada-ok] of Pis (teLocalitzacio [loc-h-centre-2]) (superficieHabitable 60.0) (numeroDormitoris 2) (numeroBanys 1) (plantaPis 0) (teAscensor no) (permetMascotes si) (nivellSoroll "Baix"))
    ([hab-jubilada-fail] of Pis (teLocalitzacio [loc-h-centre-3]) (superficieHabitable 65.0) (numeroDormitoris 2) (numeroBanys 1) (plantaPis 4) (teAscensor no) (permetMascotes si))
    ([hab-centre-normal-1] of Pis (teLocalitzacio [loc-h-centre-4]) (superficieHabitable 80.0) (numeroDormitoris 3) (numeroBanys 1) (teAscensor si) (moblat si))
    ([hab-centre-normal-2] of Atic (teLocalitzacio [loc-h-centre-5]) (superficieHabitable 90.0) (numeroDormitoris 2) (numeroBanys 2) (teAscensor si) (teTerrassaOBalco si))


    ;;; --- ZONA 2: ZONA UNIVERSITÀRIA (LES CORTS) ---
    ;;; Coordenades: X[2000-2500], Y[1000-1500]
    ;;; Característiques: Universitats, pisos estudiants

    ;;; Serveis Universitat
    ([loc-s-uni] of Localitzacio (adreca "Campus Nord") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2250.0) (coordenadaY 1250.0))
    ([loc-s-metro-uni] of Localitzacio (adreca "Metro Zona Univ") (districte "Les Corts") (barri "Les Corts") (coordenadaX 2300.0) (coordenadaY 1300.0))
    ([loc-s-bar] of Localitzacio (adreca "Bar Facultat") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2260.0) (coordenadaY 1240.0))
    ([loc-s-bus-uni] of Localitzacio (adreca "Parada Bus UPC") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2240.0) (coordenadaY 1260.0))
    ([loc-s-super-uni] of Localitzacio (adreca "Super Campus") (districte "Les Corts") (barri "Les Corts") (coordenadaX 2270.0) (coordenadaY 1230.0))

    ([servei-uni] of Universitat (nomServei "UPC") (teLocalitzacio [loc-s-uni]))
    ([servei-metro-u] of EstacioMetro (nomServei "L3 Zona Univ") (teLocalitzacio [loc-s-metro-uni]))
    ([servei-bar] of Bar (nomServei "El Frankfurt") (teLocalitzacio [loc-s-bar]))
    ([servei-bus-uni] of ParadaBus (nomServei "Bus 33") (teLocalitzacio [loc-s-bus-uni]))
    ([servei-super-uni] of Supermercat (nomServei "Caprabo Campus") (teLocalitzacio [loc-s-super-uni]))

    ;;; Habitatges Estudiants
    ([loc-h-uni-1] of Localitzacio (adreca "Avda Diagonal 1") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2270.0) (coordenadaY 1270.0))
    ([loc-h-uni-2] of Localitzacio (adreca "C/ Jordi Girona") (districte "Les Corts") (barri "Les Corts") (coordenadaX 2200.0) (coordenadaY 1200.0))
    ([loc-h-uni-3] of Localitzacio (adreca "C/ Dels Pins") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2330.0) (coordenadaY 1330.0))

    ([hab-estudiants-ok] of Pis (teLocalitzacio [loc-h-uni-1]) (superficieHabitable 80.0) (numeroDormitoris 3) (numeroBanys 1) (teAscensor si) (moblat si) (permetMascotes no) (consumEnergetic "D"))
    ([hab-estudiants-fail] of Pis (teLocalitzacio [loc-h-uni-2]) (superficieHabitable 85.0) (numeroDormitoris 3) (numeroBanys 1) (moblat no) (teAscensor si))
    ([hab-uni-extra] of Pis (teLocalitzacio [loc-h-uni-3]) (superficieHabitable 70.0) (numeroDormitoris 2) (numeroBanys 1) (moblat si) (teAscensor no))


    ;;; --- ZONA 3: BARRI ANTIC (CIUTAT VELLA) ---
    ;;; Coordenades: X[1000-1500], Y[500-1000]
    ;;; Característiques: Oci nocturn (soroll), carrers estrets, turístic.

    ;;; Serveis Antic
    ([loc-s-disco] of Localitzacio (adreca "Zona Oci") (districte "Ciutat Vella") (barri "Raval") (coordenadaX 1250.0) (coordenadaY 750.0))
    ([loc-s-museu] of Localitzacio (adreca "Museu Historia") (districte "Ciutat Vella") (barri "Gòtic") (coordenadaX 1200.0) (coordenadaY 800.0))
    ([loc-s-metro-vella] of Localitzacio (adreca "Metro Liceu") (districte "Ciutat Vella") (barri "Gòtic") (coordenadaX 1220.0) (coordenadaY 780.0))

    ([servei-discoteca] of Discoteca (nomServei "Disco Inferno") (teLocalitzacio [loc-s-disco]))
    ([servei-cultura] of Teatre (nomServei "Teatre Principal") (teLocalitzacio [loc-s-museu]))
    ([servei-metro-vella] of EstacioMetro (nomServei "L3 Liceu") (teLocalitzacio [loc-s-metro-vella]))

    ;;; Habitatges Antic
    ([loc-h-antic-1] of Localitzacio (adreca "C/ Escudellers") (districte "Ciutat Vella") (barri "Raval") (coordenadaX 1255.0) (coordenadaY 755.0))
    ([loc-h-antic-2] of Localitzacio (adreca "Placa Reial") (districte "Ciutat Vella") (barri "Gòtic") (coordenadaX 1230.0) (coordenadaY 770.0))
    ([loc-h-antic-3] of Localitzacio (adreca "Ramblas") (districte "Ciutat Vella") (barri "Raval") (coordenadaX 1300.0) (coordenadaY 700.0))

    ([hab-sorollos] of Pis (teLocalitzacio [loc-h-antic-1]) (superficieHabitable 70.0) (numeroDormitoris 2) (numeroBanys 1) (plantaPis 1) (teAscensor si) (nivellSoroll "Alt") (esExterior si))
    ([hab-antic-2] of Pis (teLocalitzacio [loc-h-antic-2]) (superficieHabitable 50.0) (numeroDormitoris 1) (numeroBanys 1) (plantaPis 3) (teAscensor no) (nivellSoroll "Alt"))
    ([hab-zulo] of Estudi (teLocalitzacio [loc-h-antic-3]) (superficieHabitable 20.0) (numeroDormitoris 0) (numeroBanys 1) (teAscensor no) (moblat no))


    ;;; --- ZONA 4: ZONA ALTA (SARRIÀ/PEDRALBES) ---
    ;;; Coordenades: X[500-1000], Y[1500-2000]
    ;;; Característiques: Cases grans, luxe, cotxe necessari, parcs grans.

    ;;; Serveis Alta
    ([loc-s-club] of Localitzacio (adreca "Club Tennis") (districte "Sarria") (barri "Sarria") (coordenadaX 750.0) (coordenadaY 1750.0))
    ([loc-s-autopista] of Localitzacio (adreca "Ronda Dalt") (districte "Sarria") (barri "Sarria") (coordenadaX 500.0) (coordenadaY 2000.0))
    ([loc-s-parc-alta] of Localitzacio (adreca "Parc Collserola") (districte "Sarria") (barri "Sarria") (coordenadaX 700.0) (coordenadaY 1800.0))

    ([servei-club] of Gimnas (nomServei "Royal Club") (teLocalitzacio [loc-s-club]))
    ([servei-autopista] of Autopista (nomServei "Sortida 5") (teLocalitzacio [loc-s-autopista]))
    ([servei-parc-alta] of Parc (nomServei "Parc Collserola") (teLocalitzacio [loc-s-parc-alta]))

    ;;; Habitatges Alta
    ([loc-h-alta-1] of Localitzacio (adreca "Avda Pedralbes") (districte "Sarria") (barri "Pedralbes") (coordenadaX 800.0) (coordenadaY 1800.0))
    ([loc-h-alta-2] of Localitzacio (adreca "C/ Major Sarria") (districte "Sarria") (barri "Sarria") (coordenadaX 850.0) (coordenadaY 1700.0))
    ([loc-h-alta-3] of Localitzacio (adreca "C/ Muntanya") (districte "Sarria") (barri "Sarria") (coordenadaX 700.0) (coordenadaY 1850.0))

    ([hab-luxe] of HabitatgeUnifamiliar (teLocalitzacio [loc-h-alta-1]) (superficieHabitable 250.0) (numeroDormitoris 5) (numeroBanys 3) (teTerrassaOBalco si) (tePiscinaComunitaria si) (tePlacaAparcament si) (teAireCondicionat si) (teVistes si) (moblat si) (nivellSoroll "Baix") (consumEnergetic "A"))
    ([hab-alta-2] of Atic (teLocalitzacio [loc-h-alta-2]) (superficieHabitable 150.0) (numeroDormitoris 3) (numeroBanys 2) (teAscensor si) (teTerrassaOBalco si) (tePlacaAparcament si))
    ([hab-alta-3] of HabitatgeUnifamiliar (teLocalitzacio [loc-h-alta-3]) (superficieHabitable 180.0) (numeroDormitoris 4) (numeroBanys 2) (teAscensor no) (tePlacaAparcament si))


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

    ;;; FARCIMENT EIXAMPLE (CENTRE)
    ([loc-f-e1] of Localitzacio (adreca "Eixample F1") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1170.0) (coordenadaY 1260.0))
    ([loc-f-e2] of Localitzacio (adreca "Eixample F2") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1180.0) (coordenadaY 1270.0))
    ([loc-f-e3] of Localitzacio (adreca "Eixample F3") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1190.0) (coordenadaY 1280.0))
    ([loc-f-e4] of Localitzacio (adreca "Eixample F4") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1310.0) (coordenadaY 1190.0))
    ([loc-f-e5] of Localitzacio (adreca "Eixample F5") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1320.0) (coordenadaY 1310.0))

    ([hab-f-e1] of Pis (teLocalitzacio [loc-f-e1]) (superficieHabitable 70.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor si))
    ([hab-f-e2] of Pis (teLocalitzacio [loc-f-e2]) (superficieHabitable 75.0) (numeroDormitoris 3) (numeroBanys 1) (teAscensor si))
    ([hab-f-e3] of Pis (teLocalitzacio [loc-f-e3]) (superficieHabitable 60.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor no))
    ([hab-f-e4] of Atic (teLocalitzacio [loc-f-e4]) (superficieHabitable 95.0) (numeroDormitoris 3) (numeroBanys 2) (teAscensor si) (teTerrassaOBalco si))
    ([hab-f-e5] of Pis (teLocalitzacio [loc-f-e5]) (superficieHabitable 85.0) (numeroDormitoris 3) (numeroBanys 1) (teAscensor si) (permetMascotes si))

    ([of-f-e1] of Oferta (teHabitatge [hab-f-e1]) (preuMensual 1100.0) (disponible si))
    ([of-f-e2] of Oferta (teHabitatge [hab-f-e2]) (preuMensual 1200.0) (disponible si))
    ([of-f-e3] of Oferta (teHabitatge [hab-f-e3]) (preuMensual 900.0) (disponible si))
    ([of-f-e4] of Oferta (teHabitatge [hab-f-e4]) (preuMensual 1500.0) (disponible si))
    ([of-f-e5] of Oferta (teHabitatge [hab-f-e5]) (preuMensual 1300.0) (disponible si))

    ;;; FARCIMENT UNIVERSITAT
    ([loc-f-u1] of Localitzacio (adreca "Uni F1") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2230.0) (coordenadaY 1230.0))
    ([loc-f-u2] of Localitzacio (adreca "Uni F2") (districte "Les Corts") (barri "Les Corts") (coordenadaX 2240.0) (coordenadaY 1240.0))
    ([loc-f-u3] of Localitzacio (adreca "Uni F3") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2250.0) (coordenadaY 1280.0))
    ([loc-f-u4] of Localitzacio (adreca "Uni F4") (districte "Les Corts") (barri "Les Corts") (coordenadaX 2210.0) (coordenadaY 1210.0))
    ([loc-f-u5] of Localitzacio (adreca "Uni F5") (districte "Les Corts") (barri "Pedralbes") (coordenadaX 2280.0) (coordenadaY 1290.0))

    ([hab-f-u1] of Pis (teLocalitzacio [loc-f-u1]) (superficieHabitable 80.0) (numeroDormitoris 3) (numeroBanys 1) (moblat si))
    ([hab-f-u2] of Pis (teLocalitzacio [loc-f-u2]) (superficieHabitable 90.0) (numeroDormitoris 4) (numeroBanys 2) (moblat si))
    ([hab-f-u3] of Estudi (teLocalitzacio [loc-f-u3]) (superficieHabitable 40.0) (numeroDormitoris 1) (numeroBanys 1) (moblat si))
    ([hab-f-u4] of Pis (teLocalitzacio [loc-f-u4]) (superficieHabitable 75.0) (numeroDormitoris 3) (numeroBanys 1) (moblat si) (teAscensor si))
    ([hab-f-u5] of Duplex (teLocalitzacio [loc-f-u5]) (superficieHabitable 110.0) (numeroDormitoris 4) (numeroBanys 2) (moblat si) (teAscensor si))

    ([of-f-u1] of Oferta (teHabitatge [hab-f-u1]) (preuMensual 800.0) (disponible si))
    ([of-f-u2] of Oferta (teHabitatge [hab-f-u2]) (preuMensual 900.0) (disponible si))
    ([of-f-u3] of Oferta (teHabitatge [hab-f-u3]) (preuMensual 600.0) (disponible si))
    ([of-f-u4] of Oferta (teHabitatge [hab-f-u4]) (preuMensual 780.0) (disponible si))
    ([of-f-u5] of Oferta (teHabitatge [hab-f-u5]) (preuMensual 950.0) (disponible si))

    ;;; FARCIMENT ANTIC
    ([loc-f-a1] of Localitzacio (adreca "Antic F1") (districte "Ciutat Vella") (barri "Raval") (coordenadaX 1260.0) (coordenadaY 730.0))
    ([loc-f-a2] of Localitzacio (adreca "Antic F2") (districte "Ciutat Vella") (barri "Gòtic") (coordenadaX 1270.0) (coordenadaY 740.0))
    ([loc-f-a3] of Localitzacio (adreca "Antic F3") (districte "Ciutat Vella") (barri "Raval") (coordenadaX 1280.0) (coordenadaY 750.0))
    ([loc-f-a4] of Localitzacio (adreca "Antic F4") (districte "Ciutat Vella") (barri "Gòtic") (coordenadaX 1210.0) (coordenadaY 790.0))
    ([loc-f-a5] of Localitzacio (adreca "Antic F5") (districte "Ciutat Vella") (barri "Raval") (coordenadaX 1290.0) (coordenadaY 710.0))

    ([hab-f-a1] of Pis (teLocalitzacio [loc-f-a1]) (superficieHabitable 50.0) (numeroDormitoris 1) (numeroBanys 1) (teAscensor no) (nivellSoroll "Alt"))
    ([hab-f-a2] of Atic (teLocalitzacio [loc-f-a2]) (superficieHabitable 60.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor si) (teTerrassaOBalco si))
    ([hab-f-a3] of Pis (teLocalitzacio [loc-f-a3]) (superficieHabitable 70.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor no))
    ([hab-f-a4] of Pis (teLocalitzacio [loc-f-a4]) (superficieHabitable 65.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor si) (moblat si))
    ([hab-f-a5] of Estudi (teLocalitzacio [loc-f-a5]) (superficieHabitable 35.0) (numeroDormitoris 0) (numeroBanys 1) (moblat si))

    ([of-f-a1] of Oferta (teHabitatge [hab-f-a1]) (preuMensual 750.0) (disponible si))
    ([of-f-a2] of Oferta (teHabitatge [hab-f-a2]) (preuMensual 1100.0) (disponible si))
    ([of-f-a3] of Oferta (teHabitatge [hab-f-a3]) (preuMensual 850.0) (disponible si))
    ([of-f-a4] of Oferta (teHabitatge [hab-f-a4]) (preuMensual 920.0) (disponible si))
    ([of-f-a5] of Oferta (teHabitatge [hab-f-a5]) (preuMensual 650.0) (disponible si))

    ;;; FARCIMENT ALTA
    ([loc-f-al1] of Localitzacio (adreca "Alta F1") (districte "Sarria") (barri "Sarria") (coordenadaX 750.0) (coordenadaY 1850.0))
    ([loc-f-al2] of Localitzacio (adreca "Alta F2") (districte "Sarria") (barri "Pedralbes") (coordenadaX 770.0) (coordenadaY 1870.0))
    ([loc-f-al3] of Localitzacio (adreca "Alta F3") (districte "Sarria") (barri "Sarria") (coordenadaX 820.0) (coordenadaY 1720.0))
    ([loc-f-al4] of Localitzacio (adreca "Alta F4") (districte "Sarria") (barri "Pedralbes") (coordenadaX 780.0) (coordenadaY 1780.0))

    ([hab-f-al1] of HabitatgeUnifamiliar (teLocalitzacio [loc-f-al1]) (superficieHabitable 200.0) (numeroDormitoris 4) (numeroBanys 3) (tePiscinaComunitaria si))
    ([hab-f-al2] of Pis (teLocalitzacio [loc-f-al2]) (superficieHabitable 120.0) (numeroDormitoris 3) (numeroBanys 2) (teAscensor si) (tePlacaAparcament si))
    ([hab-f-al3] of Atic (teLocalitzacio [loc-f-al3]) (superficieHabitable 140.0) (numeroDormitoris 3) (numeroBanys 2) (teAscensor si) (teTerrassaOBalco si) (teVistes si))
    ([hab-f-al4] of HabitatgeUnifamiliar (teLocalitzacio [loc-f-al4]) (superficieHabitable 220.0) (numeroDormitoris 5) (numeroBanys 3) (tePlacaAparcament si) (teVistes si))

    ([of-f-al1] of Oferta (teHabitatge [hab-f-al1]) (preuMensual 3200.0) (disponible si))
    ([of-f-al2] of Oferta (teHabitatge [hab-f-al2]) (preuMensual 1900.0) (disponible si))
    ([of-f-al3] of Oferta (teHabitatge [hab-f-al3]) (preuMensual 2200.0) (disponible si))
    ([of-f-al4] of Oferta (teHabitatge [hab-f-al4]) (preuMensual 3500.0) (disponible si))

    ;;; Més farciment genèric - SANTS
    ([loc-g1] of Localitzacio (adreca "Sants 1") (districte "Sants") (barri "Sants") (coordenadaX 900.0) (coordenadaY 900.0))
    ([loc-g2] of Localitzacio (adreca "Sants 2") (districte "Sants") (barri "Sants") (coordenadaX 910.0) (coordenadaY 910.0))
    ([loc-g3] of Localitzacio (adreca "Sants 3") (districte "Sants") (barri "Hostafrancs") (coordenadaX 920.0) (coordenadaY 920.0))
    ([loc-g4] of Localitzacio (adreca "Sants 4") (districte "Sants") (barri "Sants") (coordenadaX 880.0) (coordenadaY 880.0))

    ([loc-s-metro-sants] of Localitzacio (adreca "Metro Sants") (districte "Sants") (barri "Sants") (coordenadaX 905.0) (coordenadaY 905.0))
    ([loc-s-super-sants] of Localitzacio (adreca "Mercat Sants") (districte "Sants") (barri "Sants") (coordenadaX 915.0) (coordenadaY 895.0))

    ([servei-metro-sants] of EstacioMetro (nomServei "L1 Sants") (teLocalitzacio [loc-s-metro-sants]))
    ([servei-mercat-sants] of Mercat (nomServei "Mercat Sants") (teLocalitzacio [loc-s-super-sants]))

    ([hab-g1] of Pis (teLocalitzacio [loc-g1]) (superficieHabitable 70.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor si))
    ([hab-g2] of Pis (teLocalitzacio [loc-g2]) (superficieHabitable 60.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor no))
    ([hab-g3] of Pis (teLocalitzacio [loc-g3]) (superficieHabitable 80.0) (numeroDormitoris 3) (numeroBanys 1) (teAscensor si))
    ([hab-g4] of Duplex (teLocalitzacio [loc-g4]) (superficieHabitable 100.0) (numeroDormitoris 3) (numeroBanys 2) (teAscensor si))

    ([of-g1] of Oferta (teHabitatge [hab-g1]) (preuMensual 950.0) (disponible si))
    ([of-g2] of Oferta (teHabitatge [hab-g2]) (preuMensual 700.0) (disponible si))
    ([of-g3] of Oferta (teHabitatge [hab-g3]) (preuMensual 1100.0) (disponible si))
    ([of-g4] of Oferta (teHabitatge [hab-g4]) (preuMensual 1500.0) (disponible si))

    ;;; Més farciment genèric - GRÀCIA
    ([loc-g5] of Localitzacio (adreca "Gracia 1") (districte "Gracia") (barri "Vila de Gracia") (coordenadaX 1100.0) (coordenadaY 1400.0))
    ([loc-g6] of Localitzacio (adreca "Gracia 2") (districte "Gracia") (barri "Camp d'en Grassot") (coordenadaX 1120.0) (coordenadaY 1420.0))
    ([loc-g7] of Localitzacio (adreca "Gracia 3") (districte "Gracia") (barri "Vila de Gracia") (coordenadaX 1140.0) (coordenadaY 1380.0))
    ([loc-g8] of Localitzacio (adreca "Gracia 4") (districte "Gracia") (barri "Camp d'en Grassot") (coordenadaX 1080.0) (coordenadaY 1440.0))

    ([loc-s-parc-gracia] of Localitzacio (adreca "Parc Guell") (districte "Gracia") (barri "Vila de Gracia") (coordenadaX 1110.0) (coordenadaY 1410.0))
    ([loc-s-metro-gracia] of Localitzacio (adreca "Metro Fontana") (districte "Gracia") (barri "Vila de Gracia") (coordenadaX 1115.0) (coordenadaY 1405.0))

    ([servei-parc-gracia] of Parc (nomServei "Parc Guell") (teLocalitzacio [loc-s-parc-gracia]))
    ([servei-metro-gracia] of EstacioMetro (nomServei "L3 Fontana") (teLocalitzacio [loc-s-metro-gracia]))

    ([hab-g5] of Pis (teLocalitzacio [loc-g5]) (superficieHabitable 80.0) (numeroDormitoris 3) (numeroBanys 1) (teAscensor si))
    ([hab-g6] of Duplex (teLocalitzacio [loc-g6]) (superficieHabitable 100.0) (numeroDormitoris 3) (numeroBanys 2) (teAscensor si))
    ([hab-g7] of Atic (teLocalitzacio [loc-g7]) (superficieHabitable 85.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor si) (teTerrassaOBalco si))
    ([hab-g8] of Pis (teLocalitzacio [loc-g8]) (superficieHabitable 75.0) (numeroDormitoris 2) (numeroBanys 1) (teAscensor si) (permetMascotes si))

    ([of-g5] of Oferta (teHabitatge [hab-g5]) (preuMensual 1100.0) (disponible si))
    ([of-g6] of Oferta (teHabitatge [hab-g6]) (preuMensual 1500.0) (disponible si))
    ([of-g7] of Oferta (teHabitatge [hab-g7]) (preuMensual 1300.0) (disponible si))
    ([of-g8] of Oferta (teHabitatge [hab-g8]) (preuMensual 1050.0) (disponible si))

    ;;; Serveis addicionals per completar
    ([loc-s-hospital] of Localitzacio (adreca "Hospital Clinic") (districte "Eixample") (barri "Esquerra Eixample") (coordenadaX 1150.0) (coordenadaY 1250.0))
    ([loc-s-escola2] of Localitzacio (adreca "Escola Sagrada Familia") (districte "Eixample") (barri "Sagrada Familia") (coordenadaX 1350.0) (coordenadaY 1350.0))
    ([loc-s-institut] of Localitzacio (adreca "Institut Verdaguer") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1280.0) (coordenadaY 1320.0))
    ([loc-s-gimnas] of Localitzacio (adreca "Gimnas DIR") (districte "Eixample") (barri "Dreta Eixample") (coordenadaX 1240.0) (coordenadaY 1280.0))

    ([servei-hospital] of Hospital (nomServei "Hospital Clinic") (teLocalitzacio [loc-s-hospital]))
    ([servei-escola2] of Escola (nomServei "Sagrada Familia") (teLocalitzacio [loc-s-escola2]))
    ([servei-institut] of Institut (nomServei "Verdaguer") (teLocalitzacio [loc-s-institut]))
    ([servei-gimnas] of Gimnas (nomServei "DIR Eixample") (teLocalitzacio [loc-s-gimnas]))

)