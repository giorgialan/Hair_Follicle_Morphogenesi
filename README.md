# Hair_Follicle_Morphogenesi
# Instabilità di Turing nella Morfogenesi del Follicolo Pilifero: Analisi di Stabilità e Biforcazione
Questo repository contiene il codice Matlab utilizzato per la simulazione e l'analisi della formazione di pattern nei follicoli piliferi tramite il modello di reazione-diffusione di Turing. Il codice è stato sviluppato nell'ambito della tesina per il corso di **Modelli Matematici per la Biomedicina**, intitolata "Instabilità di Turing nella morfogenesi del follicolo pilifero: analisi di stabilità e biforcazione".
Oltre al codice Matlab, il repository include un modello implementato su COMSOL Multiphysics che simula la formazione di pattern attraverso meccanismi di tipo Turing. 

# Descrizione
Il codice qui contenuto implementa un modello di morfogenesi basato su equazioni di reazione-diffusione. Questo modello permette di simulare l'insorgenza di pattern spaziali, come quelli che si osservano nei follicoli piliferi, attraverso il meccanismo dell'instabilità di Turing. Tale meccanismo descrive come piccole perturbazioni in un sistema omogeneo possano crescere e portare alla formazione di strutture ordinate, grazie all'interazione tra reazione chimica e diffusione.
Le simulazioni condotte con questo codice mostrano come variando specifici parametri del sistema (ad esempio, i tassi di diffusione o le costanti di reazione), sia possibile passare da stati omogenei stabili a stati instabili caratterizzati da pattern ben definiti. Il codice esegue inoltre un'analisi delle biforcazioni del sistema, esplorando come la stabilità del modello cambi al variare di questi parametri e identificando le condizioni per l'insorgere di instabilità di Turing.

# Struttura del Codice Matlab
Il repository è suddiviso nelle seguenti principali componenti:
1. **Simulazione della PDE di Turing** (TuringPDE.m):
   - Questa funzione implementa la simulazione delle equazioni di reazione-diffusione su una griglia spaziale 2D. 
   - Le concentrazioni delle due specie chimiche coinvolte nel modello, l'attivatore u e l'inibitore v, evolvono nel tempo seguendo i meccanismi di reazione e diffusione.
   - La simulazione permette di osservare la formazione di pattern morfogenetici tipici di instabilità di Turing.
   - Vengono applicate condizioni al contorno periodiche per garantire la coerenza della simulazione su un dominio senza confini netti.


   <img width="243" alt="1" src="https://github.com/user-attachments/assets/2683508b-f342-493e-93dd-d0bd0a354db8">

1. **Analisi delle Biforcazioni** (Bifurcation_Turing.m):
   - Questa funzione svolge un'analisi della stabilità del sistema, calcolando i punti fissi delle variabili u e v e verificando la comparsa di instabilità di Turing.
   - La funzione valuta la matrice Jacobiana e analizza la relazione di dispersione per determinare le condizioni sotto cui le perturbazioni nelle concentrazioni si amplificano, portando alla formazione di pattern.
   - Viene prodotto un diagramma di biforcazione che descrive le regioni di stabilità e di formazione di pattern spaziali nel piano dei parametri.

L'obiettivo di questo codice è fornire uno strumento per lo studio numerico del processo di morfogenesi dei follicoli piliferi, simulando la formazione di pattern e analizzando le condizioni che portano a tali strutture. Il modello implementato può essere utilizzato per comprendere meglio come le instabilità di Turing contribuiscono alla formazione spontanea di pattern organizzati nei tessuti biologici, con applicazioni in biologia dello sviluppo, medicina rigenerativa e biologia dei sistemi.

<img width="241" alt="blah" src="https://github.com/user-attachments/assets/7172dadb-3c85-4885-8ef3-2f17bdb4d05c">


# Struttura del Codice COMSOL Multiphysics
Utilizzando COMSOL, vengono risolte le equazioni di reazione-diffusione attraverso l'interfaccia 'Coefficient form PDE', utilizzando variabili dipendenti per l'attivatore 'a' e l'inibitore 'h'. Inoltre, viene utilizzata una 'Random function' per introdurre rumore nelle condizioni iniziali, al fine di simulare realisticamente la formazione di pattern.
