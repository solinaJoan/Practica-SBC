(definstances solicitants

    ;;; ------------------------------------------------------------
    ;;; SOL·LICITANT 1: Família Garcia
    ;;; ------------------------------------------------------------
    ([sol-familia-garcia] of ParellaAmbFills
        (nom "Familia Garcia")
        (edat 40)
        (pressupostMaxim 1800.0)
        (pressupostMinim 1200.0)
        (margeEstricte no)
        (numeroPersones 5)
        (numeroFills 2)
        (edatsFills 6 10)
        (teAvis si)
        (numeroAvis 1)
        (teVehicle si)
        (treballaACiutat si)
        (estudiaACiutat no)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota "Gos")
        (evitaServei
            [servei-discoteca]
            [servei-bar-frankfurt]
            [servei-metro-liceu]
        )

        (prefereixServei
            [servei-escola-balmes]
            [servei-parc-miro]
            [servei-super-bonpreu]
            [servei-mercat-ninot]
            [servei-farmacia-24h]
        )
    )

    ;;; ------------------------------------------------------------
    ;;; SOL·LICITANT 2: Grup d'Estudiants UPC
    ;;; ------------------------------------------------------------
    ([sol-estudiants-upc] of GrupEstudiants
        (nom "Grup UPC")
        (edat 21)
        (pressupostMaxim 900.0)
        (pressupostMinim 600.0)
        (margeEstricte si)
        (numeroPersones 3)
        (numeroFills 0)
        (edatsFills) ; Llista buida
        (teAvis no)
        (numeroAvis 0)
        (teVehicle no)
        (treballaACiutat no)
        (estudiaACiutat si)
        (requereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "Cap")
        (evitaServei)
        (prefereixServei
            [servei-upc]
            [servei-metro-uni]
            [servei-bus-33]
            [servei-super-campus]
            [servei-bar-frankfurt]
        )

    )

    ;;; ------------------------------------------------------------
    ;;; SOL·LICITANT 3: Maria Jubilada
    ;;; ------------------------------------------------------------
    ([sol-maria-jubilada] of PersonaGran
        (nom "Maria Antonia")
        (edat 78)
        (pressupostMaxim 1100.0)
        (pressupostMinim 700.0)
        (margeEstricte no)
        (numeroPersones 1)
        (numeroFills 0)
        (edatsFills)
        (teAvis no) ; Ella és la persona gran, no conviu amb "avis" extra
        (numeroAvis 0)
        (teVehicle no)
        (treballaACiutat no)
        (estudiaACiutat no)
        (requereixTransportPublic no)
        (necessitaAccessibilitat si)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota "Gat")
        (evitaServei
            [servei-discoteca]
            [servei-bar-frankfurt]
            [servei-metro-liceu]
        )

        (prefereixServei
            [servei-cap-eixample]
            [servei-hospital-clinic]
            [servei-farmacia-24h]
            [servei-mercat-ninot]
            [servei-parc-miro]
        )

    )

    ;;; ------------------------------------------------------------
    ;;; SOL·LICITANT 4: Parella Silenciosa
    ;;; ------------------------------------------------------------
    ([sol-parella-silenciosa] of ParellaSenseFills
        (nom "Parella Tranquil·la")
        (edat 35)
        (pressupostMaxim 1400.0)
        (pressupostMinim 900.0)
        (margeEstricte no)
        (numeroPersones 2)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (numeroAvis 0)
        (teVehicle si)
        (treballaACiutat si)
        (estudiaACiutat no)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "Cap")
        (evitaServei
            [servei-discoteca]
            [servei-bar-frankfurt]
            [servei-teatre-principal]
        )

        (prefereixServei
            [servei-super-bonpreu]
            [servei-parc-miro]
            [servei-farmacia-24h]
        )

    )

    ;;; ------------------------------------------------------------
    ;;; SOL·LICITANT 5: Executiu Zona Alta
    ;;; ------------------------------------------------------------
    ([sol-executiu-alt] of Individu
        (nom "Sr. Roca")
        (edat 45)
        (pressupostMaxim 3500.0)
        (pressupostMinim 2000.0)
        (margeEstricte no)
        (numeroPersones 1)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (numeroAvis 0)
        (teVehicle si)
        (treballaACiutat si)
        (estudiaACiutat no)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "Cap")
        (evitaServei
            [servei-discoteca]
            [servei-bar-frankfurt]
            [servei-metro-liceu]
        )

        (prefereixServei
            [servei-autopista]
            [servei-club-tennis]
            [servei-parc-collserola]
            [servei-super-sarria]
        )

    )

    ;;; ------------------------------------------------------------
    ;;; SOL·LICITANT 6: Parella Jove
    ;;; ------------------------------------------------------------
    ([sol-parella-jove] of ParellaJove
        (nom "Marc i Laura")
        (edat 28)
        (pressupostMaxim 1200.0)
        (pressupostMinim 800.0)
        (margeEstricte no)
        (numeroPersones 2)
        (numeroFills 0)
        (edatsFills)
        (teAvis no)
        (numeroAvis 0)
        (teVehicle no)
        (treballaACiutat si)
        (estudiaACiutat no)
        (requereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (numeroMascotes 0)
        (tipusMascota "Cap")
        (evitaServei)
        (prefereixServei
            [servei-metro-centre]
            [servei-gimnas-dir]
            [servei-super-bonpreu]
            [servei-parc-miro]
        )

    )
)