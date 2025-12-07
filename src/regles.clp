;;; ============================================================
;;; regles.clp
;;; Sistema Expert de Recomanació d'Habitatges
;;; Fases: ABSTRACCIÓ -> RESOLUCIÓ -> REFINACIÓ
;;; ============================================================

;;; ============================================================
;;; TEMPLATES AUXILIARS
;;; ============================================================

(defglobal ?*DEBUG* = TRUE)

(deftemplate proximitat
    (slot habitatge (type INSTANCE))
    (slot servei (type INSTANCE))
    (slot categoria (type SYMBOL))
    (slot distancia (type SYMBOL))  ; MoltAProp, DistanciaMitjana, Lluny
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

(deftemplate criteri-no-complert
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
    (slot puntuacio (type INTEGER) (default 0))
)


;;; Versió amb puntuacions
;; De moment lo de la puntuacio funcionaria amb aquests deftemplates
(deftemplate proximitat
    (slot habitatge (type INSTANCE))
    (slot servei (type INSTANCE))
    (slot categoria (type SYMBOL))
    (slot distancia (type SYMBOL))  ; MoltAProp, DistanciaMitjana, Lluny
    (slot metres (type FLOAT))
)

; Per no executar la mateixa regla i que entri en bucle infinit
(deftemplate criteriAplicat
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot criteri (type SYMBOL))
)

; Estructura de dades que guarda la puntuacio per cada 
(deftemplate Recomanacio
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot puntuacio (type INTEGER) (default 0))
    (slot grau (type STRING) (default "neutre"))
)

(deftemplate fase-completada
    (slot nom (type SYMBOL))
)

;; Proposta Joan:
; El de proximitat i aquest, que a recomanacions és una nova classe que ja té grau de recomanacio i puntuacio.
; Es simplement un template amb cada usuari, i per cada usuari un vector de recomanacions. A les regles, per cada oferta que compleixi les restriccions, pujem 10 punts a l'oferta i restem si no compleix alguna restriccio. 

; Lo dels requisits inferits al final son serveis que podem posar directament al multislot de requereix servei a l'usuari, no cal un deftemplate de requisit inferit.

; Oferta descartada tambe ho podem mantenir amb nomes aquest deftemplate de recomanacions, al motiu o amb una puntuacio super negativa

; Falta documentar la nova classe al fitxer classes.txt, si fem el que estic dient canviar bastant tot el regles (jo ho puc fer pero avui no), i sobretot falta gestionar la creació de l'usuari. Ara mateix es crea al main com a classe solicitant i a les regles fem servir les subclasses. Per mi tenim dos opcions, que en ves de ser via subclasses sigui un slot de categoria, un string, i així  facil d'assignar mes tard de la creacio, a la fase d'abstraccio seria ideal, o l'altra opció es continuar amb susbclasses, pero llavors al main abans de la creacio hauriem de fer una classficacio segons el que han dit i fer la creacio del tipus de solicitant que sigui. 

; Jo faria l'opcio de que sigui una categoria dins els atributs, perque no li veig sentit a fer subclasses sobretot si no tenen atributs diferents entre elles, i posats a canviar el regles.clp doncs també es pot fer. 

; Sigui com sigui, li hauriem de donar una volta a les categories que tenim, i canviar-les perque tinguin sentit i siguin coherents (jo potser afegiria una categoria de inversor o comprador de segones residencies o aixi, i afegiria un atribut a la classe habitatge que sigui necessitaReforma, donar mes suc tambe a la practica)

(deftemplate recomanacions
    (slot solicitant (type INSTANCE))
    (multislot recomanacions (type INSTANCE))
)

;;; ============================================================
;;; FUNCIONS AUXILIARS
;;; ============================================================

(deffunction debug-print ($?msg)
   (if ?*DEBUG*
      then
         (printout t $?msg crlf)
   )
)

(deffunction calcular-distancia (?x1 ?y1 ?x2 ?y2)
    (sqrt (+ (** (- ?x2 ?x1) 2) (** (- ?y2 ?y1) 2)))
)

(deffunction classificar-distancia (?metres)
    (if (< ?metres 500.0) then MoltAProp
    else (if (< ?metres 1000.0) then DistanciaMitjana
    else Lluny))
)

(defrule abstraccio-calcular-proximitats
    "Calcula la proximitat entre cada habitatge i cada servei"
    (declare (salience 110))
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

(defrule crear-recomanacions-inicials
    (declare (salience 106))
    ?sol <- (object (is-a Solicitant))
    ?of  <- (object (is-a Oferta) (disponible si))
    (not (Recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (Recomanacio (solicitant ?sol) (oferta ?of)))
)

(defrule persona-gran-accessibilitat
    (declare (salience 105))
    ?sol <- (object (is-a PersonaGran))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor ?a) (plantaPis ?p))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri accessibilitat)))
    =>
    ;; CAS ACCESSIBLE
    (if (or (eq ?p 0) (eq ?a si))
    then
        (modify ?rec (puntuacio (+ ?pts 20)) (grau "accessibilitat_alta"))
        (debug-print (instance-name ?sol) " -> " (instance-name ?of) " [-10 accessibilitat BAIXA]")
    else
        (modify ?rec (puntuacio (- ?pts 10)) (grau "accessibilitat_baixa"))
        (debug-print (instance-name ?sol) " -> " (instance-name ?of) " [-10 accessibilitat BAIXA]")
    )
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri accessibilitat)))
)


;;; ============================================================
;;; FASE 1: ABSTRACCIÓ
;;; Inferència de requisits segons el perfil del sol·licitant
;;; ============================================================

(defrule abstraccio-familia-amb-fills
    "Les families amb fills necessiten escoles i zones verdes"
    (declare (salience 95))
    ?sol <- (object (is-a Solicitant) (numeroFills ?fills))
    (test (> ?fills 0))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)
            (obligatori si) (motiu "Familia amb fills necessita escoles")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda)
            (obligatori no) (motiu "Familia amb fills prefereix zones verdes")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita escoles (te fills)" crlf)
)

(defrule abstraccio-persona-gran
    "Les persones grans necessiten serveis de salut i comercos"
    (declare (salience 95))
    ?sol <- (object (is-a PersonaGran))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiSalut)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiSalut)
            (obligatori si) (motiu "Persona gran necessita serveis de salut")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiComercial)
            (obligatori si) (motiu "Persona gran necessita comercos a prop")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita salut i comerc" crlf)
)

(defrule abstraccio-estudiants
    "Els estudiants necessiten transport i prefereixen oci"
    (declare (salience 95))
    ?sol <- (object (is-a GrupEstudiants))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic)
            (obligatori si) (motiu "Estudiant necessita transport public")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci)
            (obligatori no) (motiu "Estudiant prefereix zones oci")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita transport" crlf)
)

(defrule abstraccio-requereix-transport
    "Si necessita transport public, el necessita a prop"
    (declare (salience 95))
    ?sol <- (object (is-a Solicitant) (requereixTransportPublic si))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic)
            (obligatori si) (motiu "Prefereix transport public")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita transport public" crlf)
)

(defrule abstraccio-parella-futurs-fills
    "Parelles que planegen tenir fills prefereixen zones adequades"
    (declare (salience 95))
    ?sol <- (object (is-a ParellaFutursFills))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)
            (obligatori no) (motiu "Parella amb plans de fills prefereix escoles")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda)
            (obligatori no) (motiu "Parella amb plans de fills prefereix parcs")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " prefereix zones per futurs fills" crlf)
)

(defrule abstraccio-te-vehicle
    "Si te vehicle, prefereix parking"
    (declare (salience 95))
    ?sol <- (object (is-a Solicitant) (teVehicle si))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei Parking)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei Parking)
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
;;; FASE 2: RESOLUCIÓ
;;; ============================================================

;;; --- REGLES DE DESCART ---

(defrule resolucio-descartar-preu-marge-estricte
    "Descartar si preu supera màxim o mínim amb marge estricte"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min) (margeEstricte si))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (or (> ?preu ?max) (< ?preu ?min)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu "Preu supera pressupost maxim (estricte)")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu " ?preu " > " ?max " EUR" crlf)
)

(defrule resolucio-descartar-preu-marge-flexible
    "Descartar si preu supera maxim mes del 15% (marge flexible)"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (or (> ?preu (* ?max 1.15)) (< ?preu (* ?min 0.85))))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu "Preu supera pressupost maxim mes del 15%")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu massa alt" crlf)
)

(defrule resolucio-descartar-no-mascotes
    "Descartar si no permet mascotes i el solicitant en té"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (teMascotes si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (permetMascotes no))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu "No permet mascotes")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - No permet mascotes" crlf)
)

(defrule resolucio-descartar-no-accessible
    "Descartar si necessita accessibilitat i no es accessible"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (necessitaAccessibilitat si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 0))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu "No accessible: sense ascensor i planta alta")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - No accessible" crlf)
)

(defrule resolucio-descartar-servei-evitat
    "Descartar si un servei que es vol evitar està Molt A Prop"
    (declare (salience 45))
    (fase-completada (nom abstraccio))
    ;; Busquem un sol·licitant que tingui un servei a la llista d'evitar
    ?sol <- (object (is-a Solicitant) (evitaServei $? ?serveiEvitat $?))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ;; Comprovem si aquest habitatge té aquest servei concret Molt A Prop
    (proximitat (habitatge ?hab) (servei ?serveiEvitat) (distancia MoltAProp))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu (str-cat "Està massa a prop d'un servei evitat: " (instance-name ?serveiEvitat)))))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - A prop de servei evitat" crlf)
)

(defrule resolucio-descartar-falta-requisit-inferit
    "Descartar si falta un servei que s'ha inferit com OBLIGATORI (i no n'hi ha cap a prop)"
    (declare (salience 42))
    (fase-completada (nom abstraccio))
    ;; Recuperem el requisit inferit (ex: obligatori escola per tenir fills)
    (requisit-inferit (solicitant ?sol) (categoria-servei ?cat) (obligatori si) (motiu ?motiuTxt))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ;; Comprovem que NO existeixi cap proximitat d'aquesta categoria (ni a prop ni mitjana)
    (not (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp|DistanciaMitjana)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu (str-cat "Falta servei obligatori (" ?cat "): " ?motiuTxt))))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Falta requisit inferit: " ?cat crlf)
)

(defrule resolucio-descartar-superficie-insuficient
    "Descartar si la superficie no es adequada pel nombre de persones"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (numeroPersones ?npers))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (superficieHabitable ?sup))
    (test (< ?sup (* ?npers 10)))  ; Mínim 10 m² per persona
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu "Superficie insuficient per al nombre de persones")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " - Massa petita" crlf)
)

(defrule resolucio-descartar-estudiant-sense-mobles
    "Els estudiants necessiten habitatge moblat"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a GrupEstudiants))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (moblat no))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of)
            (motiu "Estudiants necessiten habitatge moblat")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " - No moblat" crlf)
)

;;; --- REGLES DE CRITERIS NO COMPLERTS ---

(defrule resolucio-criteri-preu-alt
    "Preu lleugerament superior (marge flexible)"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (and (> ?preu ?max) (<= ?preu (* ?max 1.15))))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-complert (solicitant ?sol) (oferta ?of)))
    =>
    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of)
            (criteri "Preu lleugerament superior al pressupost") (gravetat Lleu)))
)

(defrule resolucio-criteri-soroll-alt
    "Habitatge amb nivell de soroll alt"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (nivellSoroll "Alt"))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Nivell de soroll alt")))
    =>
    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of)
            (criteri "Nivell de soroll alt") (gravetat Lleu)))
)

(defrule resolucio-criteri-sense-ascensor
    "Planta alta sense ascensor per persona gran"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (edat ?edat))
    (test (> ?edat 60))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 1))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Planta alta sense ascensor")))
    =>
    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of)
            (criteri "Planta alta sense ascensor") (gravetat Moderat)))
)

;;; --- REGLES DE PUNTS POSITIUS ---

(defrule resolucio-punt-bon-preu
    "El preu es molt bo (menys del 80% del pressupost)"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (< ?preu (* ?max 0.8)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Preu molt bo")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Preu molt bo (>20% estalvi)")))
)

(defrule resolucio-punt-terrassa
    "L'habitatge te terrassa o balco"
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
    "L'habitatge es molt assolellat"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (orientacioSolar "TotElDia"))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
)

(defrule resolucio-punt-eficiencia
    "Alta eficiencia energetica (A o B)"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (consumEnergetic ?ce))
    (test (or (eq ?ce A) (eq ?ce B)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Alta eficiencia energetica")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Alta eficiencia energetica")))
)

(defrule resolucio-punt-exterior-silenci
    "Exterior i silencios"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (esExterior si) (nivellSoroll "Baix"))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Exterior i silencios")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Exterior i silencios")))
)

(defrule resolucio-punt-vistes
    "Te bones vistes"
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
    "Te parking i el solicitant te vehicle"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant) (teVehicle si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePlacaAparcament si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te parking")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te parking")))
)

(defrule resolucio-punt-piscina
    "Te piscina comunitaria"
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
    "Transport public molt a prop"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp))
    (test (or (eq ?cat EstacioMetro) (eq ?cat ParadaBus) (eq ?cat EstacioTren)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Transport public molt a prop")))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Transport public molt a prop")))
)

(defrule resolucio-punt-requisit-inferit-cat
    "Dona punts si l'habitatge satisfà una necessitat inferida (ex: parc per nens)"
    (declare (salience 32))
    (fase-completada (nom abstraccio))
    ;; Si tenim un requisit inferit (encara que no sigui obligatori)
    (requisit-inferit (solicitant ?sol) (categoria-servei ?cat) (motiu ?motiuTxt))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ;; I tenim un servei d'aquesta categoria a prop
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp|DistanciaMitjana))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    ;; Evitem duplicar el mateix punt
    (not (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d&:(str-index ?motiuTxt ?d))))
    =>
    (assert (punt-positiu (solicitant ?sol) (oferta ?of)
            (descripcio (str-cat "Cobreix necessitat detectada: " ?cat " (" ?motiuTxt ")"))))
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
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-complert (solicitant ?sol) (oferta ?of)))
    (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d1))
    (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d2&~?d1))
    (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?d3&~?d1&~?d2))
    (not (recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (solicitant ?sol) (oferta ?of) (grau MoltRecomanable) (puntuacio 100)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> MOLT RECOMANABLE per " (instance-name ?sol) crlf)
)

(defrule refinacio-adequat
    "ADEQUAT: compleix tot sense destacar"
    (declare (salience 4))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteri-no-complert (solicitant ?sol) (oferta ?of)))
    (not (recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (solicitant ?sol) (oferta ?of) (grau Adequat) (puntuacio 70)))
    (printout t "[REFINACIO] " (instance-name ?of) " -> ADEQUAT per " (instance-name ?sol) crlf)
)

(defrule refinacio-parcialment
    "PARCIALMENT ADEQUAT: te algun criteri no complert"
    (declare (salience 3))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (disponible si))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (criteri-no-complert (solicitant ?sol) (oferta ?of))
    (not (recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (solicitant ?sol) (oferta ?of) (grau Parcialment) (puntuacio 50)))
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
        (do-for-all-facts ((?cn criteri-no-complert)) 
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