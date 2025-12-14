
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