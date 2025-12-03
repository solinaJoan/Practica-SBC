;;; ============================================================
;;; instancies.clp
;;; Instancies de prova per al sistema de recomanacio
;;; ============================================================


;;; Definir localitzacions de la ciutat, tant d'habitatges com de serveis publics
(definstances localitzacions
    ;;; LOCALITZACIONS D'HABITATGES
    ([loc-eixample-1] of Localitzacio
        (adreca "Carrer Arago 250")
        (districte Eixample)
        (barri DretaEixample)
        (codiPostal "08007")
        (coordenadaX 100.0)
        (coordenadaY 200.0))

    ([loc-sarria-1] of Localitzacio
        (adreca "Carrer Major de Sarria 80")
        (districte SarriaStGervasi)
        (barri Sarria)
        (codiPostal "08017")
        (coordenadaX 80.0)
        (coordenadaY 500.0))

    ;;; LOCALITZACIONS DE SERVEIS
    ([loc-metro-pg] of Localitzacio
        (adreca "Metro Passeig de Gracia")
        (districte Eixample)
        (coordenadaX 105.0)
        (coordenadaY 195.0))
)

;;; Definir instancies de transports publics
(definstances serveis
    ;;; TRANSPORT PUBLIC
    ([metro-pg] of EstacioMetro
        (nomServei "Metro Passeig de Gracia L2 L3 L4")
        (teLocalitzacio [loc-metro-pg]))
)


;;; Definir instancies d'habitatges
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
        (nivellSoroll Baix)
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
        (nivellSoroll Baix)
        (estatConservacio BonEstat))
)


;;; Definir instàncies d'ofertes
(definstances ofertes
    ([oferta-1] of Oferta
        (teHabitatge [hab-1])
        (preuMensual 1350.0)
        (disponible si)
        (dataPublicacio "2024-11-01"))

    ([oferta-5] of Oferta
        (teHabitatge [hab-5])
        (preuMensual 3500.0)
        (disponible si)
        (dataPublicacio "2024-11-15"))
)

