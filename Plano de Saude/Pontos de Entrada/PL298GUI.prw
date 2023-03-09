
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO10    บAutor  ณMicrosiga           บ Data ณ  05/04/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PL298GUI

Local aArea 		:= GetArea()//Leonardo Portella - 13/11/14
Local aAreaBR8 		:= BR8->(GetArea())//Leonardo Portella - 13/11/14

Local _cChave		:= paramixb[1]
Local _cTipoPes		:= paramixb[2]
Local _lChkChk		:= paramixb[3]
Local _aBrowGui		:= paramixb[4]          

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Efetua busca...                                                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//Leonardo Portella - 18/11/14 - Incluido o  BD6_TIPGUI na query
cSQL := "SELECT BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_TIPGUI, "
cSQL += "       BD6_MATANT, "
cSQL += "       BD6_NOMUSR, "
cSQL += "       BD6_CODOPE, BD6_ANOINT, BD6_MESINT, BD6_NUMINT, "
cSQL += "       BD6_CODPAD, BD6_CODPRO, BD6_DESPRO, BD6_DATPRO, BD6.R_E_C_N_O_ AS RECBD6 "
cSQL += "  FROM " + RetSQLName("BD6") + " BD6 "

If _cTipoPes == "1" // Nome do Usuario

	cSQL += ", " + RetSQLName("BE4") + " BE4 "
	cSQL += " WHERE "
	cSQL += "BE4_FILIAL = '"+xFilial("BE4")+"' AND "
	
	If _lChkChk
		cSQL += "BE4_NOMUSR LIKE '%" + AllTrim(_cChave) + "%' AND "
	Else
		cSQL += "BE4_NOMUSR LIKE '" + AllTrim(_cChave) + "%' AND "
	EndIf
	
	cSQL += "BE4.D_E_L_E_T_ = ' ' AND "
	cSQL += "BD6_FILIAL = BE4_FILIAL AND "
	cSQL += "BD6_CODOPE = BE4_CODOPE AND "
	cSQL += "BD6_CODLDP = BE4_CODLDP AND "
	cSQL += "BD6_CODPEG = BE4_CODPEG AND "
	cSQL += "BD6_NUMERO = BE4_NUMERO AND "
	cSQL += "BD6_ORIMOV = BE4_ORIMOV AND "
	cSQL += "BD6_SEQPF  = '  '       AND "
	cSQL += "BD6_FASE   IN ('1','2') AND "
	cSQL += "BD6_SITUAC = '1'        AND "
	cSQL += "BD6_TIPINT <> '  '      AND "
	cSQL += "BD6.D_E_L_E_T_ = ' ' "
	
	//Implementado para permitir inclusao de guias de servico...

	cSQL += "UNION "

	//Leonardo Portella - 18/11/14 - Incluido o  BD6_TIPGUI na query
	cSQL += " SELECT BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_TIPGUI, "
	cSQL += " BD6_MATANT, BD6_NOMUSR, BD6_CODOPE, BD6_ANOINT, BD6_MESINT, BD6_NUMINT, "
	cSQL += " BD6_CODPAD, BD6_CODPRO, BD6_DESPRO, BD6_DATPRO, BD6.R_E_C_N_O_ AS RECBD6 "
	cSQL += " FROM " + RetSQLName("BD6") + " BD6, " + RetSQLName("BD5") + " BD5, " + RetSQLName("BA1") + " BA1 "
	cSQL += " WHERE BA1_FILIAL = '" + xFilial("BA1") + "' "
	cSQL += " AND BA1_NOMUSR LIKE '" + AllTrim(_cChave) + "%' "
	
	cSQL += " AND BD5_FILIAL = '" + xFilial("BD5") + "' "
	cSQL += " AND BD5_CODOPE = BA1_CODINT "
	cSQL += " AND BD5_CODEMP = BA1_CODEMP "
	cSQL += " AND BD5_MATRIC = BA1_MATRIC "
	cSQL += " AND BD5_TIPREG = BA1_TIPREG "
	cSQL += " AND BD5_DIGITO = BA1_DIGITO "
	
	cSQL += " AND BD6_FILIAL = BD5_FILIAL "
	cSQL += " AND BD6_CODOPE = BD5_CODOPE "
	cSQL += " AND BD6_CODLDP = BD5_CODLDP "
	cSQL += " AND BD6_CODPEG = BD5_CODPEG "
	cSQL += " AND BD6_NUMERO = BD5_NUMERO "
	cSQL += " AND BD6_ORIMOV = BD5_ORIMOV "
	cSQL += " AND BD6_SEQPF  = '  '       "
	cSQL += " AND BD6_FASE   IN ('1','2') "
	cSQL += " AND BD6_SITUAC = '1'        "
	cSQL += " AND BD6_TIPINT <> '  '      "
	cSQL += " AND BD6.D_E_L_E_T_ = ' ' "		
	
	If FindFunction("PLSRESTOP")	
		cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
		
		If !Empty(cStrFil)
			cSQL += " AND " + cStrFil
		EndIf			
	EndIf
	
	cSQL += " ORDER BY BD6_NOMUSR "
	
ElseIf _cTipoPes == "2" // Matricula do Usuario

	cSQL += " WHERE "
	cSQL += "BD6_FILIAL = '"+xFilial("BD6")+"' AND "
	
	If _lChkChk
		cSQL += "BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG LIKE '%" + AllTrim(_cChave) + "%' AND "
	Else
		cSQL += "BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG LIKE '" + AllTrim(_cChave) + "%' AND "
	EndIf
	
	cSQL += "BD6_SEQPF  = '  '       AND "
	cSQL += "BD6_FASE   IN ('1','2') AND "
	cSQL += "BD6_TIPINT <> '  '      AND "
	cSQL += "BD6.D_E_L_E_T_ = ' '"
	
	If FindFunction("PLSRESTOP")
		cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
		
		If !Empty(cStrFil)
			cSQL += " AND " + cStrFil
		EndIf
	EndIf
	
	cSQL += " ORDER BY BD6_FILIAL,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG "
	
ElseIf _cTipoPes == "3" // Matricula Antiga

	cSQL += ", " + RetSQLName("BA1") + " BA1 "
	cSQL += " WHERE "
	cSQL += "BA1_FILIAL = '"+xFilial("BA1")+"' AND "
	
	If _lChkChk
		cSQL += "BA1_MATANT LIKE '%" + AllTrim(_cChave) + "%' AND "
	Else
		cSQL += "BA1_MATANT LIKE '" + AllTrim(_cChave) + "%' AND "
	EndIf
	
	cSQL += "BA1.D_E_L_E_T_ = ' ' AND "
	cSQL += "BD6_FILIAL = BA1_FILIAL AND "
	cSQL += "BD6_OPEUSR = BA1_CODINT AND "
	cSQL += "BD6_CODEMP = BA1_CODEMP AND "
	cSQL += "BD6_MATRIC = BA1_MATRIC AND "
	cSQL += "BD6_TIPREG = BA1_TIPREG AND "
	cSQL += "BD6_DIGITO = BA1_DIGITO AND "
	cSQL += "BD6_SEQPF  = '  '       AND "
	cSQL += "BD6_FASE   IN ('1','2') AND "
	cSQL += "BD6_TIPINT <> '  '      AND "
	cSQL += "BD6.D_E_L_E_T_ = ' '"
	
	If FindFunction("PLSRESTOP")
		cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
		
		If !Empty(cStrFil)
			cSQL += " AND " + cStrFil
		EndIf
	EndIf
	
	cSQL += " ORDER BY BD6_FILIAL,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO"
	
ElseIf _cTipoPes == "4" // Numero da Autorizacao de Internacao

	cSQL += ", " + RetSQLName("BE4") + " BE4 "
	cSQL += " WHERE "
	cSQL += "BE4_FILIAL = '"+xFilial("BE4")+"' AND "
	
	If _lChkChk
		cSQL += "BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT LIKE '%" + AllTrim(_cChave) + "%' AND "
	Else
		cSQL += "BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT LIKE '" + AllTrim(_cChave) + "%' AND "
	EndIf
	
	cSQL += "BE4.D_E_L_E_T_ = ' ' AND "
	cSQL += "BD6_FILIAL = BE4_FILIAL AND "
	cSQL += "BD6_CODOPE = BE4_CODOPE AND "
	cSQL += "BD6_CODLDP = BE4_CODLDP AND "
	cSQL += "BD6_CODPEG = BE4_CODPEG AND "
	cSQL += "BD6_NUMERO = BE4_NUMERO AND "
	cSQL += "BD6_ORIMOV = BE4_ORIMOV AND "
	cSQL += "BD6_SEQPF  = '  '       AND "
	cSQL += "BD6_FASE   IN ('1','2') AND "
	cSQL += "BD6_TIPINT <> '  '      AND "
	cSQL += "BD6.D_E_L_E_T_ = ' '"
	
	If FindFunction("PLSRESTOP")
		cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
		
		If !Empty(cStrFil)
			cSQL += " AND " + cStrFil
		EndIf
	EndIf
	
	cSQL += " ORDER BY BD6_FILIAL,BD6_NOMUSR "
	
EndIf   

PLSQuery(cSQL,"TrbPes")

TrbPes->(DbGoTop())

Do While ! TrbPes->(Eof())

	BR8->(dbSetOrder(1))
	
	If BR8->(MsSeek(xFilial("BR8")+TrbPes->(BD6_CODPAD+BD6_CODPRO)))
		cAltCus := BR8->BR8_ALTCUS
	Else
		cAltCus := ""
	EndIf
	//Bianchini - 22/05/2019 - Retirado est eIF para poder vincular procedimentos que nใo sejam Alto custo. A antiga tabela 06
	//                         estava quase toda setada para BR8_ALTCUS = '1'
	//If cAltCus == "1"
	
		//Leonardo Portella - 18/11/14 - Inicio - Apos atualizacao da TISS 3, na Function PLPESQGUIA do PLSA298.PRW foi incluido 
	    //o item tipo de guia e com isso todos os dados foram deslocados em 1 posicao 
	    //Trecho que foi incluido na nova versao do PLSA298: 
	    //-> oBrowGui:AddColumn(TcColumn():New(STR0021,Nil,; //"Tipo de Guia"
	    //-> Nil,Nil,Nil,Nil,070,.F.,.F.,Nil,Nil,Nil,.F.,Nil))     
	    //-> oBrowGui:ACOLUMNS[6]:BDATA     := { || aBrowGui[oBrowGui:nAt,6] }	         
	    //Adaptacoes para contemplar a modificacao do padrao conforme descrito acima
	    
	    /*
	    TrbPes->(aAdd(_aBrowGui, 	{  "ENABLE",;
									BD6_OPEUSR + "." + BD6_CODEMP + "." + BD6_MATRIC + "." + BD6_TIPREG + "-" + BD6_DIGITO,;
									BD6_MATANT,;
									BD6_NOMUSR,;
									BD6_CODOPE + "." + BD6_ANOINT + "." + BD6_MESINT + "." + BD6_NUMINT,;
									BD6_CODPRO,;
									BD6_DESPRO,;
									BD6_DATPRO,;
									RECBD6 };
	    							))
		*/
	    TrbPes->(aAdd(_aBrowGui, 	{  "ENABLE",;
									BD6_OPEUSR + "." + BD6_CODEMP + "." + BD6_MATRIC + "." + BD6_TIPREG + "-" + BD6_DIGITO,;
									BD6_MATANT,;
									BD6_NOMUSR,;
									BD6_CODOPE + "." + BD6_ANOINT + "." + BD6_MESINT + "." + BD6_NUMINT,;
									BD6_TIPGUI,;
									BD6_CODPRO,;
									BD6_DESPRO,;
									BD6_DATPRO,;
									RECBD6 };
	    							))
		
	    //Leonardo Portella - 18/11/14 - Fim 
	    							
	//EndIf
	
	TrbPes->(DbSkip())
	
EndDo
      
TrbPes->(DbCloseArea()) 

BR8->(RestArea(aAreaBR8))//Leonardo Portella - 13/11/14
RestArea(aArea)//Leonardo Portella - 13/11/14

Return _aBrowGui
