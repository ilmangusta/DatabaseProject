# Documentazione autorizzazioni LBD 22/23

# Table of Contents

1.  [Contenuto del pacchetto](#org6789c33)
    1.  [Eccezioni](#orgffefbf7)
    2.  [Tipi di dato](#org64e3da4)
    3.  [Costanti](#org6ea2316)
        1.  [Costanti per la tipologia dei permessi](#org55407d9)
    4.  [Procedure](#org0973b44)
        1.  [daiRuolo](#org92c75d0)
        2.  [assumi](#org85c88e2)
    5.  [Funzioni](#orgedbd217)
        1.  [haPermesso](#orgdb726b9)
        2.  [getPermessi](#org742284c)



<a id="org6789c33"></a>

# Contenuto del pacchetto


<a id="orgffefbf7"></a>

## Eccezioni

-   `UTENTE_NON_TROVATO`: viene sollevata quando l'id utente fornito non è valido
-   `UTENTE_NON_DIPENDENTE`: viene sollevata quando l'id utente fornito non appartiene ad un dipendente
-   `ROULO_NON_TROVATO`: viene sollevata quando l'id del ruolo fornito non è valido
-   `UTENTE_GIA_ASSUNTO`: viene sollevata se si tenta di assumere un utente già assunto
-   `PERMESSO_NON_TROVATO`: viene sollevata quando l'id del permesso fornito non è valido


<a id="org64e3da4"></a>

## Tipi di dato

-   `NomiPermessi_t`: un array di nomi di permessi (TABLE OF Permesso.Nome%TYPE)


<a id="org6ea2316"></a>

## Costanti


<a id="org55407d9"></a>

### Costanti per la tipologia dei permessi

Offrono un metodo mnemonico per specificare la tipologia dei permessi.
È consigliabile utilizzare queste costanti nel caso venga modificato il modo in cui viene codificata la tipologia.

-   `tipo_permessi_inserimento`
-   `tipo_permessi_modifica`
-   `tipo_permessi_cancellazione`


<a id="org0973b44"></a>

## Procedure


<a id="org92c75d0"></a>

### daiRuolo


```sql
    PROCEDURE daiRuolo(
               IDUtente_p IN Utente.IDUtente%TYPE,
               IDRuolo_p IN Ruolo.IDRuolo%TYPE)
```

Associa ad un dipendente un ruolo

-   `IDUtente_p`: l'id dell'utente a cui assegnare il ruolo
-   `IDRuolo_p`: l'id del ruolo da assegnare all'utente

-   Eccezioni sollevate: `UTENTE_NON_TROVATO`, `ROULO_NON_TROVATO`, `UTENTE_NON_DIPENDENTE`


<a id="org85c88e2"></a>

### assumi


```sql
    PROCEDURE assumi(
               IDUtente_p IN Utente.IDUtente%TYPE)
```

Rende un utente un dipendente rendendo possibile associargli dei ruoli

-   `IDUtente_p`: l'id dell'utente da rendere un dipendente

-   Eccezioni sollevate: `UTENTE_NON_TROVATO`, `UTENTE_GIA_ASSUNTO`


<a id="orgedbd217"></a>

## Funzioni


<a id="orgdb726b9"></a>

### haPermesso


```sql
    FUNCTION haPermesso(IDPermesso_p IN Permesso.IDPermesso%TYPE)
    RETURN boolean
```

Controlla che l'utente associato alla sessione corrente possieda il permesso specificato

-   `IDPermesso_p`: l'id del permesso da verificare

-   Tipo di ritorno: booleano
-   Eccezioni sollevate: `SESSIONE_NON_TROVATA`, `UTENTE_NON_DIPENDENTE`


<a id="org742284c"></a>

### getPermessi

```sql
    FUNCTION getPermessi(
              tipoPermessi_p IN INT)
    RETURN NomiPermessi_t
```

Ritorna una lista di nomi di permessi, posseduti dall'utente a cui è assegnata la sessione corrente, appartenenti al tipo specificato

-   `tipoPermessi_p`: il tipo dei permessi da ritornare

-   Tipo di ritorno: `NomiPermessi_t`
-   Eccezioni sollevate:

