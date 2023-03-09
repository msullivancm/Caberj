/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  PLSUSRIN  บ Autor ณ Fabio Bianchini     บ Data ณ  29/10/2020 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Ponto de entrada utilizado para corrigir erro no padrใo    บฑฑ
ฑฑบ            A fun็ใo PLSUSRINTE nem sempre retorna a situa็ใo de in-   บฑฑ
ฑฑบ            terna็ใo de um paciente por causa de um BUG na query que   บฑฑ
ฑฑบ            trata vazio como nulo.  Ex: BE4_DATPRO <> '' ao inv้s de   บฑฑ
ฑฑบ            BE4_DATPRO <> ' '                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ / INTEGRAL SAUDE                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PLSUSRIN() 
    Local aArea         := GetArea()
	Local cTipGui       := ParamIXB[1] 
	Local cMatricUsr    := ParamIXB[2]
	Local dDataAnalise  := ParamIXB[3] 
	Local cHorPro       := ParamIXB[4] 
	Local lCampos       := ParamIXB[5] 
	Local lConfor       := ParamIXB[6] 
	Local cAlias        := ParamIXB[7] 
	Local cOpeUsr       := ParamIXB[8] 
	Local cCodEmp       := ParamIXB[9] 
	Local cMatric       := ParamIXB[10] 
	Local cTipReg       := ParamIXB[11] 
    Local lINTERNADO    := .F.
    Local aRetCam       := {}
    Local cSQL          := ""                
    Local cNumguiInt    := ""
    Local lRetCamp      := .f. // retorna o array com os conteudos do campos mesmo que seja regfor = 1 para nใo oacionar error.log

	/*
	CONTEฺDOS

	ParamIXB[1] = cTipGui
	ParamIXB[2] = cMatricUsr
	ParamIXB[3] = dDataAnalise
	ParamIXB[4] = cHorPro
	ParamIXB[5] = lCampos
	ParamIXB[6] = lConFor
	ParamIXB[7] = cAlias
	ParamIXB[8] = cOpeUsr
	ParamIXB[9] = cCodEmp
	ParamIXB[10] = cMatric
	ParamIXB[11] = cTipReg
	*/
	/* TRECHO TODO RETIRADO DO PADRรO PARA QUE O PE TENHA O MESMO COMPORTAMENTO, APENAS CORRIGINDO O PROBLEMA */

	if !empty(cAlias) .and. &( cAlias + "->(fieldPos('" + cAlias + "_REGFOR' ) ) " ) > 0

		if ! empty( &( cAlias + "->" + cAlias + "_REGFOR" ) )

			if lRetCamp

				If cAlias == "BD5"
					cNumguiInt := BD5->BD5_GUIINT
				elseIf cAlias == "BE4"
					cNumguiInt := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
				EndIf

				aRetCam := {.t., (cAlias)->&( cAlias + "_CODOPE" ), (cAlias)->&( cAlias + "_CODLDP" ), (cAlias)->&( cAlias + "_CODPEG" ),;
				(cAlias)->&( cAlias + "_NUMERO" ), (cAlias)->&( cAlias + "_PADINT" ),;
				cNumguiInt }

			else	

				aRetCam := { ( &(cAlias+"->"+cAlias+"_REGFOR") == "1" ), (cAlias)->&( cAlias + "_CODOPE" ), (cAlias)->&( cAlias + "_CODLDP" ), (cAlias)->&( cAlias + "_CODPEG" ),;
				(cAlias)->&( cAlias + "_NUMERO" ), (cAlias)->&( cAlias + "_PADINT" ),;
				cNumguiInt }

			endIf

			return(aRetCam)

		endIf

	endIf

	If lConFor 

		If !empty(cAlias) .and. &(cAlias+"->(FieldPos('"+cAlias+"_REGATE'))") > 0

			if ! empty( &(cAlias+"->"+cAlias+"_REGATE") )

				If cAlias == "BD5"
					cNumguiInt := BD5->BD5_GUIINT
				elseIf cAlias == "BE4"
					cNumguiInt := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
				EndIf

				aRetCam := { ( &(cAlias+"->"+cAlias+"_REGATE") == "1" ), (cAlias)->&( cAlias + "_CODOPE" ), (cAlias)->&( cAlias + "_CODLDP" ), (cAlias)->&( cAlias + "_CODPEG" ),;
				(cAlias)->&( cAlias + "_NUMERO" ), (cAlias)->&( cAlias + "_PADINT" ),;
				cNumguiInt }

				return(aRetCam)	

			endIf

		endIf

	endIf

	if empty(allTrim(cHorPro))
		cHorPro := time()
	endIf

	//Caso for informada, a consulta deve considerar a Hora
	if ! empty(cHorPro)
		cHorPro := strTran(cHorPro,":","")
	endIf

	cSQL := " SELECT BE4_DATPRO, BE4_HORPRO, BE4_DTALTA, BE4_HRALTA, "
	cSQL += "        BE4_CODOPE, BE4_CODLDP, BE4_CODPEG, BE4_NUMERO, BE4_PADINT, BE4_CODOPE, BE4_ANOINT, BE4_MESINT, BE4_NUMINT "  
	cSQL += "   FROM " + retSQLName("BE4")
	cSQL += "  WHERE BE4_FILIAL = '" + xFilial("BE4") + "' "
	cSQL += "    AND BE4_OPEUSR = '" + cOpeUsr + "' "
	cSQL += "    AND BE4_CODEMP = '" + cCodEmp + "' "
	cSQL += "    AND BE4_MATRIC = '" + cMatric + "'"
	cSQL += "    AND BE4_TIPREG = '" + cTipReg + "' "
	cSQL += "    AND BE4_TIPGUI = '03' "
	cSQL += "    AND BE4_CANCEL <> '1' "
	cSQL += "    AND BE4_SITUAC <> '2' "
	cSQL += "    AND BE4_DATPRO <> ' ' "
	cSQL += "    AND BE4_DATPRO||BE4_HORPRO <= '" + dtos(dDataAnalise) + cHorPro + "' "
	cSQL += "    AND D_E_L_E_T_ = ' ' "
	//Fabio Bianchini - 04/11/2020 - Esta condi็ใo levava em considera็ใo a hora informada na abertura da senha, fazendo com que 
	//                  a query nใo retornasse nada quando a hora da alta fosse anterior เ hora da interna็ใo
	//cSQL += "    AND ( (BE4_DTALTA >= '" + dtos(dDataAnalise) + "' AND BE4_HRALTA >= '" + cHorPro + "') OR (BE4_DTALTA = ' ') )"
	cSQL += "    AND ( (BE4_DTALTA >= '" + dtos(dDataAnalise) + "') OR (BE4_DTALTA = ' ') )"
	
	//Fabio Bianchini - 05/11/2020 - Tratamento dado para o sistema pegar somente a senha indicada em tela
	If Alltrim(FunName()) $ "PLSA001|PLSA001A"
		cSQL += " AND BE4_SENHA = '" + iif(type("M->BOW_XSENHA") == "C", M->BOW_XSENHA, BOW->BOW_XSENHA) + "' "
	Endif
/*
	if !lNerRes
		cSQL += "    AND NOT EXISTS ( SELECT R_E_C_N_O_ 
		cSQL += "                       FROM " + retSQLName("BE4") 
		cSQL += "                      WHERE BE4_FILIAL = '" + xFilial("BE4") + "' "
		cSQL += "                        AND BE4_OPEUSR = '" + cOpeUsr + "' "
		cSQL += "                        AND BE4_CODEMP = '" + cCodEmp + "' "
		cSQL += "                        AND BE4_MATRIC = '" + cMatric + "'"
		cSQL += "                        AND BE4_TIPREG = '" + cTipReg + "' "
		cSQL += "                        AND BE4_TIPGUI = '05' "
		cSQL += "                        AND BE4_CANCEL <> '1' "
		cSQL += "                        AND BE4_SITUAC <> '2' "
		cSQL += "                        AND BE4_DTALTA||BE4_HRALTA <= '" + dtos(dDataAnalise) + left(cHorPro,4) + "' "
		cSQL += "                        AND D_E_L_E_T_ = ' ' ) " 
	else	                                                        
		cSQL += "                        AND D_E_L_E_T_ = ' '  " 
	endif
*/
	dbUseArea(.T.,"TOPCONN",tcGenQry(,,changeQuery(cSql)),"PLSUSRINTE",.F.,.T.)

	if ! PLSUSRINTE->(eof())

		lInternado 	:= .t.

		aRetCam := {lInternado, PLSUSRINTE->BE4_CODOPE, PLSUSRINTE->BE4_CODLDP, PLSUSRINTE->BE4_CODPEG, PLSUSRINTE->BE4_NUMERO, PLSUSRINTE->BE4_PADINT, PLSUSRINTE->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)}

	else

		aRetCam := { lInternado,"","","","","","" }

	endIf    

	PLSUSRINTE->(dbCloseArea())

	restArea(aArea)

Return (aRetCam)

