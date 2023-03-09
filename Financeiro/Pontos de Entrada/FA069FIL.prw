#INCLUDE "PROTHEUS.CH"


User Function FA069FIL()

	Local c_QryRec	:= PARAMIXB[1]
	Local c_Perg    := "FA069FIL"
	Local c_Query	:= c_QryRec
	Local c_GrpCob
	Local n_BolDg	:= 0 //Angelo Henrique - Boleto Digital
	Local c_MesAno	:= "" //Angelo Henrique - Boleto Digital
	Local _lValid	:= .T.//Angelo Henrique - Boleto Digital

	ParSX1( c_Perg )

	If Pergunte( c_Perg )

		c_GrpCob :=  iif( !empty(MV_PAR01), "'" + Replace(alltrim(MV_PAR01),",","','")   + "'"    , '')
		c_EmisDe := dtos( MV_PAR02 )
		c_EmisAt := dtos( MV_PAR03 )
		c_EmprDe := MV_PAR04
		c_EmprAt := MV_PAR05
		n_Mun    := MV_PAR06
		n_BolDg  := MV_PAR07 //Angelo henrqiue - Boleto Digital
		c_MesAno := MV_PAR08 //Angelo henrqiue - Boleto Digital
		c_titDe	 := MV_PAR09 //Angelo henrqiue - Chamad0 68941 - Publico Ex-Previ
		c_titAte := MV_PAR10 //Angelo henrqiue - Chamad0 68941 - Publico Ex-Previ

		//---------------------------------------------------------------
		//Inicio - Criando validações para não deixar preencher errado.
		//Processo boleto digital
		//---------------------------------------------------------------
		If n_BolDg = 1

			If Empty(c_MesAno)

				Aviso("Atenção","Selecionado Boleto digital, porém não foi preenchido a competência, Favor tentar novamente.",{"OK"})
				_lValid := .F.

			ElseIf n_Mun != 1

				Aviso("Atenção","Selecionado Boleto digital, a opção município será alterado para TODOS.",{"OK"})
				n_Mun := 1

			EndIf

		EndIf
		//---------------------------------------------------------------
		//Fim - Processo boleto digital
		//---------------------------------------------------------------

		If _lValid

			//Angelo henrqiue - Chamad0 68941 - Publico Ex-Previ
			If !Empty( c_titDe + c_titAte )

				c_Query+= " SE1.E1_NUM BETWEEN '" + c_titDe + "' AND '" + c_titAte +"'  AND "

			EndIf

			c_Query+= " EXISTS ( SELECT * "
			c_Query+= "       FROM " + retsqlname("BA3") + " "
			c_Query+= "       WHERE BA3_FILIAL = ' ' "
			c_Query+= "       AND BA3_CODINT = SE1.E1_CODINT "
			c_Query+= "       AND BA3_CODEMP = SE1.E1_CODEMP "
			c_Query+= "       AND BA3_MATRIC = SE1.E1_MATRIC "

			If !Empty( alltrim(c_GrpCob) )

				c_Query+= "       AND BA3_GRPCOB IN ( " + c_GrpCob + " ) "

			EndIf

			If !Empty( c_EmprDe + c_EmprAt )

				c_Query+= "       AND BA3_CODEMP BETWEEN '" + c_EmprDe + "' AND '" + c_EmprAt +"' "

			EndIf

			//-----------------------------------------------------------
			//Inicio - Angelo Henrique - Data:06/05/2020
			//Processo Boleto Digital
			//-----------------------------------------------------------
			If  n_BolDg != 3

				If n_BolDg = 1 //Sim

					c_Query += " AND BA3_XBOLDG = '1' "
					c_Query += " AND BA3_XCMPDG <= '" + c_MesAno + "' "

				Else

					c_Query += " AND ((BA3_XBOLDG = '0' OR BA3_XBOLDG = ' ') OR ( BA3_XBOLDG = '1' AND BA3_XCMPDG >= '" + c_MesAno + "' ))"

				EndIf

			EndIf
			//-----------------------------------------------------------
			//Fim - Angelo Henrique - Data:06/05/2020
			//-----------------------------------------------------------

			c_Query+= " ) "

			If n_Mun <> 1

				c_Query+= "  AND EXISTS ( SELECT * "
				c_Query+= "              FROM " + RetSqlName("SA1") + " SA1 "
				c_Query+= "              WHERE     A1_FILIAL = ' ' "
				c_Query+= "                    AND A1_COD = SE1.E1_CLIENTE "

				If n_Mun == 2  // Niteroi

					c_Query+= "                    AND A1_COD_MUN = '03302' "

				Else

					c_Query+= "                    AND A1_COD_MUN <> '03302' "

				EndIf

				c_Query+= "                    AND SA1.D_E_L_E_T_ = ' ' ) "

			EndIf

			c_Query += " AND "


		Else

			//---------------------------------------------------------------------
			//Angelo Henrique - Data: 07/05/2020
			//---------------------------------------------------------------------
			//Caso preencha errado o processo de boleto digital
			//não deve ser permitido executar o filtro corretamente
			//---------------------------------------------------------------------
			c_Query+= "  EXISTS ( SELECT * "
			c_Query+= "              FROM " + RetSqlName("SA1") + " SA1 "
			c_Query+= "              WHERE     A1_FILIAL = '99' "
			c_Query+= "                    AND SA1.D_E_L_E_T_ = '99' ) "
			c_Query += " AND "

		EndIf

	Else

		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 12/09/2019
		//---------------------------------------------------------------------
		//Caso cancele as perguntas do filtro o processo deve
		//ser interrompido e não achar nenhum resultado
		//---------------------------------------------------------------------
		c_Query+= "  EXISTS ( SELECT * "
		c_Query+= "              FROM " + RetSqlName("SA1") + " SA1 "
		c_Query+= "              WHERE     A1_FILIAL = '99' "
		c_Query+= "                    AND SA1.D_E_L_E_T_ = '99' ) "
		c_Query += " AND "

	EndIf

Return c_Query

Static Function ParSX1( c_Perg )

	PutSx1(c_Perg,"01",OemToAnsi("Grupo de cobrança:")	,"","","mv_ch1","C",99,0,0,"G",""														,"","","","mv_par01",""		,"","","",""		,"","",""					,"","","","","","","","",{"Informe os grupos de cobrança separados por virgula"},{""}	,{""})
	PutSx1(c_Perg,"02",OemToAnsi("Emissão de?")			,"","","mv_ch2","D",08,0,0,"G",""														,"","","","mv_par02",""		,"","","",""		,"","",""					,"","","","","","","","",{"Título final para filtragem"}						,{""}	,{""})
	PutSx1(c_Perg,"03",OemToAnsi("Emissão até?")		,"","","mv_ch3","D",08,0,1,"G",""														,"","","","mv_par03",""		,"","","",""		,"","",""					,"","","","","","","","",{"Prefixo inicial para filtragem"}						,{""}	,{""})
	PutSx1(c_Perg,"04",OemToAnsi("Empresa de?")			,"","","mv_ch4","C",04,0,1,"G",""														,"","","","mv_par04",""		,"","","",""		,"","",""					,"","","","","","","","",{"Empresa inicial"}									,{""}	,{""})
	PutSx1(c_Perg,"05",OemToAnsi("Empresa até?")		,"","","mv_ch5","C",04,0,0,"G",""														,"","","","mv_par05",""		,"","","",""		,"","",""					,"","","","","","","","",{"Empresa final"}										,{""}	,{""})
	PutSx1(c_Perg,"06",OemToAnsi("Municipio?")    	    ,"","","mv_ch6","N",01,0,0,"C",""														,"","","","mv_par11","Todos","","","","Niteroi"	,"","","Demais municípios"	,"","","","","","","","",{}														,{""}	,{""})

	//Processo boleto Digital - Angelo Henrique - Data: 06/05/2020
	u_CABASx1(c_Perg,"07",OemToAnsi("Bol Digital?")    	,"","","mv_ch7","N",01,0,0,"C","IIF(MV_PAR07 = 1,MV_PAR06 := 1,MV_PAR06 := MV_PAR06)"	,"","","","mv_par07","SIM"	,"","","","NAO"		,"","","AMBOS"				,"","","","","","","","",{}														,{""}	,{""})
	u_CABASx1(c_Perg,"08",OemToAnsi("Mes/Ano Base?")	,"","","mv_ch8","C",06,0,0,"G",""														,"","","","mv_par08",""		,"","","",""		,"","",""					,"","","","","","","","",{"Informe o mês base e ano base"}						,{""}	,{""})

	//Angelo henrqiue - Chamad0 68941 - Publico Ex-Previ - Data: 20/07/2020
	u_CABASx1(c_Perg,"09",OemToAnsi("Titulo De?")		,"","","mv_ch9","C",TAMSX3("E1_NUM")[1],0,0,"G",""														,"","","","mv_par09",""		,"","","",""		,"","",""					,"","","","","","","","",{"Informe o titulo de"}								,{""}	,{""})
	u_CABASx1(c_Perg,"10",OemToAnsi("Titulo Ate?")		,"","","mv_cha","C",TAMSX3("E1_NUM")[1],0,0,"G",""														,"","","","mv_par10",""		,"","","",""		,"","",""					,"","","","","","","","",{"Informe o titulo ate"}								,{""}	,{""})

Return