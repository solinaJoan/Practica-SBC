(definstances solicitants
    ;;; FAMILIA BIPARENTAL amb fills i mascota
    ([familia-garcia] of FamiliaBiparental
        (nom "Familia Garcia")
        (edat 38)
        (numeroPersones 4)
        (pressupostMaxim 1500.0)
        (pressupostMinim 600.0)
        (margeEstricte no)
        (numeroFills 2)
        (edatsFills 6 10)
        (teAvis no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gos)
        (treballaACiutat si))

    ;;; GRUP D'ESTUDIANTS
    ([estudiant-marc] of GrupEstudiants
        (nom "Marc i companys")
        (edat 22)
        (numeroPersones 3)
        (pressupostMaxim 900.0)
        (pressupostMinim 300.0)
        (margeEstricte si)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (requereixTransportPublic si)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat no)
        (estudiaACiutat si))

    ;;; PERSONA GRAN amb necessitat d'accessibilitat
    ([jubilada-maria] of PersonaGran
        (nom "Maria Lopez")
        (edat 72)
        (numeroPersones 1)
        (pressupostMaxim 1000.0)
        (pressupostMinim 400.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle no)
        (requereixTransportPublic si)
        (necessitaAccessibilitat si)
        (teMascotes no)
        (treballaACiutat no))

    ;;; PARELLA JOVE sense fills
    ([parella-martinez] of ParellaSenseFills
        (nom "Parella Martinez")
        (edat 30)
        (numeroPersones 2)
        (pressupostMaxim 1400.0)
        (pressupostMinim 500.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes no)
        (treballaACiutat si))

    ;;; PARELLA que vol tenir fills aviat
    ([parella-lopez] of ParellaFutursFills
        (nom "Parella Lopez")
        (edat 32)
        (numeroPersones 2)
        (pressupostMaxim 1600.0)
        (pressupostMinim 700.0)
        (margeEstricte no)
        (numeroFills 0)
        (teAvis no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gat)
        (treballaACiutat si))

    ;;; Inversor Desconfiat
    ([inversor-robert] of Individu
        (nom "Robert De Niro")
        (edat 50)
        (pressupostMaxim 5000.0)
        (pressupostMinim 1000.0)
        (margeEstricte no)
        (numeroFills 3)
        (teAvis no)
        (teVehicle si)
        (requereixTransportPublic no)
        (necessitaAccessibilitat no)
        (teMascotes si)
        (numeroMascotes 1)
        (tipusMascota Gos)
        (treballaACiutat si))


    ;;; 2. L'AVI EN FORMA
    ([avi-joan] of PersonaGran
        (nom "Joan Marxador")
        (edat 68) ; > 60 anys
        (pressupostMaxim 1200.0)
        (necessitaAccessibilitat no)
        (margeEstricte no)
        (requereixTransportPublic si))

    ;;; 3. EL HATER DEL SOROLL
    ([vei-tranquil] of Individu
        (nom "Senyor Silenci")
        (edat 40)
        (pressupostMaxim 1500.0)
        (margeEstricte no))

)

