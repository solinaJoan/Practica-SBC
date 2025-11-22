;;; ---------------------------------------------------------
;;; ontologiaSBC.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaSBC.ttl
;;; :Date 22/11/2025 13:42:24

(defclass Sollicitant "Persona o grup que busca habitatge de lloguer"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Lloc on estudia el sol·licitant
    (multislot estudiaA
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Servei que el sol·licitant prefereix evitar
    (multislot evitaServei
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Servei que el sol·licitant prefereix tenir a prop
    (multislot prefereixServei
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Servei que el sol·licitant requereix a prop
    (multislot requereixServei
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Oferta sol·licitada pel sol·licitant
    (multislot sollicitaOferta
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Lloc on treballa el sol·licitant
    (multislot treballaA
        (type INSTANCE)
        (create-accessor read-write))
    (multislot edatSollicitant
        (type INTEGER)
        (create-accessor read-write))
    (multislot edatsFills
        (type INTEGER)
        (create-accessor read-write))
    (multislot estudiaACiutat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot margeEstricte
        (type SYMBOL)
        (create-accessor read-write))
    (multislot necessitaAccessibilitat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot numeroAvis
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroFills
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroMascotes
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroPersones
        (type INTEGER)
        (create-accessor read-write))
    (multislot prefereixTransportPublic
        (type SYMBOL)
        (create-accessor read-write))
    (multislot pressupostMaxim
        (type FLOAT)
        (create-accessor read-write))
    (multislot pressupostMinim
        (type FLOAT)
        (create-accessor read-write))
    (multislot teAvis
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teMascotes
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teVehicle
        (type SYMBOL)
        (create-accessor read-write))
    (multislot tipusMascota
        (type SYMBOL)
        (create-accessor read-write))
    (multislot treballaACiutat
        (type SYMBOL)
        (create-accessor read-write))
)

;;; --- Subclasses de Sollicitant ---

(defclass Familia (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass FamiliaBiparental (is-a Familia) (role concrete) (pattern-match reactive))
(defclass FamiliaMonoparental (is-a Familia) (role concrete) (pattern-match reactive))
(defclass GrupEstudiants (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass Individu (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass Parella (is-a Sollicitant) (role concrete) (pattern-match reactive))
(defclass ParellaAmbFills (is-a Parella) (role concrete) (pattern-match reactive))
(defclass ParellaFutursFills (is-a Parella) (role concrete) (pattern-match reactive))
(defclass ParellaSenseFills (is-a Parella) (role concrete) (pattern-match reactive))
(defclass PersonaGran (is-a Sollicitant) (role concrete) (pattern-match reactive))

;;; ---------------------------------

(defclass Habitatge "Habitatge disponible per llogar"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ambElectrodomestics
        (type SYMBOL)
        (create-accessor read-write))
    (multislot anyConstruccio
        (type INTEGER)
        (create-accessor read-write))
    ;;; Certificat energètic: A, B, C... (Symbol)
    (multislot consumEnergetic
        (type SYMBOL)
        (create-accessor read-write))
    (multislot esExterior
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Valors: Nou, BonEstat, AReformar (Symbol)
    (multislot estatConservacio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot moblat
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Valors: Baix, Mitja, Alt (Symbol)
    (multislot nivellSoroll
        (type SYMBOL)
        (create-accessor read-write))
    (multislot numeroBanys
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroDormitoris
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroDormitorisDobles
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroDormitorisSimples
        (type INTEGER)
        (create-accessor read-write))
    (multislot numeroPlacesAparcament
        (type INTEGER)
        (create-accessor read-write))
    ;;; Valors: Mati, Tarda, TotElDia, Nord (Symbol)
    (multislot orientacioSolar
        (type SYMBOL)
        (create-accessor read-write))
    (multislot permetMascotes
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Planta del pis (0=entresol, 1=primer, etc.)
    (multislot plantaPis
        (type INTEGER)
        (create-accessor read-write))
    (multislot superficieHabitable
        (type FLOAT)
        (create-accessor read-write))
    (multislot superficieTerrassa
        (type FLOAT)
        (create-accessor read-write))
    (multislot teAireCondicionat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teArmariEncastat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teAscensor
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teCalefaccio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot tePiscinaComunitaria
        (type SYMBOL)
        (create-accessor read-write))
    (multislot tePlacaAparcament
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teTerrassaOBalco
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teTraster
        (type SYMBOL)
        (create-accessor read-write))
    (multislot teVistes
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Valors: Mar, Muntanya, Ciutat, Parc (Symbol)
    (multislot tipusVistes
        (type SYMBOL)
        (create-accessor read-write))
    (slot teLocalitzacio
        (type INSTANCE)
        (create-accessor read-write))
)

;;; --- Subclasses de Habitatge ---

(defclass Atic (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass Duplex (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass Estudi (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass HabitatgeUnifamiliar (is-a Habitatge) (role concrete) (pattern-match reactive))
(defclass Pis (is-a Habitatge) (role concrete) (pattern-match reactive))

;;; --- Classes Auxiliars ---

(defclass Dormitori (is-a USER) (role concrete) (pattern-match reactive))
(defclass DormitoriDoble (is-a Dormitori) (role concrete) (pattern-match reactive))
(defclass DormitoriSimple (is-a Dormitori) (role concrete) (pattern-match reactive))

;;; --- Serveis ---

(defclass Servei "Servei o equipament urbà"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot horariObertura
        (type STRING)
        (create-accessor read-write))
    (multislot horariTancament
        (type STRING)
        (create-accessor read-write))
    (multislot nomServei
        (type STRING)
        (create-accessor read-write))
    (slot teLocalitzacio
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass ServeiComercial (is-a Servei) (role concrete) (pattern-match reactive))
(defclass CentreComercial (is-a ServeiComercial) (role concrete) (pattern-match reactive))
(defclass Hipermercat (is-a ServeiComercial) (role concrete) (pattern-match reactive))
(defclass Mercat (is-a ServeiComercial) (role concrete) (pattern-match reactive))
(defclass Supermercat (is-a ServeiComercial) (role concrete) (pattern-match reactive))

(defclass ServeiEducatiu (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Escola (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))
(defclass Institut (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))
(defclass LlarInfants (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))
(defclass Universitat (is-a ServeiEducatiu) (role concrete) (pattern-match reactive))

(defclass ServeiMolest (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Aeroport (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass Autopista (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass Discoteca (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass Estadi (is-a ServeiMolest) (role concrete) (pattern-match reactive))
(defclass ZonaIndustrial (is-a ServeiMolest) (role concrete) (pattern-match reactive))

(defclass ServeiOci (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Bar (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Cinema (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Gimnas (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Restaurant (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass Teatre (is-a ServeiOci) (role concrete) (pattern-match reactive))
(defclass ZonaNocturna (is-a ServeiOci) (role concrete) (pattern-match reactive))

(defclass ServeiSalut (is-a Servei) (role concrete) (pattern-match reactive))
(defclass CentreSalut (is-a ServeiSalut) (role concrete) (pattern-match reactive))
(defclass Farmacia (is-a ServeiSalut) (role concrete) (pattern-match reactive))
(defclass Hospital (is-a ServeiSalut) (role concrete) (pattern-match reactive))

(defclass TransportPublic (is-a Servei) (role concrete) (pattern-match reactive))
(defclass EstacioMetro (is-a TransportPublic) (role concrete) (pattern-match reactive))
(defclass EstacioTren (is-a TransportPublic) (role concrete) (pattern-match reactive))
(defclass ParadaBus (is-a TransportPublic) (role concrete) (pattern-match reactive))

(defclass ZonaVerda (is-a Servei) (role concrete) (pattern-match reactive))
(defclass Jardi (is-a ZonaVerda) (role concrete) (pattern-match reactive))
(defclass Parc (is-a ZonaVerda) (role concrete) (pattern-match reactive))
(defclass ZonaEsportiva (is-a ZonaVerda) (role concrete) (pattern-match reactive))

;;; --- Localitzacio ---

(defclass Localitzacio "Localització geogràfica"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot aPropDe
        (type INSTANCE)
        (create-accessor read-write))
    (multislot adreca
        (type STRING)
        (create-accessor read-write))
    (multislot barri
        (type SYMBOL)
        (create-accessor read-write))
    (multislot codiPostal
        (type STRING)
        (create-accessor read-write))
    (multislot coordenadaX
        (type FLOAT)
        (create-accessor read-write))
    (multislot coordenadaY
        (type FLOAT)
        (create-accessor read-write))
    (multislot districte
        (type SYMBOL)
        (create-accessor read-write))
    (multislot latitud
        (type FLOAT)
        (create-accessor read-write))
    (multislot longitud
        (type FLOAT)
        (create-accessor read-write))
)

;;; --- Oferta ---

(defclass Oferta "Oferta de lloguer d'habitatge"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot compleixRequisit
        (type INSTANCE)
        (create-accessor read-write))
    (slot teHabitatge
        (type INSTANCE)
        (create-accessor read-write))
    (multislot dataPublicacio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot disponible
        (type SYMBOL)
        (create-accessor read-write))
    (multislot grauRecomanacio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot motiusRecomanacio
        (type STRING)
        (create-accessor read-write))
    (multislot preuMensual
        (type FLOAT)
        (create-accessor read-write))
)

(definstances instances
)
