;;; ---------------------------------------------------------
;;; ontologiaSBC.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaSBC.owl
;;; :Date 01/12/2025 19:05:34

(defclass Solicitant
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot nom
        (type STRING)
        (create-accessor read-write))
    (slot edat
        (type INTEGER)
        (create-accessor read-write))
    (multislot evitaServei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot requereixServei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot edatsFills
        (type INTEGER)
        (create-accessor read-write))
    (slot treballaACiutat
        (type SYMBOL)
        (create-accessor read-write))
    (slot estudiaACiutat
        (type SYMBOL)
        (create-accessor read-write))
    (slot margeEstricte
        (type SYMBOL)
        (create-accessor read-write))
    (slot necessitaAccessibilitat
        (type SYMBOL)
        (create-accessor read-write))
    (slot numeroAvis
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroFills
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroMascotes
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroPersones
        (type INTEGER)
        (create-accessor read-write))
    (slot requereixTransportPublic
        (type SYMBOL)
        (create-accessor read-write))
    (slot pressupostMaxim
        (type FLOAT)
        (create-accessor read-write))
    (slot pressupostMinim
        (type FLOAT)
        (create-accessor read-write))
    (slot teAvis
        (type SYMBOL)
        (create-accessor read-write))
    (slot teMascotes
        (type SYMBOL)
        (create-accessor read-write))
    (slot teVehicle
        (type SYMBOL)
        (create-accessor read-write))
    (slot tipusMascota
        (type STRING)
        (create-accessor read-write))
)

(defclass Familia
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass FamiliaBiparental
    (is-a Familia)
    (role concrete)
    (pattern-match reactive)
)

(defclass FamiliaMonoparental
    (is-a Familia)
    (role concrete)
    (pattern-match reactive)
)

(defclass GrupEstudiants
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Individu
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Parella
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass ParellaAmbFills
    (is-a Parella)
    (role concrete)
    (pattern-match reactive)
)

(defclass ParellaFutursFills
    (is-a Parella)
    (role concrete)
    (pattern-match reactive)
)

(defclass ParellaSenseFills
    (is-a Parella)
    (role concrete)
    (pattern-match reactive)
)

(defclass PersonaGran
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Servei
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot horariObertura
        (type STRING)
        (create-accessor read-write))
    (slot horariTancament
        (type STRING)
        (create-accessor read-write))
    (slot nomServei
        (type STRING)
        (create-accessor read-write))
    (slot teLocalitzacio
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass ServeiComercial
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass CentreComercial
    (is-a ServeiComercial)
    (role concrete)
    (pattern-match reactive)
)

(defclass Hipermercat
    (is-a ServeiComercial)
    (role concrete)
    (pattern-match reactive)
)

(defclass Mercat
    (is-a ServeiComercial)
    (role concrete)
    (pattern-match reactive)
)

(defclass Supermercat
    (is-a ServeiComercial)
    (role concrete)
    (pattern-match reactive)
)

(defclass ServeiEducatiu
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Escola
    (is-a ServeiEducatiu)
    (role concrete)
    (pattern-match reactive)
)

(defclass Institut
    (is-a ServeiEducatiu)
    (role concrete)
    (pattern-match reactive)
)

(defclass LlarInfants
    (is-a ServeiEducatiu)
    (role concrete)
    (pattern-match reactive)
)

(defclass Universitat
    (is-a ServeiEducatiu)
    (role concrete)
    (pattern-match reactive)
)

(defclass ServeiOci
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Bar
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass Cinema
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass Discoteca
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass Estadi
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass Gimnas
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass Restaurant
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass Teatre
    (is-a ServeiOci)
    (role concrete)
    (pattern-match reactive)
)

(defclass ServeiSalut
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass CentreSalut
    (is-a ServeiSalut)
    (role concrete)
    (pattern-match reactive)
)

(defclass Farmacia
    (is-a ServeiSalut)
    (role concrete)
    (pattern-match reactive)
)

(defclass Hospital
    (is-a ServeiSalut)
    (role concrete)
    (pattern-match reactive)
)

(defclass Transport
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Aeroport
    (is-a Transport)
    (role concrete)
    (pattern-match reactive)
)

(defclass Autopista
    (is-a Transport)
    (role concrete)
    (pattern-match reactive)
)

(defclass EstacioMetro
    (is-a Transport)
    (role concrete)
    (pattern-match reactive)
)

(defclass EstacioTren
    (is-a Transport)
    (role concrete)
    (pattern-match reactive)
)

(defclass ParadaBus
    (is-a Transport)
    (role concrete)
    (pattern-match reactive)
)

(defclass ZonaVerda
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Jardi
    (is-a ZonaVerda)
    (role concrete)
    (pattern-match reactive)
)

(defclass Parc
    (is-a ZonaVerda)
    (role concrete)
    (pattern-match reactive)
)

(defclass ZonaEsportiva
    (is-a ZonaVerda)
    (role concrete)
    (pattern-match reactive)
)

(defclass Habitatge
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot ambElectrodomestics
        (type SYMBOL)
        (create-accessor read-write))
    (slot anyConstruccio
        (type INTEGER)
        (create-accessor read-write))
    (slot consumEnergetic
        (type STRING)
        (create-accessor read-write))
    (slot esExterior
        (type SYMBOL)
        (create-accessor read-write))
    (slot estatConservacio
        (type STRING)
        (create-accessor read-write))
    (slot moblat
        (type SYMBOL)
        (create-accessor read-write))
    (slot nivellSoroll
        (type STRING)
        (create-accessor read-write))
    (slot numeroBanys
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroDormitoris
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroDormitorisDobles
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroDormitorisSimples
        (type INTEGER)
        (create-accessor read-write))
    (slot numeroPlacesAparcament
        (type INTEGER)
        (create-accessor read-write))
    (slot orientacioSolar
        (type STRING)
        (create-accessor read-write))
    (slot permetMascotes
        (type SYMBOL)
        (create-accessor read-write))
    (slot plantaPis
        (type INTEGER)
        (create-accessor read-write))
    (slot superficieHabitable
        (type FLOAT)
        (create-accessor read-write))
    (slot superficieTerrassa
        (type FLOAT)
        (create-accessor read-write))
    (slot teAireCondicionat
        (type SYMBOL)
        (create-accessor read-write))
    (slot teArmariEncastat
        (type SYMBOL)
        (create-accessor read-write))
    (slot teAscensor
        (type SYMBOL)
        (create-accessor read-write))
    (slot teCalefaccio
        (type SYMBOL)
        (create-accessor read-write))
    (slot tePiscinaComunitaria
        (type SYMBOL)
        (create-accessor read-write))
    (slot tePlacaAparcament
        (type SYMBOL)
        (create-accessor read-write))
    (slot teTerrassaOBalco
        (type SYMBOL)
        (create-accessor read-write))
    (slot teTraster
        (type SYMBOL)
        (create-accessor read-write))
    (slot teVistes
        (type SYMBOL)
        (create-accessor read-write))
    (slot tipusVistes
        (type STRING)
        (create-accessor read-write))
    (slot teLocalitzacio
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Atic
    (is-a Habitatge)
    (role concrete)
    (pattern-match reactive)
)

(defclass Duplex
    (is-a Habitatge)
    (role concrete)
    (pattern-match reactive)
)

(defclass Estudi
    (is-a Habitatge)
    (role concrete)
    (pattern-match reactive)
)

(defclass HabitatgeUnifamiliar
    (is-a Habitatge)
    (role concrete)
    (pattern-match reactive)
)

(defclass Pis
    (is-a Habitatge)
    (role concrete)
    (pattern-match reactive)
)

(defclass Localitzacio
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot aPropDe
        (type INSTANCE)
        (create-accessor read-write))
    (slot adreca
        (type STRING)
        (create-accessor read-write))
    (slot barri
        (type STRING)
        (create-accessor read-write))
    (slot codiPostal
        (type STRING)
        (create-accessor read-write))
    (slot coordenadaX
        (type FLOAT)
        (create-accessor read-write))
    (slot coordenadaY
        (type FLOAT)
        (create-accessor read-write))
    (slot districte
        (type STRING)
        (create-accessor read-write))
)

(defclass Oferta
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot teHabitatge
        (type INSTANCE)
        (create-accessor read-write))
    (slot dataPublicacio
        (type STRING)
        (create-accessor read-write))
    (slot disponible
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Valors: Parcialment, Adequat, MoltRecomanable, Cap
    (slot grauRecomanacio
        (type STRING)
        (create-accessor read-write))
    (multislot motiusRecomanacio
        (type STRING)
        (create-accessor read-write))
    (slot preuMensual
        (type FLOAT)
        (create-accessor read-write))
)

(definstances instances
)
