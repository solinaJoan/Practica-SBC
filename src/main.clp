;;; ============================================================
;;; main.clp
;;; Sistema Expert Interactiu de Recomanació d'Habitatges
;;; VERSIÓ FINAL - CORREGIDA
;;; ============================================================

;;; --- FUNCIONS AUXILIARS ---

(deffunction pregunta-si-no (?pregunta)
    (printout t ?pregunta " (si/no): ")
    (bind ?resp (read))
    (while (and (neq ?resp si) (neq ?resp no))
        (printout t "Si us plau, respon 'si' o 'no': ")
        (bind ?resp (read))
    )
    ?resp
)

(deffunction pregunta-numero (?pregunta ?min ?max)
    (printout t ?pregunta " [" ?min "-" ?max "]: ")
    (bind ?resp (read))
    (while (or (not (numberp ?resp)) (< ?resp ?min) (> ?resp ?max))
        (printout t "Si us plau, introdueix un numero entre " ?min " i " ?max ": ")
        (bind ?resp (read))
    )
    ?resp
)

(deffunction pregunta-text (?pregunta)
    (printout t ?pregunta ": ")
    (bind ?resp (readline))
    ?resp
)

(deffunction pregunta-opcio (?pregunta $?opcions)
    (printout t ?pregunta crlf)
    (bind ?i 1)
    (foreach ?opc ?opcions
        (printout t "   " ?i ". " ?opc crlf)
        (bind ?i (+ ?i 1))
    )
    (bind ?resp (pregunta-numero "Tria una opcio" 1 (length$ ?opcions)))
    (nth$ ?resp ?opcions)
)

(deffunction pregunta-multiopcio (?pregunta $?opcions)
    (printout t ?pregunta crlf)
    (printout t "   0. Cap servei molest" crlf)
    (bind ?i 1)
    (foreach ?opc ?opcions
        (printout t "   " ?i ". " ?opc crlf)
        (bind ?i (+ ?i 1))
    )
    (printout t crlf "Tria una o més opcions (separades per espais, o 0 per cap): ")
    (bind $?numeros (explode$ (readline)))
    (bind $?resposta (create$))
    (foreach ?n $?numeros
       (bind ?idx (integer ?n))
       (if (and (>= ?idx 1) (<= ?idx (length$ ?opcions))) then
            (bind $?resposta (create$ $?resposta (nth$ ?idx ?opcions)))
        )
    )
    ?resposta
)

;;; --- CREACIÓ PERFIL ---

(deffunction crear-perfil-solicitant ()
    (printout t crlf "============================================================" crlf)
    (printout t "          CREACIÓ DEL PERFIL DEL SOL·LICITANT" crlf)
    (printout t "============================================================" crlf)
    
    (printout t crlf "--- 1. DADES PERSONALS ---" crlf)
    (bind ?nom (pregunta-text "Nom del sol·licitant"))
    (bind ?edat (pregunta-numero "Edat del sol·licitant principal" 18 99))
    
    (printout t crlf "--- 2. CONVIVÈNCIA ---" crlf)
    (bind ?num-persones (pregunta-numero "Quantes persones viuran al pis (incloent-te a tu)" 1 10))
    (bind ?num-fills 0)
    (bind ?edats-fills (create$))
    (bind ?te-avis no)

    (if (> ?num-persones 1) then
        (bind ?té-fills (pregunta-si-no "Hi haurà fills menors convivint"))
        (if (eq ?té-fills si) then
            (bind ?num-fills (pregunta-numero "Quants fills" 1 (- ?num-persones 1)))
            (loop-for-count (?i 1 ?num-fills)
                (bind ?edat-fill (pregunta-numero (str-cat "Edat del fill " ?i) 0 17))
                (bind ?edats-fills (create$ ?edats-fills ?edat-fill))
            )
        )
        (if (< (+ 1 ?num-fills) ?num-persones) then
             (bind ?te-avis (pregunta-si-no "Conviureu amb persones grans (>65 anys)"))
        )
    )

    (printout t crlf "--- 3. ECONOMIA I HABITATGE ---" crlf)
    (bind ?pres-max (pregunta-numero "Pressupost màxim (EUR)" 300 6000))
    (bind ?pres-min (pregunta-numero "Pressupost mínim ideal (EUR)" 0 ?pres-max))
    (bind ?marge-estricte (pregunta-si-no "El pressupost màxim és infranquejable (sense marge)"))

    (printout t crlf "--- 4. UBICACIÓ I MOBILITAT ---" crlf)
    (bind ?treballa-ciutat (pregunta-si-no "El lloc de treball principal és a la ciutat"))
    (bind ?estudia-ciutat no)
    (if (and (< ?edat 30) (eq ?treballa-ciutat no)) then
        (bind ?estudia-ciutat (pregunta-si-no "Estudies a la ciutat (Universitat/Màster)"))
    )
    (bind ?te-vehicle (pregunta-si-no "Disposeu de cotxe propi"))
    (bind ?req-transport no)
    (if (eq ?te-vehicle no) then
        (printout t ">> Com que no teniu cotxe..." crlf)
        (bind ?req-transport (pregunta-si-no "És imprescindible tenir Metro/Bus a menys de 5 minuts"))
    else
        (bind ?req-transport (pregunta-si-no "Tot i tenir cotxe, voleu transport públic a prop"))
    )
    
    (bind ?nec-access no)
    (if (or (eq ?te-avis si) (> ?edat 65)) then
        (bind ?nec-access (pregunta-si-no "És IMPRESCINDIBLE que l'edifici tingui ascensor/accessibilitat"))
    else
        (bind ?nec-access (pregunta-si-no "Necessiteu accés per a mobilitat reduïda (cadira rodes, etc.)"))
    )

    (printout t crlf "--- 5. ALTRES ---" crlf)
    (bind ?te-mascotes (pregunta-si-no "Teniu mascotes"))
    (bind ?num-mascotes 0)
    (bind ?tipus-mascota "Cap")
    (if (eq ?te-mascotes si) then
        (bind ?tipus-mascota (pregunta-opcio "Quin tipus principal?" Gos Gat Altre))
        (bind ?num-mascotes (pregunta-numero "Quantes mascotes" 1 5))
    )
    (bind $?serveis-molestos
        (pregunta-multiopcio "Voleu EVITAR viure a prop d'algun d'aquests llocs?" Discoteca Parc Estadi Bar Mercat Autopista Aeroport)
    )

    (bind ?classe Solicitant)
    (if (eq ?estudia-ciutat si) then (bind ?classe GrupEstudiants)
    else (if (> ?edat 65) then (bind ?classe PersonaGran)
    else (if (> ?num-persones 1) then
        (if (> ?num-fills 0) then (bind ?classe FamiliaBiparental)
        else (bind ?classe ParellaSenseFills))
    else (bind ?classe Individu))))

    (printout t crlf ">> Perfil detectat: " ?classe crlf)
    (bind ?nom-inst (sym-cat sol- (gensym*)))

    (make-instance ?nom-inst of ?classe
        (nom ?nom) (edat ?edat) (numeroPersones ?num-persones)
        (pressupostMaxim ?pres-max) (pressupostMinim ?pres-min) (margeEstricte ?marge-estricte)
        (numeroFills ?num-fills) (edatsFills ?edats-fills) (teAvis ?te-avis)
        (teVehicle ?te-vehicle) (requereixTransportPublic ?req-transport)
        (necessitaAccessibilitat ?nec-access) (teMascotes ?te-mascotes)
        (numeroMascotes ?num-mascotes) (tipusMascota ?tipus-mascota)
        (treballaACiutat ?treballa-ciutat) (estudiaACiutat ?estudia-ciutat)
        (evitaServei $?serveis-molestos)
    )
    ?nom-inst
)

(deffunction main ()
    "Funció principal amb neteja d'instàncies antigues"
    (printout t crlf "============================================================" crlf)
    (printout t "   SISTEMA EXPERT D'HABITATGES - v3.0 (Final)" crlf)
    (printout t "============================================================" crlf)
    
    (reset)
    (bind ?crear-nou (pregunta-si-no "Vols crear un nou perfil de sol·licitant"))
    
    (if (eq ?crear-nou si) then
        ;; CORRECCIÓ AQUI: Usem (send ?s delete) en lloc de (delete ?s)
        (do-for-all-instances ((?s Solicitant)) TRUE (send ?s delete))
        
        (bind ?perfil (crear-perfil-solicitant))
        (printout t crlf "Iniciant cerca personalitzada per a " ?perfil "..." crlf)
        (run)
    else
        (printout t crlf "Usant perfils de prova..." crlf)
        (run)
    )
    (printout t "============================================================" crlf)
)