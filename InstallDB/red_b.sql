CREATE OR REPLACE PACKAGE BODY ROSSO AS

------------- Gabriele -----------------

        NON_AUTORIZZATO EXCEPTION;

        permesso_inserisci1     CONSTANT PERMESSO.NOME%TYPE := 'cu_rosso';
        permesso_inserisci2     CONSTANT PERMESSO.NOME%TYPE := 'cu_tutto';
        permesso_cancella1      CONSTANT PERMESSO.NOME%TYPE := 'd_rosso';
        permesso_cancella2      CONSTANT PERMESSO.NOME%TYPE := 'd_tutto';
        permesso_stat           CONSTANT PERMESSO.NOME%TYPE := 'stat';

        PACKAGE_NAME            CONSTANT CHAR(5) := 'ROSSO';

        get_Boats_URL       CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+11) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.get_boats';
        put_Boats_URL       CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+10) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.put_boat';
        mod_Boats_URL       CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+13) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.modify_boat';
        del_Boats_URL       CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+13) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.delete_boat';
        get_Cabins_URL      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+16) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.get_boatCabins';
        put_Cabins_URL      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+12) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.put_cabins';
        mod_Cabins_URL      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+15) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.modify_cabins';
        del_Cabins_URL      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+15) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.delete_cabins';
        del_CabinT_URL      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+13) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.delete_TYPE';
        cabins_table_URL    CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+17) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.inserisciCabine';
        get_CabinT_URL      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+11) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.get_Types';
        change_room_av      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+12) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.room_Avail';
        delete_room_id      CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+10) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.del_room';
        get_room_inf        CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+16) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.get_type_rooms';
        inserisci_Navi_URL  CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+15) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.inserisciNavi';
        posti_occupati_url  CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+16) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.posti_occupati';
        cabine_scelte_url   CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+15) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.scelta_cabina';
        lingua_parlata_url  CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+16) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.lingua_parlata';
        quanto_occupate_url CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+16) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.occupiedNTimes';
        quanto_sepsavis_url CONSTANT CHAR(LENGTH(AUTHENTICATE.DOMINIO)+6+LENGTH(AUTHENTICATE.DB_UTENTE)+LENGTH(PACKAGE_NAME)+14) := AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.allRoomsBook';

        navi_ins_js VARCHAR2(10000) := 'const cabinsURL="'||cabins_table_URL||'",getBoatsEP="'||get_Boats_URL||'",putBoatsEP="'||put_Boats_URL||'",delBoatsEP="'||del_Boats_URL||'",modBoatsEP="'||mod_Boats_URL||'";commitADD=(e=>{let t=putBoatsEP;return t+="?p_Nome="+e.NomeNave+"&",t+="p_Lunghezza="+e.Lunghezza+"&",t+="p_Larghezza="+e.Larghezza+"&",t+="p_altezza="+e.Altezza+"&",t+="p_peso="+e.Peso+"&",t+="p_descrizione="+e.Descrizione,fetch(t,{method:"GET",header:{"content-type":"application/json"}})}),commitMOD=(e=>{let t=modBoatsEP;return t+="?p_idnave="+e.IdNave+"&",t+="p_Nome="+e.NomeNave+"&",t+="p_Lunghezza="+e.Lunghezza+"&",t+="p_Larghezza="+e.Larghezza+"&",t+="p_altezza="+e.Altezza+"&",t+="p_peso="+e.Peso+"&",t+="p_descrizione="+e.Descrizione,fetch(t,{method:"GET",header:{"content-type":"application/json"}})}),commitDEL=(e=>{let t=delBoatsEP;return t+="?p_idnave="+e.IdNave,fetch(t,{method:"GET",hedaer:{"content-type":"application/json"}})}),document.addEventListener("DOMContentLoaded",()=>{let e=[],t=new Tabulator("#tabella",{persistentLayout:!0,height:"311px",layout:"fitColumns",history:!0,columns:[{title:"ID",field:"IdNave"},{title:"Nome",field:"NomeNave",editor:"input"},{title:"Lunghezza",field:"Lunghezza",editor:"number"},{title:"Larghezza",field:"Larghezza",editor:"number"},{title:"Altezza",field:"Altezza",editor:"number"},{title:"Peso",field:"Peso",editor:"number"},{title:"Descrizione",field:"Descrizione",editor:"textarea"},{formatter:(e,t,o)=>"...",width:40,hozAlign:"center",cellClick:(e,t)=>{let o=t.getRow().getData().IdNave;window.location.href=cabinsURL+"?p_idnave="+o}},{formatter:(e,t,o)=>"x",width:40,hozAlign:"center",cellClick:(e,t)=>{t.getRow().delete()}}]});loadTable=(()=>{fetch(getBoatsEP,{method:"GET",header:{"content-type":"application/json"}}).then(e=>e.json()).then(o=>{t.setData(o.navi),e=JSON.parse(JSON.stringify(o.navi))})}),t.on("tableBuilt",loadTable);let o=document.querySelector("#undo"),i=document.querySelector("#redo"),d=document.querySelector("#refresh"),a=document.querySelector("#addRow"),n=document.querySelector("#submit");o.addEventListener("click",()=>{t.undo()}),i.addEventListener("click",()=>{t.redo()}),d.addEventListener("click",()=>{confirm("Le tue modifiche verranno perse, continuare?")&&(loadTable(),t.clearHistory(),o.disabled=!0,i.disabled=!0)}),a.addEventListener("click",()=>{t.addRow()}),n.addEventListener("click",()=>{n.disabled=!0,t.getDataCount();let d=[],a=[],s=[],l=[];for(row of t.getRows()){let t=row.getData();if(void 0===t.IdNave)a.push(t);else{d.push(t.IdNave);let o=Object.entries(t).sort().toString();e.some(e=>Object.entries(e).sort().toString()===o)||s.push(t)}}for(row of e)d.includes(row.IdNave)||l.push(row);document.querySelector("#result").innerHTML="loading...";for(r of(promises=[],a))promises.push(commitADD(r));for(r of s)promises.push(commitMOD(r));for(r of l)promises.push(commitDEL(r));Promise.all(promises).then(()=>{document.querySelector("#result").innerHTML="successo";loadTable(),t.clearHistory(),o.disabled=!0,i.disabled=!0,n.disabled=!1})}),t.on("historyUndo",()=>{o.disabled=0==t.getHistoryUndoSize(),i.disabled=0==t.getHistoryRedoSize()}),t.on("historyRedo",()=>{o.disabled=0==t.getHistoryUndoSize(),i.disabled=0==t.getHistoryRedoSize()}),t.on("cellEdited",e=>{o.disabled=0==t.getHistoryUndoSize(),i.disabled=0==t.getHistoryRedoSize()}),t.on("rowAdded",e=>{o.disabled=0==t.getHistoryUndoSize(),i.disabled=0==t.getHistoryRedoSize()}),t.on("rowDeleted",e=>{o.disabled=0==t.getHistoryUndoSize(),i.disabled=0==t.getHistoryRedoSize()})});';
        cabine_ins_js VARCHAR2(20000) := 'const getCabinsEP="'||get_Cabins_URL||'",putCabinsEP="'||put_Cabins_URL||'",delCabinsEP="'||del_Cabins_URL||'",modCabinsEP="'||mod_Cabins_URL||'",getTypesURL="'||get_CabinT_URL||'",modRoomEP="'||change_room_av||'",delRoomEP="'||delete_room_id||'",getCabinsN="'||get_room_inf||'",inserisciNaveURL="'||inserisci_Navi_URL||'";let loadTable,tableLoad=e=>()=>{fetch(getCabinsEP+"?p_idnave="+IDNAVE,{method:"GET",headers:{"content-type":"application/json"}}).then((e=>e.json())).then((t=>e.setData(t.tipocamere)))},deleteRow=(e,t)=>{tuple=t.getRow().getData();let o=delCabinsEP;o+="?p_idnave="+IDNAVE+"&",o+="p_n="+tuple.numeroCamere+"&",o+="p_tipologia="+tuple.Tipologia,fetch(o,{method:"GET",headers:{"content-type":"application/json"}}),t.getRow().delete()},modifyType=(e,t)=>{const o=document.createElement("div");o.classList.add("popup");const n=document.createElement("div");n.classList.add("popup-content");const l=document.createElement("label");l.textContent="Tipo";const a=document.createElement("label");a.textContent="Costo";const i=document.createElement("label");i.textContent="Piano";const d=document.createElement("input"),c=document.createElement("input"),p=document.createElement("input"),s=document.createElement("div");s.classList.add("button-container");const m=document.createElement("button");m.textContent="Cancel";const r=document.createElement("button");r.textContent="OK";const u=document.createElement("div");u.classList.add("fields-container"),u.appendChild(l),u.appendChild(d),u.appendChild(a),u.appendChild(c),u.appendChild(i),u.appendChild(p),n.appendChild(u),s.appendChild(m),s.appendChild(r),n.appendChild(s),o.appendChild(n);const h="display: inline-block; width: 100px; text-align: right;",C="display: inline-block; margin-left: 10px;";l.style.cssText=h,a.style.cssText=h,i.style.cssText=h,d.style.cssText=C,c.style.cssText=C,p.style.cssText=C,u.style.display="flex",u.style.flexDirection="column",s.style.display="flex",s.style.justifyContent="flex-end",m.style.marginLeft="10px",o.style.cssText="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); display: flex; justify-content: center; align-items: center; z-index: 9999;",n.style.cssText="background-color: white; width: 50%; height: 50%; display: flex; flex-direction: column;",document.body.appendChild(o),c.type="number",p.type="number";let g=t.getRow().getData();d.value=g.Tipologia,d.disabled=!0,p.value=g.pianonave,c.value=g.costo,m.onclick=()=>{document.body.removeChild(o)},r.onclick=()=>{let e=modCabinsEP;e+="?p_tipologia="+g.Tipologia+"&",e+="p_costo="+c.value+"&",e+="p_pianonave="+p.value,fetch(e,{method:"GET"}).then((e=>{document.body.removeChild(o),loadTable()})).catch((e=>{document.body.removeChild(o)}))}},deleteRoom=(e,t)=>{tuple=t.getRow().getData();let o=delCabinsEP;o+="?p_idnave="+IDNAVE+"&",o+="p_n=1&"+"p_tipologia="+tuple.Tipologia,fetch(o,{method:"GET"}),t.getRow().update({numeroCamere:tuple.numeroCamere-1})},addRoom=(e,t)=>{tuple=t.getRow().getData();let o=putCabinsEP;o+="?p_idnave="+IDNAVE+"&",o+="p_n=1&"+"p_tipologia="+tuple.Tipologia+"&",o+="p_costo="+(tuple.costo?tuple.costo:1)+"&",o+="p_piano="+(tuple.pianonave?tuple.pianonave:1),fetch(o,{method:"GET"}),t.getRow().update({numeroCamere:tuple.numeroCamere+1})},selectType=(e,t)=>{let o=t.getOldValue();if("new"===t.getValue()){let e=prompt("nome ?");if(!e)return void t.restoreOldValue();let o=prompt("costo ?");if(!o)return void t.restoreOldValue();let n=prompt("piano ?");if(!n)return void t.restoreOldValue();t.getRow().update({Tipologia:e,costo:o,piano:n})}let n=delCabinsEP;n+="?p_idnave="+IDNAVE+"&"+"p_n="+t.getRow().getData().numeroCamere+"&"+"p_tipologia="+o;let l=putCabinsEP;l+="?p_idnave="+IDNAVE+"&",l+="p_n="+(t.getRow().getData().numeroCamere?t.getRow().getData().numeroCamere:1)+"&",l+="p_tipologia="+t.getRow().getData().Tipologia+"&",l+="p_costo="+t.getRow().getData().costo+"&",l+="p_piano="+t.getRow().getData().pianonave;let a=[];a.push(fetch(n,{method:"GET"})),a.push(fetch(l,{method:"GET"})),Promise.all(a).then((()=>{loadTable()}))},roomFields=(e,t,o)=>{const n=document.createElement("tr"),l=document.createElement("td");l.innerHTML=e,n.appendChild(l);const a=document.createElement("td"),i=document.createElement("input");i.type="checkbox",i.checked=1==t,i.addEventListener("change",(()=>{let t=modRoomEP;t+="?p_id="+e+"&",t+="p_val="+(i.checked?1:0),fetch(t,{method:"GET"})})),a.appendChild(i),n.appendChild(a);const d=document.createElement("td"),c=document.createElement("span");c.classList.add("delete-btn"),c.textContent="x",c.addEventListener("click",(()=>{let t=delRoomEP;t+="?p_id="+e,fetch(t,{method:"GET"}),o.removeChild(n)})),d.appendChild(c),n.appendChild(d),o.appendChild(n)},modifyRooms=(e,t)=>{const o=document.createElement("div");o.id="popup";const n=document.createElement("table"),l=document.createElement("thead"),a=document.createElement("tbody"),i=document.createElement("tr"),d=document.createElement("th");d.textContent="ID",i.appendChild(d);const c=document.createElement("th");c.textContent="Availability",i.appendChild(c);const p=document.createElement("th");i.appendChild(p),l.appendChild(i);let s=getCabinsN;s+="?p_idnave="+IDNAVE+"&",s+="p_tipologia="+t.getRow().getData().Tipologia;fetch(s,{method:"GET"}).then((e=>e.json())).then((e=>{for(const t of e.rooms)roomFields(t.id,t.isFree,a)}));n.appendChild(l),n.appendChild(a),o.appendChild(n);const m=document.createElement("button");m.id="confirm-btn",m.textContent="Confirm",o.appendChild(m),o.style.cssText="position: fixed;top: 0;left: 0;width: 100%;height: 100%;background-color: rgba(0,0,0,0.5);z-index: 9999;display: flex;justify-content: center;align-items: center;",n.style.cssText="width: 50%;height: 50%;background-color: white;border: 1px solid black;overflow: auto;padding: 10px;",a.style.cssText="text-align: center;",m.style.cssText="position: absolute;bottom: 10px;right: 10px;",document.body.appendChild(o),m.addEventListener("click",(()=>{loadTable(),document.body.removeChild(o)}))};document.addEventListener("DOMContentLoaded",(()=>{let e=document.querySelector("#refresh"),t=document.querySelector("#addRow"),o=document.querySelector("#BACK"),n=new Tabulator("#tipi",{persistentLayout:!0,height:"311px",layout:"fitColumns",history:!0,columns:[{title:"Tipo",editor:"list",field:"Tipologia",editorParams:{valuesURL:getTypesURL}},{title:"costo",field:"costo",cellClick:modifyType},{title:"piano",field:"pianonave",cellClick:modifyType},{title:"ncamere",field:"numeroCamere"},{formatter:(e,t,o)=>"▲",cellClick:addRoom},{formatter:(e,t,o)=>"▼",cellClick:deleteRoom},{formatter:(e,t,o)=>"...",cellClick:modifyRooms},{formatter:(e,t,o)=>"x",cellClick:deleteRow}]});n.on("tableBuilt",loadTable=tableLoad(n),loadTable),n.on("cellEdited",(function(e){"list"===e.getColumn().getDefinition().editor&& selectType(n,e)})),e.addEventListener("click",(()=>{loadTable()})),t.addEventListener("click",(()=>{n.addRow()})),o.addEventListener("click",(()=>{window.location.href=inserisciNaveURL}))}));';
        tour_mig_js VARCHAR2(1500) := 'const LOADERURL="'||posti_occupati_url||'";function loadData(a,e,t){fetch(LOADERURL+("all"===e?"":`?p_idtour=${e}`),{method:"GET"}).then((a=>a.json())).then((e=>{let o=e.dati.map((a=>a.nave)),d=e.dati.map((e=>1==a?100-e.Rel:e.Tot-e.Free)),l=e.dati.map((e=>1==a?e.Rel:e.Free));t.config.data.labels=o,t.config.data.datasets[0].data=d,t.config.data.datasets[1].data=l,t.update()}))}document.addEventListener("DOMContentLoaded",(()=>{const a=document.querySelector("#tourSelect"),e=document.querySelector("#styleSelect"),t=document.querySelector("#myChart").getContext("2d"),o=new Chart(t,{type:"bar",data:{datasets:[{label:"occupati",backgroundColor:"rgba(0,255,0,0.7)"},{label:"liberi",backgroundColor:"rgba(255,0,0,0.7)"}]},options:{}});loadData(0,"all",o),a.addEventListener("change",(()=>{loadData(e.value,a.value,o)})),e.addEventListener("change",(()=>{loadData(e.value,a.value,o)}))}));';
        tipo_migl_js VARCHAR2(2000) := 'const LOADERURL="'||cabine_scelte_url||'";function randomColor(){let e=()=>Math.floor(256*Math.random()+0);return`rgba(${e()}, ${e()}, ${e()}, 0.7)`}function loadData(e,t,a){fetch(LOADERURL+("all"===e?"":`?p_idtour=${e}`),{method:"GET"}).then((e=>e.json())).then((e=>{let o=e.dati.reduce(((e,t)=>e+`<tr><td>${t.tipo}</td><td>${t.Tot}</td><td>${t.Free}</td><td>${t.Rel}</td></tr>`),"");a.innerHTML=o,t.config.data.labels=e.dati.map((e=>e.tipo)),t.config.data.datasets[0].data=e.dati.map((e=>e.Tot-e.Free)),t.config.data.datasets[0].backgroundColor=e.dati.map((e=>randomColor())),t.update()}))}document.addEventListener("DOMContentLoaded",(()=>{const e=document.querySelector("#Tabella");e.style.display="none";const t=document.querySelector("#tbody"),a=document.querySelector("#tourSelect"),o=document.querySelector("#graphSelect"),d=document.querySelector("#myChart"),s=d.getContext("2d"),l=new Chart(s,{type:"pie",data:{datasets:[{label:"scelte"}]},options:{scales:{x:{display:!1,grid:{display:!1}},y:{display:!1,grid:{display:!1}}}}});loadData("all",l,t),a.addEventListener("change",(()=>{loadData(a.value,l,t)})),o.addEventListener("change",(()=>{switch(o.value){case"0":l.config.type="pie",l.config.options.scales.x.grid.display=!1,l.config.options.scales.x.display=!1,l.config.options.scales.y.grid.display=!1,l.config.options.scales.y.display=!1,l.update(),e.style.display="none",d.style.display="block";break;case"1":l.config.type="bar",l.config.options.scales.x.grid.display=!0,l.config.options.scales.x.display=!0,l.config.options.scales.y.grid.display=!0,l.config.options.scales.y.display=!0,e.style.display="none",d.style.display="block",l.update();break;case"2":d.style.display="none",e.style.display="block";break}}))}));';
        ling_parl_js VARCHAR2(1500) := 'const LOADERURL="'||lingua_parlata_url||'";function randomColor(){let a=()=>Math.floor(256*Math.random()+0);return`rgba(${a()}, ${a()}, ${a()}, 0.7)`}function loadData(a,t){fetch("'||lingua_parlata_url||'",{method:"GET"}).then((a=>a.json())).then((e=>{let n=e.dati.reduce(((a,t)=>a+`<tr><td>${t.Lingua}</td><td>${t.Stima}</td>`),"");t.innerHTML=n,a.config.data.labels=e.dati.map((a=>a.Lingua)),a.config.data.datasets[0].data=e.dati.map((a=>a.Stima)),a.config.data.datasets[0].backgroundColor=e.dati.map((a=>randomColor())),a.update()}))}document.addEventListener("DOMContentLoaded",(()=>{const a=document.querySelector("#Tabella"),t=document.querySelector("#tbody"),e=document.querySelector("#graphSelect"),n=document.querySelector("#myChart");n.style.display="none";const o=n.getContext("2d"),d=new Chart(o,{type:"bar",data:{datasets:[{label:"lingue"}]},options:{}});loadData(d,t),e.addEventListener("change",(()=>{switch(e.value){case"0":a.style.display="block",n.style.display="none",loadData(d,t);break;case"1":a.style.display="none",n.style.display="block",loadData(d,t);break}}))}));';
        quanto_occ_js VARCHAR2(1500) := 'const LOADERURL="'||quanto_occupate_url||'";function randomColor(){let a=()=>Math.floor(256*Math.random()+0);return`rgba(${a()}, ${a()}, ${a()}, 0.7)`}function loadData(a,t,e){fetch(`'||quanto_occupate_url||'?p_n=${a}`,{method:"GET"}).then((a=>a.json())).then((a=>{e.innerHTML=a.dati.reduce(((a,t)=>a+`<tr><td>${t.Nave}</td><td>${t.idCamera}</td><td>${t.massimo}</td></tr>`),""),t.config.data.labels=a.dati.map((a=>a.Nave)),t.config.data.datasets[0].data=a.dati.map((a=>a.massimo)),t.config.data.datasets[0].backgroundColor=a.dati.map((a=>randomColor())),t.update()}))}document.addEventListener("DOMContentLoaded",(()=>{const a=document.querySelector("#Tabella"),t=document.querySelector("#tbody"),e=document.querySelector("#graphSelect"),o=document.querySelector("#n"),d=document.querySelector("#myChart"),n=d.getContext("2d"),l=new Chart(n,{type:"bar",data:{datasets:[{label:"Occupata volte x"}]},options:{}});loadData(0,l,t),o.addEventListener("change",(()=>{loadData(o.value,l,t)})),e.addEventListener("change",(()=>{switch(e.value){case"0":a.style.display="block",d.style.display="none",loadData(o.value,l,t);break;case"1":a.style.display="none",d.style.display="block",loadData(o.value,l,t);break}}))}));';
        quanto_spv_js VARCHAR2(1500) := 'const LOADERURL="'||quanto_sepsavis_url||'";function randomColor(){let a=()=>Math.floor(256*Math.random()+0);return`rgba(${a()}, ${a()}, ${a()}, 0.7)`}function loadData(a,e,t){fetch(`'||quanto_sepsavis_url||'?p_ratio=${a}`,{method:"GET"}).then((a=>a.json())).then((a=>{t.innerHTML=a.dati.reduce(((a,e)=>a+`<tr><td>${e.username}</td><td>${e.media}</td></tr>`),""),e.config.data.labels=a.dati.map((a=>a.username)),e.config.data.datasets[0].data=a.dati.map((a=>a.media)),e.config.data.datasets[0].backgroundColor=a.dati.map((a=>randomColor())),e.update()}))}document.addEventListener("DOMContentLoaded",(()=>{const a=document.querySelector("#Tabella"),e=document.querySelector("#tbody"),t=document.querySelector("#graphSelect"),o=document.querySelector("#alpha"),d=document.querySelector("#myChart"),n=d.getContext("2d"),l=new Chart(n,{type:"bar",data:{datasets:[{label:"Speso "}]},options:{}});loadData(0,l,e),o.addEventListener("change",(()=>{loadData(o.value,l,e)})),t.addEventListener("change",(()=>{switch(t.value){case"0":a.style.display="block",d.style.display="none",loadData(o.value,l,e);break;case"1":a.style.display="none",d.style.display="block",loadData(o.value,l,e);break}}))}));';


------------------ Luca ---------------------



    PROCEDURE FORMNUOVACROCIERA IS
        v_sessione sessione%rowtype;
        flag_insert1 boolean;
        flag_insert2 boolean;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_insert1:=authorize.HAPERMESSO(permesso_inserisci1);
        flag_insert2:=authorize.HAPERMESSO(permesso_inserisci2);
        if not flag_insert1 and not flag_insert2 then raise NON_AUTORIZZATO; END IF;

        GUI.APRIPAGINASTANDARD('Inserisci crociera');
        GUI.APRIFORM('FORM CARD','GET',''||PACKAGE_NAME||'.INSERISCICROCIERA','return confirm(`Confermi di inviare dati inseriti?`);');
        GUI.CARDHEADER('INSERISCI NUOVA CROCIERA',0);
        GUI.APRIFIELD(TESTO=>'IdTour');
        GUI.INPUT_FORM('input','number', 'uname', 'idtour','', 'Inserisci idtour');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'IdNave');
        GUI.INPUT_FORM('input','number', 'uname', 'idnave','', 'Inserisci idnave');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'DataCrociera');
        GUI.INPUT_FORM('input','date','start','datacrociera',to_char(sysdate, 'yyyy-MM-dd'));
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'CostoCrociera');
        GUI.INPUT_FORM('input','number', 'uname', 'costo','', 'Inserisci costo');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(ALLINEAMENTO =>'center');
        GUI.BTNSUBMIT(TXT =>'Inserisci');
        GUI.BTNRESET(TXT =>'Cancella');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIFORM();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END FORMNUOVACROCIERA;


    PROCEDURE INSERISCICROCIERA(
        IDTOUR IN TOUR.IDTOUR%TYPE DEFAULT NULL,
        IDNAVE IN NAVE.IDNAVE%TYPE DEFAULT NULL,
        DATACROCIERA IN VARCHAR2 DEFAULT NULL,
        COSTO IN CROCIERA.COSTOCROCIERA%TYPE DEFAULT NULL
    ) IS
    BEGIN

        INSERT INTO CROCIERA (
            IDCROCIERA,
            IDNAVE,
            IDTOUR,
            DATACROCIERA,
            COSTOCROCIERA,
            ISDISPONIBILE
        ) VALUES (
            IDCROCIERASEQ.NEXTVAL,
            IDNAVE,
            IDTOUR,
            TO_DATE(DATACROCIERA, 'YYYY-MM-DD'),
            COSTO,
            1
        );
        GUI.APRIPAGINASTANDARD('Inserisci crociera');
        GUI.ESITOPERAZIONE(ESITO  => 'SUCCESSO',
                           MESSAGGIO  =>'Inserito crociera con dati: '
            ||IDTOUR
            ||' '
            ||IDNAVE
            ||' '
            ||DATACROCIERA
            ||' '
            ||COSTO);
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when others then 
        gui.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
        GUI.ESITOPERAZIONE(ESITO  => 'KO',MESSAGGIO  =>'Inserimento fallito. Dati incorretti');
        GUI.CHIUDIPAGINASTANDARD('arancione');
    END INSERISCICROCIERA;




    PROCEDURE FORMNUOVAVISITADISPONIBILE IS
        v_sessione sessione%rowtype;
        flag_insert1 boolean;
        flag_insert2 boolean;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_insert1:=authorize.HAPERMESSO(permesso_inserisci1);
        flag_insert2:=authorize.HAPERMESSO(permesso_inserisci2);
        if not flag_insert1 and not flag_insert2 then raise NON_AUTORIZZATO; END IF;

        GUI.APRIPAGINASTANDARD('Inserisci visita');
        GUI.APRIFORM('FORM CARD','GET',''||PACKAGE_NAME||'.INSERISCIVISITADISPONIBILE','return confirm(`Confermi di inviare dati inseriti?`);');
        GUI.CARDHEADER('INSERISCI NUOVA VISITA DISPONIBILE',0);
        GUI.APRIFIELD(TESTO=>'IdCrociera');
        GUI.INPUT_FORM('input','number', 'uname', 'IDCR','', 'Inserisci idcrociera');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'IdVisita');
        GUI.INPUT_FORM('input','number', 'uname', 'IDVISITA','', 'Inserisci idvisita');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'DataVisita');
        GUI.INPUT_FORM('input','date','start','DATAVISITA',to_char(sysdate, 'yyyy-MM-dd'));
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(ALLINEAMENTO =>'center');
        GUI.BTNSUBMIT(TXT =>'Inserisci');
        GUI.BTNRESET(TXT =>'Cancella');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIFORM;
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END FORMNUOVAVISITADISPONIBILE;


    PROCEDURE INSERISCIVISITADISPONIBILE(
            IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
            IDVISITA IN VISITAGUIDATA.IDVISITA%TYPE DEFAULT NULL,
            DATAVISITA IN VARCHAR2 DEFAULT NULL
    ) IS
    BEGIN

        INSERT INTO VISITEDISPONIBILI (
            IDCROCIERA,
            IDVISITA,
            DATAVISITA
        ) VALUES (
            IDCR,
            IDVISITA,
            TO_DATE(DATAVISITA, 'YYYY-MM-DD')
        );
        GUI.APRIPAGINASTANDARD('Inserisci Visita');
        GUI.ESITOPERAZIONE(ESITO  => 'SUCCESSO',
                           MESSAGGIO  =>'Inserito Visita disponibile con dati: '
            ||IDCR
            ||' '
            ||IDVISITA
            ||' '
            ||DATAVISITA);
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when others then gui.APRIPAGINASTANDARD('Inserisci crociera');
        GUI.ESITOPERAZIONE(ESITO  => 'KO',MESSAGGIO  =>'Inserimento fallito. Data sbagliata o dati incorretti');
        GUI.CHIUDIPAGINASTANDARD('arancione');
    END INSERISCIVISITADISPONIBILE;


    PROCEDURE CROCIEREDISPONIBILI(
        DOVE IN PORTO.NOMEPORTO%TYPE DEFAULT NULL,
        QUANDO IN VARCHAR2 DEFAULT NULL
    )IS
    BEGIN
        GUI.APRIPAGINASTANDARD('Crociere disponibili');
        GUI.APRITABELLA('Elenco Crociere disponibili', 1);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome Tour ', 'align = center');
        GUI.CELLATABELLAHEADER('Costo Crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Data Crociera', 'align = center');
        GUI.CHIUDIRIGATABELLA();

        IF (QUANDO IS NULL AND DOVE IS NULL) THEN
            FOR CROCIERA IN (
                SELECT
                    IDTOUR,
                    NOMETOUR,
                    CR.COSTOCROCIERA,
                    CR.DATACROCIERA,
                    CR.IDCROCIERA
                FROM
                    PORTO    P
                    INNER JOIN INCLUDE I
                    USING (POSGEOGRAFICA)
                    INNER JOIN TOUR T
                    USING (IDTOUR)
                    INNER JOIN CROCIERA CR
                    USING (IDTOUR)
                WHERE
                    I.ORDINE='1'
                    AND CR.ISDISPONIBILE=1
                ORDER BY
                    CR.IDCROCIERA
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.infocrociera?tour='
                    ||CROCIERA.IDTOUR
                    ||'&'||'idcr='
                    || CROCIERA.IDCROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                GUI.CELLATABELLALINK(CROCIERA.DATACROCIERA,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.LISTACROCIEREPERMESE?DATACR='
                    ||CROCIERA.DATACROCIERA);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSIF (QUANDO IS NULL) THEN
            FOR CROCIERA IN (
                SELECT
                    IDTOUR,
                    NOMETOUR,
                    CR.COSTOCROCIERA,
                    CR.DATACROCIERA,
                    CR.IDCROCIERA
                FROM
                    PORTO    P
                    INNER JOIN INCLUDE I
                    USING (POSGEOGRAFICA)
                    INNER JOIN TOUR T
                    USING (IDTOUR)
                    INNER JOIN CROCIERA CR
                    USING (IDTOUR)
                WHERE
                    I.ORDINE='1'
                    AND LOWER(DOVE)=LOWER(P.NOMEPORTO)
                    AND CR.ISDISPONIBILE=1
                ORDER BY
                    CR.IDCROCIERA
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.infocrociera?tour='
                    ||CROCIERA.IDTOUR
                    ||'&'||'idcr='
                    || CROCIERA.IDCROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                GUI.CELLATABELLALINK(CROCIERA.DATACROCIERA,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.LISTACROCIEREPERMESE?DATACR='
                    ||CROCIERA.DATACROCIERA);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSIF (DOVE IS NULL) THEN
            FOR CROCIERA IN (
                SELECT
                    IDTOUR,
                    NOMETOUR,
                    COSTOCROCIERA,
                    DATACROCIERA,
                    IDCROCIERA
                FROM
                    PORTO    P
                    INNER JOIN INCLUDE I
                    USING (POSGEOGRAFICA)
                    INNER JOIN TOUR T
                    USING (IDTOUR)
                    INNER JOIN CROCIERA CR
                    USING (IDTOUR)
                WHERE
                    I.ORDINE='1'
                    AND (CR.DATACROCIERA - (TO_DATE(QUANDO,
                    'YYYY/MM/DD')) < 15)
                    AND (CR.DATACROCIERA - (TO_DATE(QUANDO,
                    'YYYY/MM/DD')) > -15)
                    AND CR.ISDISPONIBILE=1
                ORDER BY
                    CR.IDCROCIERA
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.infocrociera?tour='
                    ||CROCIERA.IDTOUR
                    ||'&'||'idcr='
                    || CROCIERA.IDCROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                GUI.CELLATABELLALINK(CROCIERA.DATACROCIERA,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.LISTACROCIEREPERMESE?DATACR='
                    ||CROCIERA.DATACROCIERA);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE
            FOR CROCIERA IN (
                SELECT
                    IDTOUR,
                    NOMETOUR,
                    CR.COSTOCROCIERA,
                    CR.DATACROCIERA,
                    CR.IDCROCIERA
                FROM
                    PORTO    P
                    INNER JOIN INCLUDE I
                    USING (POSGEOGRAFICA)
                    INNER JOIN TOUR T
                    USING (IDTOUR)
                    INNER JOIN CROCIERA CR
                    USING (IDTOUR)
                WHERE
                    I.ORDINE='1'
                    AND LOWER(DOVE)=LOWER(P.NOMEPORTO)
                    AND (CR.DATACROCIERA - (TO_DATE(QUANDO,
                    'DD/MM/YYYY')) < 15)
                    AND (CR.DATACROCIERA -(TO_DATE(QUANDO,
                    'DD/MM/YYYY')) > -15)
                    AND CR.ISDISPONIBILE=1
                ORDER BY
                    CR.IDCROCIERA
            )LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.infocrociera?tour='
                    ||CROCIERA.IDTOUR
                    ||'&'||'idcr='
                    || CROCIERA.IDCROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                GUI.CELLATABELLALINK(CROCIERA.DATACROCIERA,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.LISTACROCIEREPERMESE?DATACR='
                    ||CROCIERA.DATACROCIERA);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        END IF;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
    END CROCIEREDISPONIBILI;


    PROCEDURE VISITEDISPONIBILI (
        IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
        MESE_VISITA IN INTEGER DEFAULT NULL,
        ELIMINA IN INTEGER DEFAULT 0
    )IS
        v_sessione SESSIONE%ROWTYPE;
        f_cancella1 BOOLEAN;
        f_cancella2 BOOLEAN;
    BEGIN
        v_sessione:=authenticate.RECUPERA_SESSIONE();         
        GUI.APRIPAGINASTANDARD('Visite disponibili');
        IF (ELIMINA=1) THEN 
            f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
            f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
            if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;
                GUI.APRITABELLA('!CANCELLAZIONE VISITA!', 2);
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Id crociera', 'align = center');
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Durata Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Cancella visita', 'align = center');
                GUI.CHIUDIRIGATABELLA();
                FOR VISITA IN (
                    SELECT
                        VD.IDCROCIERA,
                        VD.IDVISITA,
                        NOMEVISITA,
                        DURATAVISITA,
                        COSTOVISITA,
                        DATAVISITA
                    FROM
                        VISITAGUIDATA     VG,
                        VISITEDISPONIBILI VD
                    WHERE
                        VD.IDVISITA=VG.IDVISITA
                ) LOOP
                    GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(VISITA.IDCROCIERA);
                    GUI.CELLATABELLA(VISITA.NOMEVISITA);
                    GUI.CELLATABELLA(VISITA.DURATAVISITA);
                    GUI.CELLATABELLA(VISITA.COSTOVISITA);
                    GUI.CELLATABELLA(VISITA.DATAVISITA);
                    GUI.CELLATABELLABTN(TXT =>'CANCELLA',LINKTO => Costanti.macchina2 || Costanti.radice || 'ROSSO.DELETEVISITA?Idcr='|| VISITA.IDCROCIERA ||'&' || 'idv= '|| VISITA.IDVISITA);
                    GUI.CHIUDIRIGATABELLA();
                END LOOP;  
        ELSE
            IF (MESE_VISITA is not null and IDCR is null) THEN
                GUI.APRITABELLA('Elenco visite disponibili per mese', 2);
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Durata Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
                GUI.CHIUDIRIGATABELLA();
                FOR VISITA IN (
                    SELECT
                        NOMEVISITA,
                        DURATAVISITA,
                        COSTOVISITA,
                        DATAVISITA
                    FROM
                        VISITAGUIDATA     VG,
                        VISITEDISPONIBILI VD
                    WHERE
                        VD.IDVISITA=VG.IDVISITA
                        AND EXTRACT (MONTH FROM VD.DATAVISITA)=MESE_VISITA
                ) LOOP
                    GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(VISITA.NOMEVISITA);
                    GUI.CELLATABELLA(VISITA.DURATAVISITA);
                    GUI.CELLATABELLA(VISITA.COSTOVISITA);
                    GUI.CELLATABELLA(VISITA.DATAVISITA);
                    GUI.CHIUDIRIGATABELLA();
                END LOOP;        
            ELSIF (IDCR is not null and MESE_VISITA is null) then
                GUI.APRITABELLA('Elenco visite disponibili per la crociera selezionata', 2);
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Durata Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
                GUI.CHIUDIRIGATABELLA();
                FOR VISITA IN (
                    SELECT
                        NOMEVISITA,
                        DURATAVISITA,
                        COSTOVISITA,
                        DATAVISITA
                    FROM
                        VISITAGUIDATA     VG,
                        VISITEDISPONIBILI VD
                    WHERE
                        VD.IDVISITA=VG.IDVISITA
                        AND VD.IDCROCIERA=IDCR
                ) LOOP
                    GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(VISITA.NOMEVISITA);
                    GUI.CELLATABELLA(VISITA.DURATAVISITA);
                    GUI.CELLATABELLA(VISITA.COSTOVISITA);
                    GUI.CELLATABELLA(VISITA.DATAVISITA);
                    GUI.CHIUDIRIGATABELLA();
                END LOOP;
            ELSE 
                GUI.APRITABELLA('Elenco tutte visite disponibili delle crociere ', 2);
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Durata Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
                GUI.CHIUDIRIGATABELLA();
                FOR VISITA IN (
                    SELECT
                        NOMEVISITA,
                        DURATAVISITA,
                        COSTOVISITA,
                        DATAVISITA
                    FROM
                        VISITAGUIDATA     VG,
                        VISITEDISPONIBILI VD
                    WHERE
                        VD.IDVISITA=VG.IDVISITA
                ) LOOP
                    GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(VISITA.NOMEVISITA);
                    GUI.CELLATABELLA(VISITA.DURATAVISITA);
                    GUI.CELLATABELLA(VISITA.COSTOVISITA);
                    GUI.CELLATABELLA(VISITA.DATAVISITA);
                    GUI.CHIUDIRIGATABELLA();
                END LOOP;
            END IF;
        END IF;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END VISITEDISPONIBILI;


    PROCEDURE DELETEVISITA(
            IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
            IDV IN VISITAGUIDATA.IDVISITA%TYPE DEFAULT NULL
    ) IS 
    BEGIN 
        GUI.APRIPAGINASTANDARD('Cancellazione visita');
        DELETE FROM VISITEDISPONIBILI WHERE (IDCROCIERA=IDCR AND IDVISITA=IDV );
        GUI.ESITOPERAZIONE('SUCCESSO','ELIMINAZIONE AVVENUTA CON SUCCESSO');
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION WHEN OTHERS THEN
            GUI.ESITOPERAZIONE('KO','VISITA NON ELIMINATA');
            GUI.CHIUDIPAGINASTANDARD('Arancio');
    END DELETEVISITA;


    PROCEDURE INFOCROCIERA (
        TOUR IN TOUR.IDTOUR%TYPE DEFAULT NULL,
        IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL
    )IS
    BEGIN
        GUI.APRIPAGINASTANDARD('Informazioni crociera');
        GUI.APRITABELLA('Informazioni crociera selezionata', 1);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome nave', 'align = center');
        GUI.CELLATABELLAHEADER('Nome tour', 'align = center');
        GUI.CELLATABELLAHEADER('Data crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Numero notti', 'align = center');
        GUI.CELLATABELLAHEADER('Costo crociera', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR T IN (
            SELECT
                N.NOMENAVE,
                T.NOMETOUR,
                CR.DATACROCIERA,
                T.NUMERONOTTI,
                CR.COSTOCROCIERA
            FROM
                CROCIERA CR,
                TOUR T,
                NAVE N
            WHERE
                CR.IDCROCIERA=IDCR 
                AND CR.IDTOUR=T.IDTOUR
                AND CR.IDNAVE=N.IDNAVE

        ) LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(T.NOMENAVE);
            GUI.CELLATABELLA(T.NOMETOUR);
            GUI.CELLATABELLA(T.DATACROCIERA);
            GUI.CELLATABELLA(T.NUMERONOTTI);
            GUI.CELLATABELLA(T.COSTOCROCIERA);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.APRITABELLA('Tappe raggiungibili della crociera', 2);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome porto', 'align = center');
        GUI.CELLATABELLAHEADER('Nome localita', 'align = center');
        GUI.CELLATABELLAHEADER('Distanza', 'align = center');
        GUI.CHIUDIRIGATABELLA();

        FOR T2 IN (
            SELECT

                P.NOMEPORTO,
                L.NOMELOCALITA,
                R.DISTANZA
            FROM
                INCLUDE   I
                INNER JOIN PORTO P
                ON I.POSGEOGRAFICA=P.POSGEOGRAFICA
                JOIN RAGGIUNGE R
                ON P.POSGEOGRAFICA=R.POSGEOGRAFICAPORTO JOIN LOCALITA L
                ON R.POSGEOGRAFICALOCALITA=L.POSGEOGRAFICA
            WHERE
                I.IDTOUR=TOUR
            ORDER BY
                DISTANZA
        ) LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(T2.NOMEPORTO);
            GUI.CELLATABELLA(T2.NOMELOCALITA);
            GUI.CELLATABELLA(T2.DISTANZA);
            GUI.CHIUDIRIGATABELLA();

        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.APRIFIELD('buttons','','center');
        HTP.PRINT('<a align=left href="'|| COSTANTI.MACCHINA2|| COSTANTI.RADICE|| 'blu.infotour?id_tour='|| TOUR||'">');
        GUI.BTNSUBMIT(TXT=>'Informazioni tour e localita');
        HTP.PRINT('<a align=left href="' ||COSTANTI.MACCHINA2 || COSTANTI.RADICE || ''||PACKAGE_NAME||'.VISITEDISPONIBILI?idcr='|| IDCR||'">');
        GUI.BTNSUBMIT(TXT=>'Controlla visite disponibili della crociera');
        HTP.PRINT('<a align=center href="' || COSTANTI.MACCHINA2 || COSTANTI.RADICE|| ''||PACKAGE_NAME||'.POSTILIBERICROCIERA?idcr=' || IDCR ||'">');
        GUI.BTNSUBMIT(TXT=>'Controlla camere disponibili');
        HTP.PRINT('</a>');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIPAGINASTANDARD('arancione');
    END INFOCROCIERA;

    PROCEDURE MOSTRACAMERENAVE(
        IDN IN NAVE.IDNAVE%TYPE DEFAULT NULL,
        nomenave in NAVE.NOMENAVE%TYPE DEFAULT NULL
    )IS
        v_sessione sessione%rowtype;
    BEGIN
        v_sessione:=authenticate.RECUPERA_SESSIONE();
        GUI.APRIPAGINASTANDARD('Numero camere di una nave');
        IF (IDN IS NULL and nomenave is null) THEN
            GUI.APRITABELLA('Numero camere presenti delle navi', 2);
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Nome nave', 'align = center');
            GUI.CELLATABELLAHEADER('Tipo camera', 'align = center');
            GUI.CELLATABELLAHEADER('Numero camere', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR CAMERA IN (
                SELECT
                    C.IDNAVE,
                    N.NOMENAVE,
                    C.TIPOLOGIA,
                    COUNT(TIPOLOGIA) AS NUMERO_CAMERE
                FROM
                    CAMERA C,
                    NAVE   N
                WHERE
                    C.IDNAVE=N.IDNAVE
                GROUP BY
                    N.NOMENAVE,
                    C.IDNAVE,
                    C.TIPOLOGIA
                ORDER BY
                    C.IDNAVE
            )LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(CAMERA.NOMENAVE);
                GUI.CELLATABELLA(CAMERA.TIPOLOGIA);
                GUI.CELLATABELLA(CAMERA.NUMERO_CAMERE);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE
            GUI.APRITABELLA('Numero camere presenti della nave: '|| NOMENAVE, 2);
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Tipo camera', 'align = center');
            GUI.CELLATABELLAHEADER('Numero camere', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR CAMERA IN (
                SELECT
                    C.IDNAVE,
                    N.NOMENAVE,
                    C.TIPOLOGIA,
                    COUNT(TIPOLOGIA) AS NUMERO_CAMERE
                FROM
                    CAMERA C,
                    NAVE   N
                WHERE
                    C.IDNAVE=N.IDNAVE
                    AND N.IDNAVE=IDN
                GROUP BY
                    N.NOMENAVE,
                    C.IDNAVE,
                    C.TIPOLOGIA
                ORDER BY
                    C.IDNAVE
            )LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(CAMERA.TIPOLOGIA);
                GUI.CELLATABELLA(CAMERA.NUMERO_CAMERE);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        END IF;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END MOSTRACAMERENAVE;


    PROCEDURE POSTITOTALILIBERICROCIERE (
        IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL
    )IS
        v_sessione sessione%rowtype;
    BEGIN
        v_sessione:=authenticate.RECUPERA_SESSIONE();
        GUI.APRIPAGINASTANDARD('Posti disponibili crociere');
        GUI.APRITABELLA('Lista crociere e rispettive navi in ordine di posti totali liberi', 2);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Nome nave', 'align = center');
        GUI.CELLATABELLAHEADER('Posti totali liberi', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        IF (IDCR IS NULL) THEN
            FOR POSTI IN (
                SELECT
                    DC.IDCROCIERA,
                    CR.IDNAVE,
                    N.NOMENAVE,
                    SUM (NUMEROPOSTILIBERI) AS POSTITOTALILIBERI
                FROM
                    DISPONIBILITACAMERE DC
                    INNER JOIN CROCIERA CR ON CR.IDCROCIERA=DC.IDCROCIERA
                    INNER JOIN NAVE N on N.IDNAVE=CR.IDNAVE
                GROUP BY
                    DC.IDCROCIERA,
                    CR.IDNAVE,
                    N.NOMENAVE
                ORDER BY
                    POSTITOTALILIBERI DESC
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(POSTI.IDCROCIERA);
                GUI.CELLATABELLALINK(POSTI.NOMENAVE,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.POSTILIBERICROCIERA?idcr='
                    ||POSTI.IDCROCIERA
                    || '&'||'nomenave='
                    ||POSTI.NOMENAVE);
                GUI.CELLATABELLA(POSTI.POSTITOTALILIBERI);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE
            FOR POSTI IN (
                SELECT
                    DC.IDCROCIERA,
                    CR.IDNAVE,
                    N.NOMENAVE,
                    SUM (NUMEROPOSTILIBERI) AS POSTITOTALILIBERI
                FROM
                    DISPONIBILITACAMERE DC
                    INNER JOIN CROCIERA CR ON CR.IDCROCIERA=DC.IDCROCIERA
                    INNER JOIN NAVE N on N.IDNAVE=CR.IDNAVE
                WHERE
                    DC.IDCROCIERA=IDCR
                GROUP BY
                    DC.IDCROCIERA,
                    CR.IDNAVE,
                    N.NOMENAVE
                ORDER BY
                    POSTITOTALILIBERI DESC
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(POSTI.IDCROCIERA);
                GUI.CELLATABELLALINK(POSTI.NOMENAVE,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.POSTILIBERICROCIERA?idcr='
                    ||POSTI.IDCROCIERA
                    || '&'||'nomenave='
                    ||POSTI.NOMENAVE);
                GUI.CELLATABELLA(POSTI.POSTITOTALILIBERI);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        END IF;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END POSTITOTALILIBERICROCIERE;


    PROCEDURE POSTILIBERICROCIERA (
        IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
        NOMENAVE IN NAVE.NOMENAVE%TYPE DEFAULT NULL
    )IS
        DATACR CROCIERA.DATACROCIERA%TYPE;
        NOME_TOUR TOUR.NOMETOUR%TYPE;
        v_sessione sessione%rowtype;
    BEGIN
        v_sessione:=authenticate.RECUPERA_SESSIONE();
        select DATACROCIERA into DATACR from crociera where IDCROCIERA=IDCR;
        select NOMETOUR into NOME_TOUR from TOUR T, CROCIERA CR where CR.IDTOUR=T.IDTOUR AND CR.IDCROCIERA=IDCR;
        GUI.APRIPAGINASTANDARD('Lista camere disponibili');
        IF(IDCR IS NULL) THEN
            GUI.APRITABELLA('Posti disponibili per ogni camera per tipologia', 1, 'cameredisponibili');
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Id crociera', 'align = center');
            GUI.CELLATABELLAHEADER('Tipologia stanza', 'align = center');
            GUI.CELLATABELLAHEADER('Quantita posti liberi', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR STANZA IN (
                SELECT
                    IDCROCIERA,
                    TIPOLOGIA,
                    NUMEROPOSTILIBERI
                FROM
                    DISPONIBILITACAMERE DC
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(STANZA.IDCROCIERA);
                GUI.CELLATABELLA(STANZA.TIPOLOGIA);
                GUI.CELLATABELLA(STANZA.NUMEROPOSTILIBERI);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE if(NOMENAVE is null) THEN

            GUI.APRITABELLA('Posti disponibili per ogni camera per tipologia'||'<br>'||'Crociera: '||IDCR,1, 'cameredisponibili');
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Tipologia stanza', 'align = center');
            GUI.CELLATABELLAHEADER('Quantita posti liberi', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR STANZA IN (
                SELECT
                    IDCROCIERA,
                    TIPOLOGIA,
                    NUMEROPOSTILIBERI
                FROM
                    DISPONIBILITACAMERE DC
                WHERE
                    DC.IDCROCIERA = IDCR
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(STANZA.TIPOLOGIA);
                GUI.CELLATABELLA(STANZA.NUMEROPOSTILIBERI);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE
            GUI.APRITABELLA('Posti disponibili per ogni camera per tipologia'||'<br>'||'Crociera: '||IDCR||' - Nave: '|| NOMENAVE, 1, 'cameredisponibili');
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Tipologia stanza', 'align = center');
            GUI.CELLATABELLAHEADER('Quantita posti liberi', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR STANZA IN (
                SELECT
                    IDCROCIERA,
                    TIPOLOGIA,
                    NUMEROPOSTILIBERI
                FROM
                    DISPONIBILITACAMERE DC
                WHERE
                    DC.IDCROCIERA = IDCR
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(STANZA.TIPOLOGIA);
                GUI.CELLATABELLA(STANZA.NUMEROPOSTILIBERI);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
            end if;
        END IF;
        GUI.CHIUDITABELLA();
        GUI.APRIFIELD('buttons','','center');
        HTP.PRINT(' <a align=right href="'
            || COSTANTI.MACCHINA2
            || COSTANTI.RADICE
            || 'gverde.apripaginaprenotazioni?idcr='||IDCR||'&'||'NTOUR='||NOME_TOUR||'&'||'DATAC='||DATACR||'">');
        GUI.BTNSUBMIT(TXT=>'Prenota la crociera');
        HTP.PRINT('</a>');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END POSTILIBERICROCIERA;


    PROCEDURE ITINERARIONAVI (
        NOMETOUR IN TOUR.NOMETOUR%TYPE DEFAULT NULL
    )IS
        v_sessione sessione%rowtype;
        flag_stat boolean;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_stat:=authorize.HAPERMESSO(permesso_stat);
        if not flag_stat then raise NON_AUTORIZZATO; END IF;
        GUI.APRIPAGINASTANDARD('Informazioni itinerari');
        GUI.APRITABELLA('Quali navi hanno percorso piu di una volta lo stesso tour', 1);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome nave', 'align = center');
        GUI.CELLATABELLAHEADER('Nome tour', 'align = center');
        GUI.CELLATABELLAHEADER('Quante volte', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        IF (NOMETOUR IS NULL) THEN
            FOR T IN (
                SELECT
                    N.IDNAVE,
                    NOMENAVE,
                    NOMETOUR,
                    COUNT(*) AS NUMEROVOLTEPERCORSO
                FROM
                    NAVE     N,
                    CROCIERA C,
                    TOUR     T
                WHERE
                    T.IDTOUR=C.IDTOUR
                    AND C.IDNAVE=N.IDNAVE
                GROUP BY
                    N.IDNAVE,
                    N.NOMENAVE,
                    T.NOMETOUR
                HAVING
                    COUNT(*)>1
                ORDER BY
                    N.NOMENAVE
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(T.NOMENAVE,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.CROCIEREEFFETTUATEDANAVE?idn='
                    || T.IDNAVE);
                GUI.CELLATABELLA(T.NOMETOUR);
                GUI.CELLATABELLA(T.NUMEROVOLTEPERCORSO);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE
            FOR T IN (
                SELECT
                    N.IDNAVE,
                    N.NOMENAVE,
                    T.NOMETOUR,
                    COUNT(*) AS NUMEROVOLTEPERCORSO
                FROM
                    NAVE     N,
                    CROCIERA C,
                    TOUR     T
                WHERE
                    T.NOMETOUR=NOMETOUR
                    AND T.IDTOUR=C.IDTOUR
                    AND C.IDNAVE=N.IDNAVE
                GROUP BY
                    N.NOMENAVE,
                    T.NOMETOUR
                HAVING
                    COUNT(*)>1
                ORDER BY
                    N.NOMENAVE
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(T.NOMENAVE,'',
                    COSTANTI.MACCHINA2
                    || COSTANTI.RADICE
                    ||''||PACKAGE_NAME||'.CROCIEREEFFETTUATEDANAVE?idn='
                    || T.IDNAVE);
                GUI.CELLATABELLA(T.NOMETOUR);
                GUI.CELLATABELLA(T.NUMEROVOLTEPERCORSO);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        END IF;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END ITINERARIONAVI;


    PROCEDURE FORMCOSTOMEDIOCROCIERE IS
    BEGIN
        GUI.APRIPAGINASTANDARD;
        GUI.APRIFORM('FORM CARD','GET','ROSSO.COSTOMEDIO');
        GUI.CARDHEADER('SELEZIONA IL MESE PER IL CALCOLO',0);
        
        GUI.APRIFIELD(TESTO=>'Scegli una data');
        GUI.INPUT_FORM('input','date','start','DATACR',to_char(sysdate, 'yyyy-MM-dd'));
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(ALLINEAMENTO =>'center');
        GUI.BTNSUBMIT(TXT =>'Invia');
        GUI.BTNRESET(TXT =>'Cancella');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIFORM;  
        
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END FORMCOSTOMEDIOCROCIERE;

    PROCEDURE COSTOMEDIO(DATACR VARCHAR2) IS
    v_sessione sessione%rowtype;
        flag_stat boolean;
        mese number;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_stat:=authorize.HAPERMESSO(permesso_stat);
        mese:= EXTRACT (MONTH FROM TO_DATE(DATACR,'YYYY/MM/DD'));
        if not flag_stat then raise NON_AUTORIZZATO; END IF;
        GUI.APRIPAGINASTANDARD('Costo medio delle crociere');
        GUI.APRITABELLA('Costo medio per mese delle crociere attualmente pianificate', 1, 'costomedio');
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Costo medio crociere', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        IF (DATACR is null) THEN
            FOR COSTO IN (
                SELECT
                    CAST(AVG(COSTOCROCIERA) AS DECIMAL(10,
                    2)) AS COSTOMEDIO
                FROM
                    CROCIERA CR
                WHERE 
                    CR.ISDISPONIBILE=1
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(COSTO.COSTOMEDIO);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        ELSE 
            FOR COSTO IN (
                SELECT

                    CAST(AVG(CR.COSTOCROCIERA) AS DECIMAL(10,2)) AS COSTOMEDIO
                FROM
                    CROCIERA CR
                WHERE
                    EXTRACT (MONTH FROM CR.DATACROCIERA) = mese
                    AND CR.ISDISPONIBILE=1
            ) LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(COSTO.COSTOMEDIO);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        END IF;
        GUI.CHIUDITABELLA();
    END COSTOMEDIO;
    
    
    PROCEDURE CROCIERAPIUCOSTOSACONNOTTI(
            N_NOTTI IN TOUR.NUMERONOTTI%TYPE DEFAULT 1
    )IS
        v_sessione sessione%rowtype;
        flag_stat boolean;
        v_NOTTI number;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_stat:=authorize.HAPERMESSO(permesso_stat);
        SELECT MAX(NUMERONOTTI) into v_NOTTI FROM TOUR;
        if not flag_stat then raise NON_AUTORIZZATO; END IF;
        GUI.APRIPAGINASTANDARD('Crociera piu costosa');
        GUI.APRITABELLA('Informazioni della crociera col costo maggiore di tutte le crociere con numero notti maggiori di: '||N_NOTTI, 1, 'crociera piu costosa');
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome tour', 'align = center');
        GUI.CELLATABELLAHEADER('Data crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Costo crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Numero notti', 'align = center');
        GUI.CELLATABELLAHEADER('Numero tappi', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR CROCIERA IN (
            SELECT
                T.NOMETOUR,
                CR.DATACROCIERA,
                CR.COSTOCROCIERA,
                T.NUMERONOTTI,
                T.NUMEROTAPPE
            FROM
                CROCIERA CR,
                TOUR     T
            WHERE
                T.IDTOUR=CR.IDTOUR
                AND T.NUMERONOTTI>N_NOTTI
                AND CR.ISDISPONIBILE=1
                AND CR.COSTOCROCIERA>=(
                    SELECT
                        MAX(CR2.COSTOCROCIERA)
                    FROM
                        CROCIERA CR2,
                        TOUR     T2
                    WHERE
                        T2.IDTOUR=CR2.IDTOUR
                        AND CR2.ISDISPONIBILE=1
                        AND T2.NUMERONOTTI>N_NOTTI
                )
        ) LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(CROCIERA.NOMETOUR);
            GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
            GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
            GUI.CELLATABELLA(CROCIERA.NUMERONOTTI);
            GUI.CELLATABELLA(CROCIERA.NUMEROTAPPE);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;

        GUI.CHIUDITABELLA();
        HTP.PRINT('<form align=center action ="'||Costanti.macchina2||Costanti.radice||'ROSSO.CROCIERAPIUCOSTOSACONNOTTI'||'">');
        GUI.APRIFIELD(TESTO=> 'Scegli un numero');
        GUI.APRISELECTINPUT('N_NOTTI','N_NOTTI');
        FOR i IN 1..v_NOTTI
        LOOP 
            GUI.OPTION_SELECT(i,i);
        END LOOP;
        GUI.CHIUDISELECT;
        GUI.BTNSUBMIT('Invia');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END CROCIERAPIUCOSTOSACONNOTTI;



    PROCEDURE MESECONPIUVISITE IS
        v_sessione sessione%rowtype;
        flag_stat boolean;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_stat:=authorize.HAPERMESSO(permesso_stat);
        if not flag_stat then raise NON_AUTORIZZATO; END IF;        
        GUI.APRIPAGINASTANDARD('Mese con piu visite');
        GUI.APRITABELLA('Mesi piu popolari (con piu visite disponibili)', 1);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Numero visite disponibili', 'align = center');
        GUI.CELLATABELLAHEADER('Mese dell`anno', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR MESE IN (
            SELECT
                COUNT(*)    AS NUMERO_VISITE,
                EXTRACT (MONTH
            FROM
                DATAVISITA) AS MESE
            FROM
                CROCIERA          CR,
                VISITEDISPONIBILI VD
            WHERE
                CR.IDCROCIERA = VD.IDCROCIERA
                AND CR.ISDISPONIBILE=1
            GROUP BY
                EXTRACT (MONTH FROM DATAVISITA)
            ORDER BY
                NUMERO_VISITE DESC
        )LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(MESE.NUMERO_VISITE);
            GUI.CELLATABELLALINK(MESE.MESE,'',
                COSTANTI.MACCHINA2
                || COSTANTI.RADICE
                ||''||PACKAGE_NAME||'.VISITEDISPONIBILI?mese_visita='
                || MESE.MESE);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END MESECONPIUVISITE;



    PROCEDURE NAVEPIUCOSTOSA IS
        v_sessione sessione%rowtype;
        flag_stat boolean;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_stat:=authorize.HAPERMESSO(permesso_stat);
        if not flag_stat then raise NON_AUTORIZZATO; END IF;
        GUI.APRIPAGINASTANDARD('Nave piu costosa');
        GUI.APRITABELLA('Nave col potenziale costo piu alto (costo delle cabine)', 2);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome nave', 'align = center');
        GUI.CELLATABELLAHEADER('Potenziale costo', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR NAVE1 IN (
            SELECT
                N.IDNAVE,
                NOMENAVE,
                SUM(COSTO) AS COSTOTOTALECABINE
            FROM
                CAMERA     C,
                NAVE       N,
                TIPOCAMERA TC
            WHERE
                N.IDNAVE=C.IDNAVE
                AND C.TIPOLOGIA=TC.TIPOLOGIA
            GROUP BY
                N.IDNAVE, NOMENAVE
            ORDER BY
                COSTOTOTALECABINE desc
        )LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(NAVE1.NOMENAVE);
            GUI.CELLATABELLALINK(NAVE1.COSTOTOTALECABINE,'',
            AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.cabine?p_idnave='||NAVE1.IDNAVE);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END NAVEPIUCOSTOSA;

    

    PROCEDURE CROCIERAMAXVISITE IS
        v_sessione sessione%rowtype;
        flag_stat boolean;
    BEGIN

        v_sessione:=authenticate.RECUPERA_SESSIONE();
        flag_stat:=authorize.HAPERMESSO(permesso_stat);
        if not flag_stat then raise NON_AUTORIZZATO; END IF;
        GUI.APRIPAGINASTANDARD('Crociera che effettuano il numero massimo di visite');
        GUI.APRITABELLA('Crociera che effettuano il numero massimo di visite', 1);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Nome tour', 'align = center');
        GUI.CELLATABELLAHEADER('Data crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Numero visite', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR CROCIERA IN (
            SELECT
                CR.IDCROCIERA,
                T.NOMETOUR,
                CR.DATACROCIERA,
                VCR.NUMERO_VISITE
            FROM
                CROCIERA         CR,
                TOUR             T,
                N_VISITECROCIERE VCR
            WHERE
                T.IDTOUR=CR.IDTOUR
                AND CR.IDCROCIERA=VCR.IDCROCIERA
                AND NUMERO_VISITE >= (
                    SELECT
                        MAX(NUMERO_VISITE)
                    FROM
                        N_VISITECROCIERE
                )
        ) LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(CROCIERA.IDCROCIERA);
            GUI.CELLATABELLA(CROCIERA.NOMETOUR);
            GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
            GUI.CELLATABELLA(CROCIERA.NUMERO_VISITE);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
        when NON_AUTORIZZATO then
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: PERMESSI INSUFFICIENTI');
            GUI.CHIUDIPAGINASTANDARD('arancione');    
    END CROCIERAMAXVISITE;


    PROCEDURE CROCIEREEFFETTUATEDANAVE (
        IDN IN NAVE.IDNAVE%TYPE DEFAULT NULL
    )IS
        v_sessione sessione%rowtype;
    BEGIN
        v_sessione:=authenticate.RECUPERA_SESSIONE();    
        GUI.APRIPAGINASTANDARD('Crociere effettuate dalla nave');
    
        IF (IDN IS NULL) THEN
            GUI.APRITABELLA('Seleziona nave', 2);
            GUI.CHIUDIRIGATABELLA();
        ELSE
            GUI.APRITABELLA('Crociere effettuate dalla seguente nave', 2);
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Nome nave', 'align = center');
            GUI.CELLATABELLAHEADER('Tour effettuato', 'align = center');
            GUI.CELLATABELLAHEADER('Data crociera', 'align = center');
            GUI.CELLATABELLAHEADER('Costo crociera', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR NAVE IN (
                SELECT
                    NOMENAVE,
                    NOMETOUR,
                    DATACROCIERA,
                    COSTOCROCIERA
                FROM
                    TOUR     T,
                    NAVE       N,
                    CROCIERA CR
                WHERE
                    N.IDNAVE=IDN
                    AND CR.IDNAVE=N.IDNAVE
                    AND T.IDTOUR=CR.IDTOUR
                ORDER BY
                    NOMENAVE
            )LOOP
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(NAVE.NOMENAVE);
                GUI.CELLATABELLA(NAVE.NOMETOUR);
                GUI.CELLATABELLA(NAVE.DATACROCIERA);
                GUI.CELLATABELLA(NAVE.COSTOCROCIERA);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        END IF;
        GUI.CHIUDITABELLA();
        HTP.PRINT('<div><form align=center action ="'||Costanti.macchina2||Costanti.radice||'ROSSO.CROCIEREEFFETTUATEDANAVE'||'">');
        GUI.APRISELECTINPUT('idn','idn');
        FOR nave in (SELECT * FROM NAVE)
        LOOP
                GUI.OPTION_SELECT(nave.IDNAVE, nave.IDNAVE);
        END LOOP;
        GUI.CHIUDISELECT;
        GUI.BTNSUBMIT('Invia');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END CROCIEREEFFETTUATEDANAVE;



    FUNCTION COSTOBASE(
        IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
        TIPO IN TIPOCAMERA.TIPOLOGIA%TYPE DEFAULT NULL
    ) RETURN NUMBER IS
        COSTO_CROCIERA NUMBER;
        COSTO_CAMERA   NUMBER;
    BEGIN
        SELECT
            COSTOCROCIERA INTO COSTO_CROCIERA
        FROM
            CROCIERA
        WHERE
            IDCROCIERA=IDCR;
        SELECT
            COSTO INTO COSTO_CAMERA
        FROM
            TIPOCAMERA
        WHERE
            TIPOLOGIA=TIPO;
        RETURN COSTO_CROCIERA+COSTO_CAMERA;
    END COSTOBASE;


    PROCEDURE LISTAVISITE (
        POSIZIONE IN VARCHAR2 DEFAULT NULL,
        IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL
    )IS
    BEGIN
        GUI.APRIPAGINASTANDARD('Visite disponibili');
        GUI.APRITABELLA('Elenco visite disponibili', 2);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
        GUI.CELLATABELLAHEADER('Nome Luogo Interesse', 'align = center');
        GUI.CELLATABELLAHEADER('Durata Visita', 'align = center');
        GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
        GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR VISITA IN (
            SELECT
                NOMEVISITA,
                NOMELUOGOINTERESSE,
                DURATAVISITA,
                COSTOVISITA,
                DATAVISITA
            FROM
                VISITAGUIDATA     VG,
                LUOGOVISITA       LV,
                LUOGOINTERESSE    LI,
                VISITEDISPONIBILI VD
            WHERE
                VD.IDVISITA=VG.IDVISITA
                AND LV.IDVISITA=VG.IDVISITA
                AND LI.IDLUOGOINTERESSE=LV.IDLUOGOINTERESSE
                AND LI.POSGEOGRAFICA=POSIZIONE
                AND VD.IDCROCIERA=IDCROCIERA
        ) LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(VISITA.NOMEVISITA);
            GUI.CELLATABELLA(VISITA.NOMELUOGOINTERESSE);
            GUI.CELLATABELLA(VISITA.DURATAVISITA);
            GUI.CELLATABELLA(VISITA.COSTOVISITA);
            GUI.CELLATABELLA(VISITA.DATAVISITA);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');    
    END LISTAVISITE;


    PROCEDURE LISTACROCIEREPERMESE(
        DATACR IN CROCIERA.DATACROCIERA%TYPE DEFAULT NULL
    )IS
        v_sessione sessione%rowtype;
    BEGIN
        v_sessione:=authenticate.RECUPERA_SESSIONE();         
        GUI.APRIPAGINASTANDARD('Crociere disponibili per mese');
        GUI.APRITABELLA('Elenco Crociere disponibili per mese', 1);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER('Nome Tour ', 'align = center');
        GUI.CELLATABELLAHEADER('Costo Crociera', 'align = center');
        GUI.CELLATABELLAHEADER('Data Crociera', 'align = center');
        GUI.CHIUDIRIGATABELLA();

        FOR CROCIERA IN (
            SELECT
                NOMETOUR,
                COSTOCROCIERA,
                DATACROCIERA
            FROM
                CROCIERA     CR,
                TOUR          T
            WHERE
                CR.IDTOUR=T.IDTOUR
                AND EXTRACT (MONTH FROM CR.DATACROCIERA) = EXTRACT (MONTH FROM DATACR)

        ) LOOP
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(CROCIERA.NOMETOUR);
            GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
            GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION when Authenticate.sessione_non_trovata then 
            GUI.APRIPAGINASTANDARD('ERRORE OPERAZIONE');
            GUI.ESITOPERAZIONE('KO','Fallimento operazione: LOGIN RICHIESTO');
            GUI.CHIUDIPAGINASTANDARD('arancione');
    END LISTACROCIEREPERMESE;

------------------ Gabriele ----------------

        -- API ENDPOINTS
        PROCEDURE get_boats
        IS
                v_numeroNavi    INTEGER;
                primo           BOOLEAN;
        BEGIN
                --      DOES NOT REQUIRE LOG IN AND PRIVILEGES
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;

                htp.p('{"navi": [');
                PRIMO := TRUE;
                for boat in (
                        SELECT * FROM NAVE
                )
                LOOP
                        if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                        htp.p('{"IdNave":'||boat.IDNAVE||',"NomeNave":"'||boat.NomeNave||'","Lunghezza":'||boat.Lunghezza||',"Larghezza":'||boat.Larghezza||', "Altezza":'||boat.Altezza||', "Peso":'||boat.Peso||',"Descrizione":"'||boat.Descrizione||'"}');
                END LOOP;
                htp.p(']}');
        END;

        PROCEDURE put_boat(
                p_Nome in NAVE.NOMENAVE%TYPE,
                p_Lunghezza in NAVE.LUNGHEZZA%TYPE,
                p_LARGHEZZA in NAVE.LARGHEZZA%TYPE,
                p_altezza in NAVE.ALTEZZA%TYPE,
                p_peso in NAVE.PESO%TYPE,
                p_descrizione in NAVE.DESCRIZIONE%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if NOT f_inserisci1 AND NOT f_inserisci2 THEN raise NON_AUTORIZZATO; END IF;
                INSERT INTO NAVE VALUES(IDNaveseq.NEXTVAL ,p_Nome, p_Lunghezza, p_Larghezza, p_Altezza, p_Peso, p_Descrizione);
                htp.p('{"message":"Successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END put_boat;
        PROCEDURE delete_boat(
                p_idnave in NAVE.IDNAVE%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;
                DELETE FROM NAVE WHERE nave.IDNAVE = p_idnave;
                htp.p('{"message":"Successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END delete_boat;
        PROCEDURE modify_boat (
                p_idnave in NAVE.IDNAVE%TYPE,
                p_Nome in NAVE.NOMENAVE%TYPE,
                p_Lunghezza in NAVE.LUNGHEZZA%TYPE,
                p_LARGHEZZA in NAVE.LARGHEZZA%TYPE,
                p_altezza in NAVE.ALTEZZA%TYPE,
                p_peso in NAVE.PESO%TYPE,
                p_descrizione in NAVE.DESCRIZIONE%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if not f_inserisci1 AND NOT F_inserisci2 then raise NON_AUTORIZZATO; END IF;
                -- here modify the boat
                update NAVE
                SET NOMENAVE = p_Nome, LUNGHEZZA=p_Lunghezza, LARGHEZZA = p_LARGHEZZA, ALTEZZA = p_altezza, PESO = p_peso, DESCRIZIONE = p_descrizione
                WHERE IDNAVE = p_idnave;
        END modify_boat;
        -- same for cabins
        -- put cabins
        PROCEDURE put_cabins(
                p_idnave NAVE.IDNAVE%TYPE,
                p_n integer,
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE,
                p_costo TIPOCAMERA.COSTO%TYPE,
                p_piano TIPOCAMERA.PIANONAVE%TYPE
        )
        IS
                exist_type NUMBER;
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if NOT f_inserisci1 AND NOT f_inserisci2 THEN raise NON_AUTORIZZATO; END IF;

                SELECT count(*) INTO exist_type FROM tipocamera WHERE tipologia = p_tipologia;

                if exist_type = 0
                THEN INSERT INTO TIPOCAMERA VALUES(p_tipologia, p_costo, p_piano);
                END IF;

                FOR i in 1..p_n
                LOOP
                        INSERT INTO CAMERA VALUES (IDCameraseq.NEXTVAL, p_idnave, p_tipologia, 1);
                END LOOP;
                htp.p('{"message":"Successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END put_cabins;
        -- delete cabins
        PROCEDURE delete_cabins(
                p_idnave NAVE.IDNAVE%TYPE,
                p_n INTEGER,
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;

                DELETE FROM CAMERA
                WHERE TIPOLOGIA = p_tipologia
                AND IDNAVE = p_idnave
                AND rownum <= p_n
                ;

                htp.p('{"message":"Successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END delete_cabins;
        PROCEDURE DELETE_TYPE(
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;
                DELETE FROM TIPOCAMERA WHERE TIPOLOGIA = p_tipologia;
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END DELETE_TYPE;
        -- modify cabins
        PROCEDURE modify_cabins(
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE,
                p_costo     TIPOCAMERA.COSTO%TYPE,
                p_pianonave TIPOCAMERA.PIANONAVE%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if not f_inserisci1 AND NOT F_inserisci2 then raise NON_AUTORIZZATO; END IF;

                UPDATE TIPOCAMERA
                SET COSTO = p_costo, PIANONAVE = p_pianonave
                WHERE TIPOLOGIA = p_tipologia
                ;

                htp.p('{"message":"Successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END modify_cabins;
        -- get boat's cabins, if i ever want to change, i could give back an object with an array instead of an array
        PROCEDURE get_boatCabins(
                p_idnave NAVE.IDNAVE%TYPE
        )
        IS
                v_numeroTipi INTEGER;
                PRIMO   BOOLEAN;

        BEGIN
                -- DOES NOT REQUIRE LOG IN AND PRIVILEGES
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                htp.p('{"tipocamere": [');
                PRIMO := TRUE;
                for tipo in (
                        SELECT COUNT(*) as nCamere, tipologia, costo, pianonave
                        FROM CAMERA
                        NATURAL JOIN TIPOCAMERA
                        WHERE IDNAVE = p_IDNAVE
                        GROUP BY tipologia, costo, pianonave
                )
                LOOP
                        if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                        htp.p('{"Tipologia":"'||tipo.tipologia||'","costo":'||tipo.costo||',"pianonave":'||tipo.pianonave||',"numeroCamere":'||tipo.nCamere||'}');
                END LOOP;
                htp.p(']}');
        END;
        PROCEDURE get_Types
        IS
        BEGIN
                OWA_UTIL.MIME_HEADER('application/json', FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                HTP.P('[{"value":"new", "label":"+"}');
                FOR RIGA IN (
                        SELECT * FROM TIPOCAMERA
                )
                LOOP
                        HTP.P(',{"value":"'||RIGA.TIPOLOGIA||'", "label":"'||RIGA.TIPOLOGIA||'"}');
                END LOOP;
                HTP.P(']');
        END get_Types;
        PROCEDURE room_Avail(
                p_id IN CAMERA.IDCAMERA%TYPE,
                p_val IN CAMERA.ISDISPONIBILE%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if not f_inserisci1 AND NOT F_inserisci2 then raise NON_AUTORIZZATO; END IF;

                UPDATE CAMERA
                SET ISDISPONIBILE = p_val
                WHERE p_id = IDCAMERA
                ;

                HTP.P('{"message":"successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END room_Avail;
        PROCEDURE del_room(
                p_id CAMERA.IDCAMERA%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;

                DELETE FROM CAMERA WHERE IDCAMERA = p_id;

                HTP.P('{"message":"successo"}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END del_room;
        PROCEDURE get_type_rooms(
                p_idnave IN NAVE.IDNAVE%TYPE,
                p_tipologia IN TIPOCAMERA.TIPOLOGIA%TYPE
        )
        IS
                PRIMO BOOLEAN := TRUE;
        BEGIN
                OWA_UTIL.MIME_HEADER('application/json', FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                HTP.P('{ "rooms":[');
                FOR RIGA IN (
                        SELECT * FROM CAMERA
                        WHERE CAMERA.IDNAVE = p_idnave
                        AND CAMERA.TIPOLOGIA = p_tipologia
                )
                LOOP
                        IF PRIMO THEN PRIMO:=FALSE; ELSE HTP.P(','); END IF;
                        HTP.P('{"id":'||RIGA.IDCAMERA||',"isFree":'||RIGA.ISDISPONIBILE||'}');
                END LOOP;
                HTP.P(']}');
        END get_type_rooms;
        -- per ogni nave fai vedere quanti posti vengono occupati per tour (modalitá di visualizzazione potrebbero essere, semplicemente quali
        -- navi occupano piú posti e poi per tour)
        PROCEDURE posti_occupati(
                p_IDTOUR TOUR.IDTOUR%TYPE DEFAULT NULL
        )
        IS
                PRIMO   BOOLEAN;
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;
                htp.p('{"dati": [');
                PRIMO := TRUE;
                for riga in (
                        SELECT SUM(NUMEROPOSTITOTALI) AS TOT,
                                SUM(NUMEROPOSTILIBERI) AS FREE,
                                SUM(NUMEROPOSTILIBERI) / SUM(NUMEROPOSTITOTALI) * 100 AS PERC,
                                NOMENAVE, NOMETOUR, IDTOUR, IDNAVE
                                FROM TOUR
                                NATURAL JOIN CROCIERA
                                NATURAL JOIN NAVE
                                NATURAL JOIN DISPONIBILITACAMERE
                                WHERE (
                                        CASE
                                        WHEN p_IDTOUR IS NULL THEN 1
                                        WHEN IDTOUR = p_IDTOUR THEN 1
                                        ELSE 0 END
                                ) = 1
                                GROUP BY IDTOUR, NOMETOUR, IDNAVE, NOMENAVE
                                ORDER BY PERC
                )
                LOOP
                        if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                        htp.p('{"Tot":'||riga.TOT||',"Free":'||riga.FREE||',"Rel":'||riga.PERC||',"nave":"'||riga.NOMENAVE||'","tour":"'||riga.NOMETOUR||'"}');
                END LOOP;
                htp.p(']}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END posti_occupati;
        -- conta per ogni tour quanti hanno scelto la tipologia di cabina
        PROCEDURE scelta_cabina(
                p_IDTOUR IN TOUR.IDTOUR%TYPE DEFAULT NULL
        )
        IS
                PRIMO   BOOLEAN;
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;
                htp.p('{"dati": [');
                PRIMO := TRUE;
                IF p_IDTOUR IS NULL
                THEN
                        for RIGA in (
                                SELECT SUM(NUMEROPOSTITOTALI) AS TOT, SUM(NUMEROPOSTILIBERI) AS FREE, SUM(NUMEROPOSTILIBERI)/SUM(NUMEROPOSTITOTALI)*100 AS PERC, TIPOLOGIA
                                FROM TOUR
                                NATURAL JOIN CROCIERA
                                NATURAL JOIN DISPONIBILITACAMERE
                                GROUP BY TIPOLOGIA
                                ORDER BY TIPOLOGIA
                        )LOOP

                                if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                                htp.p('{"Tot":'||riga.TOT||',"Free":'||riga.FREE||',"Rel":'||riga.PERC||',"tipo":"'||riga.TIPOLOGIA||'"}');
                        END LOOP;
                ELSE
                        FOR RIGA IN (
                                SELECT SUM(NUMEROPOSTITOTALI) AS TOT, SUM(NUMEROPOSTILIBERI) AS FREE, SUM(NUMEROPOSTILIBERI)/SUM(NUMEROPOSTITOTALI)*100 AS PERC, TIPOLOGIA
                                FROM TOUR
                                NATURAL JOIN CROCIERA
                                NATURAL JOIN DISPONIBILITACAMERE
                                WHERE IDTOUR = p_IDTOUR
                                GROUP BY TIPOLOGIA
                                ORDER BY TIPOLOGIA
                        )LOOP
                                if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                                htp.p('{"Tot":'||riga.TOT||',"Free":'||riga.FREE||',"Rel":'||riga.PERC||',"tipo":"'||riga.TIPOLOGIA||'"}');
                        END LOOP;
                END IF;
                htp.p(']}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                --WHEN OTHERS THEN
                --        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                --        HTP.P('{"message":"NON AUTORIZZATO"}');
        END scelta_cabina;
        -- conta quanti utenti hanno prenotato una visita per ogni lingua (per stimare quanti utenti distinti parlano una lingua)
        -- stima perchè non si puo differenziera tra clienti nello stesso gruppo di prenotazione, quindi si va in eccesso
        -- con l'assunzione che in generale un gruppo che va in una visita durante una crociera e prenota quella lingua probabilmente sará
        -- una lingua parlata da tutto il gruppo
        PROCEDURE lingua_parlata
        IS
                PRIMO   BOOLEAN;
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;
                htp.p('{"dati": [');
                PRIMO := TRUE;
                for riga in (
                        SELECT LINGUA, COUNT(DISTINCT PRENOTATI.IDC) STIMA
                        FROM PRENOTAZIONEVISITA PV
                        INNER JOIN PRENOTAZIONE PO ON PV.IDPRENOTAZIONE = PO.IDPRENOTAZIONE
                        INNER JOIN ((
                                SELECT P.IDPRENOTAZIONE, U.IDUTENTE AS IDC FROM UTENTE U INNER JOIN PRENOTAZIONE P ON U.IDUTENTE = P.IDCLIENTE
                        ) UNION (
                                SELECT CR.IDPRENOTAZIONE, CR.IDCLIENTE AS IDC FROM CLIENTERIFERIMENTO CR
                        )) Prenotati ON PRENOTATI.IDPRENOTAZIONE = PO.IDPRENOTAZIONE
                        GROUP BY PV.LINGUA
                        ORDER BY STIMA
                )
                LOOP
                        if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                        htp.p('{"Lingua":"'||riga.LINGUA||'","Stima":'||riga.STIMA||'}');
                END LOOP;
                htp.p(']}'); 
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END lingua_parlata;
        -- Find all rooms that have been occupied more than n time
        PROCEDURE occupiedNTimes(
                p_n IN NUMBER
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
                PRIMO   BOOLEAN := TRUE;

        BEGIN
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;
                HTP.P('{"dati":[');
                FOR RIGA IN (
                        SELECT NOMENAVE, MAX(nPrenotazioni) as massimo, IDCAMERA
                        FROM CAMERA
                        JOIN NAVE ON NAVE.IDNAVE = CAMERA.IDNAVE
                        JOIN (
                                SELECT IDCAMERA AS IDC, COUNT(*) AS nPrenotazioni
                                FROM IMBARCO
                                GROUP BY IDCAMERA
                        ) ON CAMERA.IDCAMERA = IDC
                        WHERE
                                nPrenotazioni > p_n
                        GROUP BY NAVE.IDNAVE, NOMENAVE, IDCAMERA
                )
                LOOP
                        if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                        HTP.P('{"Nave":"'||riga.nomenave||'", "idCamera":'||riga.idcamera||',"massimo":'||riga.massimo||'}');
                END LOOP;
                HTP.P(']}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');



        END occupiedNTimes;
        -- Get the customers whose room expense avg is get more than the average price of the rooms of that cruise


        PROCEDURE allRoomsBook(
                p_ratio IN NUMBER
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
                PRIMO   BOOLEAN := TRUE;

        BEGIN
                OWA_UTIL.MIME_HEADER('application/json',FALSE, 'utf-8');
                OWA_UTIL.HTTP_HEADER_CLOSE;
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;
                HTP.P('{"dati":[');
                FOR RIGA IN (
                        SELECT AVG(TC.COSTO) AS Media, CL.USERNAME
                        FROM TIPOCAMERA TC
                        INNER JOIN CAMERA RO ON TC.TIPOLOGIA = RO.TIPOLOGIA
                        INNER JOIN IMBARCO IM ON RO.IDCAMERA = IM.IDCAMERA
                        INNER JOIN PRENOTAZIONE P ON IM.IDPRENOTAZIONE = P.IDPRENOTAZIONE
                        INNER JOIN UTENTE CL ON CL.IDUTENTE = P.IDCLIENTE
                        GROUP BY IM.IDPRENOTAZIONE, RO.IDNAVE, CL.USERNAME
                        HAVING AVG(TC.COSTO) > p_ratio * (
                                SELECT AVG(TC2.COSTO)
                                FROM TIPOCAMERA TC2
                                INNER JOIN CAMERA RO2 ON TC2.TIPOLOGIA = RO2.TIPOLOGIA
                                WHERE RO2.IDNAVE = RO.IDNAVE
                        )
                )
                LOOP
                        if PRIMO THEN PRIMO:=FALSE; ELSE htp.p(','); END IF;
                        HTP.P('{"username":"'||riga.USERNAME||'", "media":'||riga.MEDIA||'}');
                END LOOP;
                HTP.P(']}');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN
                        OWA_UTIL.STATUS_LINE(400, AUTHENTICATE.ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||AUTHENTICATE.ERRORE_SESSIONE||'"}');

                WHEN OTHERS THEN
                        OWA_UTIL.STATUS_LINE(400, 'NON AUTORIZZATO', TRUE);
                        HTP.P('{"message":"NON AUTORIZZATO"}');
        END allRoomsBook;
        -- API USERS
        PROCEDURE inserisciNavi
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if NOT f_inserisci1 AND NOT f_inserisci2 THEN raise NON_AUTORIZZATO; END IF;
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;

                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="https://unpkg.com/tabulator-tables@5.4.4/dist/css/tabulator.min.css" rel="stylesheet">');
                HTP.P('<script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.4.4/dist/js/tabulator.min.js"></script>');
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.TITLE('Inserisci Navi');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                HTP.P('<div id="tabella"></div>');
                GUI.BTN(ID  => 'undo', TXT  => HTF.ESCAPE_SC('<'));
                GUI.BTN(ID  => 'redo', TXT  => HTF.ESCAPE_SC('>'));
                GUI.BTN(ID  => 'refresh', TXT  => '↺');
                GUI.BTN(ID  => 'addrow', TXT  => '+');
                GUI.BTN(ID  => 'submit', TXT  => 'Invia');
                HTP.P('<br />');
                HTP.P('<p id="result"></p>');
                GUI.CHIUDICONTAINER;
                HTP.P('<script type="text/javascript">'||navi_ins_js||'</script>');
                GUI.CHIUDIPAGINASTANDARD('arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END inserisciNavi;
        PROCEDURE inserisciCabine(
                p_idNave NAVE.IDNAVE%TYPE
        )
        IS
                v_nomeNave NAVE.NOMENAVE%TYPE;
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if NOT f_inserisci1 AND NOT f_inserisci2 THEN raise NON_AUTORIZZATO; END IF;
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;

                SELECT NOMENAVE INTO v_nomenave FROM NAVE WHERE IDNAVE = p_IDNAVE;
                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="https://unpkg.com/tabulator-tables@5.4.4/dist/css/tabulator.min.css" rel="stylesheet">');
                HTP.P('<script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.4.4/dist/js/tabulator.min.js"></script>');
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.TITLE('Inserisci cabine nave '||v_nomenave);
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                HTP.P('<div id="tipi"></div>');
                GUI.BTN(ID  => 'refresh', TXT  => HTF.ESCAPE_SC('↺'));
                GUI.BTN(ID  => 'addrow', TXT  => '+');
                GUI.BTN(ID  => 'BACK', TXT => '◀');
                GUI.CHIUDICONTAINER;
                HTP.P('<script type="text/javascript">const IDNAVE='||p_idNave||';'||cabine_ins_js||'</script>');
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END inserisciCabine;
        -- qui 3 pagine per la visualizzazione delle 3 operazioni statistiche
        PROCEDURE tourMigliori
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;

                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes@0.3.0/dist/chartjs-plugin-colorschemes.min.js"></script>');

                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                HTP.P('<canvas width="500px" heigth="500px" id="myChart"></canvas>');
                HTP.P('<select id="tourSelect">');
                HTP.P('<option value="all">TUTTI</option>');
                FOR riga in (SELECT * FROM TOUR)
                LOOP
                        HTP.P('<option value="'||riga.IDTOUR||'">'||riga.NOMETOUR||'</option>');
                END LOOP;
                HTP.P('</select>');
                HTP.P('<select id="styleSelect">');
                HTP.P('<option value="0">N</option>');
                HTP.P('<option value="1">%</option>');
                HTP.P('</select>');
                GUI.CHIUDICONTAINER;
                HTP.P('<script type="text/javascript">'||tour_mig_js||'</script>');
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END tourMigliori;
        PROCEDURE tipologiaMigliore
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;

                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.PRINT('<link href="style.css" rel="style.css"/>');
                HTP.PRINT('<style> ' || Costanti.stile  || ' </style>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes@0.3.0/dist/chartjs-plugin-colorschemes.min.js"></script>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                HTP.P('<script type="text/javascript">'||tipo_migl_js||'</script>');
                GUI.APRICONTAINER;
                GUI.APRITABELLA(TITOLO  => 'Passeggeri',
                                TABLEID  => 'Tabella');
                HTP.P('<thead>');
                GUI.APRIRIGATABELLA;
                HTP.P('<th>Tipo</th>');
                HTP.P('<th>Totali</th>');
                HTP.P('<th>Liberi</th>');
                HTP.P('<th>Occupati</th>');
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</thead>');
                HTP.P('<tbody id="tbody"></tbody>');
                GUI.CHIUDITABELLA;
                HTP.P('<canvas width="500px" heigth="500px" id="myChart"></canvas>');
                HTP.P('<select id="tourSelect">');
                HTP.P('<option value="all">TUTTI</option>');
                FOR riga in (SELECT * FROM TOUR)
                LOOP
                        HTP.P('<option value="'||riga.IDTOUR||'">'||riga.NOMETOUR||'</option>');
                END LOOP;
                HTP.P('</select>');
                HTP.P('<select id="graphSelect">');
                HTP.P('<option value="0">◐</option>');
                HTP.P('<option value="1">📊</option>');
                HTP.P('<option value="2">Tab</option>');
                HTP.P('</select>');
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END tipologiaMigliore;
        PROCEDURE quantiParlano
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;

                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes@0.3.0/dist/chartjs-plugin-colorschemes.min.js"></script>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                GUI.APRITABELLA(TITOLO  => 'Passeggeri',
                                TABLEID  => 'Tabella');
                HTP.P('<tHead>');
                GUI.APRIRIGATABELLA;
                HTP.P('<th>Lingua</th>');
                HTP.P('<th>Passeggeri</th>');
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</tHead>');
                HTP.P('<tBody id="tbody">');
                GUI.APRIRIGATABELLA;
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</tBody>');
                GUI.CHIUDITABELLA;
                HTP.P('<canvas id="myChart" style="display:none"></canvas>');
                HTP.P('<select id="graphSelect">');
                HTP.P('<option value="0">Tab</option>');
                HTP.P('<option value="1">📊</option>');
                HTP.P('</select>');
                GUI.CHIUDICONTAINER;
                HTP.P('<script type="text/javascript">'||ling_parl_js||'</script>');
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END quantiParlano;
        PROCEDURE quanteMultiple
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;

                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes@0.3.0/dist/chartjs-plugin-colorschemes.min.js"></script>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                GUI.APRITABELLA(TITOLO  => 'Navi',
                                TABLEID  => 'Tabella');
                HTP.P('<tHead>');
                GUI.APRIRIGATABELLA;
                HTP.P('<th>Nave</th>');
                HTP.P('<th>Cabina</th>');
                HTP.P('<th>nVolte</th>');
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</tHead>');
                HTP.P('<tBody id="tbody">');
                HTP.P('</tBody>');
                GUI.CHIUDITABELLA;
                HTP.P('<canvas id="myChart" style="display:none"></canvas>');
                HTP.P('<input id="n" value="0" type="number" min="0" step="1" />');
                HTP.P('<select id="graphSelect">');
                HTP.P('<option value="0">Tab</option>');
                HTP.P('<option value="1">📊</option>');
                HTP.P('</select>');
                GUI.CHIUDICONTAINER;
                HTP.P('<script type="text/javascript">'||quanto_occ_js||'</script>');
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END quanteMultiple;
        PROCEDURE quanteSopraMedia
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_statistica BOOLEAN;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_statistica := AUTHORIZE.HAPERMESSO(permesso_stat);
                if not f_statistica then raise NON_AUTORIZZATO; END IF;

                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chart.js@3.3.2/dist/chart.min.js"></script>');
                HTP.P('<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes@0.3.0/dist/chartjs-plugin-colorschemes.min.js"></script>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                GUI.APRITABELLA(TITOLO  => 'Spesa',
                                TABLEID  => 'Tabella');
                HTP.P('<tHead>');
                GUI.APRIRIGATABELLA;
                HTP.P('<th>Nome</th>');
                HTP.P('<th>Media</th>');
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</tHead>');
                HTP.P('<tBody id="tbody">');
                HTP.P('</tBody>');
                GUI.CHIUDITABELLA;
                HTP.P('<canvas id="myChart" style="display:none"></canvas>');
                HTP.P('<input id="alpha" value="0" type="number" min="0" />');
                HTP.P('<select id="graphSelect">');
                HTP.P('<option value="0">Tab</option>');
                HTP.P('<option value="1">📊</option>');
                HTP.P('</select>');
                GUI.CHIUDICONTAINER;
                HTP.P('<script type="text/javascript">'||quanto_spv_js||'</script>');
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'arancione');
        EXCEPTION
                WHEN AUTHENTICATE.sessione_non_trovata THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
                WHEN NON_AUTORIZZATO THEN GUI.APRIPAGINASTANDARD('ERRORE');GUI.ESITOPERAZIONE('KO', 'Login Richiesto');GUI.CHIUDIPAGINASTANDARD('arancione');
        END quanteSopraMedia;
        PROCEDURE navi
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                GUI.APRITABELLA(TITOLO => 'Navi', TABLEID => 'Tabella');
                HTP.P('<thead>');
                GUI.APRIRIGATABELLA;
                HTP.P('<th>Nome Nave</th><th>Lunghezza</th><th>Larghezza</th><th>Altezza</th><th>Peso</th><th>Descrizione</th>');
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</thead>');
                HTP.P('<tbody>');
                FOR BOAT IN (
                        SELECT * FROM NAVE
                )
                LOOP
                        GUI.APRIRIGATABELLA;
                        HTP.P('<td><a href="'||Authenticate.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.cabine?p_idNave='||BOAT.IDNAVE||'">'||BOAT.NomeNAve||'</a></td><td>'||BOAT.Lunghezza||'</td><td>'||BOAT.Larghezza||'</td><td>'||BOAT.Altezza||'</td><td>'||BOAT.PESO||'</td><td>'||BOAT.Descrizione||'</td>');
                        GUI.CHIUDIRIGATABELLA;
                END LOOP;
                HTP.P('</tbody>');
                GUI.CHIUDITABELLA;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if NOT f_inserisci1 AND NOT f_inserisci2 THEN raise NON_AUTORIZZATO; END IF;
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;
                GUI.BTN(ID  => 'inserisciNave',TXT  => 'Modifica Tabella');
                HTP.P('
                <script type="application/javascript">
                document.addEventListener("DOMContentLoaded",()=>{
                        document.querySelector("#inserisciNave").addEventListener("click", ()=>{
                                location.href="'||AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.inserisciNavi'||'";
                        });
                });
                </script>
                ');
        EXCEPTION
                WHEN OTHERS THEN NULL;
        END;
                GUI.CHIUDIPAGINASTANDARD('arancione');
        END navi;
        PROCEDURE cabine(
                p_idNave NAVE.IDNAVE%TYPE
        )
        IS
                v_sessione SESSIONE%ROWTYPE;
                f_inserisci1 BOOLEAN;
                f_inserisci2 BOOLEAN;
                f_cancella1 BOOLEAN;
                f_cancella2 BOOLEAN;
        BEGIN
                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                HTP.P('<link href="style.css" rel="style.css"/>');
                HTP.P('<style> ' || Costanti.stile  || ' </style>');
                HTP.HEADCLOSE;
                GUI.APRINAV;
                GUI.APRICONTAINER;
                GUI.APRITABELLA(TITOLO => 'Camere', TABLEID => 'Tabella');
                HTP.P('<thead>');
                GUI.APRIRIGATABELLA;
                HTP.P('<th>Tipo</th><th>Prezzo</th><th>Piano</th><th>nCamere</th>');
                GUI.CHIUDIRIGATABELLA;
                HTP.P('</thead>');
                HTP.P('<tbody>');
                for tipo in (
                        SELECT COUNT(*) as nCamere, tipologia, costo, pianonave
                        FROM CAMERA
                        NATURAL JOIN TIPOCAMERA
                        WHERE IDNAVE = p_IDNAVE
                        AND CAMERA.ISDISPONIBILE = 1
                        GROUP BY tipologia, costo, pianonave
                )
                LOOP
                        GUI.APRIRIGATABELLA;
                        HTP.P('<td>'||tipo.tipologia||'</td><td>'||tipo.costo||'</td><td>'||tipo.pianonave||'</td><td>'||tipo.nCamere||'</td>');
                        GUI.CHIUDIRIGATABELLA;
                END LOOP;
                HTP.P('</tbody>');
                GUI.CHIUDITABELLA;
        BEGIN
                v_sessione := AUTHENTICATE.RECUPERA_SESSIONE();
                f_inserisci1 := AUTHORIZE.HAPERMESSO(permesso_inserisci1);
                f_inserisci2 := AUTHORIZE.HAPERMESSO(permesso_inserisci2);
                if NOT f_inserisci1 AND NOT f_inserisci2 THEN raise NON_AUTORIZZATO; END IF;
                f_cancella1 := AUTHORIZE.HAPERMESSO(permesso_cancella1);
                f_cancella2 := AUTHORIZE.HAPERMESSO(permesso_cancella2);
                if not f_cancella1 AND not f_cancella2 then raise NON_AUTORIZZATO; END IF;
                GUI.BTN(ID  => 'inserisciCamere',TXT  => 'Modifica Tabella');
                HTP.P('
                        <script type="application/javascript">
                        document.addEventListener("DOMContentLoaded",()=>{
                                document.querySelector("#inserisciCamere").addEventListener("click", ()=>{
                                        location.href="'||AUTHENTICATE.DOMINIO||'/apex/'||AUTHENTICATE.DB_UTENTE||'.'||PACKAGE_NAME||'.inserisciCabine?p_idnave='||p_idNave||'";
                                });
                        });
                        </script>
                ');
        EXCEPTION
                WHEN OTHERS THEN NULL;
        END;
                GUI.CHIUDIPAGINASTANDARD('arancione');
        END cabine;
END ROSSO;
/