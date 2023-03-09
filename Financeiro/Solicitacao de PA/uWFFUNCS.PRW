#Include "RwMake.ch"
#Include "Topconn.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "ap5mail.ch"

**'---------------------------------------------------------------------'**
**'--Função resposavel pela montagem do html de aprovação de SPA -------'**
**'---------------------------------------------------------------------'**
User Function 016WFApro(a_SaldoPls,  a_VetSe2, c_Num, c_Grupo) 
                                    
Local c_ItGuias := " "                    
Local c_ItFin 	:= " "
Local c_ItApro 	:= " "


//Local cHtmlModelo  	:= "\HTML\SPAAPROV.HTML"
Local cHtmlModelo  	:= "\HTML\SPAAPROV.HTML"
Local cCodProcesso 	:= "000002"                          
Local cAssunto		:= "Envio para Aprovação Pagamento Antecipado : " + c_Num + ". (" + ALLTRIM(SM0->M0_NOME) + ")"
Local oProcess
Local a_Aprov		:= {}
Local c_Grade		:= ""
Local c_ItApro		:= ""   
Local l_Niv 		:= .T.
Local cURLBrw 		:= AllTrim(GetMv("MV_WFBRWSR"))

a_Aprov := u_AprovSCR( c_Num , .F.)     

For n_Aprov := 1 to Len( a_Aprov )

	c_ItGuias := " "
	c_ItFin 	:= " "
	c_ItApro 	:= " "
	cHtmlModelo  	:= "\HTML\SPAAPROV.HTML"
    
	**'-----------------------------------------------------------------------------'** 
	**' Início bloco de criação do HTTP                                             '** 
	**'-----------------------------------------------------------------------------'**
	
	oProcess := TWFProcess():New(cCodProcesso, cAssunto) 
	oProcess:NewTask(cAssunto, cHtmlModelo)  
	conout("(INICIO|ATUAPV)Processo: " + oProcess:fProcessID + " - Task: " + oProcess:fTaskID )
	
	oProcess:oHtml:ValByName( "c_Emp"		, ALLTRIM(SM0->M0_NOME) +  " - Aprovador:" + usrfullname(a_Aprov[n_Aprov][1])  )
	oProcess:oHtml:ValByName( "c_CodSpa"	, PA0->PA0_NUM  )  // Marcela Coimbra - GLPI 37859
	oProcess:oHtml:ValByName( "c_Solic" 	, UsrFullName( PA0->PA0_SOLICI ) )
	oProcess:oHtml:ValByName( "c_Data"  	, dtoc( PA0->PA0_DTINC ))
	oProcess:oHtml:ValByName( "c_MesAno"	, PA0->PA0_MESCOM + "/" +  PA0->PA0_ANOCOM )
	oProcess:oHtml:ValByName( "c_PgtoSug"   , dtoc( PA0->PA0_PAGSUG ))
	oProcess:oHtml:ValByName( "c_Natureza"  , PA0->PA0_NATURE )
	oProcess:oHtml:ValByName( "c_RDA"    	, PA0->PA0_RDA + ' - ' +  PA0->PA0_NOME    )                                                                       
	oProcess:oHtml:ValByName( "c_CC"    	, PA0->PA0_CC     )                                                                       
	oProcess:oHtml:ValByName( "c_Justifica" , iif( !Empty(PA0->PA0_JUSTIF), PA0->PA0_JUSTIF , "&nbsp;" ) )
	oProcess:oHtml:ValByName( "c_Process" 	, oProcess:fProcessID + " " + oProcess:fTaskID )
	oProcess:oHtml:ValByName( "c_TipoCon" 	, fTipoOp( PA0->PA0_TPTITU ) ) // 
	oProcess:oHtml:ValByName( "c_ValProt" 	, TRANSFORM(PA0->PA0_VLPROT , "@E 999,999,999.99" ) )
	oProcess:oHtml:ValByName( "c_Valor" 	, TRANSFORM(PA0->PA0_VALOR , "@E 999,999,999.99" ) )
	fMontaData( PA0->PA0_PAGREA , oProcess)

	If u_fTpAprov( a_Aprov[n_Aprov][1] ) != "A"
	
		oProcess:oHtml:ValByName( "c_Enable"    , 'disabled="disabled"'     )                                                                       
	                                        
	Else                                                                                                                                          
	
		oProcess:oHtml:ValByName( "c_Enable"    , "&nbsp;"     )                                                                       
	
	EndIf 
	             
	conout( "0 " + c_Grupo )
	
	If u_fPosSAL(c_Grupo, a_Aprov[n_Aprov][1])
	     
		fEscBco(oProcess)//oProcess:oHtml:ValByName( "c_Bco" 	, TRANSFORM(PA0->PA0_VALOR , "@E 999,999,999.99" ) )	
	
	EndIf
	
	conout( "1 " + c_Grupo )
	
	aAdd( oProcess:aParams, PA0->PA0_NUM )
	aAdd( oProcess:aParams, PA0->PA0_FORNECE )
	aAdd( oProcess:aParams, a_Aprov[n_Aprov][1] ) // usuáro do aprovador
	
	conout( "2 " + c_Grupo )
	
	aAdd( oProcess:aParams, c_Grupo ) // codigo do aprovador//

	conout( "1 " + c_Grupo )

	aAdd( oProcess:aParams, a_Aprov[n_Aprov][2] ) // e-mail
	                        
	    
	/*
	For I:=1 to Len( a_SaldoPls )
	    
		c_ItGuias += "<tr><td>" +iIf(Empty(a_SaldoPls[I][1]),"&nbsp;" ,a_SaldoPls[I][1] )  + "</td><td style='text-align: right;' >" +;
							 transform(a_SaldoPls[I][2], "@E 999,999,999.99") + "</td> <td style='text-align: right;'>" 	+ ;
							 transform(a_SaldoPls[I][3], "@E 999,999,999.99") + "</td> <td style='text-align: right;'>" 	+ ;
							 transform(a_SaldoPls[I][4], "@E 999,999,999.99") + "</td> <td style='text-align: right;'>" 	+ ;
							 transform(a_SaldoPls[I][5], "@E 999,999,999.99") + "</td> <td style='text-align: right;'> "
	
	Next
	
	oProcess:oHtml:ValByName( "c_TablePos"	,	c_ItGuias	)
	  */
	For I:=1 to Len( a_VetSe2 )

  		c_ItFin += "<tr><td>" +	a_VetSe2[I][1] + "</td><td>" + ;
								a_VetSe2[I][2] + "</td><td>" + ;
								a_VetSe2[I][3] + "</td><td>"+ ;
								a_VetSe2[I][4] + "</td> <td style='text-align: right;'>"+ ;
								transform( a_VetSe2[I][5], "@E 999,999,999.99") + "</td> <td style='text-align: right;'>"+ ;
								transform( a_VetSe2[I][6], "@E 999,999,999.99") + ;
								"</td> <td> "+ a_VetSe2[I][7] + "</td> </tr> "	
		
	Next
	
	oProcess:oHtml:ValByName( "c_TableFin"	,	c_ItFin	)  
	
	dbSelectArea("SCR")
	dbSetOrder(1)
	If dbSeek(xFilial("SCR") + "PA" + PA0->PA0_NUM ) 
	     
		while !SCR->( EOF() ) .AND. alltrim( CR_FILIAL+CR_TIPO+CR_NUM )== alltrim( xFilial("SCR") + "PA" + PA0->PA0_NUM )
		
			If SCR->CR_STATUS == "01"
				cStatus := "Nivel Bloqueado"
			Elseif SCR->CR_STATUS == "02"
				cStatus := "Aguardando Liberação"
			Elseif SCR->CR_STATUS == "03"
				cStatus := "Aprovado"
			Elseif SCR->CR_STATUS == "04"
				cStatus := "Pedido Bloqueado"
			Elseif SCR->CR_STATUS == "05"
				cStatus := "Nivel Aprovado"
			Endif   
	      
			c_ItApro += "<tr><td>"  + UsrFullName( SCR->CR_USER ) +;
						"</td><td>" + SCR->CR_NIVEL + ;
						"</td><td>" + cStatus  + ;
						"</td><td>" + dtoc(SCR->CR_YDTPGTO) + ;
						"</td><td>" + iif( !Empty(SCR->CR_YOBS2), SCR->CR_YOBS2 , "&nbsp;" ) + ;
						"</td></tr>"
		
			SCR->( dbSkip() )
		
		EndDo
	
	EndIf
	
	oProcess:oHtml:ValByName( "c_TableApro"	,	c_ItApro	)  
	
	oProcess:cSubject := cAssunto
	oProcess:cTo := "SPA"
	oProcess:bReturn := "U_WFAPROSP()"
	
	cMailID := oProcess:Start()
	
	**'-----------------------------------------------------------------------------'**
	**' FIM bloco de criação do HTTP                                                '** 
	**'-----------------------------------------------------------------------------'**
	
	**'-----------------------------------------------------------------------------'**
	**' Início do bloco de envio de e-mail para o aprovador                         '** 
	**'-----------------------------------------------------------------------------'**
	
	cHtmlModelo := "HTML\WFAPSPA.HTML"
	
	oProcess:NewTask(cAssunto, cHtmlModelo)  
	conout("(INICIO|WFLINK)Processo: " + oProcess:fProcessID + " - Task: " + oProcess:fTaskID )
	oProcess:cSubject := cAssunto
	
	oProcess:cTo := a_Aprov[n_Aprov][2]
	
	oProcess:ohtml:ValByName("c_Empresa", iif(cEmpAnt == "01", "CABERJ", "INTEGRAL" ))
	oProcess:ohtml:ValByName("c_NomeUsu", UsrFullName( __cUserId ))
	oProcess:ohtml:ValByName("c_AcaoD"	, "incluiu")
    //oProcess:ohtml:ValByName("c_http"	, "http://10.19.1.31:7072/messenger/emp"+cEmpant+"/spa/" + cMailID + ".htm" )//teste
    //oProcess:ohtml:ValByName("c_http"	, "http://10.19.1.8:8088/messenger/emp"+cEmpant+"/spa/" + cMailID + ".htm")//Prod
    //oProcess:ohtml:ValByName("c_http"	, "http://10.19.1.8:8089/messenger/emp"+cEmpant+"/spa/" + cMailID + ".htm")

    //Bianchini - 07/07/2020 - P12-R27 - Adequação de URL´s para MV´s
    oProcess:ohtml:ValByName("c_http"	, "http://"+cURLBrw+"/messenger/emp"+cEmpant+"/spa/" + cMailID + ".htm")

	
	oProcess:Start()   
	                                      
	// u_GEnvMail("T:\Protheus_Data\HTML\WFAPSPA.HTML", "marcela@caberj.com.br", "", c_Assunto, a_Msg )

Next
	
Return    
             
**'---------------------------------------------------------------------'**
**'--Função responsável por processar o retorno no WF-------------------'**
**'---------------------------------------------------------------------'**
User Function WFAPROSP(oProcess)                                           
**'---------------------------------------------------------------------'**

Local nPrecoVenda
Local cCodStatus, cTexto, cCodProduto
Local aCodProdutos, aPrecoVendas
Local nC, nDias := 0, nHoras := 0, nMinutos := 10

Local c_Opc     	:= alltrim(oProcess:oHtml:RetByName("OPC"))
Local c_Obs     	:= alltrim(oProcess:oHtml:RetByName("OBS"))
Local c_Dia 		:= alltrim(oProcess:oHtml:RetByName("c_OpDia"))
Local c_Mes 		:= alltrim(oProcess:oHtml:RetByName("c_OpMes"))
Local c_Ano 		:= alltrim(oProcess:oHtml:RetByName("c_OpAno"))
//Local c_OpBco 		:= alltrim(oProcess:oHtml:RetByName("C_OPBCO"))

Local c_PA0Num		:= oProcess:aParams[1]
Local c_Fornec		:= oProcess:aParams[2]
Local c_User		:= oProcess:aParams[3]
Local c_Grade		:= oProcess:aParams[4]
Local l_Libera 		:= .F.    
Local l_Niv := .t.
Private a_SaldoPls 	:= {}
Private a_VetSe2	:= {}



conout( " ___ Obs: " 	+ c_Obs		)
conout( " ___ Opc: " 	+ c_Opc		)
conout( " ___ Num SP: " + c_PA0Num	)
conout( " ___ Cod For: "+ c_Fornec	)
conout( " ___ Grade: " 	+ c_Grade 	)
conout( " ___ Dia: " 	+ c_Dia 	)
conout( " ___ Mes: " 	+ c_Mes 	)
conout( " ___ Ano: " 	+ c_Ano 	)
//conout( " ___ Banco: " 	+ c_OpBco 	)

If Alltrim( c_Opc ) == 'S'
	
	dbSelectArea("SCR")
	dbSetOrder(2)
	If dbSeek(xFilial("SCR") + "PA" + c_PA0Num+Space(Len(SCR->CR_NUM)-Len(c_PA0Num)) + c_User )
	 
		l_Libera := u_fAltGrade({SCR->CR_NUM,"PA",SCR->CR_VALLIB,c_User,,c_Grade,,1,,dDataBase},dDataBase,4,, @l_Niv)// Cria grade  

conout( "__1" + IIF(l_Niv, ' - LIBERADO', '- NAO LIBERADO')	)
conout( "__2" + IIF(l_Libera, ' - LIBERADO', '- NAO LIBERADO')	)


			Reclock("SCR", .F.)                 
				
					SCR->CR_YOBS2   	:= c_Obs
					SCR->CR_YDTPGTO   	:= stod( iIf(Empty( c_Ano ) .or. Empty( c_Mes ) .or. Empty( c_Dia ), " ",  c_Ano + c_Mes + c_Dia  ) )
					SCR->CR_WF   		:= "S"
					SCR->CR_YPROCES   	:= oProcess:fProcessID + " " + oProcess:fTaskID
	//				SCR->CR_YBANCO   	:= c_OpBco
					
			MsUnlock() 

    Else 
    
	    conout( "***** Não encontrou SCR na hora da liberação"	)
    
    EndIf                                 
		
	If l_Libera    
		
		conout( "------ SPA totalmente Liberada "	)
		
		If !Empty(SCR->CR_YBANCO)
			
			dbSelectArea("SA6")
			dbSetOrder(1)
			If dbSeek( xFilial("SA6") + SCR->CR_YBANCO )
				
				a_Banco := {SA6->A6_COD ,SA6->A6_AGENCIA ,SA6->A6_NUMCON}
				
			EndIf
			
		Else
			
			a_Banco := &(GetMv("MV_XBCOPA"))
			
		EndIf
		
		
		dbSelectArea("PA0")
		dbSetOrder(1)
		If dbSeek( xFilial("PA0") + c_PA0Num )
                                                    
			Reclock("PA0", .F.)

				PA0->PA0_DTCANC   	:= DATE()
				PA0->PA0_STATUS 	:= "A"
				PA0->PA0_BANCO 		:= "A"
				PA0->PA0_AGENCIA 	:= "A"
				PA0->PA0_CONTA 		:= "A"
				PA0->PA0_BANCO 		:= a_Banco[1]
				PA0->PA0_AGENCIA 	:= a_Banco[2]
				PA0->PA0_CONTA 		:= a_Banco[3]  
					
			MsUnlock()

			
			If !Empty(SCR->CR_YBANCO)
                           
				dbSelectArea("SA6")
				dbSetOrder(1)
				If dbSeek( xFilial("SA6") + SCR->CR_YBANCO )
				
					a_Banco := {SA6->A6_COD ,SA6->A6_AGENCIA ,SA6->A6_NUMCON}
					
				EndIf

			Else
			
				a_Banco := &(GetMv("MV_XBCOPA"))				
			    
			EndIf
			
			Reclock("PA0", .F.)                                 	

				PA0->PA0_DTCANC   	:= DATE()
				PA0->PA0_STATUS 	:= "A"
				PA0->PA0_BANCO 		:= a_Banco[1]
				PA0->PA0_AGENCIA 	:= a_Banco[2]
				PA0->PA0_CONTA 		:= a_Banco[3]

			PA0->( MsUnlock() )


			c_Result := u_GeraSe2( SCR->CR_YDTPGTO, a_Banco  )
			
			
			If Empty( c_Result )

 			   u_fAvisaSPA('1', c_PA0Num, c_User )
				
				
			Else
			
 			 u_fAvisaSPA('1', c_PA0Num, c_User, .T. , c_Result)

			EndIf
					
		Else                                                              
		
			conout( "Não encontrou PA0 na hora da liberação"	)
		
		EndIf
	
	Else    


conout( "MATA MAMAE 3" + IIF(l_Niv, ' - LIBERADO', '- NAO LIBERADO')	)
conout( "MATA MAMAE 4" + IIF(l_Libera, ' - LIBERADO', '- NAO LIBERADO')	)
	
	If l_Niv
	
		dbSelectArea("PA0")
		dbSetOrder(1)
		If dbSeek( xFilial("PA0") + c_PA0Num )
		                       
			Reclock("PA0", .F.)
				
				PA0->PA0_PAGREA   	:= SCR->CR_YDTPGTO
				
			MsUnlock() 
			
			// u_cb19GSaldo(PA0->PA0_RDA, PA0->PA0_PERINI, PA0->PA0_PERFIN ) 
		
			u_cb19SE2Sal( PA0->PA0_FORNECE )    
		    
		    
			
		   		u_016WFApro( a_SaldoPls,  a_VetSe2 , PA0->PA0_NUM, c_Grade )   
		   		conout( "MATA A MAMAE"	)
			
		EndIf
				
		EndIf	
	
	EndIf    
	
Else

	dbSelectArea("SCR")
	dbSetOrder(2)
	If dbSeek(xFilial("SCR") + "PA" + c_PA0Num+Space(Len(SCR->CR_NUM)-Len(c_PA0Num)) + c_User ) .AND. Empty( SCR->CR_DATALIB )

		 u_fAltGrade({SCR->CR_NUM,"PA",SCR->CR_VALLIB,c_User,,c_Grade,,1,,dDataBase},dDataBase,6)
		
			dbSelectArea("PA0")
			dbSetOrder(1)
			If dbSeek( xFilial("PA0") + c_PA0Num )
				
				Reclock("PA0", .F.)
					PA0->PA0_DTCANC   	:= DATE()
					PA0->PA0_STATUS 	:= "R"
				MsUnlock() 
				
 			 u_fAvisaSPA('4', c_PA0Num, c_User )	
						
			EndIf    
			
			Reclock("SCR", .F.)                 
			
					SCR->CR_YOBS2   	:= c_Obs
				
			MsUnlock() 
		
	
	EndiF
	
EndIf

Return

**'---------------------------------------------------------------------'**
**'-- Função responsável por retornar os aprovadores da grade ----------'**
**'---------------------------------------------------------------------'**
User Function AprovSCR( c_NumSp, l_Lib )
**'---------------------------------------------------------------------'**

Local aArea 	:= GetArea() 
Local a_Mails 	:= {}
Local c_Qry 	:= "" 

c_Qry := "SELECT * "
c_Qry += "FROM " + RetSqlName("SCR") + " SCR " 
c_Qry += "WHERE SCR.CR_NUM = '" + c_NumSp + "' "
c_Qry += "AND SCR.CR_TIPO = 'PA' "
c_Qry += "AND d_e_l_e_t_ <> '*' "


If !l_Lib 

	c_Qry += "AND SCR.CR_STATUS = '02' " 

EndIf

c_Qry += "ORDER BY SCR.CR_NIVEL "

TcQuery c_Qry New Alias "cResult"

while !cResult->(Eof())
 
	PswOrder(1)
	PswSeek(cResult->CR_USER,.t.)
	aUser := PswRet(1)
	
	If aUser[1,14] <> ""

		aAdd(a_Mails,{cResult->CR_USER,aUser[1,14], cResult->r_e_c_n_o_ ,cResult->CR_APROV})
		
	Endif

	cResult->(dbSkip())

enddo

cResult->(dbCloseArea()) 

RestArea(aArea)  

Return( a_Mails )

**'---------------------------------------------------------------------'**
**'-- Função responsável por enviar e-mails de aviso de mudança de    --'**
**'-- status da SPA.                                                  --'**
**'---------------------------------------------------------------------'**
User Function fAvisaSPA(c_tipo, c_Num, c_UsrApr, l_Erro, c_Mensagem )
**'---------------------------------------------------------------------'**
// c_Tipo = 1 -> Aprovação Total da SPA
// c_Tipo = 2 -> SPA cancelada pelo solicitante antes da aprovação
// c_Tipo = 3 -> SPA cancelada pelo solicitante depois da aprovação
// c_Tipo = 4 -> SPA Reprovada pelo aprovador.  
      
Local cHtmlModelo  	:= " "                                              
Local cCodProcesso 	:= "000002"                     
Local cAssunto		:= " "   
Local c_ItGuias		:= " "                                
Local c_ItApro		:= " "   
Local c_ItFin 		:= " "   
Local c_To 			:= " "   

Private a_SaldoPls  := {}   

default l_Erro := .F.

a_Aprov := u_AprovSCR( c_Num , .T.)

PswOrder(1)
PswSeek(PA0->PA0_SOLICI,.t.)
aUser := PswRet(1)

If aUser[1,14] <> ""
	
	c_To := aUser[1,14] + ";"
	
Endif

For j=1 to Len( a_Aprov )
	
	c_To += a_Aprov[j][2] + ";"
	
Next

If l_Erro                      

	c_To += "angelo.cassago@caberj.com.br" + ";"

EndIf

dbSelectArea("PA0")
dbSetOrder(1)
If dbSeek(xFilial("PA0") + c_Num )
	
	Do Case
	
		Case l_Erro
		
			cHtmlModelo  	:= "\HTML\SPAAVISOAPROCV.html"
			cAssunto		:= "Erro na aprovação da solicitação de PA numero " + c_Num + " o título NÃO FOI GERADO. "
			c_Titulo		:= "Erro na aprovação da solicitação de PA numero " + c_Num + " o título NÃO FOI GERADO. "
		
		Case c_tipo = '1'  
		
			cHtmlModelo  	:= "\HTML\SPAAVISOAPROCV.html"
			cAssunto		:= "A solicitação de PA numero " + c_Num + " foi APROVADA. "
			c_Titulo			:= "A solicitação de PA numero " + c_Num + " foi APROVADA e o título PA gerado" 
			
			c_To += GetMv("MV_XSPAAVS") + ";"
			
		Case c_tipo = '2'
		
			cHtmlModelo  	:= "\HTML\SPAAVISOAPROCV.html"
			cAssunto		:= "A solicitação de PA numero " + c_Num + " foi CANCELADA. "
			c_Titulo		:= "A solicitação de PA numero " + c_Num + " foi CANCELADA pelo solicitante"
			
		Case c_tipo = '3'

			cHtmlModelo  	:= "\HTML\SPAAVISOAPROCV.html"
			cAssunto		:= "A solicitação de PA numero " + c_Num + " foi CANCELADA. "
			c_Titulo		:= "A solicitação de PA numero " + c_Num + " foi CANCELADA pelo solicitante e o título de PA gerado foi excluído. "
	
		Case c_tipo = '4'
		
			cHtmlModelo  	:= "\HTML\SPAAVISOAPROCV.html"
			cAssunto		:= "A solicitação de PA numero " + c_Num + " foi REPROVADA. "
			c_Titulo		:= "A solicitação de PA numero " + c_Num + " foi REPROVADA pelo aprovador " + usrFullName( c_UsrApr ) + ". "
	
	EndCase

EndIf

   		oProcess := TWFProcess():New(cCodProcesso, cAssunto) 
		oProcess:NewTask(cAssunto, cHtmlModelo)  
	
		oProcess:oHtml:ValByName( "c_Titulo"	, c_Titulo )
		oProcess:oHtml:ValByName( "c_Solic" 	, UsrFullName( PA0->PA0_SOLICI ) )
		oProcess:oHtml:ValByName( "c_Data"  	, dtoc(PA0->PA0_DTINC) )
		oProcess:oHtml:ValByName( "c_MesAno"	, PA0->PA0_MESCOM + "/" +  PA0->PA0_ANOCOM )
		oProcess:oHtml:ValByName( "c_PgtoSug"   , dtoc( PA0->PA0_PAGSUG ) )
		oProcess:oHtml:ValByName( "c_Natureza"  , PA0->PA0_NATURE )
		oProcess:oHtml:ValByName( "c_RDA"    	, PA0->PA0_RDA     )
		oProcess:oHtml:ValByName( "c_Justifica" , PA0->PA0_JUSTIF  )
		oProcess:oHtml:ValByName( "c_CC"    	, PA0->PA0_CC     )                                                                       
		oProcess:oHtml:ValByName( "c_Valor" 	, TRANSFORM(PA0->PA0_VALOR , "@E 999,999,999.99" ) )  
		
		If l_Erro
		 
			
			c_Html := "		<html>"
			c_Html += "<head>"
			c_Html += "  <meta content='text/html; charset=ISO-8859-1' "
			c_Html += " http-equiv='content-type'>"
			c_Html += "  <title></title>"
			c_Html += "</head>"
			c_Html += "<body>"
			c_Html += "<table style='text-align: left; width: 599px; height: 60px;'"
			c_Html += " border='1' cellpadding='2' cellspacing='2'>"
			c_Html += "  <tbody>"
			c_Html += "    <tr style='color: rgb(255, 0, 0);'>"
			c_Html += "      <td style='background-color: rgb(255, 255, 255);'><span"
			c_Html += " style='font-weight: bold;'>ERRO</span></td>"
			c_Html += "    </tr>"
			c_Html += "    <tr style='color: rgb(255, 0, 0);'>"
			c_Html += "      <td style='background-color: rgb(255, 255, 255);'><span"
			c_Html += " style='color: rgb(0, 0, 0);'>" + c_Mensagem + "</span></td>"
			c_Html += "    </tr>"
			c_Html += "  </tbody>"
			c_Html += "</table>"
			c_Html += "<br>"
			c_Html += "</body>"
			c_Html += "</html>"
		
			oProcess:oHtml:ValByName( "c_Erro" 	, c_Html )  
		
		Else
		
			oProcess:oHtml:ValByName( "c_Erro" 	, " " )  

		EndIf

//		u_cb19GSaldo(PA0->PA0_RDA, PA0->PA0_PERINI, PA0->PA0_PERFIN )
		
		dbSelectArea("SCR")
		dbSetOrder(1)
		If dbSeek(xFilial("SCR") + "PA" + PA0->PA0_NUM ) 
		     
			while !SCR->( EOF() ) .AND. alltrim( CR_FILIAL+CR_TIPO+CR_NUM )== alltrim( xFilial("SCR") + "PA" + PA0->PA0_NUM )
			
				If SCR->CR_STATUS == "01"
					cStatus := "Nivel Bloqueado"
				Elseif SCR->CR_STATUS == "02"
					cStatus := "Aguardando Liberação"
				Elseif SCR->CR_STATUS == "03"
					cStatus := "Aprovado"
				Elseif SCR->CR_STATUS == "04"
					cStatus := "Pedido Bloqueado"
				Elseif SCR->CR_STATUS == "05"
					cStatus := "Nivel Aprovado"
				Endif   
		      
				c_ItApro += "<tr><td>"  + UsrFullName( SCR->CR_USER )  	+ ;
							"</td><td>" + dtoc(SCR->CR_DATALIB) 				+ ;
							"</td><td>" + SCR->CR_NIVEL 				+ ;
							"</td><td>" + cStatus 						+ ;	
							"</td><td>" + dtoc( SCR->CR_YDTPGTO ) + ;
							"</td><td>" + iif( !Empty( SCR->CR_YOBS2 ), SCR->CR_YOBS2 , "&nbsp;" ) 		+ ;	
							"</td></tr>"
				
				SCR->( dbSkip() )
			
			EndDo
		
		EndIf
		
		oProcess:oHtml:ValByName( "c_TableApro"	,	c_ItApro	)  
		oProcess:cSubject := cAssunto
		oProcess:cTo := c_To

		cMailID := oProcess:Start()

Return

Static Function fMontaData( d_Data, oProcess )

Local c_Select := ""

For n_S:= 1 To 31     

	c_Ops := strzero( n_S, 2 )                              
                            
	If Day( d_Data ) == n_S

		c_Select	+= "<option SELECTED value='" + c_Ops + "'>" + c_Ops + "</option>"
    
	Else
	     
		c_Select	+= "<option value='" + c_Ops + "'>" + c_Ops + "</option>"
	
	EndIf
Next

oProcess:oHtml:ValByName( "c_Dia" 	, c_Select  )  
 
c_Select	:= ""

For n_S:= 1 To 12     

	c_Ops := strzero( n_S, 2 )                              
                            
	If Month( d_Data ) == n_S

		c_Select	+= "<option SELECTED value='" + c_Ops + "'>" + c_Ops + "</option>"
    
	Else
	     
		c_Select	+="<option value='" + c_Ops + "'>" + c_Ops + "</option>"
	
	EndIf
Next            

oProcess:oHtml:ValByName( "c_Mes" 	, c_Select  ) 

c_Select	:= ""

For n_S:= Year( dDataBase ) To Year( dDataBase ) + 4

	c_Ops := strzero( n_S, 4 )                              
                            
	If Year( d_Data ) == n_S

		c_Select	+= "<option SELECTED value='" + c_Ops + "'>" + c_Ops + "</option>"
    
	Else
	     
		c_Select	+= "<option value='" + c_Ops + "'>" + c_Ops + "</option>"
	
	EndIf
Next

oProcess:oHtml:ValByName( "c_Ano" 	, c_Select  )      

//c_Select	+= " </select>"

Return c_Select

Static Function fTipoOp( c_Opc ) 

Local c_Return := ""
               
Do Case

	case c_Opc = '1' 
		c_Return := "Contratos"
	case c_Opc = '2'
		c_Return := "Rda"
	case c_Opc = '3'  
		c_Return := "Opme"
	case c_Opc = '4'
		c_Return := "Reemb/AXF/DEV"
	case c_Opc = '5'   
		c_Return := "Corretor"
	case c_Opc = '6' 
		c_Return := "Convenio"
	case c_Opc = '7' 
		c_Return := "Financeiro"
	case c_Opc = '9'                                             
		c_Return := "Outros"

EndCase
      
Return c_Return

User Function fPosSAL( c_Grupo, c_User )

Local c_Qry 	:= " "      
Local l_InfBco 	:= .F.

c_Qry := " SELECT SAL.*  "
c_Qry += " FROM " + RETSQLNAME("SAL") +" SAL, " + RETSQLNAME("SAK") +" SAK "
c_Qry += " WHERE AL_FILIAL = '" + XFILIAL("SAL") +  "' "
c_Qry += " AND AL_FILIAL = '" + XFILIAL("SAL") +  "' "
c_Qry += " AND AL_COD = '" + c_Grupo + "' "
c_Qry += " AND AK_USER = AL_USER "
c_Qry += " AND AK_USER = '" + c_User  + "' "
c_Qry += " AND SAK.D_E_L_E_T_ <> '*'  "
c_Qry += " AND SAL.D_E_L_E_T_ <> '*' "

TcQuery c_Qry New Alias "QRYSAL"

IF !QRYSAL->( EOF() )

	l_InfBco := ( QRYSAL->AL_YINFBCO == "S")

EndIf             

QRYSAL->( dbCloseArea() )


Return l_InfBco

Static Function fEscBco(oProcess)

c_Select	:= "" 
c_Html 		:= ""

a_Banco := &(GetMv("MV_XBCOPA")) 
      
c_Html+="<tr>"
c_Html+="<td style='width: 138px;'>Conta para Pgto:</td>"
c_Html+="<td style='' text='' h='' 511px=''>"
c_Html+="<select name='C_OPBCO' >!C_OPBCO!"

dbSelectArea("SA6")
dbGoTop()
dbSetOrder(1)
While !EOF()
                            
	If ( Alltrim(SA6->A6_COD) == PA0->PA0_BANCO .AND. Alltrim(SA6->A6_AGENCIA) == PA0->PA0_AGENCIA .AND. Alltrim(SA6->A6_NUMCON) == PA0->PA0_CONTA ) .or. ;
		Alltrim(SA6->A6_COD) == a_Banco[1] .AND. Alltrim(SA6->A6_AGENCIA) == a_Banco[2] .AND. Alltrim(SA6->A6_NUMCON) == a_Banco[3]

		c_Html	+= "<option SELECTED value='" + SA6->A6_COD + SA6->A6_AGENCIA + SA6->A6_NUMCON + ;
						"' >" + "Banco: " + SA6->A6_COD + " - " + SA6->A6_NOME + " Agencia: " + SA6->A6_AGENCIA + " Conta: " + A6_NUMCON + ". " + "</option>"
  
	Else
	     
		c_Html	+= "<option value='" + SA6->A6_COD + SA6->A6_AGENCIA + SA6->A6_NUMCON + ;
						"' >" + "Banco: " + SA6->A6_COD + " - " + SA6->A6_NOME + " Agencia: " + SA6->A6_AGENCIA + " Conta: " + A6_NUMCON + ". " + "</option>"
  
	EndIf

SA6->( dbSkip() )

EndDo

c_Html+="</select>
c_Html+="</td>
c_Html+="</tr>

oProcess:oHtml:ValByName( "c_BCO" 	, c_Html  ) 

Return


User Function LogMatInt(c_MatMem, c_NomMem, c_Posic)   

 //	Local oError	:= ErrorBlock({|e| u_ErroFun(/*"Mensagem de Erro: " +chr(10)+ e:Description*/)})    
	Local l_Ret 	:= .T.  
	Local a_Area	:= getArea()

//	Begin Transaction
//	Begin Sequence
	    
	PlsLogFil(	"LOGINT " +  c_Posic + " || HORA: " + Time() + " || RECNO BA1: " + alltrim( str( BA1->( RECNO() ) ) ) + " || MAT MEMORIA: " + c_MatMem + " || NOME MEMORIA: " + c_NomMem + " || NOME BA1: " + BA1->BA1_NOMUSR + " || RPO: " + GetEnvServer() + " || FUNCAO: " + FUNNAME() + " || BE4->BE4_MATRIC" + BE4->BE4_MATRIC + " || M->BE4_MATRIC" + M->BE4_MATRIC,;
				"LOGINT_" +  __cUserId  + "_" + dtos( date() )+".txt",.t.) //"Validacao usuario"" Segundo(s)"	_" + usrfullname( __cUserId ) + "_" + dtos( date() ) + "_" + replace(Time()
	
	/*
	dbSelectArea("BA1")
	dbSetOrder(2)
	If dbSeek(xFilial("BA1") + c_MatMem )
	     
		If !Empty(c_NomMem) .and. Alltrim( BA1->BA1_NOMUSR ) <> ALLTRIM( c_NomMem )
		     
			l_Ret := .F.                               
			
			    // "roberto.meirelles@totvs.com.br;marcelo.giglio@totvs.com.br;fabiobianchini@caberj.com.br;marcela@caberj.com.br;"

		    EnviaEmail( "marcela@caberj.com.br;",;
		                "", "Erro de matricula internação - PRODUÇÃO",;
		                	"LOGINT " +  c_Posic + " || HORA: " + Time() + " || RECNO BA1: " + alltrim( str( BA1->( RECNO() ) ) ) + " || MAT MEMORIA: " + c_MatMem + " || NOME MEMORIA: " + c_NomMem + " || NOME BA1: " + BA1->BA1_NOMUSR + " || RPO: " + GetEnvServer() ) // +  c_Posic + " -> MAT MEMORIA: " + c_MatMem + "|| NOME MEMORIA: " + c_NomMem + " || NOME BA1: " + BA1->BA1_NOMUSR
				          
		EndIf	
		
	EndIf    */       
	
	**'Inicio - Marcela Coimbra - 28/06/2010'  **
	**'Rotina para tratamento de erro'** 
   //	End Sequence
	
	// ErrorBlock(oError)
	
	// End Transaction
	
	            
	RestArea( a_Area )
	
Return l_Ret           

Static Function EnviaEmail( c_To, c_CC, c_Assunto, c_Msg )

Local oMsg
Local _cError     := ""
Local l_Result    := .F.                   // resultado de uma conexão ou envio
Local c_Body      := space(99999)

Private _cServer  := Trim(GetMV("MV_RELSERV")) // smtp.ig.com.br ou 200.181.100.51
Private _cUser    := Trim(GetMV("MV_RELACNT")) // fulano@ig.com.br
Private _cPass    := Trim(GetMV("MV_RELPSW"))  // 123abc

Private _cFrom    := "CABERJ Ptotheus"
Private cMsg      := ""
Private cdata	  := DATE()
Private cNomFor
Private cNum          
Private nOrdSE2Esp:= GetNewPar("MV_PLSOSE2",11)

Private c_Itens:= ""

// Contecta o servidor de e-mail
CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result
                          
// Autentica
If !MailAuth(_cUser,_cPass)
	//MSGINFO("Falla de Atentificacion","Error")
	DISCONNECT SMTP SERVER RESULT lOk
	IF !lOk
		GET MAIL ERROR cErrorMsg
		//Alert("Error al tratar de enviar correo  Error")
	ENDIF

EndIf

SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Msg  RESULT l_Result

If !l_Result
	GET MAIL ERROR _cError
	//alert("Erro ao conectar no servidor: " + _cError)
	Return
Endif

If !l_Result
	GET MAIL ERROR _cError
	//("Erro ao enviar e-mail: " + _cError)
	Return    

Endif 
               
Return  

**'Inicio - Marcela Coimbra - 28/06/2010'  **
**'Rotina para tratamento de erro'** 
Static Function ErroFun(cMsg)

DisarmTransaction()   

//__Quit()

Return      

**'Fim - Marcela Coimbra - 28/06/2010'  **
**'Rotina para tratamento de erro'** 
