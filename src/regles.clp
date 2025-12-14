;;; ============================================================
;;; regles.clp
;;; ============================================================

(defglobal ?*DEBUG* = TRUE)

;;; ============================================================
;;; TEMPLATES
;;; ============================================================


(deftemplate dades-solicitant
    (slot nom)
    (slot edat)
    (slot numeroPersones)
    (slot numeroFills)
    (multislot edatsFills)
    (slot teAvis)
    (slot segonaResidencia)
    (slot estudiaACiutat)
    (slot pressupostMaxim)
    (slot pressupostMinim)
    (slot margeEstricte)
    (slot teVehicle)
    (slot requereixTransportPublic)
    (slot necessitaAccessibilitat)
    (slot teMascotes)
    (slot numeroMascotes)
    (slot tipusMascota)
    (slot planejaFills)
    (multislot evitaServei)
    (multislot prefereixServei)
)

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

(deftemplate criteri-no-complert
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot criteri (type STRING))
    (slot gravetat (type SYMBOL) (default Lleu))
)

(deftemplate punt-positiu
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot descripcio (type STRING))
    (slot punts (type INTEGER) (default 10))
)

(deftemplate criteriAplicat
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot criteri (type SYMBOL))
)

(deftemplate Recomanacio
    (slot solicitant (type INSTANCE))
    (slot oferta (type INSTANCE))
    (slot puntuacio (type INTEGER) (default 0))
    (slot grau (type SYMBOL) (default NULL))
)

(deftemplate fase
   (slot actual (type SYMBOL))
)

(deffacts inicial (fase (actual init)))

;;; ============================================================
;;; FUNCIONS AUXILIARS
;;; ============================================================

(deffunction debug-print ($?msg)
   (if ?*DEBUG*
      then (printout t $?msg crlf)
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

;;; ============================================================
;;; CONTROL DE FASES
;;; ============================================================

(defrule init-fi
    "Marca el final de la fase d'incialitzacio"
    (declare (salience -10))
    ?f <- (fase (actual init))
    =>
    (modify ?f (actual abstraccio))
    (printout t crlf "=== FASE INICIALITZACIÓ COMPLETADA ===" crlf crlf)
)

(defrule abstraccio-fi
    "Marca el final de la fase d'abstraccio"
    (declare (salience -10))
    ?f <- (fase (actual abstraccio))
    =>
    (modify ?f (actual descart))
    (printout t crlf "=== FASE ABSTRACCIÓ COMPLETADA ===" crlf crlf)
)

(defrule descart-fi
    "Marca el final de la fase de descart"
    (declare (salience -10))
    ?f <- (fase (actual descart))
    =>
    (modify ?f (actual scoring))
    (printout t crlf "=== FASE DESCART COMPLETADA ===" crlf crlf)
)

(defrule scoring-fi
    "Marca el final de la fase de scoring"
    (declare (salience -10))
    ?f <- (fase (actual scoring))
    =>
    (modify ?f (actual classificacio))
    (printout t crlf "=== FASE DE SCORING COMPLETADA ===" crlf crlf)
)

(defrule classificacio-fi
    "Marca el final de la fase de classificacio"
    (declare (salience -10))
    ?f <- (fase (actual classificacio))
    =>
    (modify ?f (actual presentacio))
    (printout t crlf "=== FASE DE CLASSIFICACIO COMPLETADA ===" crlf crlf)
)

;;; ============================================================
;;; CLASSIFICACIÓ DE SOL·LICITANTS
;;; ============================================================

(defrule crear-segona-residencia
    (declare (salience 100))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (segonaResidencia si) (edat ?e) (numeroPersones ?np) 
             (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc) 
             (prefereixServei $?ps) (evitaServei $?es))
    =>
    (make-instance (sym-cat sol- (gensym*)) of CompradorSegonaResidencia
        (nom ?n) (edat ?e) (numeroPersones ?np) (segonaResidencia si)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria CompradorSegonaResidencia: ?n)
)

(defrule crear-persona-gran
    "Persona gran (>65)"
    (declare (salience 90))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (edat ?e) (teAvis ?avis) 
             (numeroPersones ?np) (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    (test (> ?e 65))
    =>
    (make-instance (sym-cat sol- (gensym*)) of PersonaGran
        (nom ?n) (edat ?e) (teAvis ?avis) (numeroPersones ?np)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria PersonaGran: ?n)
)

(defrule crear-estudiants
    "Estudiants"
    (declare (salience 80))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (estudiaACiutat si) (edat ?e)
             (numeroPersones ?np) (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    =>
    (make-instance (sym-cat sol- (gensym*)) of GrupEstudiants
        (nom ?n) (edat ?e) (estudiaACiutat si) (numeroPersones ?np)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria GrupEstudiants: ?n)
)

(defrule crear-parella-jove
    "Parella Jove (<35)"
    (declare (salience 70))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (edat ?e) (numeroPersones ?np)
             (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    (test (<= ?e 35))
    (test (> ?np 1))
    =>
    (make-instance (sym-cat sol- (gensym*)) of ParellaJove
        (nom ?n) (edat ?e) (numeroPersones ?np)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria ParellaJove: ?n)
)

(defrule crear-jove
    "Jove independent"
    (declare (salience 70))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (edat ?e) (numeroPersones ?np)
             (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    (test (<= ?e 35))
    (test (= ?np 1))
    =>
    (make-instance (sym-cat sol- (gensym*)) of Joves
        (nom ?n) (edat ?e) (numeroPersones ?np)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria Jove: ?n)
)

(defrule crear-adult-amb-fills
    "Adult (>35) amb fills"
    (declare (salience 60))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (edat ?e) (numeroPersones ?np) (numeroFills ?nf) (edatsFills $?ef)
             (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    (test (> ?e 35))
    (test (> ?nf 0))
    =>
    ;; Distingim entre parella o individu segons numeroPersones
    (bind ?classe ParellaAmbFills)
    ;; Si num persones és igual a fills + 1 (l'adult), llavors és individu monoparental
    (if (= ?np (+ ?nf 1)) then (bind ?classe IndividuAmbFills))

    (make-instance (sym-cat sol- (gensym*)) of ?classe
        (nom ?n) (edat ?e) (numeroPersones ?np) (numeroFills ?nf) (edatsFills $?ef)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria ParellaAmbFills ?n)
)

(defrule crear-adult-futurs-fills
    "Adult (>35) sense fills però amb plans"
    (declare (salience 60))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (edat ?e) (numeroPersones ?np) (numeroFills 0) (planejaFills si)
             (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    (test (> ?e 35))
    =>
    (bind ?classe ParellaFutursFills)
    (if (= ?np 1) then (bind ?classe IndividuFutursFills))

    (make-instance (sym-cat sol- (gensym*)) of ?classe
        (nom ?n) (edat ?e) (numeroPersones ?np)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria ParellaFutursFills ?n)
)

(defrule crear-adult-sense-fills
    "Adult standard (>35) sense fills ni plans"
    (declare (salience 50))
    (fase (actual init))
    ?f <- (dades-solicitant (nom ?n) (edat ?e) (numeroPersones ?np)
             (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
             (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
             (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
             (prefereixServei $?ps) (evitaServei $?es))
    (test (> ?e 35))
    =>
    (bind ?classe ParellaSenseFills)
    (if (= ?np 1) then (bind ?classe IndividuSenseFills))

    (make-instance (sym-cat sol- (gensym*)) of ?classe
        (nom ?n) (edat ?e) (numeroPersones ?np)
        (pressupostMaxim ?pmax) (pressupostMinim ?pmin) (margeEstricte ?me)
        (teVehicle ?tv) (requereixTransportPublic ?rtp) (necessitaAccessibilitat ?na)
        (teMascotes ?tm) (numeroMascotes ?nm) (tipusMascota ?tmasc)
        (prefereixServei $?ps) (evitaServei $?es))
    (retract ?f)
    (debug-print [ABSTRACCIO] Solicitant de la categoria ParellaSenseFills ?n)
)

;;; ============================================================
;;; FASE INIT: INICIALITZACIÓ
;;; ============================================================

(defrule abstraccio-calcular-proximitats
    "Calcula la proximitat entre cada habitatge i cada servei"
    (fase (actual init))
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
    (debug-print [DISTANCIES] (instance-name ?hab) i (instance-name ?serv) categoria ?cat distancia: ?dist)
)

(defrule abstraccio-expandir-categories
    "Expandeix categories pare per evitar resultats buits"
    (declare (salience 99))
    (fase (actual init))
    (proximitat (habitatge ?h) (servei ?s) (categoria ?cat) (distancia ?d) (metres ?m))
    =>
    ;; Transport
    (if (or (eq ?cat EstacioMetro) (eq ?cat ParadaBus) (eq ?cat EstacioTren) (eq ?cat Aeroport)) then 
        (assert (proximitat (habitatge ?h) (servei ?s) (categoria TransportPublic) (distancia ?d) (metres ?m))))
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

(defrule crear-recomanacions-inicials
    "Crea tot el parell de recomanacions entre oferta i solicitant"
    (fase (actual init))
    ?sol <- (object (is-a Solicitant))
    ?of  <- (object (is-a Oferta) (disponible si))
    (not (Recomanacio (solicitant ?sol) (oferta ?of)))
    =>
    (assert (Recomanacio (solicitant ?sol) (oferta ?of)))
)

;;; ============================================================
;;; FASE 1: ABSTRACCIÓ - Inferència de requisits
;;; ============================================================

(defrule abstraccio-familia-amb-fills
    "Les families amb fills puntuen escoles i zones verdes"
    (fase (actual abstraccio))
    ?sol <- (object (is-a Solicitant) (numeroFills ?fills))
    (test (> ?fills 0))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu) (obligatori si) (motiu "Familia amb fills necessita escoles")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda) (obligatori no) (motiu "Familia amb fills prefereix zones verdes")))
    (debug-print [ABSTRACCIO] (instance-name ?sol) necessita escoles perquè te fills)
)

(defrule abstraccio-persona-gran
    "Les persones grans necessiten serveis de salut"
    (fase (actual abstraccio))
    ?sol <- (object (is-a PersonaGran))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiSalut)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiSalut) (obligatori si) (motiu "Persona gran necessita serveis de salut")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiComercial) (obligatori si) (motiu "Persona gran necessita comerços a prop")))
    (debug-print [ABSTRACCIO] (instance-name ?sol) necessita salut i comerç)
)

(defrule abstraccio-estudiants
    "Els estudiants necessiten transport i prefereixen oci"
    (fase (actual abstraccio))
    ?sol <- (object (is-a GrupEstudiants))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic) (obligatori si) (motiu "Estudiant necessita transport public")))

    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci) (obligatori no) (motiu "Estudiant prefereix zones oci")))

    (debug-print [ABSTRACCIO] (instance-name ?sol) Els joves necessiten transport i oci)
)

(defrule abstraccio-parella-futurs-fills
    "Parelles que planegen tenir fills prefereixen zones adequades"
    (fase (actual abstraccio))
    ?sol <- (object (is-a ParellaFutursFills))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiEducatiu) (obligatori no) (motiu "Parella amb plans de fills prefereix escoles")))
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ZonaVerda) (obligatori no) (motiu "Parella amb plans de fills prefereix parcs")))
    (debug-print [ABSTRACCIO] (instance-name ?sol) prefereix zones per futurs fills)
)

(defrule abstraccio-individu-jove
    (fase (actual abstraccio))
    ?sol <- (object (is-a Individu) (edat ?e))
    (test (and (>= ?e 18) (<= ?e 35)))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei ServeiOci) (obligatori no) (motiu "Individu jove prefereix zones oci")))
    (debug-print [ABSTRACCIO] (instance-name ?sol) prefereix oci perquè és jove)
)

(defrule abstraccio-requereix-transport
    (fase (actual abstraccio))
    ?sol <- (object (is-a Solicitant) (requereixTransportPublic si))
    (not (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic)))
    =>
    (assert (requisit-inferit (solicitant ?sol) (categoria-servei TransportPublic) (obligatori si) (motiu "Prefereix transport public")))
    (debug-print [ABSTRACCIO] (instance-name ?sol) necessita transport public)
)

(defrule abstraccio-necessita-autopista-feina-fora
    "Inferència: Si té cotxe, edat laboral i no treballa/estudia a la ciutat, necessita sortir-ne"
    (fase (actual abstraccio))
    ?sol <- (object (is-a Solicitant) 
                (estudiaACiutat no)
                (treballaACiutat no) 
                (teVehicle si) 
                (edat ?e))
    ;; Edat laboral (aprox 18-65)
    (test (and (>= ?e 18) (<= ?e 65)))
    ;; Comprovem que no tingui ja el requisit
    (not (requisit-inferit (solicitant ?sol) (categoria-servei Autopista)))
    =>
    (assert (requisit-inferit (solicitant ?sol) 
                              (categoria-servei Autopista) 
                              (obligatori no) 
                              (motiu "Treballa fora de la ciutat i té vehicle")))
    (debug-print [ABSTRACCIO] (instance-name ?sol) necessita autopista perquè treballa fora)
)

;;; ============================================================
;;; FASE 2: RESOLUCIÓ 
;;; ============================================================

;;; --- REGLES DE DESCART ---

(defrule resolucio-descartar-preu-marge-estricte
    "Descartar si preu supera màxim o mínim amb marge estricte"
    (fase (actual descart))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min) (margeEstricte si))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (or (> ?preu ?max) (< ?preu ?min)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Preu supera pressupost maxim (estricte)")))
            
    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) per (instance-name ?sol) - Preu excessiu i marge de pressupost estricte)
)

(defrule resolucio-descartar-no-mascotes
    "Descartar si no permet mascotes i el solicitant en té"
    (fase (actual descart))
    ?sol <- (object (is-a Solicitant) (teMascotes si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (permetMascotes no))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "No permet mascotes")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) per (instance-name ?sol) - No permet mascotes)
)

(defrule resolucio-descartar-no-accessible
    "Descartar si necessita accessibilitat i no es accessible"
    (fase (actual descart))
    ?sol <- (object (is-a Solicitant) (necessitaAccessibilitat si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 0))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "No accessible: sense ascensor i planta alta")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) per (instance-name ?sol) - No accessible)
)

(defrule resolucio-descartar-servei-evitat
    "Descartar si un servei que es vol evitar està Molt A Prop"
    (fase (actual descart))
    ?sol <- (object (is-a Solicitant) (evitaServei $? ?serveiEvitat $?))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (servei ?serveiEvitat) (distancia MoltAProp))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu (str-cat "Està massa a prop d'un servei evitat: " (instance-name ?serveiEvitat)))))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) per (instance-name ?sol) - A prop de servei evitat)
)

(defrule resolucio-descartar-falta-requisit-inferit
    "Descartar si falta un servei que s'ha inferit com OBLIGATORI (i no n'hi ha cap a prop)"
    (fase (actual descart))
    ;; Recuperem el requisit inferit obligatori
    (requisit-inferit (solicitant ?sol) (categoria-servei ?cat) (obligatori si) (motiu ?motiuTxt))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ;; Comprovem que NO existeixi cap proximitat d'aquesta categoria (ni a prop ni mitjana)
    (not (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp|DistanciaMitjana)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu (str-cat "Falta servei obligatori (" ?cat "): " ?motiuTxt))))

    (printout t "[RESOLUCIO] DESCARTADA " (instance-name ?of) " per "  (instance-name ?sol) " - Falta requisit inferit: " ?cat crlf)
)

(defrule resolucio-descartar-superficie-insuficient
    "Descartar si la superficie no es adequada pel nombre de persones"
    (fase (actual descart))
    ?sol <- (object (is-a Solicitant) (numeroPersones ?npers))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (superficieHabitable ?sup))
    (test (< ?sup (* ?npers 10)))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Superficie insuficient per al nombre de persones")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) - Massa petita)
)

(defrule resolucio-descartar-estudiant-a-reformar
    "Els estudiants necessiten habitatge llestos"
    (fase (actual descart))
    ?sol <- (object (is-a GrupEstudiants))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (estatConservacio ?ec))
    (test (eq ?ec AReformar))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Estudiants necessiten habitatge moblat")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) - Pis a reformar)
)

(defrule resolucio-descartar-no-garatge
    "Les persones amb vehicle necessiten garatge"
    (fase (actual descart))
    ?sol <- (object (is-a Solicitant) (teVehicle si))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePlacaAparcament no))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Persones amb vehicle necessiten aparcament")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) - Necessita aparcament)
)

(defrule resolucio-descartar-avis-lluny-salut
    "Salut molt lluny de persones grans"
    (fase (actual descart))
    ?sol <- (object (is-a PersonaGran))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia Lluny))
    (test(eq ?cat ServeiSalut))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Salut molt lluny de persones grans")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) - Necessita salut no lluny)
)

(defrule resolucio-descartar-estudi-per-segona-residencia
    "Salut molt lluny de persones grans"
    (fase (actual descart))
    ?sol <- (object (is-a CompradorSegonaResidencia))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Estudi) (name ?hab))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (assert (oferta-descartada (solicitant ?sol) (oferta ?of) (motiu "Descartem estudis per compradors de segones residencies")))

    (debug-print [RESOLUCIO] DESCARTADA (instance-name ?of) - Estudi per compradors de segones residencies)
)


;;; --- REGLES DE PUNTUACIÓ ---

(defrule resolucio-puntuar-pressupost-dins-marge
    "Pressupost dins el marge"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min))
    ?of <- (object (is-a Oferta) (disponible si) (preuMensual ?preu))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri pressupost-dins-marge)))
    (test (and (< ?preu (* ?max 1.15)) (> ?preu (* ?min 0.85))))
    =>
    (if (and (< ?preu ?max) (> ?preu ?min))
    then 
        (modify ?rec (puntuacio (+ ?pts 40)))
        (debug-print [RESOLUCIO] PUNTUADA +40p A (instance-name ?of) per (instance-name ?sol) - Pressupost dins el marge)
    else 
        (modify ?rec (puntuacio (+ ?pts 20)))
        (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Pressupost dins el marge flexible)
    )
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri pressupost-dins-marge)))
)

(defrule resolucio-puntuar-silencios
    "Habitatge silenciós per avis i segones residencies"
    (fase (actual scoring))
    ?sol <- (object (is-a ?tipus)) 
    (test (or (eq ?tipus PersonaGran) (eq ?tipus CompradorSegonaResidencia)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (nivellSoroll "Baix"))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri silencios-avis)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge silenciós per avis i segones residencies)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri silencios-avis)))
)

(defrule resolucio-puntuar-vistes-segones-residencies
    "Habitatge amb vistes al mar o muntanya per a segones residencies"
    (fase (actual scoring))
    ?sol <- (object (is-a CompradorSegonaResidencia)) 
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tipusVistes ?vist))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri vistes-segones-residencies)))
    (test (or (eq ?vist "Mar") (eq ?vist "Muntanya")))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb vistes al mar o muntanya per segones residencies)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri vistes-segones-residencies)))
)

(defrule resolucio-puntuar-extra-terrassa-per-joves
    "Habitatge amb terrassa per joves puntua extra"
    (fase (actual scoring))
    ?sol <- (object (is-a Joves)) 
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teTerrassaOBalco si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-terrassa-joves)))
    =>
    (modify ?rec (puntuacio (+ ?pts 5)))
    (debug-print [RESOLUCIO] PUNTUADA +5p A (instance-name ?of) per (instance-name ?sol) - Puntuació extra per terrassa i ser jove)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-terrassa-joves)))
)

(defrule resolucio-puntuar-piscina-joves-i-adults-fills
    "Habitatge amb piscina per joves"
    (fase (actual scoring))
    ?sol <- (object (is-a ?tipus))
    (test (or (eq ?tipus Joves) (eq ?tipus ParellaAmbFills) (eq ?tipus ParellaFutursFills) (eq ?tipus IndividuAmbFills) (eq ?tipus IndividuFutursFills)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePiscinaComunitaria si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-piscina-joves-i-fills)))
    =>
    (modify ?rec (puntuacio (+ ?pts 5)))
    (debug-print [RESOLUCIO] PUNTUADA +5p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb piscina)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-piscina-joves-i-fills)))
)

(defrule resolucio-puntuar-habitatge-eficient
    "Habitatge amb consum enerètic eficient"
    (fase (actual scoring))
    ?sol <- (object (is-a CompradorSegonaResidencia))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (consumEnergetic ?ce))
    (test (or (eq ?ce A) (eq ?ce B)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri consum-eficient)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb consum energètic eficient)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri consum-eficient)))
)

(defrule resolucio-puntuar-traster-adults-avis
    "Habitatge amb traster"
    (fase (actual scoring))
    ?sol <- (object (is-a ?tipus))
    (test (or (eq ?tipus Adults) (eq ?tipus PersonaGran)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teTraster si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-traster-adults-avis)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb traster)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-traster-adults-avis)))
)

(defrule resolucio-puntuar-areformar-segones-residencies
    "Habitatge a reformar ideal per compradors amb poder econòmic i que es volen fer la casa a mida"
    (fase (actual scoring))
    ?sol <- (object (is-a CompradorSegonaResidencia))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (estatConservacio ?ec))
    (test (eq ?ec AReformar))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri a-reformar)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge a reformar)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri a-reformar)))
)

(defrule resolucio-puntuar-moblats
    "Habitatge amb mobles"
    (fase (actual scoring))
    ?sol <- (object (is-a GrupEstudiants))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (moblat si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri ja-moblat)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge ja moblat)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri ja-moblat)))
)

(defrule resolucio-puntuar-aire-acondicionat
    (fase (actual scoring))
    ?sol <- (object (is-a Adults))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAireCondicionat si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri aire-acondicionat)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb aire acondicionat)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri aire-acondicionat)))
)

(defrule resolucio-puntuar-calefaccio
    (fase (actual scoring))
    ?sol <- (object (is-a ?tipus))
    (test (or (eq ?tipus Adults) (eq ?tipus PersonaGran)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teCalefaccio si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-calefaccio)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb calefaccio)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-calefaccio)))
)

(defrule resolucio-puntuar-electrodomestics
    (fase (actual scoring))
    ?sol <- (object (is-a Joves))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (ambElectrodomestics si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-electrodomestics)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb calefaccio)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-electrodomestics)))
)

(defrule resolucio-puntuar-nombre-banys
    (fase (actual scoring))
    ?sol <- (object (is-a ?tipus))
    (test (or (eq ?tipus ParellaAmbFills) (eq ?tipus ParellaFutursFills) (eq ?tipus IndividuAmbFills) (eq ?tipus IndividuFutursFills) (eq ?tipus GrupEstudiants)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (numeroBanys ?numBanys))
    (test (> ?numBanys 1))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri nombre-banys)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb nombre de banys minim)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri nombre-banys)))
)

(defrule resolucio-puntuar-dormitoris-individuals-estudiants
    (fase (actual scoring))
    ?sol <- (object (is-a ?tipus) (numeroPersones ?numPersones))
    (test (or (eq ?tipus GrupEstudiants) (eq ?tipus Individu)))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (numeroDormitorisSimples ?dorm-simples))
    ; Mirem si el nombre de dormitoris simple es mes gran o igual que el nombre de persones quan son Individus (no parelles) o grups d'estudiants
    (test (or (< ?numPersones ?dorm-simples ) (eq ?numPersones ?dorm-simples)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri nombre-dormitoris-simples)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb nombre de dormitoris suficicient)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri nombre-dormitoris-simples)))
)

(defrule resolucio-puntuar-universitat
    (fase (actual scoring))
    ?sol <- (object (is-a Joves))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia ?dist))
    (test (eq ?cat Universitat))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-universitat)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'una Universitat)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-universitat)))
)

(defrule resolucio-puntuar-autopista
    ;; De moment agafa tots els solicitants. Mirar si es pot afegr un requisit-inferit d'autopista
    
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia ?dist))
    (test (eq ?cat Autopista))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-autopista)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'una Autopista)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-autopista)))
)

(defrule resolucio-puntuar-comerços
    (fase (actual scoring))
    ?sol <- (object (is-a Adults))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia ?dist))
    (test (eq ?cat ServeiComercial))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-comerç)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'un servei comercial)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-comerç)))
)

(defrule resolucio-puntuar-oci-joves
    (fase (actual scoring))
    ?sol <- (object (is-a Joves))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia ?dist))
    (test ( or (eq ?cat TransportPublic) (eq ?cat Bar) (eq ?cat Discoteca) (eq ?cat Gimnas)))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-oci-joves)))
    =>
    (modify ?rec (puntuacio (+ ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA +10 A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'un servei de salut)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-oci-joves)))
)

(defrule resolucio-puntuar-oci-adults
    (fase (actual scoring))
    ?sol <- (object (is-a Adults))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia ?dist))
    (test ( or (eq ?cat Cinema) (eq ?cat Teatre) (eq ?cat Restaurants)))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-oci-adults)))
    =>
    (modify ?rec (puntuacio (+ ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA +10 A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'oci per adults)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-oci-adults)))
)

(defrule resolucio-puntuar-oci-avis
    (fase (actual scoring))
    ?sol <- (object (is-a PersonaGran))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia ?dist))
    (test ( or (eq ?cat Teatre) (eq ?cat Restaurants)))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-oci-avis)))
    =>
    (modify ?rec (puntuacio (+ ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA +10 A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'oci per persones grans)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-oci-avis)))
)

(defrule resolucio-puntuar-molta-proximitat-salut
    (fase (actual scoring))
    ?sol <- (object (is-a PersonaGran))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp))
    (test (eq ?cat ServeiSalut))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri molta-proximitat-salut)))
    =>
    (modify ?rec (puntuacio (+ ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA +10 A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'un servei de salut)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri molta-proximitat-salut)))
)

(defrule resolucio-puntuar-servei-preferit
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (prefereixServei $? ?serveiPreferit $?))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab))
    (proximitat (habitatge ?hab) (servei ?serveiPreferit) (distancia ?dist))
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-serveis-preferits)))
    =>
    (modify ?rec (puntuacio (+ ?pts 5)))
    (debug-print [RESOLUCIO] PUNTUADA +5 A (instance-name ?of) per (instance-name ?sol) - Habitatge a prop d'un servei preferit)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-serveis-preferits)))
)


;;; --- REGLES DE CRITERIS NO COMPLERTS ---

(defrule resolucio-criteri-preu-alt
    "Preu lleugerament superior (marge flexible)"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (and (> ?preu ?max) (<= ?preu (* ?max 1.15))))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri preu-lleugerament-superior)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge amb preu superior al pressupost)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri preu-lleugerament-superior)))

    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Preu lleugerament superior al pressupost")))
)

(defrule resolucio-criteri-soroll-alt
    "Habitatge amb nivell de soroll alt"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (nivellSoroll "Alt"))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri molt-soroll)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge amb molt soroll)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri molt-soroll)))

    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Nivell de soroll alt")))
)

(defrule resolucio-criteri-sense-ascensor
    "Planta alta sense ascensor"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (edat ?edat))
    
    ; (test (> ?edat 60))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 2))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri planta-alta-sense-ascensor)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge sense ascensor)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri planta-alta-sense-ascensor)))

    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Planta alta sense ascensor")))
)

;;; --- REGLES DE PUNTS POSITIUS ---

(defrule resolucio-punt-bon-preu
    "El preu es molt bo (menys del 80% del pressupost)"
    (fase (actual scoring))
    ?sol <- (object (is-a Joves) (pressupostMaxim ?max))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (< ?preu (* ?max 0.8)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri planta-alta-sense-ascensor)))
    =>
    (modify ?rec (puntuacio (+ ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA +10 A (instance-name ?of) per (instance-name ?sol) - Molt bon preu)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri planta-alta-sense-ascensor)))

    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Preu molt bo (>20% estalvi)")))
)

(defrule resolucio-punt-terrassa
    "Habitatge amb terrassa"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant)) 
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teTerrassaOBalco si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-terrassa)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb terrassa)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-terrassa)))

    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te terrassa o balco")))
)

(defrule resolucio-punt-assolellat
    "L'habitatge es molt assolellat"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (orientacioSolar "TotElDia"))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri es-assolellat)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb sol tot el dia)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri es-assolellat)))

    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Molt assolellat")))
)

(defrule resolucio-punt-vistes
    "Habitatge amb vistes al mar o muntanya per a segones residencies"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant)) 
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teVistes si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri bones-vistes)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb bones vistes)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri bones-vistes)))

    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te bones vistes")))
)

(defrule resolucio-punt-piscina
    "Habitatge amb piscina"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant)) 
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (tePiscinaComunitaria si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-piscina)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Habitatge amb terrassa)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri te-piscina)))

    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Te piscina comunitaria")))
)

(defrule resolucio-punt-requisit-inferit-molt-a-prop
    "Dona punts si l'habitatge satisfà una necessitat inferida (ex: parc per nens)"
    (fase (actual scoring))
    ;; Si tenim un requisit inferit (encara que no sigui obligatori)
    (requisit-inferit (solicitant ?sol) (categoria-servei ?cat) (motiu ?motiuTxt))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    ;; I tenim un servei d'aquesta categoria a prop
    (proximitat (habitatge ?hab) (categoria ?cat) (distancia MoltAProp))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri req-inferit-mol-a-prop)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print [RESOLUCIO] PUNTUADA +20p A (instance-name ?of) per (instance-name ?sol) - Preferència detectada a prop)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri req-inferit-mol-a-prop)))

    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio (str-cat "Preferència detectada molt a prop"))))
)


(defrule resolucio-puntuar-habitacio-doble-families
    "Puntua si l'habitatge té almenys una habitació doble per a parelles, famílies o avis"
    (fase (actual scoring))
       
    ?sol <- (object (is-a ?tipus))
    (test (or (eq ?tipus ParellaJove) 
              (eq ?tipus ParellaAdulta)
              (eq ?tipus ParellaAmbFills) 
              (eq ?tipus ParellaFutursFills)
              (eq ?tipus ParellaSenseFills)
              (eq ?tipus IndividuAmbFills)    
              (eq ?tipus IndividuFutursFills)
              (eq ?tipus PersonaGran)))       
              
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))

    ?h <- (object (is-a Habitatge) (name ?hab) (numeroDormitorisDobles ?nd))
    (test (>= ?nd 1))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri habitacio-doble)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print  [RESOLUCIO] PUNTUADA +20p a (instance-name ?of) per tenir habitacio doble)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri habitacio-doble)))
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Disposa d'habitació doble") (punts 20)))
)




(defrule resolucio-puntuar-autopista
    "Puntua autopista només si s'ha inferit que la necessita (treballa fora)"
    (fase (actual scoring))
    (requisit-inferit (solicitant ?sol) (categoria-servei Autopista))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    (proximitat (habitatge ?hab) (categoria Autopista) (distancia ?dist))
    
    (test (or (eq ?dist MoltAProp) (eq ?dist DistanciaMitjana)))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-autopista)))
    =>
    (modify ?rec (puntuacio (+ ?pts 20)))
    (debug-print  [RESOLUCIO] PUNTUADA +20p a (instance-name ?of) per Autopista a prop)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri proximitat-autopista)))
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio "Acces facil a autopista (Necessari per feina)") (punts 20)))
)


(defrule resolucio-puntuar-pressupost
    "Puntua segons si el preu esta dins el pressupost (amb bonus per preus molt bons)"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (pressupostMinim ?min))
    ?of <- (object (is-a Oferta) (disponible si) (preuMensual ?preu))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri pressupost)))
    (test (and (< ?preu (* ?max 1.15)) (> ?preu (* ?min 0.85))))
    =>
    ;; Calcula puntuacio segons relacio preu/pressupost
    (bind ?punts 0)
    (bind ?missatge "")
    
    (if (< ?preu (* ?max 0.7))
    then 
        (bind ?punts 50)
        (bind ?missatge "Preu excepcional (>30% estalvi)")
    else (if (< ?preu (* ?max 0.8))
    then
        (bind ?punts 40)
        (bind ?missatge "Preu molt bo (>20% estalvi)")
    else (if (and (<= ?preu ?max) (>= ?preu ?min))
    then
        (bind ?punts 30)
        (bind ?missatge "Pressupost perfecte")
    else
        (bind ?punts 20)
        (bind ?missatge "Pressupost adequat")
    )))
    
    (modify ?rec (puntuacio (+ ?pts ?punts)))
    (assert (punt-positiu (solicitant ?sol) (oferta ?of) (descripcio ?missatge) (punts ?punts)))
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri pressupost)))
    (debug-print  [RESOLUCIO] PUNTUADA +20p a (instance-name ?of) per ?missatge)
)


;;; --- REGLES DE CRITERIS NO COMPLERTS ---

(defrule resolucio-criteri-preu-alt
    "Preu lleugerament superior (marge flexible)"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (pressupostMaxim ?max) (margeEstricte no))
    ?of <- (object (is-a Oferta) (preuMensual ?preu) (disponible si))
    (test (and (> ?preu ?max) (<= ?preu (* ?max 1.15))))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri preu-lleugerament-superior)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge amb preu superior al pressupost)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri preu-lleugerament-superior)))

    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Preu lleugerament superior al pressupost")))
)

(defrule resolucio-criteri-soroll-alt
    "Habitatge amb nivell de soroll alt"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (nivellSoroll "Alt"))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri molt-soroll)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge amb molt soroll)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri molt-soroll)))

    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Nivell de soroll alt")))
)

(defrule resolucio-criteri-sense-ascensor
    "Planta alta sense ascensor"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant) (edat ?edat))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (teAscensor no) (plantaPis ?planta))
    (test (> ?planta 2))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri planta-alta-sense-ascensor)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge sense ascensor)
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri planta-alta-sense-ascensor)))

    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Planta alta sense ascensor")))
)

(defrule resolucio-criteri-poc-assolellat
    "Penalitza habitatges amb poca llum natural"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (orientacioSolar "Mai"))
    
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri poc-assolellat)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Poca llum natural") (gravetat Lleu)))
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri poc-assolellat)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Habitatge poc assolellat)
)

(defrule resolucio-criteri-baixa-eficiencia
    "Penalitza habitatges amb mala qualificació energètica"
    (fase (actual scoring))
    ?sol <- (object (is-a Solicitant))
    ?of <- (object (is-a Oferta) (teHabitatge ?hab) (disponible si))
    ?h <- (object (is-a Habitatge) (name ?hab) (consumEnergetic ?ce))
    (test (or (eq ?ce F) (eq ?ce G)))
    
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    (not (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri baixa-eficiencia)))
    =>
    (modify ?rec (puntuacio (- ?pts 10)))
    (assert (criteri-no-complert (solicitant ?sol) (oferta ?of) (criteri "Baixa eficiència energètica (F/G)") (gravetat Lleu)))
    (assert (criteriAplicat (solicitant ?sol) (oferta ?of) (criteri baixa-eficiencia)))
    (debug-print [RESOLUCIO] PUNTUADA -10 A (instance-name ?of) per (instance-name ?sol) - Baixa eficiència energètica)
)

;;; --- REGLA DE CLASSIFICACIO ---

(defrule classificacio-assignar-grau
    (fase (actual classificacio))
    ?rec <- (Recomanacio (solicitant ?sol) (oferta ?of) (puntuacio ?pts) (grau NULL))
    (not (oferta-descartada (solicitant ?sol) (oferta ?of)))
    =>
    (if (>= ?pts 70) then
        (modify ?rec (grau MoltRecomanable))
    else (if (>= ?pts 40) then
        (modify ?rec (grau Adequat))
    else (if (> ?pts 0) then
        (modify ?rec (grau Parcialment))
    )))
    (bind ?nouGrau (fact-slot-value ?rec grau))
    (debug-print [CLASSIFICACIO] (instance-name ?of) classificat-com ?nouGrau per (instance-name ?sol) amb-puntuacio ?pts)
)

;;; ============================================================
;;; FASE 5: PRESENTACIÓ 
;;; ============================================================

(defrule presentacio-completada
    (declare (salience -10))
    (fase (actual presentacio))
    =>
    (printout t crlf "[SISTEMA] Fase de resolució completada" crlf)
    (load presentacio.clp)
)