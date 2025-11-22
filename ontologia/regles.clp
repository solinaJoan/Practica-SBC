;;; ============================================================
;;; regles.clp
;;; Sistema Expert de Recomanació d'Habitatges
;;; Fases: ABSTRACCIÓ -> RESOLUCIÓ -> REFINACIÓ
;;; ============================================================
;;; IMPORTANT: Carregar SEMPRE ontologiaSBC.clp ABANS d'aquest fitxer
;;; ============================================================

;;; ============================================================
;;; TEMPLATES AUXILIARS PER AL RAONAMENT
;;; ============================================================

(deftemplate proximitat
    (slot habitatge (type INSTANCE))
    (slot servei (type INSTANCE))
    (slot categoria (type SYMBOL))
    (slot distancia (type SYMBOL))
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
;;; ============================================================

;;; --- Inferència de requisits segons perfil ---

(defrule abstraccio-familia-amb-fills
    "Les families amb fills necessiten escoles"
    (declare (salience 95))
    ?sol <- (object (is-a Sollicitant) (numeroFills $?fills))
    (test (and (> (length$ $?fills) 0) (> (nth$ 1 $?fills) 0)))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)
            (obligatori si) (motiu "Familia amb fills necessita escoles")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ZonaVerda)
            (obligatori no) (motiu "Familia amb fills prefereix zones verdes")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita escoles (te fills)" crlf)
)

(defrule abstraccio-persona-gran
    "Les persones grans necessiten serveis de salut"
    (declare (salience 95))
    ?sol <- (object (is-a PersonaGran))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiSalut)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiSalut)
            (obligatori si) (motiu "Persona gran necessita serveis de salut")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiComercial)
            (obligatori si) (motiu "Persona gran necessita comercos a prop")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita salut i comerc (persona gran)" crlf)
)

(defrule abstraccio-estudiants
    "Els estudiants necessiten transport"
    (declare (salience 95))
    ?sol <- (object (is-a GrupEstudiants))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)
            (obligatori si) (motiu "Estudiant necessita transport public")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiOci)
            (obligatori no) (motiu "Estudiant prefereix zones oci")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita transport (estudiant)" crlf)
)

(defrule abstraccio-prefereix-transport
    "Si prefereix transport public"
    (declare (salience 95))
    ?sol <- (object (is-a Sollicitant) (prefereixTransportPublic $?pref))
    (test (and (> (length$ $?pref) 0) (eq (nth$ 1 $?pref) si)))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei TransportPublic)
            (obligatori si) (motiu "Prefereix transport public")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " necessita transport public" crlf)
)

(defrule abstraccio-parella-futurs-fills
    "Parelles que planegen tenir fills"
    (declare (salience 95))
    ?sol <- (object (is-a ParellaFutursFills))
    (not (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ServeiEducatiu)
            (obligatori no) (motiu "Parella amb plans de fills prefereix escoles")))
    (assert (requisit-inferit (sollicitant ?sol) (categoria-servei ZonaVerda)
            (obligatori no) (motiu "Parella amb plans de fills prefereix zones verdes")))
    (printout t "[ABSTRACCIO] " (instance-name ?sol) " prefereix zones per futurs fills" crlf)
)

(defrule abstraccio-fi
    "Fi de la fase abstraccio"
    (declare (salience 50))
    (not (fase-completada (nom abstraccio)))
    =>
    (assert (fase-completada (nom abstraccio)))
    (printout t crlf "=== FASE ABSTRACCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 2: RESOLUCIÓ
;;; ============================================================

;;; --- Regles de DESCART ---

(defrule resolucio-descartar-preu-excessiu
    "Descartar si preu supera maxim amb marge estricte"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim $?maxlist) (margeEstricte $?margelist))
    (test (and (> (length$ $?maxlist) 0) (> (length$ $?margelist) 0)))
    (test (eq (nth$ 1 $?margelist) si))
    ?of <- (object (is-a Oferta) (preuMensual $?preulist) (disponible $?displist))
    (test (and (> (length$ $?preulist) 0) (> (length$ $?displist) 0)))
    (test (eq (nth$ 1 $?displist) si))
    (test (> (nth$ 1 $?preulist) (nth$ 1 $?maxlist)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "Preu supera pressupost maxim (marge estricte)")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu " (nth$ 1 $?preulist) " > " (nth$ 1 $?maxlist) " EUR" crlf)
)

(defrule resolucio-descartar-no-mascotes
    "Descartar si no permet mascotes"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (teMascotes $?masclist))
    (test (and (> (length$ $?masclist) 0) (eq (nth$ 1 $?masclist) si)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (permetMascotes $?permlist))
    (test (and (> (length$ $?permlist) 0) (eq (nth$ 1 $?permlist) no)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "No permet mascotes")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - No permet mascotes" crlf)
)

(defrule resolucio-descartar-no-accessible
    "Descartar si necessita accessibilitat"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (necessitaAccessibilitat $?acclist))
    (test (and (> (length$ $?acclist) 0) (eq (nth$ 1 $?acclist) si)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (teAscensor $?asclist) (plantaPis $?plantalist))
    (test (and (> (length$ $?asclist) 0) (eq (nth$ 1 $?asclist) no)))
    (test (and (> (length$ $?plantalist) 0) (> (nth$ 1 $?plantalist) 0)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "No accessible: sense ascensor i planta alta")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - No accessible" crlf)
)

(defrule resolucio-descartar-preu-baix
    "Descartar si preu sospitosament baix"
    (declare (salience 40))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMinim $?minlist))
    (test (and (> (length$ $?minlist) 0) (> (nth$ 1 $?minlist) 0)))
    ?of <- (object (is-a Oferta) (preuMensual $?preulist) (disponible $?displist))
    (test (and (> (length$ $?preulist) 0) (> (length$ $?displist) 0)))
    (test (eq (nth$ 1 $?displist) si))
    (test (< (nth$ 1 $?preulist) (nth$ 1 $?minlist)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (sollicitant ?sol) (oferta ?of)
            (motiu "Preu sospitosament baix")))
    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per " (instance-name ?sol)
              " - Preu sospitos" crlf)
)

;;; --- Regles de CRITERIS NO COMPLERTS ---

(defrule resolucio-criteri-preu-alt
    "Preu superior pero marge flexible"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim $?maxlist) (margeEstricte $?margelist))
    (test (and (> (length$ $?maxlist) 0) (> (length$ $?margelist) 0)))
    (test (eq (nth$ 1 $?margelist) no))
    ?of <- (object (is-a Oferta) (preuMensual $?preulist) (disponible $?displist))
    (test (and (> (length$ $?preulist) 0) (> (length$ $?displist) 0)))
    (test (eq (nth$ 1 $?displist) si))
    (test (> (nth$ 1 $?preulist) (nth$ 1 $?maxlist)))
    (test (<= (nth$ 1 $?preulist) (* (nth$ 1 $?maxlist) 1.15)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)
            (criteri "Preu lleugerament superior") (gravetat Lleu)))
)

(defrule resolucio-criteri-soroll
    "Habitatge amb soroll alt"
    (declare (salience 35))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (nivellSoroll $?sorolllist))
    (test (and (> (length$ $?sorolllist) 0) (eq (nth$ 1 $?sorolllist) Alt)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of) (criteri "Nivell soroll alt")))
    =>
    (assert (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)
            (criteri "Nivell soroll alt") (gravetat Lleu)))
)

;;; --- Regles de PUNTS POSITIUS ---

(defrule resolucio-punt-bon-preu
    "Preu molt bo"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (pressupostMaxim $?maxlist))
    (test (> (length$ $?maxlist) 0))
    ?of <- (object (is-a Oferta) (preuMensual $?preulist) (disponible $?displist))
    (test (and (> (length$ $?preulist) 0) (> (length$ $?displist) 0)))
    (test (eq (nth$ 1 $?displist) si))
    (test (< (nth$ 1 $?preulist) (* (nth$ 1 $?maxlist) 0.8)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Preu molt bo")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Preu molt bo")))
)

(defrule resolucio-punt-terrassa
    "Te terrassa"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (teTerrassaOBalco $?terrlist))
    (test (and (> (length$ $?terrlist) 0) (eq (nth$ 1 $?terrlist) si)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te terrassa")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te terrassa")))
)

(defrule resolucio-punt-assolellat
    "Molt assolellat"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (orientacioSolar $?orientlist))
    (test (and (> (length$ $?orientlist) 0) (eq (nth$ 1 $?orientlist) TotElDia)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
)

(defrule resolucio-punt-eficiencia
    "Alta eficiencia energetica"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (consumEnergetic $?celist))
    (test (> (length$ $?celist) 0))
    (test (or (eq (nth$ 1 $?celist) A) (eq (nth$ 1 $?celist) B)))
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
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (esExterior $?extlist) (nivellSoroll $?sorolllist))
    (test (and (> (length$ $?extlist) 0) (eq (nth$ 1 $?extlist) si)))
    (test (and (> (length$ $?sorolllist) 0) (eq (nth$ 1 $?sorolllist) Baix)))
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
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (teVistes $?visteslist))
    (test (and (> (length$ $?visteslist) 0) (eq (nth$ 1 $?visteslist) si)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
)

(defrule resolucio-punt-parking
    "Te parking"
    (declare (salience 30))
    (fase-completada (nom abstraccio))
    ?sol <- (object (is-a Sollicitant) (teVehicle $?vehlist))
    (test (and (> (length$ $?vehlist) 0) (eq (nth$ 1 $?vehlist) si)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    ?h <- (object (is-a Habitatge) (OBJECT ?hab) (tePlacaAparcament $?parklist))
    (test (and (> (length$ $?parklist) 0) (eq (nth$ 1 $?parklist) si)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te parking")))
    =>
    (assert (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio "Te parking")))
)

(defrule resolucio-fi
    "Fi de la fase resolucio"
    (declare (salience 10))
    (fase-completada (nom abstraccio))
    (not (fase-completada (nom resolucio)))
    =>
    (assert (fase-completada (nom resolucio)))
    (printout t crlf "=== FASE RESOLUCIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; FASE 3: REFINACIÓ
;;; ============================================================

(defrule refinacio-molt-recomanable
    "MOLT RECOMANABLE: sense negatius i 3+ positius"
    (declare (salience 5))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?d1))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?d2&~?d1))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?d3&~?d1&~?d2))
    (not (recomanacio (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (sollicitant ?sol) (oferta ?of) (grau MoltRecomanable) (puntuacio 100)))
    (printout t "[REFINACIO] " (instance-name ?of) " es MOLT RECOMANABLE per " (instance-name ?sol) crlf)
)

(defrule refinacio-adequat
    "ADEQUAT: compleix tot"
    (declare (salience 4))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (not (criteri-no-cumplit (sollicitant ?sol) (oferta ?of)))
    (not (recomanacio (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (sollicitant ?sol) (oferta ?of) (grau Adequat) (puntuacio 70)))
    (printout t "[REFINACIO] " (instance-name ?of) " es ADEQUAT per " (instance-name ?sol) crlf)
)

(defrule refinacio-parcialment
    "PARCIALMENT: te criteris no complerts"
    (declare (salience 3))
    (fase-completada (nom resolucio))
    ?sol <- (object (is-a Sollicitant))
    ?of <- (object (is-a Oferta) (disponible $?displist))
    (test (and (> (length$ $?displist) 0) (eq (nth$ 1 $?displist) si)))
    (not (oferta-descartada (sollicitant ?sol) (oferta ?of)))
    (criteri-no-cumplit (sollicitant ?sol) (oferta ?of))
    (not (recomanacio (sollicitant ?sol) (oferta ?of)))
    =>
    (assert (recomanacio (sollicitant ?sol) (oferta ?of) (grau Parcialment) (puntuacio 50)))
    (printout t "[REFINACIO] " (instance-name ?of) " es PARCIALMENT ADEQUAT per " (instance-name ?sol) crlf)
)

(defrule refinacio-fi
    "Fi de la fase refinacio"
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
    "Encapcalament resultats"
    (declare (salience -10))
    (fase-completada (nom refinacio))
    (not (fase-completada (nom presentacio)))
    =>
    (assert (fase-completada (nom presentacio)))
    (printout t crlf)
    (printout t "========================================================" crlf)
    (printout t "         RESULTATS DEL SISTEMA DE RECOMANACIO           " crlf)
    (printout t "========================================================" crlf)
)

(defrule presentacio-recomanacio
    "Mostra cada recomanacio"
    (declare (salience -20))
    (fase-completada (nom presentacio))
    (recomanacio (sollicitant ?sol) (oferta ?of) (grau ?grau) (puntuacio ?punt))
    ?oferta <- (object (is-a Oferta) (OBJECT ?of) (preuMensual $?preulist) (teHabitatge ?hab))
    ?habitatge <- (object (is-a Habitatge) (OBJECT ?hab)
                          (superficieHabitable $?suplist)
                          (numeroDormitoris $?dormlist)
                          (numeroBanys $?banyslist)
                          (teLocalitzacio ?loc))
    (object (is-a Localitzacio) (OBJECT ?loc) (adreca $?adrecalist) (barri $?barrilist))
    =>
    (printout t crlf)
    (printout t "--------------------------------------------------------" crlf)
    (printout t "SOLLICITANT: " (instance-name ?sol) crlf)
    (printout t "OFERTA: " (instance-name ?of) crlf)
    (printout t "--------------------------------------------------------" crlf)
    (printout t "GRAU: *** " ?grau " *** (Puntuacio: " ?punt ")" crlf)
    (printout t "--------------------------------------------------------" crlf)
    (printout t "Tipus: " (class ?hab) crlf)
    (if (> (length$ $?suplist) 0) then
        (printout t "Superficie: " (nth$ 1 $?suplist) " m2" crlf))
    (if (> (length$ $?dormlist) 0) then
        (printout t "Dormitoris: " (nth$ 1 $?dormlist) crlf))
    (if (> (length$ $?banyslist) 0) then
        (printout t "Banys: " (nth$ 1 $?banyslist) crlf))
    (if (> (length$ $?preulist) 0) then
        (printout t "Preu: " (nth$ 1 $?preulist) " EUR/mes" crlf))
    (if (> (length$ $?adrecalist) 0) then
        (printout t "Adreca: " (nth$ 1 $?adrecalist) crlf))
    (if (> (length$ $?barrilist) 0) then
        (printout t "Barri: " (nth$ 1 $?barrilist) crlf))
    (printout t "--------------------------------------------------------" crlf)
)

(defrule presentacio-punts-positius
    "Mostra punts positius"
    (declare (salience -21))
    (fase-completada (nom presentacio))
    (recomanacio (sollicitant ?sol) (oferta ?of))
    (punt-positiu (sollicitant ?sol) (oferta ?of) (descripcio ?desc))
    =>
    (printout t "  [+] " ?desc crlf)
)

(defrule presentacio-criteris-negatius
    "Mostra criteris negatius"
    (declare (salience -22))
    (fase-completada (nom presentacio))
    (recomanacio (sollicitant ?sol) (oferta ?of) (grau Parcialment))
    (criteri-no-cumplit (sollicitant ?sol) (oferta ?of) (criteri ?crit) (gravetat ?grav))
    =>
    (printout t "  [-] " ?crit " (" ?grav ")" crlf)
)

(defrule presentacio-descartades
    "Mostra ofertes descartades"
    (declare (salience -30))
    (fase-completada (nom presentacio))
    (oferta-descartada (sollicitant ?sol) (oferta ?of) (motiu ?motiu))
    =>
    (printout t crlf "[DESCARTADA] " (instance-name ?of) " per " (instance-name ?sol) ": " ?motiu crlf)
)

(defrule presentacio-fi
    "Fi del sistema"
    (declare (salience -100))
    (fase-completada (nom presentacio))
    (not (fase-completada (nom fi)))
    =>
    (assert (fase-completada (nom fi)))
    (printout t crlf)
    (printout t "========================================================" crlf)
    (printout t "                    FI DEL PROCES                       " crlf)
    (printout t "========================================================" crlf)
)
