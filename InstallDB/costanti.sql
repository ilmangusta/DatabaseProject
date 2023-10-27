CREATE OR REPLACE package COSTANTI as
      stile constant varchar2(32767) := '
    body {
        background-color: F3F9FB;
        font-family: Verdana;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0;
        height: fit-content !important;
    }

    a:-webkit-any-link {
    color: #013A63;
    cursor: pointer;
    text-decoration: underline;
}

    .nav {

        background-color: 013a63;
        padding-top: 2px;
        padding-bottom: 2px;
        padding-left: 16px;
        padding-right: 16px;
        text-decoration: none;
        flex: auto;
        border-radius: .5em;
        height:80;
        width: 97%;

    }
    .nav .title {

          font-size: 36px;
          color: a9d6e5;
          text-decoration: none;
          float: left;
          height: 80px;
          border: rgba(255,255,255, 0);
   }

    .title1{
         font-size: 36px;
          font-family: Calibri;
          font-weight: bold;
          color: a9d6e5;
          text-decoration: none;
          height:25px;
          text-decoration: none;
    }
    .mess_importante {
        font-weight: bold;
        color: 013a63;
        align-items: center;
        font-family:Segoe Script;
        text-decoration: none;
        display: block;
        text-decoration: none;
        padding:20;
    }

    .nav .title .title2 {
        font-family:Segoe Script;
        text-decoration: none;
        display: block;
        text-decoration: none;
    }
    .title3 {
        font-family: Arial;
        text-decoration: none;
        display: block;
        text-decoration: none;
    }

    .nav a:hover {
        background-color: 013a63;
    }

    .nav .title a.title:hover {
        text-color: F3F9FB;
        color:	F3F9FB;
    }
    .sx{
        float: left;
    }
    .dx {
        float: right;
    }

        /* Finestrella del sottomenu */
        .dropdown-contentarancio {
            display: none;
            position: absolute;
            background-color: 013a63;
            min-width: 10px; /* lunghezza minima sottomenu */
            text-overflow: ellipsis;
            word-break: break-word;
            box-shadow: 0px 16px 16px 0px rgba(0,0,0,0.2);
            padding: 0px 0px;
            z-index: 1;
        }

        /* caselle sottomenu ARANCIO*/

        .dropdown-contentarancio a {
          font-family: helvetica; ;
          background-color: lightgrey;
          text-decoration: none;
          height:25px;
          text-align: left;
        }

        .dropdown-contentarancio a:hover {
            background-color: #f3ae7c;
        }

        .dropdown:hover .dropdown-contentarancio {
            display: block;
            background-color: #013a63;
        }


        /* Finestrella del sottomenu */
        .dropdown-contentblu {
            display: none;
            position: absolute;
            background-color: 013a63;
            min-width: 10px; /* lunghezza minima sottomenu */
            text-overflow: ellipsis;
            word-break: break-word;
            box-shadow: 0px 16px 16px 0px rgba(0,0,0,0.2);
            padding: 0px 0px;
            z-index: 1;
        }

        /* caselle sottomenu BLU*/

        .dropdown-contentblu a {
          font-family: helvetica; ;
          background-color: lightgrey;
          text-decoration: none;
          height:25px;
          text-align: left;
        }

        .dropdown-contentblu a:hover {
            background-color: #7394f2;
        }

        .dropdown:hover .dropdown-contentblu {
            display: block;
            background-color: #013a63;
        }
        /* Finestrella del sottomenu VERDE */
        .dropdown-contentverde {
            display: none;
            position: absolute;
            background-color: 013a63;
            min-width: 10px; /* lunghezza minima sottomenu */
            text-overflow: ellipsis;
            word-break: break-word;
            box-shadow: 0px 16px 16px 0px rgba(0,0,0,0.2);
            padding: 0px 0px;
            z-index: 1;
        }

        /* caselle sottomenu */

        .dropdown-contentverde a {
          font-family: helvetica; ;
          background-color: lightgrey;
          text-decoration: none;
          height:25px;
          text-align: left;
        }

        .dropdown-contentverde a:hover {
            background-color: #bbeebb;
        }

        .dropdown:hover .dropdown-contentverde {
            display: block;
            background-color: #013a63;
        }


    html, body { height: 100%; }

    .container {
        position: relative;
        min-height: calc(100vh - 155px);
        box-sizing: border-box;
        height: fit-content !important;
        height: 100%;
        margin: 0 auto 50px; 
    }


.footer {
    position: relative;
    color: a9d6e5;
    background-color: 013a63;
    font-family: helvetica;
    padding:0px;
    margin:0;
    text-align:center;
    width: 100%;
    height:25px;
    }
    
    .verde {
    color: 013a63;
     background-color: #bbeebb;
    }
    
    .arancione {
    color: 013a63;
    background-color: #f3ae7c;
    }
    
    .blu {
    color: 013a63;
    background-color: #7394f2;
    }

    /*----- inizio form ---- */
#nameError {
  display: none;
  font-size: 0.8em;
}

#nameError.visible {
  display: block;
}

input.invalid {
  border-color: red;
}
    .card {

      width: 300px;
      background: #F4F6FB;
      box-shadow: 10px 10px 64px 0px rgba(180, 180, 207, 0.75);
      -webkit-box-shadow: 10px 10px 64px 0px rgba(186, 186, 202, 0.75);
      -moz-box-shadow: 10px 10px 64px 0px rgba(208, 208, 231, 0.75);
    }

    .form {
    display: flex;
    flex-direction: column;
      padding: 40px;
    }

    .card_header {
      display: -webkit-box;
      display: -ms-flexbox;
      display: flex;
      align-items: center;
      -webkit-box-align: center;
          -ms-flex-align: center;
              align-items: center;
    }

    .card svg {
      color: #468FAF;
      margin-bottom: 0px;
      margin-right: 15px;
    }
    
    h1 {
     align-items: center;
    display: block;
    font-size: 2em;
    margin-block-start: 0.67em;
    margin-block-end: 0.67em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}

    .form_heading {

      padding-bottom: 0px;
      font-size: 21px;
      color: #468FAF;
    }

    .field {
      padding-bottom: 10px;
      border-color: #24478f;
    }

    .input {
      border-radius: 5px;
      background-color: #c5e0eb;
      FONT-FAMILY: Verdana;
      padding: 5px;
      width: 100%;
      color: #24478f;
      border-color: rgba(186, 186, 202, 0.75);
    }

    .input:focus-visible {
      outline: 1px solid #aeaed6;
    }

    .input::-webkit-input-placeholder {
      color: #24478f;
    }

    .input::-moz-placeholder {
      color: #24478f;
      FONT-FAMILY: Verdana;
    }

    .input:-ms-input-placeholder {
      color: #24478f;
    }

    .input::placeholder {
      color: #24478f;
      FONT-FAMILY: Verdana;
    }

    label {
      color: #468FAF;
      font-size: 14px;
      display: block;
      padding-bottom: 4px;
      FONT-FAMILY: Verdana;
    }


    .submit-button {
         --color: #468FAF;
         font-family: Verdana;
         display: inline-block;
         width:fit-content;
         height:fit-content;
         line-height: 2.5em;
         margin: 10px;
         position: relative;
         overflow: hidden;
         border: 2px solid var(--color);
         transition: color .5s;
         z-index: 1;
         font-size: 10px;
         border-radius: 6px;
         font-weight: 500;
         color: var(--color);
    }

    .submit-button:before {
          content: "";
          position: absolute;
          z-index: -1;
          background: var(--color);
          height: 150px;
          width: 200px;
          border-radius: 50%;
     }


    .submit-button:hover {
        color: #fff;
    }

    .submit-button:before {
         top: 100%;
         left: 100%;
         transition: all .7s;
    }

    .submit-button:hover:before {
         top: -30px;
         left: -30px;
    }

    .submit-button:active:before {
         background: #3a0ca3;
         transition: background 0s;
    }



    .cancella-button {
         --color: #FF0000 ;
         font-family: inherit;
         display: inline-block;
         width:fit-content;
         height:fit-content;
         line-height: 2.5em;
         margin: 10px;
         position: relative;
         overflow: hidden;
         border: 2px solid var(--color);
         transition: color .5s;
         z-index: 1;
         font-size: 10px;
         border-radius: 6px;
         font-weight: 500;
         color: var(--color);
    }

    .cancella-button:before {
          content: "";
          position: absolute;
          z-index: -1;
          background: var(--color);
          height: 150px;
          width: 200px;
          border-radius: 50%;
     }


    .cancella-button:hover {
        color: #fff;
    }

    .cancella-button:before {
         top: 100%;
         left: 100%;
         transition: all .7s;
    }

    .cancella-button:hover:before {
         top: -30px;
         left: -30px;
    }

    .cancella-button:active:before {
         background: #3a0ca3;
         transition: background 0s;
    }

    .btn {
         --color: #013a63 ;
         font-family: inherit;
         display: inline-block;
         width:fit-content;
         height:fit-content;
         line-height: 2.5em;
         margin: 10px;
         position: relative;
         overflow: hidden;
         border: 2px solid var(--color);
         transition: color .5s;
         z-index: 1;
         font-size: 12px;
         border-radius: 8px;
         font-weight: 500;
         color: var(--color);
    }

    .btn:before {
          content: "";
          position: absolute;
          z-index: -1;
          background: var(--color);
          height: 150px;
          width: 200px;
          border-radius: 50%;
     }


    .btn:hover {
        color: #468FAF;
    }

    .btn:before {
         top: 100%;
         left: 100%;
         transition: all .7s;
    }

    .btn:hover:before {
         top: -30px;
         left: -30px;
    }

    .btn:active:before {
         background: #468FAF;
         transition: background 0s;
    }


  * Stile dei bottoni
 */
main button,
main form input[type=submit],
main > form input[type=reset] {
    background-image: linear-gradient( #B90504, #990100 );
    color: white;
    border: 1px solid #B90504;
    border-radius: 5px;
    font-size: 15px;
    padding: 1px 7px 2px;
    min-width: auto;
    outline: none;
}

main button:hover,
main > form input[type=submit]:hover,
main > form input[type=reset]:hover {
    border: 1px solid red;
}

main button:active,
main > form input[type=submit]:active,
main > form input[type=reset]:active {
    background-image: linear-gradient( #990100, #B90504 );
    border: 1px solid red;
}


btng {
 width: 150px;
 height: 50px;
 cursor: pointer;
 display: flex;
 align-items: center;
 background: red;
 border: none;
 border-radius: 5px;
 box-shadow: 1px 1px 3px rgba(0,0,0,0.15);
 background: #e62222;
}

btng, btng span {
 transition: 200ms;
}

btng .text {

 transform: translateX(35px);
 color: white;
 font-weight: bold;
}

btng .icon {
 position: absolute;
 border-left: 1px solid #c41b1b;
 transform: translateX(110px);
 height: 40px;
 width: 40px;
 display: flex;
 align-items: center;
 justify-content: center;
}

btng svg {
 width: 15px;
 fill: #eee;
}

btng:hover {
 background: #ff3636;
}

btng:hover .text {
 color: transparent;
}

btng:hover .icon {
 width: 150px;
 border-left: none;
 transform: translateX(0);
}

btng:focus {
 outline: none;
}

btng:active .icon svg {
 transform: scale(0.8);
}

 /* Initial form state */
.frm {
  --col1: #fff;
  --col2: #013a63;
  --col3: rgba(232, 213, 196, 0.9);
  --col4: #ffffff;
  --col5: #683363;
  --sh: rgba(80, 80, 80, 0.35);
  --rad: 6px;
  --radBig: 10px;
  border-radius: 0 0 var(--radBig) var(--radBig);
  box-shadow: 0 0 90px var(--sh);
  display: flex;
  flex-direction: column;
  gap: 1.5em 1em;
  padding: 20mm;
  position: relative;
  max-width: 90%;
  max-height: 200px;
  transition: background .3s ease-out, max-height .3s ease-out;
}

fieldset {
    display: block;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-block-start: 0em;
    padding-inline-start: 0em;
    padding-inline-end: 0em;
    padding-block-end: 0em;
    /* min-inline-size: min-content; */
    border-width: 0px;
    border-style: groove;
    border-color: #ffffff;
    border-image: initial;
}

.frm::before {
  content: "Pronto per effettuare la tua operazione?";
  font-family: Segoe Script;
  color:  013a63;
  font-weight: 700;
  display: grid;
  place-items: center;
  z-index: 99999;
}


.frm::after {
  backdrop-filter: blur(6px) grayscale(100%);
  background: linear-gradient(-180deg, rgba(255,255,255,1) 0%, rgba(255,255,255,.5) 70%, rgba(255, 255, 255, 0.3) 100%);
  height: 100%;
  width: 100%;
  left: 0;
  top: 10;
  display: block;
  position: absolute;
  z-index: 999;
}

.frm::after,
.frm::before {
  border-radius: 0 3 var(--radBig) var(--radBig);
  pointer-events: none;
  transition: all .5s ease-out;
}

/* Form hover and focus */
.frm:hover,
.frm:focus-within {
  max-width: 100%;
  max-height: 500px;
}

.frm:focus-within {
  overflow: initial;
}

.frm:hover::before,
.frm:hover::after {
  opacity: 0;
}

.frm:hover::after {
  backdrop-filter: blur(0) grayscale(0%);
}

.frm header {
  color: var(--col1);
  font-family:Segoe Script;
  font-weight: bold;
  text-decoration: none;
  display: block;
  text-align: center;

}
/* Labels and inputs UI */
:is(.frm) label span, label input {
  flex: 1 100%;
  transition: all .3s ease-out;
}

:is(.frm) input, select, button {
  appearance: none;
  border: 0;
  padding: .75em;
  border-radius: var(--rad);
  transition: all .3s ease-out;
}

.frm label {
  display: flex;
  flex-flow: row wrap;
  color: var(--col4);
  gap: .5em;
}

.frm input {
  box-shadow: inset 3px 3px 1px var(--sh);
}

.frm fieldset {
  display: flex;
  backdrop-filter: blur(10px);
  flex-flow: row nowrap;
  gap: 1em;
  position: relative;
  transition: all .3s ease-out;
  z-index: 10;

}

.frm fieldset label {
  flex: 1;
  display: flex;
  flex-flow: row wrap;
  font-size: .75em;
}

.sm {
  justify-content: space-around;
}

.sm span {
  text-align: center;
}

.frm select {
  box-shadow: inset 3px 3px 1px var(--sh);
  padding: .75em 1.75em .75em 0.5em;
  position: relative;
}

.custom-select {
  position: relative;
}

.custom-select::after {
  position: absolute;
  content: "";
  top: 45%;
  right: 5px;
  width: 0;
  height: 0;
  border: 6px solid transparent;
  border-color: var(--col5) transparent transparent transparent;
}

.frm fieldset span {
  flex: 1 100%;
}

.frm fieldset input {
  flex: 0 1 40px;
}

.frm button {
  background-color: var(--col1);
  color: var(--col4);
  border: 2px solid var(--col4);
  font-size: 1em;
  font-weight: 700;
  align-self: center;
  padding: .5em 1.5em;
  appearance: none;
}

/* Form and UI valid and invalid states */
.frm input:focus,
.frm select:focus {
  outline: 3px solid var(--col3);
  outline-offset: 1px;
}

.frm input:invalid:not(:focus),
.frm select:invalid:not(:focus) {
  background-color: var(--col3);
  outline: 3px solid var(--col4);
  outline-offset: 1px;
}

.frm input:valid:not(:focus),
.frm select:valid:not(:focus) {
  outline: 3px solid var(--col1);
  outline-offset: 1px;
}

.frm .message {
  display: block;
  opacity: 0;
  font-size: .75em;
  font-weight: 400;
  transition: all .3s ease-out;
  margin: -1rem 0 0;
}

.frm:has(:invalid) .message {
  opacity: 1;
  margin: .25rem 0 0 0;
}

label:has(input:invalid),
label:has(select:invalid) {
  color: var(--col3);
  opacity: .8;
}

select{
border-color: rgba(186, 186, 202, 0.75);
}


label:has(input:valid),
label:has(select:valid) {
  opacity: 1;
}

.frm:hover:has(:focus, :active):valid .submitCard {
  max-height: 180px;
  opacity: 1;
  transition: opacity 1s ease-out .5s, translate 1.3s ease-out;
  translate: 0 100%;
}

.frm:hover:invalid {
  transition: all .3s ease-out;
  background-color: var(--col5);
}

.frm:hover:valid {
  transition: all .3s ease-out;
  background-color: var(--col1);
}

.frm:hover:valid * {
  color: var(--col2);
}

.frm:hover:valid input,
.frm:hover:valid select {
  outline: 3px solid var(--col2);
}

.frm:hover:invalid fieldset {
  border: 1px dashed var(--col3);
}

.frm:hover:valid fieldset {
  border: 1px dashed var(--col2);
}

/* Submit block */
.frm .submitCard {
  display: flex;
  justify-content: center;
  background-color: var(--col2);
  border-radius: 0 0 var(--rad) var(--rad);
  bottom: 0;
  padding: .5em;
  opacity: 0;
  max-height: 0;
  translate: 0 -100%;
  position: absolute;
  width: calc(100% - 2em);
  transition: all .5s ease-out .1s;
  z-index: -1;
}   




/*
 * Stile tabella
 */
 
table {
  width:100%
  text-align: center;
  position: relative;
  font-family: Verdana;
  border-collapse: collapse; 
  border-color: 013a63;
  background-color: #f6f6f6;
}

td {
  border: 1px solid #999;
  padding: 20px;
  font-family: Verdana;
}
th {
    color: a9d6e5;
    border: 1px solid #999;
    padding: 20px;
    background-color: 013a63;
    font-family:Verdana;
    border-radius: 0;
    position: sticky;
    top: 0;
    padding: 10px;
}

/* t01 stile tabella gruppo verde */

table#t01 td {
  border: 1px solid #999;
  font-family: Verdana;
  padding: 20px;
}
table#t01 th {
border: 1px solid #999;
padding: 20px;
    color: 013a63;
    background-color: #bbeebb;
    font-family:Segoe Script;
    border-radius: 0;
    position: sticky;
    top: 0;
    padding: 10px;
}
.primary{
  background-color: #000000
}

table#t01 tfoot > tr  {
  background: black;
  color: white;
}
table#t01 tbody > tr:hover {
  background-color: #a9d6e5;;
}


,col-md-4 mb-3 {

}



/* Checkout */
.checkout {
  border-radius: 9px 9px 19px 19px;
  background-color: #F4F6FB;
}

.checkout .details {
  display: grid;
  padding: 10px;
  gap: 5px;
  border-radius: 5px;
  background-color: #c5e0eb;
  color: #24478f;
  border-color: rgba(186, 186, 202, 0.75);
}

.checkout .details span {
  font-size: 13px;
  font-weight: 600;
}

.checkout .details span:nth-child(odd) {
  font-size: 11px;
  font-weight: 700;
  color: #24478f;
  margin: auto auto auto 0;
}

.checkout .details span:nth-child(even) {
  font-size: 13px;
  font-weight: 600;
  color: #24478f;
  margin: auto 0 auto auto;
}

.checkout .checkout--footer {
 
  align-items: center;
  justify-content: space-between;
  padding: 10px 10px 10px 20px;
  background-color: #F4F6FB;
}



.price {
  position: relative;
  font-size: 22px;
  color: #2B2B2F;
  font-weight: 900;
}

.price sup {
  font-size: 13px;
}

.price sub {
  width: fit-content;
  position: absolute;
  font-size: 11px;
  color: #5F5D6B;
  bottom: 5px;
  display: inline-block;
}

.checkout .checkout-btn {
  
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 150px;
  height: 36px;
  background: #24478f;
  box-shadow: 0px 0.5px 0.5px #EFEFEF, 0px 1px 0.5px rgba(239, 239, 239, 0.5);
  border-radius: 7px;
  border: 0;
  outline: none;
  color: #ffffff;
  font-size: 11px;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.15, 0.83, 0.66, 1);
}

.card1 {
  background-color: #fff;
  border: 1px solid rgba(0,0,0,.125);
  border-radius: .25rem;
  box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,.075);
  margin: 20px;
}

.card1-REDheader {
  background-color: #CD5C5C ;
  font-family:Segoe Script;
  border-bottom: none;
  border-radius: calc(0.25rem - 1px) calc(0.25rem - 1px) 0 0;
  color: 013a63;
  font-size: 1.25rem;
  font-weight: 600;
  line-height: 1.5;
  padding: 1rem;
}

.card1-header {
  background-color:  a9d6e5;
  font-family:Segoe Script;
  border-bottom: none;
  border-radius: calc(0.25rem - 1px) calc(0.25rem - 1px) 0 0;
  color: 013a63;
  font-size: 1.25rem;
  font-weight: 600;
  line-height: 1.5;
  padding: 1rem;
}

.card1-body {
  padding: 1rem;
  font-family:Verdana;
}

blockquote1 {
  border-left: 5px solid #007bff;
  color: #444;
  font-size: 1.25rem;
  font-style: italic;
  margin: 0;
  padding: 0.5rem 0.5rem 0.5rem 1.5rem;
}

blockquote1 p {
  margin-bottom: 0;
}

blockquote1 footer {
  color: #fff;
  font-size: 1rem;

  text-align: right;
}






';

  radice constant varchar2(20) := '/apex/testUTENTE2223.'; -- Da sostituire (includere il punto)
  macchina2 constant varchar2(50) := 'http://oracle01.polo2.ad.unipi.it:8080';

end Costanti;
