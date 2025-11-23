;;; ---------------------------------------------------------
;;; ontologiaSBC.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaSBC.ttl
;;; :Date 22/11/2025 13:42:24

;;; ============================================================
;;; CLASSE: Localitzacio
;;; ============================================================
(defclass Localitzacio "Localitzacio geografica"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot adreca (type STRING) (create-accessor read-write))
    (slot districte (type SYMBOL) (create-accessor read-write))
    (slot barri (type SYMBOL) (create-accessor read-write))
    (slot codiPostal (type STRING) (create-accessor read-write))
    (slot coordenadaX (type FLOAT) (create-accessor read-write))
    (slot coordenadaY (type FLOAT) (create-accessor read-write))
    (slot latitud (type FLOAT) (create-accessor read-write))
    (slot longitud (type FLOAT) (create-accessor read-write))
)

;;; ============================================================
;;; CLASSE: Servei (i subclasses)
;;; ============================================================
(defclass Servei "Servei o equipament urba"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot nomServei (type STRING) (create-accessor read-write))
    (slot teLocalitzacio (type INSTANCE) (create-accessor read-write))
    (slot horariObertura (type STRING) (create-accessor read-write))
    (slot horariTancament (type STRING) (create-accessor read-write))
)

;;; Transport Public
(defclass TransportPublic (is-a Servei) (role concrete) (pattern-match reactive))
(defclass EstacioMetro (is-a TransportPublic) (role concrete) (pattern-match reactive))
(defclass EstacioTren (is-a TransportPublic) (role concrete) (pattern-match reactive))
(defclass ParadaBus (is-a TransportPublic) (role concrete) (pattern-match reactive))

;;; Servei Salut
(defclass ServeiSalut (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Hospital (is-a ServeiSalut) (role concrete) (pattern-match reactive))
(defclass CentreSalut (is-a ServeiSalut) (role concrete) (pattern-match reactive))
(defclass Farmacia (is-a ServeiSalut) (role concrete) (pattern-match reactive))

;;; Servei Educatiu
(defclass ServeiEducatiu (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Escola (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))
(defclass Institut (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))
(defclass Universitat (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))
(defclass LlarInfants (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))

;;; Servei Comercial
(defclass ServeiComercial (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Supermercat (is-a ServeiComercial) (role concrete) (pattern-match reactive))
(defclass Hipermercat (is-a ServeiComercial) (role concrete) (pattern-match reactive))
(defclass CentreComercial (is-a ServeiComercial) (role concrete) (pattern-match reactive))
(defclass Mercat (is-a ServeiComercial) (role concrete) (pattern-match reactive))

;;; Zona Verda
(defclass ZonaVerda (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Parc (is-a ZonaVerda) (role concrete) (pattern-match reactive))
(defclass Jardi (is-a ZonaVerda) (role concrete) (pattern-match reactive))
(defclass ZonaEsportiva (is-a ZonaVerda) (role concrete) (pattern-match reactive))

;;; Servei Oci
(defclass ServeiOci (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Cinema (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Teatre (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Gimnas (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Restaurant (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Bar (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass ZonaNocturna (is-a ServeiOci) (role concrete) (pattern-match reactive))

;;; Servei Molest
(defclass ServeiMolest (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Discoteca (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass Estadi (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass Aeroport (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass ZonaIndustrial (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass Autopista (is-a ServeiMolest) (role concrete) (pattern-match reactive))

;;; ============================================================
;;; CLASSE: Habitatge (i subclasses)
;;; ============================================================
(defclass Habitatge "Habitatge disponible per llogar"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Relacio amb localitzacio
    (slot teLocalitzacio (type INSTANCE) (create-accessor read-write))
    ;;; Caracteristiques basiques
    (slot superficieHabitable (type FLOAT) (create-accessor read-write))
    (slot numeroDormitoris (type INTEGER) (create-accessor read-write))
    (slot numeroDormitorisDobles (type INTEGER) (create-accessor read-write))
    (slot numeroDormitorisSimples (type INTEGER) (create-accessor read-write))
    (slot numeroBanys (type INTEGER) (create-accessor read-write))
    (slot plantaPis (type INTEGER) (default 0) (create-accessor read-write))
    (slot anyConstruccio (type INTEGER) (create-accessor read-write))
    ;;; Caracteristiques booleanes (si/no)
    (slot teTerrassaOBalco (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot superficieTerrassa (type FLOAT) (default 0.0) (create-accessor read-write))
    (slot moblat (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot ambElectrodomestics (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot teAscensor (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot permetMascotes (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot teCalefaccio (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot teAireCondicionat (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot teVistes (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot tePiscinaComunitaria (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot tePlacaAparcament (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot numeroPlacesAparcament (type INTEGER) (default 0) (create-accessor read-write))
    (slot teArmariEncastat (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot teTraster (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot esExterior (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    ;;; Caracteristiques amb valors limitats
    (slot orientacioSolar (type SYMBOL) (allowed-symbols Mati Tarda TotElDia Nord) (create-accessor read-write))
    (slot tipusVistes (type SYMBOL) (allowed-symbols Mar Muntanya Ciutat Parc Cap) (default Cap) (create-accessor read-write))
    (slot consumEnergetic (type SYMBOL) (allowed-symbols A B C D E F G) (create-accessor read-write))
    (slot nivellSoroll (type SYMBOL) (allowed-symbols Baix Mitja Alt) (default Mitja) (create-accessor read-write))
    (slot estatConservacio (type SYMBOL) (allowed-symbols Nou BonEstat AReformar) (default BonEstat) (create-accessor read-write))
)

;;; Subclasses d'Habitatge
(defclass Pis (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass Atic (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass Duplex (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass Estudi (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass HabitatgeUnifamiliar (is-a Habitatge) (role concrete) (pattern-match reactive))

;;; ============================================================
;;; CLASSE: Sollicitant (i subclasses)
;;; ============================================================
(defclass Sollicitant "Persona o grup que busca habitatge de lloguer"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Dades personals
    (slot nom (type STRING) (create-accessor read-write))
    (slot edat (type INTEGER) (create-accessor read-write))
    (slot numeroPersones (type INTEGER) (default 1) (create-accessor read-write))
    ;;; Pressupost
    (slot pressupostMaxim (type FLOAT) (create-accessor read-write))
    (slot pressupostMinim (type FLOAT) (default 0.0) (create-accessor read-write))
    (slot margeEstricte (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    ;;; Familia
    (slot numeroFills (type INTEGER) (default 0) (create-accessor read-write))
    (multislot edatsFills (type INTEGER) (create-accessor read-write))  ; Aquest si que es multislot
    (slot teAvis (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot numeroAvis (type INTEGER) (default 0) (create-accessor read-write))
    ;;; Vehicle i transport
    (slot teVehicle (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot prefereixTransportPublic (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    ;;; Accessibilitat
    (slot necessitaAccessibilitat (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    ;;; Mascotes
    (slot teMascotes (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot numeroMascotes (type INTEGER) (default 0) (create-accessor read-write))
    (slot tipusMascota (type SYMBOL) (allowed-symbols Gos Gat Altres Cap) (default Cap) (create-accessor read-write))
    ;;; Treball i estudi
    (slot treballaACiutat (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot estudiaACiutat (type SYMBOL) (allowed-symbols si no) (default no) (create-accessor read-write))
    (slot llocTreball (type INSTANCE) (create-accessor read-write))
    (slot llocEstudi (type INSTANCE) (create-accessor read-write))
    ;;; Preferencies de serveis (multislot perque poden ser varis)
    (multislot requereixServei (type INSTANCE) (create-accessor read-write))
    (multislot prefereixServei (type INSTANCE) (create-accessor read-write))
    (multislot evitaServei (type INSTANCE) (create-accessor read-write))
)

;;; Subclasses de Sollicitant
(defclass Individu (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass Parella (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass ParellaSenseFills (is-a Parella) (role concrete) (pattern-match reactive))
(defclass ParellaAmbFills (is-a Parella) (role concrete) (pattern-match reactive))
(defclass ParellaFutursFills (is-a Parella) (role concrete) (pattern-match reactive))
(defclass Familia (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass FamiliaMonoparental (is-a Familia) (role concrete) (pattern-match reactive))
(defclass FamiliaBiparental (is-a Familia) (role concrete) (pattern-match reactive))
(defclass GrupEstudiants (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass PersonaGran (is-a Sollicitant) (role concrete) (pattern-match reactive))

;;; ============================================================
;;; CLASSE: Oferta
;;; ============================================================
(defclass Oferta "Oferta de lloguer d'habitatge"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Relacio amb habitatge
    (slot teHabitatge (type INSTANCE) (create-accessor read-write))
    ;;; Dades de l'oferta
    (slot preuMensual (type FLOAT) (create-accessor read-write))
    (slot disponible (type SYMBOL) (allowed-symbols si no) (default si) (create-accessor read-write))
    (slot dataPublicacio (type STRING) (create-accessor read-write))
    ;;; Resultat del sistema (s'omplira automaticament)
    (slot grauRecomanacio (type SYMBOL) (allowed-symbols Parcialment Adequat MoltRecomanable Cap) (default Cap) (create-accessor read-write))
    (multislot motiusRecomanacio (type STRING) (create-accessor read-write))
)
