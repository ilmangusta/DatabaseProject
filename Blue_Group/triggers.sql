create or REPLACE trigger tr_prenotazionevisita
before insert on PRENOTAZIONEVISITA
for EACH row
DECLARE
    v_prenotati number := 0;
    n_guide NUMBER := 0;
    v_maxprenotati number;
    V_COUNT INTEGER;
BEGIN

    SELECT NPERSONE into v_maxprenotati
    from VISITAGUIDATA
    where IDVISITA = :new.IDVISITA;

    SELECT COUNT(*)
    INTO N_GUIDE
    FROM GUIDA
    INNER JOIN GESTISCE ON GUIDA.IDGUIDA = GESTISCE.IDGUIDA
    WHERE IDVISITA = :NEW.IDVISITA
        and LINGUA = :NEW.LINGUA;
    
    V_MAXPRENOTATI := N_GUIDE * V_MAXPRENOTATI;

    SELECT COUNT(*) INTO V_COUNT
    FROM PRENOTAZIONEVISITA PV
    WHERE PV.LINGUA = :NEW.LINGUA
    AND PV.IDVISITA = :NEW.IDVISITA;

    IF V_COUNT > 0 THEN
        SELECT SUM(PV.NUMEROBIGLIETTI) INTO V_PRENOTATI
        FROM PRENOTAZIONEVISITA PV
        WHERE PV.LINGUA = :NEW.LINGUA
        AND PV.IDVISITA = :NEW.IDVISITA;
    END IF;
    if (v_prenotati + :new.NUMEROBIGLIETTI) > v_maxprenotati then
        raise_application_error(-20001, 'Numero biglietti superiore a ' || v_maxprenotati );
    end if;

end;