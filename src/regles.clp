;;; ============================================================
;;; regles.clp
;;; VERSIÓ COMPLETA I CORREGIDA (Restaurada original + Fixes)
;;; ============================================================

;;; --- TEMPLATES ---

(deftemplate proximitat
    (slot habitatge (type INSTANCE))
    (slot servei (type INSTANCE))
    (slot categoria (type SYMBOL))
    (slot distancia (type SYMBOL))
    (slot metres (type FLOAT))
)

(deftemplate requisit-inferit
    (slot solicitant (type INSTANCE))
    (slot categoria-servei (type SYMBOL))
    (slot obligatori (type SYMBOL))
    (slot motiu (type STRING))
)

(deftemplate oferta-descartada
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot motiu (type STRING))
)

(deftemplate criteri-no-cumplit
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot criteri (type STRING))
    (slot gravetat (type SYMBOL))
)

(deftemplate punt-positiu
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot descripcio (type STRING))
)

(deftemplate recomanacio
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot grau (type SYMBOL))
    (slot puntuacio (type INTEGER))
)

(deftemplate fase-completada (slot nom (type SYMBOL)))

;;; --- FUNCIONS AUXILIARS ---

(deffunction calcular-distancia (?x1 ?y1 ?x2 ?y2)
    (sqrt (+ (** (- ?x2 ?x1) 2) (** (- ?y2 ?y1) 2)))
)

(deffunction classificar-distancia (?metres)
    (if (< ?metres 100.0) then MoltAProp
    else (if (< ?metres 500.0) then DistanciaMitjana
    else Lluny))
)

;;; ============================================================
;;; FASE 1: ABSTRACCIÓ
;;; ============================================================

(defrule abstraccio-calcular-proximitats
    "Calcula la proximitat base entre habitatges i serveis"
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

(defrule abstraccio-expandir-categories
    "FIX: Expandeix categories pare per evitar resultats buits"
    (declare (salience 99))
    (proximitat (habitatge ?h) (servei ?s) (categoria ?cat) (distancia ?d) (metres ?m))
    =>
    ;; Transport
    (if (or (eq ?cat EstacioMetro) (eq ?cat ParadaBus) (eq ?cat EstacioTren) (eq ?cat Aeroport)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria Transport) (distancia ?d) (metres ?m))))
    ;; Educacio
    (if (or (eq ?cat Escola) (eq ?cat Universitat) (eq ?cat Institut) (eq ?cat LlarInfants)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria ServeiEducatiu) (distancia ?d) (metres ?m))))
    ;; Comercial
    (if (or (eq ?cat Supermercat) (eq ?cat Mercat) (eq ?cat CentreComercial) (eq ?cat Hipermercat)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria ServeiComercial) (distancia ?d) (metres ?m))))
    ;; ZonaVerda
    (if (or (eq ?cat Parc) (eq ?cat Jardi) (eq ?cat ZonaEsportiva)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria ZonaVerda) (distancia ?d) (metres ?m))))
    ;; ServeiSalut
    (if (or (eq ?cat Farmacia) (eq ?cat CentreSalut) (eq ?cat Hospital)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria ServeiSalut) (distancia ?d) (metres ?m))))
    ;; ServeiOci
    (if (or (eq ?cat Bar) (eq ?cat Restaurant) (eq ?cat Cinema) (eq ?cat Teatre) (eq ?cat Discoteca) (eq ?cat Gimnas)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria ServeiOci) (distancia ?d) (metres ?m))))
)

(defrule abstraccio-familia-amb-fills
    (declare (salience 95))
    ?sol <- (object (is-a Solicitant) (numeroFills ?fills))
    (test (> ?fills 0))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu) (obligatori si) (motiu "Familia amb fills necessita escoles")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda) (obligatori no) (motiu "Familia amb fills prefereix zones verdes")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] necessita escoles (te fills)" crlf)
)

(defrule abstraccio-persona-gran
    (declare (salience 95))
    ?sol <- (object (is-a PersonaGran))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiSalut)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiSalut) (obligatori si) (motiu "Persona gran necessita serveis de salut")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiComercial) (obligatori si) (motiu "Persona gran necessita comercos a prop")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] necessita salut i comerc" crlf)
)

(defrule abstraccio-estudiants
    (declare (salience 95))
    ?sol <- (object (is-a GrupEstudiants))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei Transport)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei Transport) (obligatori si) (motiu "Estudiant necessita transport public")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci) (obligatori no) (motiu "Estudiant prefereix zones oci")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] necessita transport" crlf)
)

(defrule abstraccio-requereix-transport
    (declare (salience 95))
    ?sol <- (object (is-a Solicitant) (requereixTransportPublic si))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei Transport)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei Transport) (obligatori si) (motiu "Prefereix transport public")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] necessita transport public" crlf)
)

(defrule abstraccio-parella-futurs-fills
    (declare (salience 95))
    ?sol <- (object (is-a ParellaFutursFills))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu) (obligatori no) (motiu "Parella amb plans de fills prefereix escoles")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda) (obligatori no) (motiu "Parella amb plans de fills prefereix parcs")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] prefereix zones per futurs fills" crlf)
)

(defrule abstraccio-individu-jove
    (declare (salience 95))
    ?sol <- (object (is-a Individu) (edat ?e))
    (test (and (>= ?e 18) (<= ?e 35)))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci) (obligatori no) (motiu "Individu jove prefereix zones oci")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] prefereix oci (jove)" crlf)
)

(defrule abstraccio-parella-sense-fills
    (declare (salience 95))
    ?sol <- (object (is-a ParellaSenseFills))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda) (obligatori no) (motiu "Parella prefereix zones tranquil·les")))
    (printout t "[ABSTRACCIO] [" (send ?sol get-nom) "] prefereix zones tranquil·les" crlf)
)

(defrule abstraccio-fi
    (declare (salience 50))
    (not (fase-completada (nom abstraccio)))
    =>
    (assert (fase-completada (nom abstraccio)))
    (printout t crlf "=== FASE ABSTRACCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 2: RESOLUCIÓ (DESCARTAR)
;;; ============================================================

(defrule resolucio-descartar-preu-marge-estricte
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min) (margeEstricte si))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (or (> ?preu ?max) (< ?preu ?min)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Preu supera pressupost maxim (estricte)")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> Preu " ?preu " (Max " ?max ")" crlf)
)

(defrule resolucio-descartar-preu-marge-flexible
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (or (> ?preu (* ?max 1.15)) (< ?preu (* ?min 0.85))))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Preu supera pressupost maxim mes del 15%")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> Preu " ?preu " excessiu" crlf)
)

(defrule resolucio-descartar-no-mascotes
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (teMascotes si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (permetMascotes no))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "No permet mascotes")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> No mascotes" crlf)
)

(defrule resolucio-descartar-no-accessible
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (necessitaAccessibilitat si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 0))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "No accessible: sense ascensor i planta alta")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> No accessible" crlf)
)

(defrule resolucio-descartar-servei-evitat
    (declare (salience 45))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (evitaServei $? ?serveiEvitat $?))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (servei ?serveiEvitat) (distancia MoltAProp))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu (str-cat "Està massa a prop d'un servei evitat: " (instance-name ?serveiEvitat)))))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> Servei evitat a prop" crlf)
)

(defrule resolucio-descartar-falta-requisit-inferit
    (declare (salience 42))
    (fase-completada (nom abstraccio))
    (requisit-inferit (solicitant ?sol) (categoria-servei ?cat) (obligatori si) (motiu ?motiuTxt))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (not (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp|DistanciaMitjana)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu (str-cat "Falta servei obligatori (" ?cat "): " ?motiuTxt))))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> Falta " ?cat crlf)
)

(defrule resolucio-descartar-superficie-insuficient
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (numeroPersones ?npers))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (superficieHabitable ?sup))
    (test (< ?sup (* ?npers 10)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Superficie insuficient per al nombre de persones")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> Massa petit" crlf)
)

(defrule resolucio-descartar-estudiant-sense-mobles
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a GrupEstudiants))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (moblat no))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Estudiants necessiten habitatge moblat")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (send ?sol get-nom) " -> No moblat (estudiant)" crlf)
)

(defrule resolucio-fi
    (declare (salience 10))
    (fase-completada (nom abstraccio))
    (not (fase-completada (nom resolucio)))
    =>
    (assert (fase-completada (nom resolucio)))
    (printout t crlf "=== FASE RESOLUCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 3: REFINACIÓ (PUNTS POSITIUS DETALLATS)
;;; ============================================================

(defrule resolucio-criteri-preu-alt
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (and (> ?preu ?max) (<= ?preu (* ?max 1.15))))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (solicitant ?sol) (oferta ?of) (criteri "Preu lleugerament superior al pressupost")))
    =>
    (assert (criteri-no-cumplit (solicitant ?sol) (oferta ?of) (criteri "Preu lleugerament superior al pressupost") (gravetat Lleu)))
)

(defrule resolucio-criteri-soroll-alt
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (nivellSoroll ?ns))
    (test (eq ?ns "Alt"))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (solicitant ?sol) (oferta ?of) (criteri "Nivell de soroll alt")))
    =>
    (assert (criteri-no-cumplit (solicitant ?sol) (oferta ?of) (criteri "Nivell de soroll alt") (gravetat Lleu)))
)

(defrule resolucio-criteri-sense-ascensor
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (edat ?edat))
    (test (> ?edat 60))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 1))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (solicitant ?sol) (oferta ?of) (criteri "Planta alta sense ascensor")))
    =>
    (assert (criteri-no-cumplit (solicitant ?sol) (oferta ?of) (criteri "Planta alta sense ascensor") (gravetat Moderat)))
)

(defrule resolucio-punt-bon-preu
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (< ?preu (* ?max 0.8)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Preu molt bo (>20% estalvi)")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Preu molt bo (>20% estalvi)")))
)

(defrule resolucio-punt-terrassa
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teTerrassaOBalco si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te terrassa o balco")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te terrassa o balco")))
)

(defrule resolucio-punt-assolellat
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (orientacioSolar ?os))
    (test (eq ?os "TotElDia"))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
)

(defrule resolucio-punt-eficiencia
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (consumEnergetic ?ce))
    (test (or (eq ?ce "A") (eq ?ce "B")))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Alta eficiencia energetica")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Alta eficiencia energetica")))
)

(defrule resolucio-punt-exterior-silenci
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (esExterior si) (nivellSoroll ?ns))
    (test (eq ?ns "Baix"))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Exterior i silencios")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Exterior i silencios")))
)

(defrule resolucio-punt-vistes
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teVistes si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
)

(defrule resolucio-punt-parking
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePlacaAparcament si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te parking")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te parking")))
)

(defrule resolucio-punt-piscina
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePiscinaComunitaria si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te piscina comunitaria")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te piscina comunitaria")))
)

(defrule resolucio-punt-transport-aprop
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp))
    (test (or (eq ?cat EstacioMetro) (eq ?cat ParadaBus) (eq ?cat EstacioTren) (eq ?cat Transport)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Transport public molt a prop")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Transport public molt a prop")))
)

(defrule resolucio-punt-requisit-inferit-cat
    (declare (salience 32))
    (fase-completada (nom abstraccio))
    (requisit-inferit (solicitant ?sol) (categoria-servei ?cat) (motiu ?motiuTxt))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp|DistanciaMitjana))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d&:(str-index ?motiuTxt ?d))))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio (str-cat "Cobreix necessitat: " ?cat))))
)

(defrule resolucio-fi
    (declare (salience 10))
    (fase-completada (nom abstraccio))
    (not (fase-completada (nom resolucio)))
    =>
    (assert (fase-completada (nom resolucio)))
    (printout t crlf "=== FASE RESOLUCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 4: REFINACIÓ (CLASSIFICACIÓ ORIGINAL)
;;; ============================================================

(defrule refinacio-molt-recomanable
    (declare (salience 5))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (solicitant ?sol) (oferta ?of)))
    (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d1))
    (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d2&~?d1))
    (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d3&~?d1&~?d2))
    (not (recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (solicitant ?sol) (oferta ?of) (grau MoltRecomanable) (puntuacio 100)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> MOLT RECOMANABLE per " (send ?sol get-nom) crlf)
)

(defrule refinacio-adequat
    (declare (salience 4))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (solicitant ?sol) (oferta ?of)))
    (not (recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (solicitant ?sol) (oferta ?of) (grau Adequat) (puntuacio 70)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> ADEQUAT per " (send ?sol get-nom) crlf)
)

(defrule refinacio-parcialment
    (declare (salience 3))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (criteri-no-cumplit (solicitant ?sol) (oferta ?of))
    (not (recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (solicitant ?sol) (oferta ?of) (grau Parcialment) (puntuacio 50)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> PARCIALMENT per " (send ?sol get-nom) crlf)
)

(defrule refinacio-fi
    (declare (salience 0))
    (fase-completada (nom resolucio))
    (not (fase-completada (nom refinacio)))
    =>
    (assert (fase-completada (nom refinacio)))
    (printout t crlf "=== FASE REFINACIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 5: PRESENTACIÓ (AMB NOMS REALS I FILTRES)
;;; ============================================================

(defrule presentacio-inici
    (declare (salience -10))
    (fase-completada (nom refinacio))
    (not (fase-completada (nom presentacio)))
    =>
    (assert (fase-completada (nom presentacio)))
    (printout t crlf)
    (printout t "================================================================" crlf)
    (printout t "          RESULTATS DEL SISTEMA DE RECOMANACIO                  " crlf)
    (printout t "================================================================" crlf)
    (printout t crlf)
)

(defrule presentacio-recomanacio
    (declare (salience -20))
    (fase-completada (nom presentacio))
    ?rec <- (recomanacio (solicitant ?sol) (oferta ?of) (grau ?grau) (puntuacio ?punt))
    (not (and (mostrar-nomes ?target) (test (neq ?target ?sol))))
    =>
    (bind ?nom-real (send ?sol get-nom))
    (bind ?habitatge (send ?of get-teHabitatge))
    (bind ?localitzacio (send ?habitatge get-teLocalitzacio))
    (bind ?preu (send ?of get-preuMensual))
    (bind ?tipus (class ?habitatge))
    (bind ?sup (send ?habitatge get-superficieHabitable))
    (bind ?dorm (send ?habitatge get-numeroDormitoris))
    (bind ?banys (send ?habitatge get-numeroBanys))
    (bind ?adreca (send ?localitzacio get-adreca))
    (bind ?districte (send ?localitzacio get-districte))
    
    (printout t crlf)
    (printout t "----------------------------------------------------------------" crlf)
    (printout t "SOL·LICITANT: " ?nom-real crlf)
    (printout t "OFERTA: " ?of crlf)
    (printout t "----------------------------------------------------------------" crlf)
    (printout t "*** GRAU: " ?grau " *** (Puntuacio: " ?punt ")" crlf)
    (printout t "----------------------------------------------------------------" crlf)
    (printout t "Tipus: " ?tipus crlf)
    (printout t "Superficie: " ?sup " m2" crlf)
    (printout t "Dormitoris: " ?dorm " | Banys: " ?banys crlf)
    (printout t "Preu: " ?preu " EUR/mes" crlf)
    (printout t "Adreca: " ?adreca crlf)
    (printout t "Districte: " ?districte crlf)
    (printout t "----------------------------------------------------------------" crlf)
    
    (do-for-all-facts ((?pp punt-positiu)) 
        (and (eq ?pp:solicitant ?sol) (eq ?pp:oferta ?of))
        (printout t "  [+] " ?pp:descripcio crlf))
    (if (eq ?grau Parcialment) then
        (do-for-all-facts ((?cn criteri-no-cumplit)) 
            (and (eq ?cn:solicitant ?sol) (eq ?cn:oferta ?of))
            (printout t "  [-] " ?cn:criteri " (" ?cn:gravetat ")" crlf)))
    (printout t crlf)
)

(defrule presentacio-fi
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