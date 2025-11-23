;;; ============================================================
;;; regles.clp
;;; Sistema Expert de Recomanació d'Habitatges
;;; Fases: ABSTRACCIÓ -> RESOLUCIÓ -> REFINACIÓ
;;; ============================================================

;;; ============================================================
;;; TEMPLATES AUXILIARS
;;; ============================================================

(deftemplate proximitat
    (slot habitatge (type INSTANCE))
    (slot servei (type INSTANCE))
    (slot categoria (type SYMBOL))
    (slot distancia (type SYMBOL))  ; MoltAProp, DistanciaMitjana, Lluny
    (slot metres (type FLOAT))
)

(deftemplate requisit-inferit
    (slot sollicitant (type INSTANCE))
    (slot categoria-servei (type SYMBOL))
    (slot obligatori (type SYMBOL))
    (slot motiu (type STRING))
)

(deftemplate oferta-descartada
    (slot sollicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot motiu (type STRING))
)

(deftemplate criteri-no-cumplit
    (slot sollicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot criteri (type STRING))
    (slot gravetat (type SYMBOL))
)

(deftemplate punt-positiu
    (slot sollicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot descripcio (type STRING))
)

(deftemplate recomanacio
    (slot sollicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot grau (type SYMBOL))
    (slot puntuacio (type INTEGER))
)

(deftemplate fase-completada
    (slot nom (type SYMBOL))
)

;;; ============================================================
;;; FUNCIONS AUXILIARS
;;; ============================================================

(deffunction calcular-distancia (?x1 ?y1 ?x2 ?y2)
    (sqrt (+ (** (- ?x2 ?x1) 2) (** (- ?y2 ?y1) 2)))
)

(deffunction classificar-distancia (?metres)
    (if (< ?metres 300.0) then MoltAProp
    else (if (< ?metres 700.0) then DistanciaMitjana
    else Lluny))
)

;;; ============================================================
;;; FASE 1: ABSTRACCIÓ
;;; Inferència de requisits segons el perfil del sol·licitant
;;; ============================================================

(defrule abstraccio-calcular-proximitats
    "Calcula la proximitat entre cada habitatge i cada servei"
    (declare (salience 100))
    ?hab <- (object (is-a Habitatge) (teLocalitzacio ?locH))
    ?locHab <- (object (is-a Localitzacio) (name ?locH) (coordenadaX ?x1) (coordenadaY ?y1))
    ?serv <- (object (is-a Servei) (teLocalitzacio ?locS))
    ?locServ <- (object (is-a Localitzacio) (name ?locS) (coordenadaX ?x2) (coordenadaY ?y2))
    (not (proximitat (habitatge ?hab) (servei ?serv)))
    =>
    (bind ?metres (calcular-distancia ?x1 ?y1 ?x2 ?y2))
    (bind ?dist (classificar-distancia ?metres))
    (bind ?cat (class ?serv))
    (assert (proximitat (habitatge ?hab) (servei ?serv) (categoria ?cat) (distancia ?dist) (metres ?metres)))
)

(defrule abstraccio-familia-amb-fills
    "Les families amb fills necessiten escoles i zones verdes"
    (declare (salience 95))
    ?sol <- (object (is-a Sollicitant) (numeroFills ?fills))
    (test (> ?fills 0))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)
            (obligatori si) (motiu "Familia amb fills necessita escoles")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ZonaVerda)
            (obligatori no) (motiu "Familia amb fills prefereix zones verdes")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita escoles (te fills)" crlf)
)

(defrule abstraccio-persona-gran
    "Les persones grans necessiten serveis de salut i comercos"
    (declare (salience 95))
    ?sol <- (object (is-a PersonaGran))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiSalut)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiSalut)
            (obligatori si) (motiu "Persona gran necessita serveis de salut")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiComercial)
            (obligatori si) (motiu "Persona gran necessita comercos a prop")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita salut i comerc" crlf)
)

(defrule abstraccio-estudiants
    "Els estudiants necessiten transport i prefereixen oci"
    (declare (salience 95))
    ?sol <- (object (is-a GrupEstudiants))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)
            (obligatori si) (motiu "Estudiant necessita transport public")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiOci)
            (obligatori no) (motiu "Estudiant prefereix zones oci")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita transport" crlf)
)

(defrule abstraccio-prefereix-transport
    "Si prefereix transport public, el necessita a prop"
    (declare (salience 95))
    ?sol <- (object (is-a Sollicitant) (prefereixTransportPublic si))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)
            (obligatori si) (motiu "Prefereix transport public")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita transport public" crlf)
)

(defrule abstraccio-parella-futurs-fills
    "Parelles que planegen tenir fills prefereixen zones adequades"
    (declare (salience 95))
    ?sol <- (object (is-a ParellaFutursFills))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)
            (obligatori no) (motiu "Parella amb plans de fills prefereix escoles")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ZonaVerda)
            (obligatori no) (motiu "Parella amb plans de fills prefereix parcs")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " prefereix zones per futurs fills" crlf)
)

(defrule abstraccio-te-vehicle
    "Si te vehicle, prefereix parking"
    (declare (salience 95))
    ?sol <- (object (is-a Sollicitant) (teVehicle si))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei Parking)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei Parking)
            (obligatori no) (motiu "Te vehicle, prefereix parking")))
)

(defrule abstraccio-fi
    "Marca el final de la fase d'abstraccio"
    (declare (salience 50))
    (not (fase-completada (nom abstraccio)))
    =>
    (assert (fase-completada (nom abstraccio)))
    (printout t crlf "=== FASE ABSTRACCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 2: RESOLUCIÓ (MATCHING)
;;; Filtratge i avaluació d'ofertes
;;; ============================================================

;;; --- REGLES DE DESCART ---

(defrule resolucio-descartar-preu-excessiu
    "Descartar si preu supera maxim amb marge estricte"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim ?max) (margeEstricte si))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (> ?preu ?max))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "Preu supera pressupost maxim (estricte)")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu " ?preu " > " ?max " EUR" crlf)
)

(defrule resolucio-descartar-preu-molt-alt
    "Descartar si preu supera maxim mes del 15% (marge flexible)"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim ?max) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (> ?preu (* ?max 1.15)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "Preu supera pressupost maxim mes del 15%")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu massa alt" crlf)
)

(defrule resolucio-descartar-no-mascotes
    "Descartar si no permet mascotes i el sollicitant en te"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (teMascotes si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (permetMascotes no))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "No permet mascotes")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - No permet mascotes" crlf)
)

(defrule resolucio-descartar-no-accessible
    "Descartar si necessita accessibilitat i no es accessible"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (necessitaAccessibilitat si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 0))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "No accessible: sense ascensor i planta alta")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - No accessible" crlf)
)

(defrule resolucio-descartar-preu-sospitos
    "Descartar si preu es sospitosament baix"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMinim ?min))
    (test (> ?min 0))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (< ?preu ?min))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "Preu sospitosament baix")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu sospitos" crlf)
)

;;; --- REGLES DE CRITERIS NO COMPLERTS ---

(defrule resolucio-criteri-preu-alt
    "Preu lleugerament superior (marge flexible)"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim ?max) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (and (> ?preu ?max) (<= ?preu (* ?max 1.15))))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)
            (criteri "Preu lleugerament superior al pressupost") (gravetat Lleu)))
)

(defrule resolucio-criteri-soroll-alt
    "Habitatge amb nivell de soroll alt"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (nivellSoroll Alt))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of) (criteri "Nivell de soroll alt")))
    =>
    (assert (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)
            (criteri "Nivell de soroll alt") (gravetat Lleu)))
)

(defrule resolucio-criteri-sense-ascensor
    "Planta alta sense ascensor per persona gran"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (edat ?edat))
    (test (> ?edat 60))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 1))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of) (criteri "Planta alta sense ascensor")))
    =>
    (assert (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)
            (criteri "Planta alta sense ascensor") (gravetat Moderat)))
)

;;; --- REGLES DE PUNTS POSITIUS ---

(defrule resolucio-punt-bon-preu
    "El preu es molt bo (menys del 80% del pressupost)"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim ?max))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (< ?preu (* ?max 0.8)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Preu molt bo")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Preu molt bo")))
)

(defrule resolucio-punt-terrassa
    "L'habitatge te terrassa o balco"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teTerrassaOBalco si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te terrassa o balco")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te terrassa o balco")))
)

(defrule resolucio-punt-assolellat
    "L'habitatge es molt assolellat"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (orientacioSolar TotElDia))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
)

(defrule resolucio-punt-eficiencia
    "Alta eficiencia energetica (A o B)"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (consumEnergetic ?ce))
    (test (or (eq ?ce A) (eq ?ce B)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Alta eficiencia energetica")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Alta eficiencia energetica")))
)

(defrule resolucio-punt-exterior-silenci
    "Exterior i silencios"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (esExterior si) (nivellSoroll Baix))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Exterior i silencios")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Exterior i silencios")))
)

(defrule resolucio-punt-vistes
    "Te bones vistes"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teVistes si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
)

(defrule resolucio-punt-parking
    "Te parking i el sollicitant te vehicle"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (teVehicle si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePlacaAparcament si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te parking")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te parking")))
)

(defrule resolucio-punt-piscina
    "Te piscina comunitaria"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePiscinaComunitaria si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te piscina comunitaria")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te piscina comunitaria")))
)

(defrule resolucio-punt-transport-aprop
    "Transport public molt a prop"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp))
    (test (or (eq ?cat EstacioMetro) (eq ?cat ParadaBus) (eq ?cat EstacioTren)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Transport public molt a prop")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Transport public molt a prop")))
)

(defrule resolucio-fi
    "Marca el final de la fase de resolucio"
    (declare (salience 10))
    (fase-completada (nom abstraccio))
    (not (fase-completada (nom resolucio)))
    =>
    (assert (fase-completada (nom resolucio)))
    (printout t crlf "=== FASE RESOLUCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 3: REFINACIÓ
;;; Classificació final de les ofertes
;;; ============================================================

(defrule refinacio-molt-recomanable
    "MOLT RECOMANABLE: sense negatius i 3+ positius"
    (declare (salience 5))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?d1))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?d2&~?d1))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?d3&~?d1&~?d2))
    (not (recomanacio (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (sollicitant ?sol) (oferta ?of) (grau MoltRecomanable) (puntuacio 100)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> MOLT RECOMANABLE per " (instance-name ?sol) crlf)
)

(defrule refinacio-adequat
    "ADEQUAT: compleix tot sense destacar"
    (declare (salience 4))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)))
    (not (recomanacio (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (sollicitant ?sol) (oferta ?of) (grau Adequat) (puntuacio 70)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> ADEQUAT per " (instance-name ?sol) crlf)
)

(defrule refinacio-parcialment
    "PARCIALMENT ADEQUAT: te algun criteri no complert"
    (declare (salience 3))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (criteri-no-cumplit (sollicitant ?sol) (oferta ?of))
    (not (recomanacio (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (sollicitant ?sol) (oferta ?of) (grau Parcialment) (puntuacio 50)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> PARCIALMENT per " (instance-name ?sol) crlf)
)

(defrule refinacio-fi
    "Marca el final de la fase de refinacio"
    (declare (salience 0))
    (fase-completada (nom resolucio))
    (not (fase-completada (nom refinacio)))
    =>
    (assert (fase-completada (nom refinacio)))
    (printout t crlf "=== FASE REFINACIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; PRESENTACIÓ DE RESULTATS
;;; ============================================================

(defrule presentacio-inici
    "Mostra l'encapcalament dels resultats"
    (declare (salience -10))
    (fase-completada (nom refinacio))
    (not (fase-completada (nom presentacio)))
    =>
    (assert (fase-completada (nom presentacio)))
    (printout t crlf)
    (printout t "================================================================" crlf)
    (printout t "          RESULTATS DEL SISTEMA DE RECOMANACIO                  " crlf)
    (printout t "================================================================" crlf)
)

(defrule presentacio-recomanacio
    "Mostra cada recomanacio amb detalls"
    (declare (salience -20))
    (fase-completada (nom presentacio))
    (recomanacio (sollicitant ?sol) (oferta ?of) (grau ?grau) (puntuacio ?punt))
    ?oferta <- (object (is-a Oferta) (name ?of) (preuMensual ?preu) (teHabitatge ?hab))
    ?habitatge <- (object (is-a Habitatge) (name ?hab)
            (superficieHabitable ?sup)
            (numeroDormitoris ?dorm)
            (numeroBanys ?banys)
            (teLocalitzacio ?loc))
    ?localitzacio <- (object (is-a Localitzacio) (name ?loc) (adreca ?adreca) (barri ?barri))
    =>
    (printout t crlf)
    (printout t "----------------------------------------------------------------" crlf)
    (printout t "SOLLICITANT: " (instance-name ?sol) crlf)
    (printout t "OFERTA: " (instance-name ?of) crlf)
    (printout t "----------------------------------------------------------------" crlf)
    (printout t "*** GRAU: " ?grau " *** (Puntuacio: " ?punt ")" crlf)
    (printout t "----------------------------------------------------------------" crlf)
    (printout t "Tipus: " (class ?hab) crlf)
    (printout t "Superficie: " ?sup " m2" crlf)
    (printout t "Dormitoris: " ?dorm " | Banys: " ?banys crlf)
    (printout t "Preu: " ?preu " EUR/mes" crlf)
    (printout t "Adreca: " ?adreca crlf)
    (printout t "Barri: " ?barri crlf)
    (printout t "----------------------------------------------------------------" crlf)
)

(defrule presentacio-punts-positius
    "Mostra els punts positius de cada recomanacio"
    (declare (salience -21))
    (fase-completada (nom presentacio))
    (recomanacio (sollicitant ?sol) (oferta ?of))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?desc))
    =>
    (printout t "  [+] " ?desc crlf)
)

(defrule presentacio-criteris-negatius
    "Mostra els criteris no complerts per ofertes parcials"
    (declare (salience -22))
    (fase-completada (nom presentacio))
    (recomanacio (sollicitant ?sol) (oferta ?of) (grau Parcialment))
    (criteri-no-cumplit (sollicitant ?sol) (oferta ?of) (criteri ?crit) (gravetat ?grav))
    =>
    (printout t "  [-] " ?crit " (" ?grav ")" crlf)
)

(defrule presentacio-descartades
    "Mostra les ofertes descartades"
    (declare (salience -30))
    (fase-completada (nom presentacio))
    (oferta-descartada (sollicitant ?sol) (oferta ?of) (motiu ?motiu))
    =>
    (printout t crlf "[DESCARTADA] " (instance-name ?of) " per " (instance-name ?sol) ": " ?motiu crlf)
)

(defrule presentacio-fi
    "Mostra el final del proces"
    (declare (salience -100))
    (fase-completada (nom presentacio))
    (not (fase-completada (nom fi)))
    =>
    (assert (fase-completada (nom fi)))
    (printout t crlf)
    (printout t "================================================================" crlf)
    (printout t "                      FI DEL PROCES                             " crlf)
    (printout t "================================================================" crlf)
)
