;;; ============================================================
;;; instancies.clp
;;; Instàncies de prova per al sistema de recomanació
;;; IMPORTANT: Carregar DESPRÉS de ontologiaSBC.clp
;;; ============================================================

(definstances instancies-localitzacions
    ([loc-eixample-1] of Localitzacio
        (adreca "Carrer Arago 250")
        (districte Eixample)
        (barri DretaEixample)
        (codiPostal "08007")
        (coordenadaX 100.0)
        (coordenadaY 200.0))

    ([loc-gracia-1] of Localitzacio
        (adreca "Carrer Verdi 45")
        (districte Gracia)
        (barri VilaDeGracia)
        (codiPostal "08012")
        (coordenadaX 150.0)
        (coordenadaY 400.0))

    ([loc-sants-1] of Localitzacio
        (adreca "Carrer Sants 120")
        (districte SantsMontjuic)
        (barri Sants)
        (codiPostal "08014")
        (coordenadaX 50.0)
        (coordenadaY 100.0))

    ([loc-born-1] of Localitzacio
        (adreca "Passeig del Born 15")
        (districte CiutatVella)
        (barri Born)
        (codiPostal "08003")
        (coordenadaX 200.0)
        (coordenadaY 150.0))

    ([loc-sarria-1] of Localitzacio
        (adreca "Carrer Major de Sarria 80")
        (districte SarriaStGervasi)
        (barri Sarria)
        (codiPostal "08017")
        (coordenadaX 80.0)
        (coordenadaY 500.0))

    ([loc-metro-1] of Localitzacio
        (adreca "Metro Passeig de Gracia")
        (districte Eixample)
        (coordenadaX 105.0)
        (coordenadaY 195.0))

    ([loc-escola-1] of Localitzacio
        (adreca "Escola Eixample")
        (districte Eixample)
        (coordenadaX 120.0)
        (coordenadaY 220.0))

    ([loc-hospital-1] of Localitzacio
        (adreca "Hospital Clinic")
        (districte Eixample)
        (coordenadaX 90.0)
        (coordenadaY 180.0))

    ([loc-super-1] of Localitzacio
        (adreca "Supermercat Eixample")
        (districte Eixample)
        (coordenadaX 110.0)
        (coordenadaY 210.0))

    ([loc-parc-1] of Localitzacio
        (adreca "Parc Ciutadella")
        (districte CiutatVella)
        (coordenadaX 220.0)
        (coordenadaY 160.0))
)

(definstances instancies-serveis
    ([metro-pg] of EstacioMetro
        (nomServei "Metro Passeig de Gracia")
        (teLocalitzacio [loc-metro-1]))

    ([escola-eix] of Escola
        (nomServei "Escola Eixample")
        (teLocalitzacio [loc-escola-1]))

    ([hospital-clinic] of Hospital
        (nomServei "Hospital Clinic")
        (teLocalitzacio [loc-hospital-1]))

    ([super-eix] of Supermercat
        (nomServei "Supermercat Eixample")
        (teLocalitzacio [loc-super-1]))

    ([parc-ciut] of Parc
        (nomServei "Parc Ciutadella")
        (teLocalitzacio [loc-parc-1]))
)

(definstances instancies-habitatges
    ;;; HABITATGE 1: Pis familiar Eixample - MOLT COMPLET
    ([hab-1] of Pis
        (superficieHabitable 95.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (teTerrassaOBalco si)
        (superficieTerrassa 8.0)
        (moblat si)
        (ambElectrodomestics si)
        (plantaPis 3)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (tePiscinaComunitaria no)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 1)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (anyConstruccio 2005)
        (estatConservacio BonEstat)
        (teLocalitzacio [loc-eixample-1]))

    ;;; HABITATGE 2: Atic luxe Gracia
    ([hab-2] of Atic
        (superficieHabitable 120.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (teTerrassaOBalco si)
        (superficieTerrassa 40.0)
        (moblat no)
        (ambElectrodomestics si)
        (plantaPis 5)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Muntanya)
        (tePiscinaComunitaria no)
        (tePlacaAparcament no)
        (teArmariEncastat si)
        (teTraster no)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (anyConstruccio 2018)
        (estatConservacio Nou)
        (teLocalitzacio [loc-gracia-1]))

    ;;; HABITATGE 3: Estudi economic Sants - NO MASCOTES
    ([hab-3] of Estudi
        (superficieHabitable 35.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (plantaPis 2)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes no)
        (tePiscinaComunitaria no)
        (tePlacaAparcament no)
        (teArmariEncastat no)
        (teTraster no)
        (consumEnergetic D)
        (esExterior no)
        (nivellSoroll Mitja)
        (anyConstruccio 1975)
        (estatConservacio BonEstat)
        (teLocalitzacio [loc-sants-1]))

    ;;; HABITATGE 4: Pis Born - SOROLLOS
    ([hab-4] of Pis
        (superficieHabitable 70.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (teTerrassaOBalco si)
        (superficieTerrassa 5.0)
        (moblat si)
        (ambElectrodomestics si)
        (plantaPis 1)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar Tarda)
        (teVistes si)
        (tipusVistes Ciutat)
        (tePiscinaComunitaria no)
        (tePlacaAparcament no)
        (teArmariEncastat si)
        (teTraster no)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Alt)
        (anyConstruccio 1920)
        (estatConservacio BonEstat)
        (teLocalitzacio [loc-born-1]))

    ;;; HABITATGE 5: Casa Sarria - LUXE
    ([hab-5] of HabitatgeUnifamiliar
        (superficieHabitable 200.0)
        (numeroDormitoris 5)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 2)
        (numeroBanys 3)
        (teTerrassaOBalco si)
        (superficieTerrassa 100.0)
        (moblat no)
        (ambElectrodomestics si)
        (plantaPis 0)
        (teAscensor no)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Muntanya)
        (tePiscinaComunitaria si)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 2)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (anyConstruccio 2010)
        (estatConservacio BonEstat)
        (teLocalitzacio [loc-sarria-1]))

    ;;; HABITATGE 6: Pis PB accessible
    ([hab-6] of Pis
        (superficieHabitable 80.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (plantaPis 0)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar Mati)
        (teVistes no)
        (tePiscinaComunitaria no)
        (tePlacaAparcament no)
        (teArmariEncastat si)
        (teTraster no)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Mitja)
        (anyConstruccio 1990)
        (estatConservacio BonEstat)
        (teLocalitzacio [loc-eixample-1]))
)

(definstances instancies-ofertes
    ([oferta-1] of Oferta
        (preuMensual 1350.0)
        (disponible si)
        (teHabitatge [hab-1]))

    ([oferta-2] of Oferta
        (preuMensual 1800.0)
        (disponible si)
        (teHabitatge [hab-2]))

    ([oferta-3] of Oferta
        (preuMensual 650.0)
        (disponible si)
        (teHabitatge [hab-3]))

    ([oferta-4] of Oferta
        (preuMensual 1100.0)
        (disponible si)
        (teHabitatge [hab-4]))

    ([oferta-5] of Oferta
        (preuMensual 3500.0)
        (disponible si)
        (teHabitatge [hab-5]))

    ([oferta-6] of Oferta
        (preuMensual 950.0)
        (disponible si)
        (teHabitatge [hab-6]))
)

(definstances instancies-sollicitants
    ;;; FAMILIA amb fills i mascota
    ([familia-garcia] of FamiliaBiparental
        (pressupostMaxim 1500.0)
        (pressupostMinim 600.0)
        (margeEstricte no)
        (edatSollicitant 38)
        (numeroPersones 4)
        (numeroFills 2)
        (edatsFills 6 10)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (tipusMascota Gos)
        (treballaACiutat si))

    ;;; ESTUDIANT
    ([estudiant-marc] of GrupEstudiants
        (pressupostMaxim 700.0)
        (pressupostMinim 300.0)
        (margeEstricte si)
        (edatSollicitant 22)
        (numeroPersones 1)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no)
        (estudiaACiutat si))

    ;;; PERSONA GRAN amb accessibilitat
    ([jubilada-maria] of PersonaGran
        (pressupostMaxim 1000.0)
        (pressupostMinim 400.0)
        (margeEstricte no)
        (edatSollicitant 72)
        (numeroPersones 1)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes no)
        (treballaACiutat no))

    ;;; PARELLA jove
    ([parella-martinez] of ParellaSenseFills
        (pressupostMaxim 1400.0)
        (pressupostMinim 500.0)
        (margeEstricte no)
        (edatSollicitant 30)
        (numeroPersones 2)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ;;; PARELLA futurs fills
    ([parella-lopez] of ParellaFutursFills
        (pressupostMaxim 1600.0)
        (pressupostMinim 700.0)
        (margeEstricte no)
        (edatSollicitant 32)
        (numeroPersones 2)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (tipusMascota Gat)
        (treballaACiutat si))
)
