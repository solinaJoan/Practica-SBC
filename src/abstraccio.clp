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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com CompradorSegonaResidencia: ?n)
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com PersonaGran: ?n)
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com GrupEstudiants: ?n)
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com  ParellaJove: ?n)
)

(defrule crear-individu-jove
    "Individu Jove (<35)"
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com Jove: ?n)
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com ?classe ?n)
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com ?classe ?n)
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
    (debug-print [ABSTRACCIO] Solicitant categoritzat com ?classe ?n)
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
    (debug-print [ABSTRACCIO] (instance-name ?sol) necessita transport)
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
    (debug-print [ABSTRACCIO] (instance-name ?sol) necessita Autopista perquè treballa fora)
)

