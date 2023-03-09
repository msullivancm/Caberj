/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLS780CM  บAutor  ณMicrosiga           บ Data ณ  08/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PLS780CM()
LOCAL _aCampos    := paramixb[1]
LOCAL _nDigito    := paramixb[2]
LOCAL _nAtuSIB    := paramixb[3]
LOCAL _nUsrMatAnt := paramixb[4]
Local cMatAnt
Local _cMatUsr	:= ''
Local nQtdZero := 0                  

//Trata matricula antiga, no envio...
//Jean - Comentado apos verificar o arquivo
//retorno da Caberj. A Caberj nao envia o 
//arquivo com zeros a frente.
/*
If Len(alltrim(_acampos[3])) < 11
	cMatAnt := Alltrim(_acampos[3])
	nQtdZero := 11-Len(cMatAnt)
	cMatAnt := Replicate("0",nQtdZero)+cMatAnt
	_aCampos[3] := cMatAnt+SPACE(19)
Endif

If Len(alltrim(_acampos[34])) < 11
	cMatAnt := Alltrim(_acampos[3])
	nQtdZero := 11-Len(cMatAnt)
	cMatAnt := Replicate("0",nQtdZero)+cMatAnt
	_aCampos[34] := cMatAnt+SPACE(19)
Endif
*/

//Jean - Em 08/2/08, realizada melhoria no ponto de entrada
//para tratar inclusoes que nao sejam por troca de sistema, 
//enviar a matricula nova mesmo que tenha a antiga...
/*
If _nAtuSib == 3 .And. cIndicador == "1" .And. _aCampos[2] $ "1,2" .And. Len(Alltrim(_aCampos[3])) < 17
	_aCampos[3] := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+Space(13)
Endif
*/
If _nAtuSib == 1 .And. cIndicador == "3" .And. _aCampos[2] == "3" .And. _nUsrMatAnt == 2 .And. Len(Alltrim(_aCampos[3])) == 17
	If Empty(BA1->BA1_MATANT)
		If Empty(BA1->BA1_MATUSB)
			_cMatUsr := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
		Else
			_cMatUsr  := Alltrim(BA1->BA1_MATUSB)
		Endif
	Else	
		_cMatUsr  := Alltrim(BA1->BA1_MATANT)
	Endif
	_aCampos[3] := _cMatUsr+Space(30-Len(Alltrim(_cMatUsr)))
Endif
     


//Tratamento relativo a informacao de plano nao
//regulamentado (antes da lei).
If !Empty(_acampos[28]) .And. Alltrim(_acampos[28]) == "0006"
	_aCampos[28] := "010"+space(27)
	_aCampos[21] := "00"
	_aCampos[22] := "0"
	_aCampos[23] := "0"
Endif                                                        

Return _aCampos