;;; ---------------------------------------------------------
;;; ontologiaSBC.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaSBC.owl
;;; :Date 01/12/2025 19:05:34

(defclass Solicitant
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot evitaServei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot llocEstudi
        (type INSTANCE)
        (create-accessor read-write))
    (multislot llocTreball
        (type INSTANCE)
        (create-accessor read-write))
    (multislot prefereixServei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot requereixServei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot edat
        (type INTEGER)
        (create-accessor read-write))
    ;;; Llista d'edats (multislot en CLIPS)
    (multislot edatsFills
        (type STRING)
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
    (multislot nom
        (type STRING)
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
        (type STRING)
        (create-accessor read-write))
    (multislot treballaACiutat
        (type SYMBOL)
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
    (multislot ambElectrodomestics
        (type SYMBOL)
        (create-accessor read-write))
    (multislot anyConstruccio
        (type INTEGER)
        (create-accessor read-write))
    (multislot consumEnergetic
        (type STRING)
        (create-accessor read-write))
    (multislot esExterior
        (type SYMBOL)
        (create-accessor read-write))
    (multislot estatConservacio
        (type STRING)
        (create-accessor read-write))
    (multislot moblat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot nivellSoroll
        (type STRING)
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
    (multislot orientacioSolar
        (type STRING)
        (create-accessor read-write))
    (multislot permetMascotes
        (type SYMBOL)
        (create-accessor read-write))
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
    (multislot tipusVistes
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
    (multislot aPropDe
        (type INSTANCE)
        (create-accessor read-write))
    (multislot adreca
        (type STRING)
        (create-accessor read-write))
    (multislot barri
        (type STRING)
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
    (multislot dataPublicacio
        (type STRING)
        (create-accessor read-write))
    (multislot disponible
        (type SYMBOL)
        (create-accessor read-write))
    ;;; Valors: Parcialment, Adequat, MoltRecomanable, Cap
    (multislot grauRecomanacio
        (type STRING)
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
