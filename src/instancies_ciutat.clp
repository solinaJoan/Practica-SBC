
;;; ============================================================
;;; instancies.clp
;;; Instancies de prova per al sistema de recomanacio
;;; ============================================================

(definstances localitzacions
    ;;; LOCALITZACIONS D'HABITATGES
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

    ([loc-eixample-2] of Localitzacio
        (adreca "Carrer Valencia 180")
        (districte Eixample)
        (barri EsquerraEixample)
        (codiPostal "08011")
        (coordenadaX 90.0)
        (coordenadaY 190.0))

    ;;; LOCALITZACIONS DE SERVEIS
    ([loc-metro-pg] of Localitzacio
        (adreca "Metro Passeig de Gracia")
        (districte Eixample)
        (coordenadaX 105.0)
        (coordenadaY 195.0))

    ([loc-metro-fontana] of Localitzacio
        (adreca "Metro Fontana")
        (districte Gracia)
        (coordenadaX 155.0)
        (coordenadaY 395.0))

    ([loc-escola-1] of Localitzacio
        (adreca "Escola Eixample")
        (districte Eixample)
        (coordenadaX 110.0)
        (coordenadaY 210.0))

    ([loc-hospital] of Localitzacio
        (adreca "Hospital Clinic")
        (districte Eixample)
        (coordenadaX 85.0)
        (coordenadaY 185.0))

    ([loc-super-1] of Localitzacio
        (adreca "Supermercat Mercadona")
        (districte Eixample)
        (coordenadaX 95.0)
        (coordenadaY 205.0))

    ([loc-parc] of Localitzacio
        (adreca "Parc Ciutadella")
        (districte CiutatVella)
        (coordenadaX 210.0)
        (coordenadaY 160.0))

    ([loc-discoteca] of Localitzacio
        (adreca "Zona Clubs Port Olimpic")
        (districte SantMarti)
        (coordenadaX 250.0)
        (coordenadaY 120.0))
)

(definstances serveis
    ;;; TRANSPORT PUBLIC
    ([metro-pg] of EstacioMetro
        (nomServei "Metro Passeig de Gracia L2 L3 L4")
        (teLocalitzacio [loc-metro-pg]))

    ([metro-fontana] of EstacioMetro
        (nomServei "Metro Fontana L3")
        (teLocalitzacio [loc-metro-fontana]))

    ;;; SERVEIS EDUCATIUS
    ([escola-eixample] of Escola
        (nomServei "Escola Eixample")
        (teLocalitzacio [loc-escola-1]))

    ;;; SERVEIS DE SALUT
    ([hospital-clinic] of Hospital
        (nomServei "Hospital Clinic Barcelona")
        (teLocalitzacio [loc-hospital]))

    ;;; SERVEIS COMERCIALS
    ([mercadona-eix] of Supermercat
        (nomServei "Mercadona Eixample")
        (teLocalitzacio [loc-super-1]))

    ;;; ZONES VERDES
    ([parc-ciutadella] of Parc
        (nomServei "Parc de la Ciutadella")
        (teLocalitzacio [loc-parc]))

    ;;; SERVEIS MOLESTOS
    ([discoteca-port] of Discoteca
        (nomServei "Zona Clubs Port Olimpic")
        (teLocalitzacio [loc-discoteca]))
)

(definstances habitatges
    ;;; HABITATGE 1: Pis familiar Eixample - MOLT COMPLET
    ([hab-1] of Pis
        (teLocalitzacio [loc-eixample-1])
        (superficieHabitable 95.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 3)
        (anyConstruccio 2005)
        (teTerrassaOBalco si)
        (superficieTerrassa 8.0)
        (moblat si)
        (ambElectrodomestics si)
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
        (nivellSoroll "Baix")
        (estatConservacio BonEstat))

    ;;; HABITATGE 2: Atic de luxe Gracia
    ([hab-2] of Atic
        (teLocalitzacio [loc-gracia-1])
        (superficieHabitable 120.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 5)
        (anyConstruccio 2018)
        (teTerrassaOBalco si)
        (superficieTerrassa 40.0)
        (moblat no)
        (ambElectrodomestics si)
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
        (nivellSoroll "Baix")
        (estatConservacio Nou))

    ;;; HABITATGE 3: Estudi economic Sants - NO MASCOTES
    ([hab-3] of Estudi
        (teLocalitzacio [loc-sants-1])
        (superficieHabitable 35.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 2)
        (anyConstruccio 1975)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes no)
        (tipusVistes Cap)
        (tePiscinaComunitaria no)
        (tePlacaAparcament no)
        (teArmariEncastat no)
        (teTraster no)
        (consumEnergetic D)
        (esExterior no)
        (nivellSoroll "Baix")
        (estatConservacio BonEstat))

    ;;; HABITATGE 4: Pis al Born - SOROLLOS
    ([hab-4] of Pis
        (teLocalitzacio [loc-born-1])
        (superficieHabitable 70.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 1)
        (anyConstruccio 1920)
        (teTerrassaOBalco si)
        (superficieTerrassa 5.0)
        (moblat si)
        (ambElectrodomestics si)
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
        (nivellSoroll "Alt")
        (estatConservacio BonEstat))

    ;;; HABITATGE 5: Casa unifamiliar Sarria - LUXE
    ([hab-5] of HabitatgeUnifamiliar
        (teLocalitzacio [loc-sarria-1])
        (superficieHabitable 200.0)
        (numeroDormitoris 5)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 2)
        (numeroBanys 3)
        (plantaPis 0)
        (anyConstruccio 2010)
        (teTerrassaOBalco si)
        (superficieTerrassa 100.0)
        (moblat no)
        (ambElectrodomestics si)
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
        (nivellSoroll "Baix")
        (estatConservacio BonEstat))

    ;;; HABITATGE 6: Pis planta baixa accessible
    ([hab-6] of Pis
        (teLocalitzacio [loc-eixample-2])
        (superficieHabitable 80.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (plantaPis 0)
        (anyConstruccio 1990)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar Mati)
        (teVistes no)
        (tipusVistes Cap)
        (tePiscinaComunitaria no)
        (tePlacaAparcament no)
        (teArmariEncastat si)
        (teTraster no)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll "Mitja")
        (estatConservacio BonEstat))
)

(definstances ofertes
    ([oferta-1] of Oferta
        (teHabitatge [hab-1])
        (preuMensual 1350.0)
        (disponible si)
        (dataPublicacio "2024-11-01"))

    ([oferta-2] of Oferta
        (teHabitatge [hab-2])
        (preuMensual 1800.0)
        (disponible si)
        (dataPublicacio "2024-11-10"))

    ([oferta-3] of Oferta
        (teHabitatge [hab-3])
        (preuMensual 650.0)
        (disponible si)
        (dataPublicacio "2024-11-05"))

    ([oferta-4] of Oferta
        (teHabitatge [hab-4])
        (preuMensual 1100.0)
        (disponible si)
        (dataPublicacio "2024-10-20"))

    ([oferta-5] of Oferta
        (teHabitatge [hab-5])
        (preuMensual 3500.0)
        (disponible si)
        (dataPublicacio "2024-11-15"))

    ([oferta-6] of Oferta
        (teHabitatge [hab-6])
        (preuMensual 950.0)
        (disponible si)
        (dataPublicacio "2024-11-12"))


    ([oferta-flexible] of Oferta
        (teHabitatge [hab-1])
        (preuMensual 1650.0)
        (disponible si)
        (dataPublicacio "2024-11-20"))

    ([oferta-zulo] of Oferta
        (teHabitatge [hab-3])
        (preuMensual 200.0)
        (disponible si)
        (dataPublicacio "2024-11-21"))
)
