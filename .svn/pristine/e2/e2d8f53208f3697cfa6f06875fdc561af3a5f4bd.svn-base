/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAJSREG    บAutor  ณMicrosiga           บ Data ณ  05/06/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AJSREG //U_AJSREG()
Local cSQL 		:= ""
Local dDatAlt   := CtoD("")
Local dDatInt 	:= CtoD("")
Local _aVetRCB  := {}
Local _nTotRCB  := 0
Local nCtRot	:= 0

Private aOk		:= {}

MsgAlert("Rotina ajustada em 26/08/09")

cSQL := " SELECT BE4_OPEUSR, BE4_CODEMP, BE4_MATRIC, BE4_TIPREG, BE4_DIGITO, BE4_DTALTA, BE4_DATPRO "
cSQL += " FROM "+RetSQLName("BE4")+" BE4 "
cSQL += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
//Raquel - mudar senhas aqui!!!
cSQL += " AND BE4_SENHA IN ('937821114') "

/*
cSQL += " AND BE4_CODOPE = '0001' "
cSQL += " AND BE4_CODLDP = '0000' "
cSQL += " AND BE4_SITUAC = '1' "
cSQL += " AND BE4_FASE = '1' "
cSQL += " AND BE4_DATPRO <> ' ' "
cSQL += " AND BE4_DTALTA = ' ' "
*/

/*
cSQL += " AND BE4_CODPEG = '00015851' "
cSQL += " AND BE4_NUMERO = '00000009' "
*/

cSQL += " AND D_E_L_E_T_ = ' ' "

PLSQuery(cSQL,"TRBPRI")

While !TRBPRI->(Eof())

	dDatAlt := TRBPRI->BE4_DTALTA  
	dDatInt := TRBPRI->BE4_DATPRO  
	nCtRot++
	
	//BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+DTOS(BD6_DATPRO)+BD6_CODPAD+BD6_CODPRO+BD6_FASE+BD6_SITUAC+BD6_HORPRO                         
	_cSQL := " SELECT BD5.R_E_C_N_O_  AS REGBD5 "
	_cSQL += " FROM "+RetSQLName("BD5")+ " BD5 "
	_cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' "
	_cSQL += " AND BD5_OPEUSR  = '"+TRBPRI->BE4_OPEUSR+"' "
	_cSQL += " AND BD5_CODEMP  = '"+TRBPRI->BE4_CODEMP+"' "
	_cSQL += " AND BD5_MATRIC  = '"+TRBPRI->BE4_MATRIC+"' "
	_cSQL += " AND BD5_TIPREG  = '"+TRBPRI->BE4_TIPREG+"' "
	_cSQL += " AND BD5_DIGITO  = '"+TRBPRI->BE4_DIGITO+"' "
	_cSQL += " AND BD5_SITUAC = '1' "
	_cSQL += " AND BD5_FASE >= '3' "           
	//_cSQL += " AND ((BD5_NUMSE1 = ' ' AND BD5_CODEMP <> '0004') OR  BD5_CODEMP = '0004' )"

	If Empty(dDatAlt)     
		_cSQL += " AND BD5_DATPRO >= '"+DtoS(dDatInt)+"' "  
		_cSQL += " AND BD5_MESPAG >= '01' "  
		_cSQL += " AND BD5_ANOPAG = '2009' "  
	Endif

	_cSQL += " AND BD5_ORIMOV = '1' "
	_cSQL += " AND BD5.D_E_L_E_T_ = ' ' "
	
	PLSQuery(_cSQL,"TRB500GR")

	While !(TRB500GR->(EOF()))
		aadd(_aVetRCB,TRB500GR->(REGBD5))
		TRB500GR->(DbSkip())
	Enddo	
	
	TRB500GR->(DbCloseArea())   						
	
	Processa({|| APrcRCB(_nTotRCB,_aVetRCB,TRBPRI->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)) } , "Aguarde", "Revalorizando cobran็a de guias ambulatoriais... "+StrZero(nCtRot,5), .T.)	
	
	BDH->(DbCloseArea())	
	_aVetRCB := {}
	
	TRBPRI->(DbSkip())
Enddo

TRBPRI->(DbCloseArea())

PLSCRIGEN(aOk,{ {"CODLDP","@C",50},{"CODPEG","@C",50},{"NUMERO","@C",50},{"DATPRO","@C",50},{"REG. ANT","@C",50},{"REG. ATU","@C",150}},"Resumo da modificacao...",.T.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAPrcRCB   บAutor  ณMicrosiga           บ Data ณ  08/13/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function APrcRCB(_nTotRCB3,_aVetRCB,cMatricUsr)
Local _nCt1 := 0
Local _uVar := {}
Local _aArBD5 := BD5->(GetArea())

_nTotRCB := Len(_aVetRCB)

ProcRegua(_nTotRCB)

If _nTotRCB > 0		
	
	For _nCt1 := 1 to _nTotRCB	                                              
	                              	
	 	BD5->(DbGoTo(_aVetRCB[_nCt1]))
	 	RecLock("BD5",.F.)        
	 	
		_uVar := PLSUSRINTE(cMatricUsr,BD5->BD5_DATPRO,BD5->BD5_HORPRO,.T.,.F.,"BD5")
		
		If BD5->(FieldPos("BD5_YGIINT")) > 0
			BD5->BD5_YRGANT := BD5->BD5_REGATE
			BD5->BD5_YGIINT := BD5->BD5_GUIINT
		Endif		
	                                          
		If Len(_uVar) > 0
			BD5->BD5_REGATE := iif(_uVar[1],"1","2")   		
			If BD5->BD5_REGATE == "1"
				BD5->BD5_GUIINT := _uVar[2]+_uVar[3]+_uVar[4]+_uVar[5]
			Endif
		Else
			BD5->BD5_REGATE := "2" 
			BD5->BD5_GUIINT := ""
		Endif
		   
		MsUnlock()
		//PLSCRIGEN(aOk,{ {"CODLDP","@C",150},{"CODPEG","@C",150},{"NUMERO","@C",150},{"DATPRO","@C",150},{"ALTEROU","@C",150}},"Resumo da modificacao...",.T.)
		aadd(aOk,{BD5->BD5_CODLDP,BD5->BD5_CODPEG,BD5->BD5_NUMERO,DtoS(BD5->BD5_DATPRO),BD5->BD5_YRGANT,BD5->BD5_REGATE})
		
		IncProc("Revalorizando: "+StrZero(_nCt1,6)+" de "+StrZero(_nTotRCB,6))	
		PLSA500RCB("BD5",_aVetRCB[_nCt1],Nil,Nil,.F.)		
		
	Next				
	
Endif

RestArea(_aArBD5)

Return Nil