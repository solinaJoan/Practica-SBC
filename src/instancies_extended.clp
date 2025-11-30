;;; ============================================================
;;; instancies_extended.clp
;;; 100 instàncies significatives d'habitatges, ofertes i solicitants
;;; ============================================================

(definstances localitzacions-extended
    ;;; LOCALITZACIONS EIXAMPLE
    ([loc-eix-3] of Localitzacio
        (adreca "Carrer Consell de Cent 320")
        (districte Eixample)
        (barri DretaEixample)
        (codiPostal "08007")
        (coordenadaX 105.0)
        (coordenadaY 205.0))

    ([loc-eix-4] of Localitzacio
        (adreca "Passeig de Gracia 95")
        (districte Eixample)
        (barri DretaEixample)
        (codiPostal "08008")
        (coordenadaX 102.0)
        (coordenadaY 198.0))

    ([loc-eix-5] of Localitzacio
        (adreca "Carrer Mallorca 275")
        (districte Eixample)
        (barri EsquerraEixample)
        (codiPostal "08008")
        (coordenadaX 98.0)
        (coordenadaY 202.0))

    ;;; LOCALITZACIONS GRÀCIA
    ([loc-gra-2] of Localitzacio
        (adreca "Travessera de Gracia 150")
        (districte Gracia)
        (barri VilaDeGracia)
        (codiPostal "08012")
        (coordenadaX 148.0)
        (coordenadaY 398.0))

    ([loc-gra-3] of Localitzacio
        (adreca "Carrer Gran de Gracia 80")
        (districte Gracia)
        (barri VilaDeGracia)
        (codiPostal "08012")
        (coordenadaX 152.0)
        (coordenadaY 405.0))

    ;;; LOCALITZACIONS SANTS
    ([loc-sants-2] of Localitzacio
        (adreca "Carrer Creu Coberta 45")
        (districte SantsMontjuic)
        (barri Sants)
        (codiPostal "08014")
        (coordenadaX 55.0)
        (coordenadaY 105.0))

    ([loc-sants-3] of Localitzacio
        (adreca "Ronda Sant Pau 70")
        (districte SantsMontjuic)
        (barri Sants)
        (codiPostal "08015")
        (coordenadaX 48.0)
        (coordenadaY 98.0))

    ;;; LOCALITZACIONS CIUTAT VELLA
    ([loc-gotic-1] of Localitzacio
        (adreca "Carrer Ferran 25")
        (districte CiutatVella)
        (barri Gotic)
        (codiPostal "08002")
        (coordenadaX 195.0)
        (coordenadaY 145.0))

    ([loc-raval-1] of Localitzacio
        (adreca "Carrer Hospital 80")
        (districte CiutatVella)
        (barri Raval)
        (codiPostal "08001")
        (coordenadaX 190.0)
        (coordenadaY 140.0))

    ([loc-barceloneta-1] of Localitzacio
        (adreca "Passeig Maritim 30")
        (districte CiutatVella)
        (barri Barceloneta)
        (codiPostal "08003")
        (coordenadaX 220.0)
        (coordenadaY 130.0))

    ;;; LOCALITZACIONS SARRIA-ST GERVASI
    ([loc-sarria-2] of Localitzacio
        (adreca "Via Augusta 200")
        (districte SarriaStGervasi)
        (barri Sarria)
        (codiPostal "08021")
        (coordenadaX 75.0)
        (coordenadaY 510.0))

    ([loc-stgervasi-1] of Localitzacio
        (adreca "Carrer Mandri 50")
        (districte SarriaStGervasi)
        (barri StGervasi)
        (codiPostal "08022")
        (coordenadaX 70.0)
        (coordenadaY 520.0))

    ;;; LOCALITZACIONS HORTA-GUINARDÓ
    ([loc-horta-1] of Localitzacio
        (adreca "Carrer Horta 120")
        (districte HortaGuinardo)
        (barri Horta)
        (codiPostal "08031")
        (coordenadaX 180.0)
        (coordenadaY 450.0))

    ([loc-guinardo-1] of Localitzacio
        (adreca "Carrer Mare de Deu del Coll 55")
        (districte HortaGuinardo)
        (barri Guinardo)
        (codiPostal "08023")
        (coordenadaX 175.0)
        (coordenadaY 445.0))

    ;;; LOCALITZACIONS NOU BARRIS
    ([loc-noubarris-1] of Localitzacio
        (adreca "Passeig Fabra i Puig 250")
        (districte NouBarris)
        (barri VilapicinavalldHebron)
        (codiPostal "08016")
        (coordenadaX 140.0)
        (coordenadaY 500.0))

    ([loc-noubarris-2] of Localitzacio
        (adreca "Carrer Via Julia 100")
        (districte NouBarris)
        (barri Vilapicina)
        (codiPostal "08016")
        (coordenadaX 145.0)
        (coordenadaY 505.0))

    ;;; LOCALITZACIONS SANT MARTÍ
    ([loc-poblenou-1] of Localitzacio
        (adreca "Rambla Poblenou 80")
        (districte SantMarti)
        (barri Poblenou)
        (codiPostal "08005")
        (coordenadaX 240.0)
        (coordenadaY 180.0))

    ([loc-poblenou-2] of Localitzacio
        (adreca "Carrer Llull 150")
        (districte SantMarti)
        (barri Poblenou)
        (codiPostal "08005")
        (coordenadaX 245.0)
        (coordenadaY 175.0))

    ;;; LOCALITZACIONS LES CORTS
    ([loc-corts-1] of Localitzacio
        (adreca "Travessera de les Corts 300")
        (districte LesCorts)
        (barri LesCorts)
        (codiPostal "08029")
        (coordenadaX 60.0)
        (coordenadaY 250.0))

    ([loc-corts-2] of Localitzacio
        (adreca "Carrer Entenca 180")
        (districte LesCorts)
        (barri LesCorts)
        (codiPostal "08029")
        (coordenadaX 65.0)
        (coordenadaY 255.0))

    ;;; LOCALITZACIONS SANT ANDREU
    ([loc-standreu-1] of Localitzacio
        (adreca "Carrer Gran de Sant Andreu 200")
        (districte SantAndreu)
        (barri SantAndreu)
        (codiPostal "08030")
        (coordenadaX 200.0)
        (coordenadaY 420.0))
)

(definstances habitatges-extended
    ;;; ESTUDIS I PISOS PETITS (per estudiants i joves)
    ([hab-7] of Estudi
        (teLocalitzacio [loc-gracia-1])
        (superficieHabitable 30.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 4)
        (anyConstruccio 1980)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes no)
        (consumEnergetic D)
        (esExterior si)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-8] of Estudi
        (teLocalitzacio [loc-sants-2])
        (superficieHabitable 28.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 1)
        (anyConstruccio 1970)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio no)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes no)
        (consumEnergetic E)
        (esExterior no)
        (nivellSoroll Alt)
        (estatConservacio Reformar))

    ([hab-9] of Estudi
        (teLocalitzacio [loc-raval-1])
        (superficieHabitable 32.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 3)
        (anyConstruccio 1960)
        (teTerrassaOBalco si)
        (superficieTerrassa 4.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (consumEnergetic D)
        (esExterior si)
        (nivellSoroll Alt)
        (estatConservacio BonEstat))

    ([hab-10] of Estudi
        (teLocalitzacio [loc-poblenou-1])
        (superficieHabitable 40.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (plantaPis 2)
        (anyConstruccio 2015)
        (teTerrassaOBalco si)
        (superficieTerrassa 6.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Mar)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ;;; PISOS DE 2 DORMITORIS (parelles)
    ([hab-11] of Pis
        (teLocalitzacio [loc-eix-3])
        (superficieHabitable 65.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 2)
        (anyConstruccio 1995)
        (teTerrassaOBalco si)
        (superficieTerrassa 6.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar Mati)
        (teVistes si)
        (tipusVistes Ciutat)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-12] of Pis
        (teLocalitzacio [loc-gra-2])
        (superficieHabitable 70.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (plantaPis 3)
        (anyConstruccio 2000)
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
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-13] of Pis
        (teLocalitzacio [loc-barceloneta-1])
        (superficieHabitable 55.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 1)
        (anyConstruccio 1950)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio no)
        (teAireCondicionat si)
        (orientacioSolar Tarda)
        (teVistes si)
        (tipusVistes Mar)
        (consumEnergetic E)
        (esExterior si)
        (nivellSoroll Alt)
        (estatConservacio Reformar))

    ([hab-14] of Pis
        (teLocalitzacio [loc-corts-1])
        (superficieHabitable 75.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 2)
        (plantaPis 4)
        (anyConstruccio 2010)
        (teTerrassaOBalco si)
        (superficieTerrassa 10.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-15] of Pis
        (teLocalitzacio [loc-noubarris-1])
        (superficieHabitable 60.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 5)
        (anyConstruccio 1985)
        (teTerrassaOBalco si)
        (superficieTerrassa 5.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes si)
        (tipusVistes Muntanya)
        (consumEnergetic D)
        (esExterior si)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ;;; PISOS DE 3 DORMITORIS (famílies petites)
    ([hab-16] of Pis
        (teLocalitzacio [loc-eix-4])
        (superficieHabitable 90.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 5)
        (anyConstruccio 2008)
        (teTerrassaOBalco si)
        (superficieTerrassa 10.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 1)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-17] of Pis
        (teLocalitzacio [loc-horta-1])
        (superficieHabitable 85.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 3)
        (anyConstruccio 1998)
        (teTerrassaOBalco si)
        (superficieTerrassa 12.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Muntanya)
        (tePlacaAparcament no)
        (teArmariEncastat si)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-18] of Pis
        (teLocalitzacio [loc-sants-3])
        (superficieHabitable 80.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 2)
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
        (consumEnergetic D)
        (esExterior no)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-19] of Pis
        (teLocalitzacio [loc-standreu-1])
        (superficieHabitable 88.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 1)
        (anyConstruccio 2005)
        (teTerrassaOBalco si)
        (superficieTerrassa 8.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes no)
        (teArmariEncastat si)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-20] of Pis
        (teLocalitzacio [loc-poblenou-2])
        (superficieHabitable 100.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 0)
        (numeroBanys 2)
        (plantaPis 6)
        (anyConstruccio 2020)
        (teTerrassaOBalco si)
        (superficieTerrassa 15.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Mar)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 1)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ;;; PISOS DE 4 DORMITORIS (famílies grans)
    ([hab-21] of Pis
        (teLocalitzacio [loc-eix-5])
        (superficieHabitable 110.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 2)
        (numeroBanys 2)
        (plantaPis 4)
        (anyConstruccio 2003)
        (teTerrassaOBalco si)
        (superficieTerrassa 12.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 1)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-22] of Pis
        (teLocalitzacio [loc-gra-3])
        (superficieHabitable 105.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 2)
        (anyConstruccio 1990)
        (teTerrassaOBalco si)
        (superficieTerrassa 10.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes si)
        (tipusVistes Ciutat)
        (teArmariEncastat si)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-23] of Pis
        (teLocalitzacio [loc-sarria-2])
        (superficieHabitable 130.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 1)
        (numeroBanys 3)
        (plantaPis 3)
        (anyConstruccio 2012)
        (teTerrassaOBalco si)
        (superficieTerrassa 20.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Muntanya)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 2)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-24] of Pis
        (teLocalitzacio [loc-corts-2])
        (superficieHabitable 115.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 2)
        (numeroBanys 2)
        (plantaPis 5)
        (anyConstruccio 2001)
        (teTerrassaOBalco si)
        (superficieTerrassa 14.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 1)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ;;; ÀTICS (luxe i espais exteriors)
    ([hab-25] of Atic
        (teLocalitzacio [loc-eix-3])
        (superficieHabitable 95.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 2)
        (plantaPis 6)
        (anyConstruccio 2015)
        (teTerrassaOBalco si)
        (superficieTerrassa 35.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (teArmariEncastat si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ([hab-26] of Atic
        (teLocalitzacio [loc-poblenou-1])
        (superficieHabitable 110.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 7)
        (anyConstruccio 2019)
        (teTerrassaOBalco si)
        (superficieTerrassa 50.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Mar)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 2)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ([hab-27] of Atic
        (teLocalitzacio [loc-sarria-2])
        (superficieHabitable 140.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 0)
        (numeroBanys 3)
        (plantaPis 5)
        (anyConstruccio 2017)
        (teTerrassaOBalco si)
        (superficieTerrassa 60.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
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
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ([hab-28] of Atic
        (teLocalitzacio [loc-gra-2])
        (superficieHabitable 100.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 2)
        (plantaPis 4)
        (anyConstruccio 2016)
        (teTerrassaOBalco si)
        (superficieTerrassa 30.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

￼   ;;; HABITATGES UNIFAMILIARS (famílies grans o luxe)
    ([hab-29] of HabitatgeUnifamiliar
        (teLocalitzacio [loc-sarria-2])
        (superficieHabitable 180.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 3)
        (numeroDormitorisSimples 1)
        (numeroBanys 3)
        (plantaPis 0)
        (anyConstruccio 2008)
        (teTerrassaOBalco si)
        (superficieTerrassa 80.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Muntanya)
        (tePiscinaComunitaria no)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 2)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-30] of HabitatgeUnifamiliar
        (teLocalitzacio [loc-stgervasi-1])
        (superficieHabitable 220.0)
        (numeroDormitoris 5)
        (numeroDormitorisDobles 4)
        (numeroDormitorisSimples 1)
        (numeroBanys 4)
        (plantaPis 0)
        (anyConstruccio 2015)
        (teTerrassaOBalco si)
        (superficieTerrassa 120.0)
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
        (numeroPlacesAparcament 3)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ;;; PISOS ACCESSIBLES (persones grans o mobilitat reduïda)
    ([hab-31] of Pis
        (teLocalitzacio [loc-eix-5])
        (superficieHabitable 70.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (plantaPis 0)
        (anyConstruccio 2010)
        (teTerrassaOBalco si)
        (superficieTerrassa 6.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar Mati)
        (teVistes no)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-32] of Pis
        (teLocalitzacio [loc-corts-1])
        (superficieHabitable 65.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 1)
        (numeroBanys 1)
        (plantaPis 0)
        (anyConstruccio 2005)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes no)
        (consumEnergetic C)
        (esExterior no)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ([hab-33] of Pis
        (teLocalitzacio [loc-horta-1])
        (superficieHabitable 60.0)
        (numeroDormitoris 1)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (plantaPis 0)
        (anyConstruccio 2000)
        (teTerrassaOBalco si)
        (superficieTerrassa 8.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Muntanya)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio BonEstat))

    ;;; PISOS AMB ZONA D'ESTUDI/TREBALL (teletreball)
    ([hab-34] of Pis
        (teLocalitzacio [loc-poblenou-2])
        (superficieHabitable 85.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 4)
        (anyConstruccio 2018)
        (teTerrassaOBalco si)
        (superficieTerrassa 10.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Mar)
        (teArmariEncastat si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ([hab-35] of Pis
        (teLocalitzacio [loc-eix-4])
        (superficieHabitable 92.0)
        (numeroDormitoris 3)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 1)
        (numeroBanys 2)
        (plantaPis 6)
        (anyConstruccio 2017)
        (teTerrassaOBalco si)
        (superficieTerrassa 12.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (tePlacaAparcament si)
        (numeroPlacesAparcament 1)
        (teArmariEncastat si)
        (teTraster si)
        (consumEnergetic A)
        (esExterior si)
        (nivellSoroll Baix)
        (estatConservacio Nou))

    ;;; PISOS PER COMPARTIR (estudiants)
    ([hab-36] of Pis
        (teLocalitzacio [loc-gra-3])
        (superficieHabitable 95.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 1)
        (numeroDormitorisSimples 3)
        (numeroBanys 2)
        (plantaPis 2)
        (anyConstruccio 1985)
        (teTerrassaOBalco si)
        (superficieTerrassa 8.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes si)
        (tipusVistes Ciutat)
        (consumEnergetic D)
        (esExterior si)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-37] of Pis
        (teLocalitzacio [loc-sants-2])
        (superficieHabitable 100.0)
        (numeroDormitoris 5)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 5)
        (numeroBanys 2)
        (plantaPis 3)
        (anyConstruccio 1980)
        (teTerrassaOBalco no)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor si)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat no)
        (orientacioSolar Mati)
        (teVistes no)
        (consumEnergetic D)
        (esExterior no)
        (nivellSoroll Mitja)
        (estatConservacio BonEstat))

    ([hab-38] of Pis
        (teLocalitzacio [loc-raval-1])
        (superficieHabitable 90.0)
        (numeroDormitoris 4)
        (numeroDormitorisDobles 0)
        (numeroDormitorisSimples 4)
        (numeroBanys 2)
        (plantaPis 4)
        (anyConstruccio 1970)
        (teTerrassaOBalco si)
        (superficieTerrassa 6.0)
        (moblat si)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio no)
        (teAireCondicionat no)
        (orientacioSolar Tarda)
        (teVistes si)
        (tipusVistes Ciutat)
        (consumEnergetic E)
        (esExterior si)
        (nivellSoroll Alt)
        (estatConservacio Reformar))

    ;;; PISOS REFORMATS RECENTMENT
    ([hab-39] of Pis
        (teLocalitzacio [loc-gotic-1])
        (superficieHabitable 75.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 1)
        (plantaPis 3)
        (anyConstruccio 1920)
        (teTerrassaOBalco si)
        (superficieTerrassa 5.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes no)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar TotElDia)
        (teVistes si)
        (tipusVistes Ciutat)
        (teArmariEncastat si)
        (consumEnergetic C)
        (esExterior si)
        (nivellSoroll Alt)
        (estatConservacio Reformat))

    ([hab-40] of Pis
        (teLocalitzacio [loc-born-1])
        (superficieHabitable 80.0)
        (numeroDormitoris 2)
        (numeroDormitorisDobles 2)
        (numeroDormitorisSimples 0)
        (numeroBanys 2)
        (plantaPis 2)
        (anyConstruccio 1900)
        (teTerrassaOBalco si)
        (superficieTerrassa 10.0)
        (moblat no)
        (ambElectrodomestics si)
        (teAscensor no)
        (permetMascotes si)
        (teCalefaccio si)
        (teAireCondicionat si)
        (orientacioSolar Tarda)
        (teVistes si)
        (tipusVistes Ciutat)
        (teArmariEncastat si)
        (consumEnergetic B)
        (esExterior si)
        (nivellSoroll Alt)
        (estatConservacio Reformat))
)
(definstances ofertes-extended
    ;;; OFERTES ESTUDIS
    ([oferta-7] of Oferta
        (teHabitatge [hab-7])
        (preuMensual 750.0)
        (disponible si)
        (dataPublicacio "2024-11-18"))
        ([oferta-8] of Oferta
        (teHabitatge [hab-8])
        (preuMensual 550.0)
        (disponible si)
        (dataPublicacio "2024-11-22"))

    ([oferta-9] of Oferta
        (teHabitatge [hab-9])
        (preuMensual 680.0)
        (disponible si)
        (dataPublicacio "2024-11-19"))

    ([oferta-10] of Oferta
        (teHabitatge [hab-10])
        (preuMensual 950.0)
        (disponible si)
        (dataPublicacio "2024-11-25"))

    ;;; OFERTES 2 DORMITORIS
    ([oferta-11] of Oferta
        (teHabitatge [hab-11])
        (preuMensual 1150.0)
        (disponible si)
        (dataPublicacio "2024-11-14"))

    ([oferta-12] of Oferta
        (teHabitatge [hab-12])
        (preuMensual 1250.0)
        (disponible si)
        (dataPublicacio "2024-11-16"))

    ([oferta-13] of Oferta
        (teHabitatge [hab-13])
        (preuMensual 1400.0)
        (disponible si)
        (dataPublicacio "2024-11-10"))

    ([oferta-14] of Oferta
        (teHabitatge [hab-14])
        (preuMensual 1300.0)
        (disponible si)
        (dataPublicacio "2024-11-17"))

    ([oferta-15] of Oferta
        (teHabitatge [hab-15])
        (preuMensual 900.0)
        (disponible si)
        (dataPublicacio "2024-11-20"))

    ;;; OFERTES 3 DORMITORIS
    ([oferta-16] of Oferta
        (teHabitatge [hab-16])
        (preuMensual 1550.0)
        (disponible si)
        (dataPublicacio "2024-11-12"))

    ([oferta-17] of Oferta
        (teHabitatge [hab-17])
        (preuMensual 1200.0)
        (disponible si)
        (dataPublicacio "2024-11-15"))

    ([oferta-18] of Oferta
        (teHabitatge [hab-18])
        (preuMensual 1000.0)
        (disponible si)
        (dataPublicacio "2024-11-13"))

    ([oferta-19] of Oferta
        (teHabitatge [hab-19])
        (preuMensual 1150.0)
        (disponible si)
        (dataPublicacio "2024-11-11"))

    ([oferta-20] of Oferta
        (teHabitatge [hab-20])
        (preuMensual 1700.0)
        (disponible si)
        (dataPublicacio "2024-11-26"))

    ;;; OFERTES 4 DORMITORIS
    ([oferta-21] of Oferta
        (teHabitatge [hab-21])
        (preuMensual 1800.0)
        (disponible si)
        (dataPublicacio "2024-11-09"))

    ([oferta-22] of Oferta
        (teHabitatge [hab-22])
        (preuMensual 1650.0)
        (disponible si)
        (dataPublicacio "2024-11-08"))

    ([oferta-23] of Oferta
        (teHabitatge [hab-23])
        (preuMensual 2500.0)
        (disponible si)
        (dataPublicacio "2024-11-23"))

    ([oferta-24] of Oferta
        (teHabitatge [hab-24])
        (preuMensual 1900.0)
        (disponible si)
        (dataPublicacio "2024-11-07"))

    ;;; OFERTES ÀTICS
    ([oferta-25] of Oferta
        (teHabitatge [hab-25])
        (preuMensual 1600.0)
        (disponible si)
        (dataPublicacio "2024-11-21"))

    ([oferta-26] of Oferta
        (teHabitatge [hab-26])
        (preuMensual 2200.0)
        (disponible si)
        (dataPublicacio "2024-11-24"))

    ([oferta-27] of Oferta
        (teHabitatge [hab-27])
        (preuMensual 2800.0)
        (disponible si)
        (dataPublicacio "2024-11-22"))

    ([oferta-28] of Oferta
        (teHabitatge [hab-28])
        (preuMensual 1750.0)
        (disponible si)
        (dataPublicacio "2024-11-19"))

    ;;; OFERTES UNIFAMILIARS
    ([oferta-29] of Oferta
        (teHabitatge [hab-29])
        (preuMensual 3000.0)
        (disponible si)
        (dataPublicacio "2024-11-18"))

    ([oferta-30] of Oferta
        (teHabitatge [hab-30])
        (preuMensual 4500.0)
        (disponible si)
        (dataPublicacio "2024-11-27"))

    ;;; OFERTES ACCESSIBLES
    ([oferta-31] of Oferta
        (teHabitatge [hab-31])
        (preuMensual 1100.0)
        (disponible si)
        (dataPublicacio "2024-11-16"))

    ([oferta-32] of Oferta
        (teHabitatge [hab-32])
        (preuMensual 950.0)
        (disponible si)
        (dataPublicacio "2024-11-14"))

    ([oferta-33] of Oferta
        (teHabitatge [hab-33])
        (preuMensual 850.0)
        (disponible si)
        (dataPublicacio "2024-11-13"))

    ;;; OFERTES TREBALL/ESTUDI
    ([oferta-34] of Oferta
        (teHabitatge [hab-34])
        (preuMensual 1450.0)
        (disponible si)
        (dataPublicacio "2024-11-20"))

    ([oferta-35] of Oferta
        (teHabitatge [hab-35])
        (preuMensual 1600.0)
        (disponible si)
        (dataPublicacio "2024-11-21"))

    ;;; OFERTES PER COMPARTIR
    ([oferta-36] of Oferta
        (teHabitatge [hab-36])
        (preuMensual 1400.0)
        (disponible si)
        (dataPublicacio "2024-11-15"))

    ([oferta-37] of Oferta
        (teHabitatge [hab-37])
        (preuMensual 1500.0)
        (disponible si)
        (dataPublicacio "2024-11-12"))

    ([oferta-38] of Oferta
        (teHabitatge [hab-38])
        (preuMensual 1200.0)
        (disponible si)
        (dataPublicacio "2024-11-10"))

    ;;; OFERTES PISOS REFORMATS
    ([oferta-39] of Oferta
        (teHabitatge [hab-39])
        (preuMensual 1350.0)
        (disponible si)
        (dataPublicacio "2024-11-23"))

    ([oferta-40] of Oferta
        (teHabitatge [hab-40])
        (preuMensual 1500.0)
        (disponible si)
        (dataPublicacio "2024-11-25")))

;;; ============================================================
;;; SERVEIS ADDICIONALS (60 nous serveis)
;;; ============================================================

;;; ============================================================
;;; instancies_extended_FIXED.clp
;;; Instàncies corregides amb serveis vinculats als habitatges
;;; ============================================================

;;; NOTA IMPORTANT: Cal modificar les localitzacions dels SERVEIS
;;; per posar-los a prop dels habitatges existents

(definstances serveis-extended-fixed
    ;;; TRANSPORT PÚBLIC - Prop dels habitatges existents
    ([metro-eixample-1] of EstacioMetro
        (nomServei "Metro Passeig de Gracia L2 L3 L4")
        (teLocalitzacio [loc-eixample-1]))

    ([metro-eixample-2] of EstacioMetro
        (nomServei "Metro Diagonal L3 L5")
        (teLocalitzacio [loc-eixample-2]))

    ([metro-eixample-3] of EstacioMetro
        (nomServei "Metro Sagrada Familia L2 L5")
        (teLocalitzacio [loc-eix-4]))

    ([metro-gracia-1] of EstacioMetro
        (nomServei "Metro Fontana L3")
        (teLocalitzacio [loc-gracia-1]))

    ([metro-gracia-2] of EstacioMetro
        (nomServei "Metro Lesseps L3")
        (teLocalitzacio [loc-gra-2]))

    ([metro-gracia-3] of EstacioMetro
        (nomServei "Metro Joanic L4")
        (teLocalitzacio [loc-gra-3]))

    ([metro-sants-1] of EstacioMetro
        (nomServei "Metro Sants Estacio L3 L5")
        (teLocalitzacio [loc-sants-1]))

    ([metro-sants-2] of EstacioMetro
        (nomServei "Metro Hostafrancs L1")
        (teLocalitzacio [loc-sants-2]))

    ([metro-born-1] of EstacioMetro
        (nomServei "Metro Jaume I L4")
        (teLocalitzacio [loc-born-1]))

    ([metro-barceloneta] of EstacioMetro
        (nomServei "Metro Barceloneta L4")
        (teLocalitzacio [loc-barceloneta-1]))

    ([metro-poblenou-1] of EstacioMetro
        (nomServei "Metro Poblenou L4")
        (teLocalitzacio [loc-poblenou-1]))

    ([metro-poblenou-2] of EstacioMetro
        (nomServei "Metro Llacuna L4")
        (teLocalitzacio [loc-poblenou-2]))

    ([metro-sarria-1] of EstacioMetro
        (nomServei "Metro Sarria FGC")
        (teLocalitzacio [loc-sarria-1]))

    ([metro-sarria-2] of EstacioMetro
        (nomServei "Metro Reina Elisenda FGC")
        (teLocalitzacio [loc-sarria-2]))

    ([metro-corts-1] of EstacioMetro
        (nomServei "Metro Les Corts L3")
        (teLocalitzacio [loc-corts-1]))

    ([metro-horta-1] of EstacioMetro
        (nomServei "Metro Horta L5")
        (teLocalitzacio [loc-horta-1]))

    ([metro-noubarris-1] of EstacioMetro
        (nomServei "Metro Fabra i Puig L1 L5")
        (teLocalitzacio [loc-noubarris-1]))

    ([metro-standreu-1] of EstacioMetro
        (nomServei "Metro Sant Andreu L1")
        (teLocalitzacio [loc-standreu-1]))

    ;;; ESCOLES - Una a prop de cada zona residencial
    ([escola-eixample-1] of Escola
        (nomServei "Escola Eixample")
        (teLocalitzacio [loc-eixample-1]))

    ([escola-eixample-2] of Escola
        (nomServei "Col·legi Sagrada Familia")
        (teLocalitzacio [loc-eix-4]))

    ([escola-gracia-1] of Escola
        (nomServei "Escola Gracia")
        (teLocalitzacio [loc-gracia-1]))

    ([escola-gracia-2] of Escola
        (nomServei "Escola Lesseps")
        (teLocalitzacio [loc-gra-2]))

    ([escola-sants-1] of Escola
        (nomServei "Escola Sants")
        (teLocalitzacio [loc-sants-1]))

    ([escola-born-1] of Escola
        (nomServei "Escola Born")
        (teLocalitzacio [loc-born-1]))

    ([escola-poblenou-1] of Escola
        (nomServei "Escola Poblenou")
        (teLocalitzacio [loc-poblenou-1]))

    ([escola-poblenou-2] of Escola
        (nomServei "Escola Diagonal Mar")
        (teLocalitzacio [loc-poblenou-2]))

    ([escola-sarria-1] of Escola
        (nomServei "Escola Sarria")
        (teLocalitzacio [loc-sarria-1]))

    ([escola-sarria-2] of Escola
        (nomServei "Escola Internacional Barcelona")
        (teLocalitzacio [loc-sarria-2]))

    ([escola-corts-1] of Escola
        (nomServei "Escola Les Corts")
        (teLocalitzacio [loc-corts-1]))

    ([escola-horta-1] of Escola
        (nomServei "Escola Horta")
        (teLocalitzacio [loc-horta-1]))

    ([escola-noubarris-1] of Escola
        (nomServei "Escola Nou Barris")
        (teLocalitzacio [loc-noubarris-1]))

    ([escola-standreu-1] of Escola
        (nomServei "Escola Sant Andreu")
        (teLocalitzacio [loc-standreu-1]))

    ;;; HOSPITALS I CENTRES DE SALUT
    ([hospital-clinic] of Hospital
        (nomServei "Hospital Clinic")
        (teLocalitzacio [loc-eixample-1]))

    ([cap-eixample] of Hospital
        (nomServei "CAP Eixample")
        (teLocalitzacio [loc-eix-3]))

    ([cap-gracia] of Hospital
        (nomServei "CAP Gracia")
        (teLocalitzacio [loc-gra-2]))

    ([cap-sants] of Hospital
        (nomServei "CAP Sants")
        (teLocalitzacio [loc-sants-1]))

    ([hospital-mar] of Hospital
        (nomServei "Hospital del Mar")
        (teLocalitzacio [loc-barceloneta-1]))

    ([cap-poblenou] of Hospital
        (nomServei "CAP Poblenou")
        (teLocalitzacio [loc-poblenou-1]))

    ([cap-sarria] of Hospital
        (nomServei "CAP Sarria")
        (teLocalitzacio [loc-sarria-1]))

    ([hospital-sant-pau] of Hospital
        (nomServei "Hospital Sant Pau")
        (teLocalitzacio [loc-horta-1]))

    ([hospital-vall-hebron] of Hospital
        (nomServei "Hospital Vall d'Hebron")
        (teLocalitzacio [loc-noubarris-1]))

    ;;; SUPERMERCATS - Diversos a cada zona
    ([mercadona-eixample] of Supermercat
        (nomServei "Mercadona Eixample")
        (teLocalitzacio [loc-eixample-1]))

    ([caprabo-eixample] of Supermercat
        (nomServei "Caprabo Eixample")
        (teLocalitzacio [loc-eix-3]))

    ([mercadona-gracia] of Supermercat
        (nomServei "Mercadona Gracia")
        (teLocalitzacio [loc-gracia-1]))

    ([veritas-gracia] of Supermercat
        (nomServei "Veritas Gracia")
        (teLocalitzacio [loc-gra-2]))

    ([caprabo-sants] of Supermercat
        (nomServei "Caprabo Sants")
        (teLocalitzacio [loc-sants-1]))

    ([lidl-sants] of Supermercat
        (nomServei "Lidl Sants")
        (teLocalitzacio [loc-sants-2]))

    ([mercadona-born] of Supermercat
        (nomServei "Mercadona Born")
        (teLocalitzacio [loc-born-1]))

    ([carrefour-barceloneta] of Supermercat
        (nomServei "Carrefour Barceloneta")
        (teLocalitzacio [loc-barceloneta-1]))

    ([lidl-poblenou] of Supermercat
        (nomServei "Lidl Poblenou")
        (teLocalitzacio [loc-poblenou-1]))

    ([mercadona-poblenou] of Supermercat
        (nomServei "Mercadona Poblenou")
        (teLocalitzacio [loc-poblenou-2]))

    ([bonpreu-sarria] of Supermercat
        (nomServei "Bonpreu Sarria")
        (teLocalitzacio [loc-sarria-1]))

    ([caprabo-sarria] of Supermercat
        (nomServei "Caprabo Sarria")
        (teLocalitzacio [loc-sarria-2]))

    ([aldi-corts] of Supermercat
        (nomServei "Aldi Les Corts")
        (teLocalitzacio [loc-corts-1]))

    ([caprabo-horta] of Supermercat
        (nomServei "Caprabo Horta")
        (teLocalitzacio [loc-horta-1]))

    ([mercadona-noubarris] of Supermercat
        (nomServei "Mercadona Nou Barris")
        (teLocalitzacio [loc-noubarris-1]))

    ;;; PARCS
    ([parc-ciutadella] of Parc
        (nomServei "Parc Ciutadella")
        (teLocalitzacio [loc-born-1]))

    ([parc-guell] of Parc
        (nomServei "Parc Guell")
        (teLocalitzacio [loc-gra-3]))

    ([jardins-laribal] of Parc
        (nomServei "Jardins Laribal")
        (teLocalitzacio [loc-sants-1]))

    ([parc-diagonal-mar] of Parc
        (nomServei "Parc Diagonal Mar")
        (teLocalitzacio [loc-poblenou-2]))

    ([jardins-pedralbes] of Parc
        (nomServei "Jardins Pedralbes")
        (teLocalitzacio [loc-sarria-1]))

    ([parc-collserola] of Parc
        (nomServei "Parc Collserola")
        (teLocalitzacio [loc-sarria-2]))

    ([parc-cervantes] of Parc
        (nomServei "Parc Cervantes")
        (teLocalitzacio [loc-corts-1]))

    ([parc-tres-turons] of Parc
        (nomServei "Parc dels Tres Turons")
        (teLocalitzacio [loc-horta-1]))

    ([parc-guinea] of Parc
        (nomServei "Parc Guinea")
        (teLocalitzacio [loc-noubarris-1]))

    ;;; GIMNASOS
    ([dir-eixample] of Gimnasio
        (nomServei "DIR Eixample")
        (teLocalitzacio [loc-eix-4]))

    ([basic-fit-gracia] of Gimnasio
        (nomServei "Basic Fit Gracia")
        (teLocalitzacio [loc-gra-2]))

    ([mcfit-sants] of Gimnasio
        (nomServei "McFit Sants")
        (teLocalitzacio [loc-sants-2]))

    ([anytime-poblenou] of Gimnasio
        (nomServei "Anytime Fitness Poblenou")
        (teLocalitzacio [loc-poblenou-1]))

    ([holmes-place-sarria] of Gimnasio
        (nomServei "Holmes Place Sarria")
        (teLocalitzacio [loc-sarria-2]))

    ([go-fit-corts] of Gimnasio
        (nomServei "Go Fit Les Corts")
        (teLocalitzacio [loc-corts-1]))

    ;;; BIBLIOTEQUES
    ([biblioteca-gracia] of Biblioteca
        (nomServei "Biblioteca Vila de Gracia")
        (teLocalitzacio [loc-gra-2]))

    ([biblioteca-born] of Biblioteca
        (nomServei "Biblioteca Born")
        (teLocalitzacio [loc-born-1]))

    ([biblioteca-sarria] of Biblioteca
        (nomServei "Biblioteca Sarria")
        (teLocalitzacio [loc-sarria-1]))

    ([biblioteca-noubarris] of Biblioteca
        (nomServei "Biblioteca Nou Barris")
        (teLocalitzacio [loc-noubarris-1]))

    ;;; CENTRES CULTURALS
    ([centre-civic-gracia] of CentreCultural
        (nomServei "Centre Civic Gracia")
        (teLocalitzacio [loc-gra-3]))

    ([centre-civic-sants] of CentreCultural
        (nomServei "Centre Civic Sants")
        (teLocalitzacio [loc-sants-2]))

    ([caixaforum] of CentreCultural
        (nomServei "CaixaForum Barcelona")
        (teLocalitzacio [loc-sants-1]))

    ([centre-civic-poblenou] of CentreCultural
        (nomServei "Centre Civic Poblenou")
        (teLocalitzacio [loc-poblenou-1]))

    ;;; SERVEIS MOLESTOS - Zones de soroll
    ([discoteca-port] of Discoteca
        (nomServei "Zona Clubs Port Olimpic")
        (teLocalitzacio [loc-discoteca]))

    ([discoteca-razzmatazz] of Discoteca
        (nomServei "Razzmatazz")
        (teLocalitzacio [loc-poblenou-1]))

    ([discoteca-apolo] of Discoteca
        (nomServei "Sala Apolo")
        (teLocalitzacio [loc-sants-1]))

    ([zona-born-nit] of Discoteca
        (nomServei "Zona Nocturna Born")
        (teLocalitzacio [loc-born-1]))

    ([discoteca-sutton] of Discoteca
        (nomServei "Sutton Barcelona")
        (teLocalitzacio [loc-eix-4]))
)

;;; Més solicitants amb perfils variats per provar el sistema

(definstances solicitants-adicionals
    ;;; FAMÍLIES AMB NECESSITATS CLARES
    ([familia-escola-publica] of FamiliaBiparental
        (nom "Familia Publica")
        (edat 37)
        (numeroPersones 4)
        (pressupostMaxim 1500.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (numeroFills 2)
        (edatsFills 7 10)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([familia-mascota-gran] of FamiliaBiparental
        (nom "Familia Amb Gos")
        (edat 40)
        (numeroPersones 4)
        (pressupostMaxim 1600.0)
        (pressupostMinim 1100.0)
        (margeEstricte no)
        (numeroFills 2)
        (edatsFills 9 12)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gos)
        (treballaACiutat si))

    ([familia-bebe-nou] of FamiliaBiparental
        (nom "Familia Bebe")
        (edat 31)
        (numeroPersones 3)
        (pressupostMaxim 1400.0)
        (pressupostMinim 900.0)
        (margeEstricte no)
        (numeroFills 1)
        (edatsFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ;;; ESTUDIANTS AMB PRESSUPOST JUST
    ([estudiant-ajustat-1] of Individu
        (nom "Estudiant Economia")
        (edat 21)
        (numeroPersones 1)
        (pressupostMaxim 700.0)
        (pressupostMinim 500.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ([estudiant-ajustat-2] of Individu
        (nom "Estudiant Medicina")
        (edat 23)
        (numeroPersones 1)
        (pressupostMaxim 750.0)
        (pressupostMinim 550.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ;;; PROFESSIONALS JOVES
    ([jove-professional-1] of Individu
        (nom "Enginyer Junior")
        (edat 26)
        (numeroPersones 1)
        (pressupostMaxim 1000.0)
        (pressupostMinim 700.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([jove-professional-2] of Individu
        (nom "Dissenyadora UX")
        (edat 28)
        (numeroPersones 1)
        (pressupostMaxim 1100.0)
        (pressupostMinim 800.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat si))

    ;;; PARELLES PROFESSIONALS
    ([parella-joves-pro] of ParellaSenseFills
        (nom "Joves Professionals")
        (edat 29)
        (numeroPersones 2)
        (pressupostMaxim 1500.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([parella-mascota] of ParellaSenseFills
        (nom "Parella Amb Gat")
        (edat 30)
        (numeroPersones 2)
        (pressupostMaxim 1400.0)
        (pressupostMinim 950.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat si))

    ;;; PERSONES GRANS ACCESSIBLES
    ([avi-accessible-1] of PersonaGran
        (nom "Avi Accessible")
        (edat 74)
        (numeroPersones 1)
        (pressupostMaxim 1000.0)
        (pressupostMinim 650.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes no)
        (treballaACiutat no))

    ([avia-accessible-2] of PersonaGran
        (nom "Avia Accessible")
        (edat 71)
        (numeroPersones 1)
        (pressupostMaxim 950.0)
        (pressupostMinim 600.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat no))
)

;;; ============================================================
;;; SOLICITANTS ADDICIONALS (40 més per arribar a 100 total)
;;; ============================================================

(definstances solicitants-mes
    ;;; ESTUDIANTS MÀSTER I DOCTORAT (5)
    ([estudiant-master-upc] of Individu
        (nom "Sofia Master UPC")
        (edat 25)
        (numeroPersones 1)
        (pressupostMaxim 850.0)
        (pressupostMinim 600.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ([doctorand-biologia] of Individu
        (nom "Raul Doctorand")
        (edat 28)
        (numeroPersones 1)
        (pressupostMaxim 900.0)
        (pressupostMinim 650.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([estudiant-mba] of Individu
        (nom "Andrea MBA")
        (edat 29)
        (numeroPersones 1)
        (pressupostMaxim 1400.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ([estudiant-arquitectura] of Individu
        (nom "Pau Arquitecte")
        (edat 23)
        (numeroPersones 1)
        (pressupostMaxim 750.0)
        (pressupostMinim 550.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ([estudiant-bellesarts] of Individu
        (nom "Nuria Artista")
        (edat 22)
        (numeroPersones 1)
        (pressupostMaxim 700.0)
        (pressupostMinim 500.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat no))

    ;;; GRUPS D'ESTUDIANTS DIVERSOS (3)
    ([estudiants-enginyeria] of GrupEstudiants
        (nom "Grup Enginyeria Industrial")
        (edat 22)
        (numeroPersones 4)
        (pressupostMaxim 1400.0)
        (pressupostMinim 1000.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no)
        (estudiaACiutat si))

    ([estudiants-dret] of GrupEstudiants
        (nom "Estudiants Dret UB")
        (edat 21)
        (numeroPersones 3)
        (pressupostMaxim 1100.0)
        (pressupostMinim 800.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no)
        (estudiaACiutat si))

    ([estudiants-internacional] of GrupEstudiants
        (nom "International Students")
        (edat 23)
        (numeroPersones 4)
        (pressupostMaxim 1600.0)
        (pressupostMinim 1100.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no)
        (estudiaACiutat si))

    ;;; PARELLES PROFESSIONALS ESPECÍFIQUES (5)
    ([parella-advocats] of ParellaSenseFills
        (nom "Parella Advocats")
        (edat 34)
        (numeroPersones 2)
        (pressupostMaxim 2000.0)
        (pressupostMinim 1500.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([parella-metge-infermera] of ParellaSenseFills
        (nom "Sanitaris")
        (edat 33)
        (numeroPersones 2)
        (pressupostMaxim 1700.0)
        (pressupostMinim 1200.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gos)
        (treballaACiutat si))

    ([parella-arquitectes] of ParellaSenseFills
        (nom "Arquitectes Studio")
        (edat 31)
        (numeroPersones 2)
        (pressupostMaxim 1800.0)
        (pressupostMinim 1300.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([parella-enginyers] of ParellaSenseFills
        (nom "Enginyers Tech")
        (edat 29)
        (numeroPersones 2)
        (pressupostMaxim 1600.0)
        (pressupostMinim 1100.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([parella-dissenyadors] of ParellaSenseFills
        (nom "Disseny Grafic")
        (edat 27)
        (numeroPersones 2)
        (pressupostMaxim 1300.0)
        (pressupostMinim 900.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 2)
        (tipusMascota Gat)
        (treballaACiutat no))

    ;;; PARELLES AMB PLANS ESPECÍFICS (3)
    ([parella-adopcio] of ParellaFutursFills
        (nom "Adoptants")
        (edat 36)
        (numeroPersones 2)
        (pressupostMaxim 1900.0)
        (pressupostMinim 1400.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([parella-gemels] of ParellaFutursFills
        (nom "Esperant Bessons")
        (edat 31)
        (numeroPersones 2)
        (pressupostMaxim 1800.0)
        (pressupostMinim 1300.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([parella-embarassada] of ParellaFutursFills
        (nom "Futura Mare")
        (edat 30)
        (numeroPersones 2)
        (pressupostMaxim 1600.0)
        (pressupostMinim 1100.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat si))

    ;;; FAMÍLIES MONOPARENTALS (4)
    ([monoparental-2fills] of Individu
        (nom "Mare Sola 2 Fills")
        (edat 39)
        (numeroPersones 3)
        (pressupostMaxim 1400.0)
        (pressupostMinim 900.0)
        (margeEstricte no)
        (numeroFills 2)
        (edatsFills 5 8)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([monoparental-adolescent] of Individu
        (nom "Pare Amb Adolescent")
        (edat 45)
        (numeroPersones 2)
        (pressupostMaxim 1500.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (numeroFills 1)
        (edatsFills 14)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([monoparental-petit] of Individu
        (nom "Mare Amb Bebe")
        (edat 32)
        (numeroPersones 2)
        (pressupostMaxim 1200.0)
        (pressupostMinim 800.0)
        (margeEstricte no)
        (numeroFills 1)
        (edatsFills 2)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([monoparental-3fills] of Individu
        (nom "Mare 3 Fills")
        (edat 42)
        (numeroPersones 4)
        (pressupostMaxim 1700.0)
        (pressupostMinim 1200.0)
        (margeEstricte no)
        (numeroFills 3)
        (edatsFills 6 9 12)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat si))

    ;;; FAMÍLIES AMB ADOLESCENTS (3)
    ([familia-adolescents] of FamiliaBiparental
        (nom "Familia Teenagers")
        (edat 48)
        (numeroPersones 4)
        (pressupostMaxim 2000.0)
        (pressupostMinim 1500.0)
        (margeEstricte no)
        (numeroFills 2)
        (edatsFills 14 16)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([familia-institut] of FamiliaBiparental
        (nom "Fills a l'Institut")
        (edat 46)
        (numeroPersones 5)
        (pressupostMaxim 1900.0)
        (pressupostMinim 1400.0)
        (margeEstricte no)
        (numeroFills 3)
        (edatsFills 12 14 16)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gos)
        (treballaACiutat si))

    ([familia-universitari] of FamiliaBiparental
        (nom "Fill Universitari")
        (edat 50)
        (numeroPersones 3)
        (pressupostMaxim 1800.0)
        (pressupostMinim 1300.0)
        (margeEstricte no)
        (numeroFills 1)
        (edatsFills 19)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ;;; PERSONES GRANS AMB DIFERENTS NECESSITATS (5)
    ([jubilat-vidu] of PersonaGran
        (nom "Senyor Vidu")
        (edat 73)
        (numeroPersones 1)
        (pressupostMaxim 950.0)
        (pressupostMinim 600.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes no)
        (treballaACiutat no))

    ([jubilada-autonoma] of PersonaGran
        (nom "Senyora Independent")
        (edat 67)
        (numeroPersones 1)
        (pressupostMaxim 1100.0)
        (pressupostMinim 700.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat no))

    ([parella-jubilats-actius] of PersonaGran
        (nom "Jubilats Viatgers")
        (edat 69)
        (numeroPersones 2)
        (pressupostMaxim 1500.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ([jubilat-cadira-rodes] of PersonaGran
        (nom "Senyor Mobilitat Reduida")
        (edat 76)
        (numeroPersones 1)
        (pressupostMaxim 1000.0)
        (pressupostMinim 650.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes no)
        (treballaACiutat no))

    ([jubilada-cultural] of PersonaGran
        (nom "Senyora Cultural")
        (edat 71)
        (numeroPersones 1)
        (pressupostMaxim 1200.0)
        (pressupostMinim 750.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ;;; PROFESSIONALS ESPECÍFICS (6)
    ([pilot-aeroport] of Individu
        (nom "Pilot Aviacio")
        (edat 38)
        (numeroPersones 1)
        (pressupostMaxim 1800.0)
        (pressupostMinim 1300.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (prefereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no))

    ([infermera-hospital] of Individu
        (nom "Infermera Urgencies")
        (edat 31)
        (numeroPersones 1)
        (pressupostMaxim 1100.0)
        (pressupostMinim 750.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (prefereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ([professor-universitat] of Individu
    (nom "Professor UB")
    (edat 44)
    (numeroPersones 1)
    (pressupostMaxim 1400.0)
    (pressupostMinim 1000.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes si)
    (numeroMascotes 2)
    (tipusMascota Gat)
    (treballaACiutat si))

([musica-professional] of Individu
    (nom "Musica Orquestra")
    (edat 35)
    (numeroPersones 1)
    (pressupostMaxim 1200.0)
    (pressupostMinim 850.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

([periodista-tv] of Individu
    (nom "Periodista TV3")
    (edat 37)
    (numeroPersones 1)
    (pressupostMaxim 1500.0)
    (pressupostMinim 1100.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle si)
    (prefereixTransportPublic no)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

([cuiner-restaurant] of Individu
    (nom "Chef Estrella Michelin")
    (edat 41)
    (numeroPersones 1)
    (pressupostMaxim 1600.0)
    (pressupostMinim 1100.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle si)
    (prefereixTransportPublic no)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

;;; EXPATRIATS I INTERNACIONALS (4)
([expatriat-alemany] of Individu
    (nom "German Engineer")
    (edat 34)
    (numeroPersones 1)
    (pressupostMaxim 1800.0)
    (pressupostMinim 1400.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

([familia-expatriada-usa] of FamiliaBiparental
    (nom "American Family")
    (edat 40)
    (numeroPersones 4)
    (pressupostMaxim 3000.0)
    (pressupostMinim 2200.0)
    (margeEstricte no)
    (numeroFills 2)
    (edatsFills 8 11)
    (teAvis no)
    (teVehicle si)
    (prefereixTransportPublic no)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

([parella-italiana] of ParellaSenseFills
    (nom "Italian Couple")
    (edat 28)
    (numeroPersones 2)
    (pressupostMaxim 1400.0)
    (pressupostMinim 1000.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

([expatriat-japones] of Individu
    (nom "Japanese Executive")
    (edat 42)
    (numeroPersones 1)
    (pressupostMaxim 2500.0)
    (pressupostMinim 1800.0)
    (margeEstricte no)
    (numeroFills 0)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

;;; SITUACIONS ESPECIALS DIVERSES (2)
([persona-refugiada] of Individu
    (nom "Refugiat Siria")
    (edat 35)
    (numeroPersones 4)
    (pressupostMaxim 800.0)
    (pressupostMinim 500.0)
    (margeEstricte si)
    (numeroFills 2)
    (edatsFills 6 9)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes no)
    (treballaACiutat si))

([artista-bohemi] of Individu
    (nom "Artista Emergent")
    (edat 26)
    (numeroPersones 1)
    (pressupostMaxim 700.0)
    (pressupostMinim 450.0)
    (margeEstricte si)
    (numeroFills 0)
    (teAvis no)
    (teVehicle no)
    (prefereixTransportPublic si)
    (necessitaAccessibilitat no)
    (teMascotes si)
    (numeroMascotes 1)
    (tipusMascota Gat)
    (treballaACiutat no)))