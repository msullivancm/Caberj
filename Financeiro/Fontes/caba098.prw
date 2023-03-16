
#INCLUDE "PROTHEUS.CH"   
#INCLUDE "TOPCONN.CH"     
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)


*----------------------------------*
/*/{Protheus.doc} CABA098

@project Controle de Débito Automático
@description Tela de Configuração para o envio de ocorrência de débito automático. 
@author Luiz Otávio Campos
@since 21/09/2021
@version 1.0		

@return

@see www.7consulting.com.br/
/*/               

#Include "Protheus.Ch"

*---------------------*
User Function CABA098()
*---------------------*
Local aLegenda 		:= {{"P12_ATIVO ='N'"  ,"BR_VERMELHO"},;
					    {"P12_TESTE ='S'" ,"BR_AMARELO"	},;
					    {"P12_ATIVO ='S'" ,"BR_VERDE"	}}

//{"P13_STATUS=''" ,"BR_AMARELO"	},;
Private cCadastro   := "Configuração de Mensagem de Débito Automático"
Private aRotina     := {}   

DbSelectArea( "P13" ) 
DbGoTop() 

aRotina     		:= {  { "Pesquisar"  	  , "AxPesqui"  , 0, 1 } ,;
						  { "Visualizar" 	  , "AxVisual"  , 0, 2 } ,;
						  { "Incluir"		  , "Axinclui"  , 0, 3 } ,;						  
						  { "Alterar"		  , "Axaltera"  , 0, 4 } ,;						  
						  { "Excluir"		  , "u_CABA098B", 0, 5 } ,;						  						  
						  { "Previa  Envio"   , "U_CABA098F", 0, 3 } ,; 						  						  						  						  						  
						  { "Env. E-mail"	  , "U_CABA098A", 0, 4 } ,;
						  { "&Rel.Tit X Ocorr", "U_CABA098H", 0, 2 },;
						  { "Rel.Log Envio"	  , "U_CABA098D", 0, 4 },;						  
						  { "Legenda"         , "U_CABA098C", 0, 2 }  }

DbSelectArea( "P12" ) 
DbGoTop() 
mBrowse( 06, 01, 22, 75, "P12",,,,,,aLegenda)

Return


*---------------------------*
User Function CABA098A
*---------------------------*
Private cFormPgt :=""
Private cTpcfg   :=""
Private cCanal 	 := ""
//Private lRepet	  := (PDK->PDK_REPETE="S")  
//Private nQtdDRpt  := PDK->PDK_QDTRPT // Quantidade de dias para repetir o envio de mensagem
//Private nQtdDStop := PDK->PDK_QDSTOP //Quantidade de dias do vencimento que o sistema irá parar de enviar mensagens
Private cEmpresa   :=""
Private cTeste     := P12->P12_TESTE
Private cMatr 	   := P12->P12_MATTST
Private cEmailtst  := Alltrim(P12->P12_EMAIL)
Private CMSG  	   := P12->P12_MSG 
Private CMSGSMS	   := Alltrim(P12->P12_MSGSMS)
Private cTpTeste   := Alltrim(P12->P12_TPTEST)
Private cAssunto   := ""//Alltrim(P12->P12_TITEMA)
Private cCodCfg    := Alltrim(P12->P12_CODIGO)
Private cPerg 	 := "CBA092ENV"
Private cAnoBase := Space(4)
Private cMesBase := Space(2)

// A primeira linha da MSG será o titulo do e-mail para utilizar a formatação com acento.
nFimLinha1 := AT( Chr(13) + Chr(10), CMSG ) 
cAssunto:= SubStr(CMSG,1, nFimLinha1-1)

//Trata o corpo do e-mail a partir da segunda linha
CMSG  := SubStr(CMSG,nFimLinha1+2, len(CMSG)-nFimLinha1)
CMSG  := STRTRAN(CMSG, Chr(13) + Chr(10) , '<br>')  



If cTeste="S"
	If Empty(cEmailtst)
		Alert("MODO TESTE. E-mail de teste não informado para envio da mensagem. Favor informar!")
		return()
	Endif

	If Empty(cMatr)
			Alert("MODO TESTE. Não foi identificado as matriculas que serão consideradas no teste de envio. Favor informar!")
			Return
	EndIf
EndIf 

IF P12->P12_DTUENV= dDatabase
	If aviso("A T E N Ç Ã O","Já foi enviado mensagem para os clientes com esta configuração no dia de hoje. Deseja continuar?",{"Sim","Não"})=2
		Return
	EndIf
EndIf

If P12->P12_ATIVO = "N"
	Alert("Configuração selecionada não está habilitada para uso.")
	Return
EndIf


/*/Tipo de configuração de mensagem Pre-Cobrança ou Inadimplencia  
cTpcfg := P12->P12_TIPO //"1" --> Normal  //"2"--> Rejeição
If Empty(cTpcfg)
	Alert("Tipo de Configuração é inválido. Favor rever a configuração.")
	Return
EndIf*/

//Canal de Envio da Mensagem						
cCanal := P12->P12_CANAL //"1" -> E-mail //   "2" --> SMS
If Empty (cCanal)
	Alert("Tipo de Canal de Envio é inválido. Favor rever a configuração.")
	Return
EndIf

//Canal de Envio da Mensagem
If cCanal= "2"
	If aviso("A T E N Ç Ã O","Será disparado o envio de mensagem via SMS e isto terá custo. Tem certeza que deseja continuar?",{"Sim","Não"})=2
		Return
	EndIf	
EndIf

if cEmpAnt="01"
	cEmpresa  :="C"
Elseif cEmpAnt="02"
	cEmpresa  := "I"
EndIf

If Empty(cAssunto)
	Alert("Título do e-mail é inválido. Favor rever a configuração.")
	Return
EndIf

If Empty(CMSG) .and.  cCanal = '1'
	Alert("É necessário informar uma mensagem para o envio do e-mail automárico. Por favor, atualize a configuração para continuar.")
	Return
EndIf

If Empty(CMSGSMS) .and.  cCanal = '2'
	Alert("É necessário informar uma mensagem para o envio de SMS automárico. Por favor, atualize a configuração para continuar.")
	Return
EndIf


//====================================================================================
//INFORMA  MES /ANO BASE E EXECUTA O ENVIO
//====================================================================================
SX1_3(cPerg)

// Pergunta com parametros para a exclusão
IF Pergunte(cPerg, .T.)

	cAnoBase := MV_PAR01
	cMesBase := MV_PAR02

	Processa({||EnvAviso()},'Processando...')
EndIf	

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  EnvAviso  ºAutor  ³Luiz Otavio Campos  º Data ³  30/03/2021  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para disparar os e-mails via Procedure no Oracle     º±±
±±º          ³                										      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus.                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EnvAviso

	Local cQuery   := ""
	 

	ProcRegua(1000)

	Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio...')


	/* PROCEDURE "ENVIA_EMAIL_SMS_SISDEB"  (PEMPRESA IN VARCHAR2,
                                     pTESTE IN VARCHAR2 DEFAULT 'S',
                                     pMATRIC IN VARCHAR2,
                                     pEMAILTESTE IN VARCHAR2,
                                     pPREVIA IN VARCHAR2,
                                     pUSUARIO IN VARCHAR2,
                                     pASSUNTO IN VARCHAR2,
                                     pCONFIG IN VARCHAR2,
                                     pREFER IN VARCHAR2) IS
  /*
     PEMPRESA => "CABERJ" 'C','1','01','A'
                  OU
                "INTEGRAL" 'I','2','02'
                "AMBAS" 'A'
    pTESTE       S/N
    pMATRIC     lista de matriculas a filtrar , teste ou não
    pEMAILTESTE email de rederecionamento no teste
    pPREVIA     1 NORMAL 2 PREVIA
    pUSUARIO    usuario protheus do disparo
    pASSUNTO    assunto que vai no email
    pCONFIG     config padrão do usuario tabela P12
    pREFER      AAAAMM (E1_ANOBASE E1_MESBASE) do título, em branco assume ano/mês corrente , não trata aqui no Assunto)   
					
		Na Produção a SP (job)
			
		JOB_ENVIA_EMAIL_SMS_SISDEB
		fará esta chamada   

		Nota , sugiro um domínio no campo
		P13_STATUS
		X - Erro no envio 	*/

	cNameUsr:=UsrFullName(__cUserID)
    
	cQuery := "BEGIN " + CRLF
	cQuery += " ENVIA_EMAIL_SMS_SISDEB('"+cEmpresa+"',  '"+cTeste+"', '"+cMatr+"','"+cEmailtst+"','1','"+cNameUsr+"','"+cAssunto+"', '"+cCodCfg+"', '"+cAnoBase+cMesBase+"');"
	cQuery += "END;" + CRLF

	If TcSqlExec(cQuery) <> 0	
		Alert("Erro na execuçao do envio de boletos.")   
	Else                 
		Aviso("Atenção","Envio de mensagem finalizada com sucesso!.",{"OK"}) 

		//Registra a Data do ultimo envio
		DbSelectArea("P12")
		Reclock("P12",.f.)
		P12->P12_DTUENV := dDatabase
		Msunlock()
	EndIf  
Return


*-------------------------------------------------------------------------------------------*
*//Possibilita a configuração de envio do e-mail para processamento normalem rejeição.
*-------------------------------------------------------------------------------------------*
User Function CABA098B
*-------------------------------------------------------------------------------------------*
Local aArea  := GetArea()

DbSelectArea("P13")
DbSetorder(2)
If !DbSeek(xFilial("P13")+P12->P12_CODIGO)
	AxDeleta("P12",P12->(Recno()),5)
else
	alert("Configuração não pode ser excluída! Existem títulos vinculados a configuração.")
EndIf		

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  ±± CABA098C     ±±Autor  ±±Luiz Otavio Campos ±±   14/04/21   ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     ±± Mostrar a Legenda de status do Recebimento de NF           ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA098C()

BrwLegenda("Controle de Débito Automatico ","Legenda",{  {"BR_VERMELHO"         ,"Configuração Inativa."      },;
															{"BR_AMARELO"	,"Configuração em Teste"},;
															{"BR_VERDE"		,"Configuração Ativa" }}	)
															 

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  ±± CABA098D     ±±Autor  ±±Luiz Otavio Campos ±±   14/04/21   ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     ±± Gera Relatório de Log de mensagens enviadas		           ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA098D()
Local oReport
Local aArea := GetArea()
Private cPerg  := "CABA098D"

AjustaSx1(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportDef()
oReport:PrintDialog()

RestArea(aArea)

Return
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportDef()
                                      
Local oSection2
//Local oSection1
Local oReport
//Local aOrdem    := {}
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relatório de Log de Envio de Mensagens - Débito Automático"
Private contador := 1

cDesCRel := cTit

//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????
cDesl:= "Este relatorio tem como objetivo imprimir o log de mensagens enviadas."
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrint(oReport)},cDescRel)
oReport:SetLandScape()
oReport:SetTotalInLine(.T.) 


Pergunte(oReport:uParam,.F.)


	oSection2 := TRSection():New(oReport,"Ocorrências X Titulo ",{}, , ,) //"Documento"
	// Colunas do relatório
	TRCell():New(oSection2,"OPERADORA"	  ,,"Empresa"			, ""	,7	   ,  ,{|| Iif((cAliasBOL)->OPERADORA="C","Caberj","Integral")  }  		  ,"LEFT"  , ,"LEFT" ) 
	TRCell():New(oSection2,"DATA"		  ,,"Dt.Inc"  			, ""	,10	   ,  ,{|| Dtoc(Stod((cAliasBOL)->DATA)) } 											  ,"LEFT"  , ,"LEFT" )
	TRCell():New(oSection2,"ENVIO"		  ,,"Dt.Env"  			, ""	,10	   ,  ,{|| (cAliasBOL)->ENVIO } 										  ,"LEFT"  , ,"LEFT" )//Prefixo
	TRCell():New(oSection2,"HORA"		  ,,"Hr.Env" 			, ""	,5	   ,  ,{|| (cAliasBOL)->HORA } 											  ,"LEFT"  , ,"LEFT" )//Numero t?ulo a pagar
	TRCell():New(oSection2,"MATRICULA"	  ,,"Matricula"			, ""	,18	   ,  ,{|| (cAliasBOL)->MATRICULA  }  									  ,"LEFT"  , ,"LEFT" )
	TRCell():New(oSection2,"CPF"          ,,"CPF"			    , ""	,20	   ,  ,{|| (cAliasBOL)->BA1_CPFUSR }                                      ,"LEFTR" , ,"LEFT" )
	TRCell():New(oSection2,"NOMUSR"		  ,,"Beneficiário"		, ""	,30	   ,  ,{|| (cAliasBOL)->BA1_NOMUSR             }  					      ,"LEFTR" , ,"LEFT" )
	TRCell():New(oSection2,"CANAL" 		  ,,"Canal"   			, "" 	,7	   ,  ,{|| Iif((cAliasBOL)->CANAL='1',"E-mail","SMS")   } 				  ,"LEFT"  , ,"LEFT" )//N?ero do t?ulo a receber	
	TRCell():New(oSection2,"EMAIL_SMS" 	  ,,"Email\SMS."	    , ""	,20	   ,  ,{|| (cAliasBOL)->EMAIL_SMS        } 								  ,"LEFT" , ,"LEFT" )//Tipo	
	TRCell():New(oSection2,"SALDO_TOTAL"  ,,"Saldo Tit"	  	    , ""	,14	   ,  ,{|| Transform(  (cAliasBOL)->SALDO,  "@e 999,999,999.99" ) }  	)
	TRCell():New(oSection2,"TITULO"  	  ,,"Ref. " 	        , ""	,27	   ,  ,{|| (cAliasBOL)->TITULO		   }                 					,"LEFT"  , ,"LEFT" )//
	TRCell():New(oSection2,"REFERENCIAS"  ,,"Dt. Ref. " 	    , ""	,21	   ,  ,{|| (cAliasBOL)->REFERENCIA	   }                 					,"LEFT"  , ,"LEFT" )//
	TRCell():New(oSection2,"LETRAS"       ,,"Letra Ref. " 	    , ""	,15    ,  ,{|| (cAliasBOL)->LETRA	   }             							,"LEFT"  , ,"LEFT" )//	
	TRCell():New(oSection2,"ENVIADO"	  ,,"Enviado?"		    , ""	,4	   ,  ,{|| (cAliasBOL)->ENVIADO       }                       				,"LEFT"  , ,"LEFT" )//Enviado 
	TRCell():New(oSection2,"MOTIVO"	 	  ,,"Motivo.Nao.Env "	, ""	,4	   ,  ,{|| (cAliasBOL)->MOTIVO       }                        				,"LEFT"  , ,"LEFT" )//Motivo de envio
	TRCell():New(oSection2,"CODIGO"	 	  ,,"Cod. Cfg. "		, ""	,6	   ,  ,{|| (cAliasBOL)->CODCFG       }                        				,"LEFT"  , ,"LEFT" )//Motivo de envio
	TRCell():New(oSection2,"DESCRI"	 	  ,,"Descri Cfg. "		, ""	,30	   ,  ,{|| Posicione("P12",1,xFilial("P12")+(cAliasBOL)->CODCFG, "P12_DESCRI")       }                        				,"LEFT"  , ,"LEFT" )//Motivo de envio
	  
	TRFunction():New(oSection2:Cell("OPERADORA"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	


RestArea( aAreaSM0 )

Return(oReport)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportPrint(oReport)

Local oSection2 
Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 

oSection2 := oReport:Section(1)


// Query para buscar os dados no banco
cQry:="  SELECT " 
cQry+="         1 CONTADOR, LOG_ENVIO_EMAIL_SISDEB.*, BA1_NOMUSR, BA1_CPFUSR " 
cQry+=" FROM  "
cQry+="         LOG_ENVIO_EMAIL_SISDEB"
cQry+=" INNER JOIN "+RetSqlName("BA1")+" BA1 ON "
cQry+=" 	SUBSTR(MATRICULA,1,4) = BA1_CODINT "
cQry+=" 	AND SUBSTR(MATRICULA,5,4) = BA1_CODEMP "
cQry+=" 	AND SUBSTR(MATRICULA,9,6) = BA1_MATRIC "
cQry+="  	AND SUBSTR(MATRICULA,15,2) = BA1_TIPREG "
cQry+="  	AND SUBSTR(MATRICULA,17,1) = BA1_DIGITO "


cQry+=" WHERE  BA1.d_e_l_e_t_ = ' ' AND PREVIA <> '2' "

If MV_PAR01= 1
	cQry+=" AND  OPERADORA= 'C'"
ElseIf MV_PAR01= 2
	cQry+=" AND  OPERADORA= 'I'"
Else
	cQry+=" AND  OPERADORA IN ('I','C') "
EndIf

cQry+="         AND  DATA >= '"+Dtos(MV_PAR02)+"' AND DATA <= '"+Dtos(MV_PAR03)+"' "

cQry+="         AND  SUBSTR(TITULO,1,9) >= '"+MV_PAR09+"' AND SUBSTR(DATA,1,9) <= '"+MV_PAR10+"' "

If MV_PAR04 = 1
	cQry+=" AND  CANAL = '1' "  // E-mail
ElseIf MV_PAR04 = 2
	cQry+=" AND  CANAL = '2' "  // SMS
EndIf

If !Empty(MV_PAR05)
	cQry+="  AND CODCFG = '"+MV_PAR05+"' "
EndIf

If MV_PAR06 = 1
	cQry+=" AND ENVIADO = 'SIM' "
elseif MV_PAR06 = 2
	cQry+=" AND ENVIADO = 'NAO'"
EndIf

cQry+=" AND  MATRICULA >= '"+Alltrim(MV_PAR07)+"' and  MATRICULA <= '"+Alltrim(MV_PAR08)+"' "


cQry+=" ORDER BY  OPERADORA, MATRICULA, DATA   "

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Não foram encontrados dados!")
Else

	oSection2:Init()

	While  !(cAliasBOL)->(Eof())       
			
		oReport:IncMeter()
		oSection2:PrintLine()
			
		(cAliasBOL)->(DbSkip())
	Enddo   
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function AjustaSX1(cPerg)

Local aHelpPor	:= {} 

nTamMat := TamSX3("BA1_CODINT")[1]+TamSX3("BA1_CODEMP")[1]+TamSX3("BA1_MATRIC")[1]+TamSX3("BA1_TIPREG")[1]+TamSX3("BA1_DIGITO")[1] 

aHelpPor := {}
AADD(aHelpPor,"Informe a Matricula:			")

 u_CABASX1(cPerg,"01","Empresa:"		,"","a","MV_CH1"	,"C",1      ,0,0,"C","","","","","MV_PAR01","1-CABERJ","1-CABERJ","1-CABERJ","","2-INTEGRAL","2-INTEGRAL","2-INTEGRAL","3-AMBOS","3-AMBOS","3-AMBOS","","","","","","",aHelpPor,{},{},"")	
 u_CABASX1(cPerg,"02","Dt Envio De: "	,"","a","MV_CH2"	,"D",8      ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"03","Dt. Envio Ate:"	,"","a","MV_CH3"    ,"D",8      ,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"04","Canal?"		    ,"","a","MV_CH4"	,"C",1      ,0,0,"C","","","","","MV_PAR04","1-Email","1-Email","1-Email","","2-SMS","2-SMS","2-SMS","3-Ambos","3-Ambos","3-Ambos","","","","","","",aHelpPor,{},{},"")	
 u_CABASX1(cPerg,"05","Cod.Config?"	    ,"","a","MV_CH5"	,"C",6      ,0,0,"G","","P12","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"06","Enviado?"	    ,"","a","MV_CH6"	,"C",1      ,0,0,"C","","","","","MV_PAR06","1-Sim","1-Sim","1-Sim","","2-Nao","2-Nao","2-Nao","3-Ambos","3-Ambos","3-Ambos","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"07","Matricula De: "	,"","a","MV_CH7"	,"C",nTamMat,0,0,"G","","CABC03","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"08","Matricula Ate: "	,"","a","MV_CH8"	,"C",nTamMat,0,0,"G","","CABC03","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"09","Titulo De: 	"	,"","a","MV_CH9"	,"C",9 	 ,0,0,"G","",""      ,"","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"10","Titulo Ate: "	,"","a","MV_CHA"	,"C",9	 ,0,0,"G","",""      ,"","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  ±± CABA098D     ±±Autor  ±±Luiz Otavio Campos ±±   14/04/21   ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     ±± Rotina automatica de envio de mensagem		           ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA098e(lSchedule)

	Default lSchedule 	:= .T.
	
	QOut("INÍCIO PROCESSAMENTO - SCHEDULE CABA611 - "+Time())

	******************************************
	*'Executa a busca pelos anexos das guias'*
	******************************************
	execAnexo(lSchedule/*,aEmpresas[nX]*/)
	******************************************

	QOut("FIM PROCESSAMENTO - SCHEDULE CABA611 - "+Time())
	
Return


/*---------------------------------------------------------------
* Executa 
*---------------------------------------------------------------
Static Function execAnexo(lSchedule)
	
	RpcSetType(3)
	RpcClearEnv()
  	RpcSetEnv(lSchedule[1],lSchedule[2]) 
  		
	// Query buscar as informações dos arquivo  
	if cEmpAnt == '01'
		cRegAns := '324361'
		QOut("INÍCIO PROCESSAMENTO - SCHEDULE CABA098E - CABERJ - "+Time())
	else	
		 cRegAns :=  '415774'		
		 QOut("INÍCIO PROCESSAMENTO - SCHEDULE CABA098E - INTEGRAL - "+Time())
	endif 
	

	DbSelectArea("P12")
	Dbgotop()

	While !P12->(Eof())

		If P12->P12_ATIVO="S" .and. P12->PD_AUTO ="S"

			/****************************************************************************************************************************************
					PROCEDURE "ENVIA_EMAIL_SMS_INADIMPLENTES" (pEMPRESA IN VARCHAR2,
                                                             pFORMAPGTO IN VARCHAR2,
                                                             pTPCONFIG IN VARCHAR2,
                                                             pQTDDIASENV IN NUMBER,
                                                             pCANAL IN VARCHAR2,
                                                             pMSGENV IN VARCHAR2,
                                                             pTESTE IN VARCHAR2 DEFAULT 'S',
                                                             pTIPOTESTE IN VARCHAR2,
                                                             pMATRIC IN VARCHAR2,
                                                             pEMAILTESTE IN VARCHAR2,
                                                             pPREVIA IN VARCHAR2,
                                                             pUSUARIO IN VARCHAR2) IS

										
						pEMPRESA    pode ser 'C' '1' ou '01' Caberj
										'I' '2' ou '02' Integrak
						pFORMAPGTO  Lista por ex 04/06 ou Branco para Todos
						pTPCONFIG   Obrig. "1"= Pré-Cobrança ou "2"=Inadimplência.
						pQTDDIASENV Obrig. Quantidade de Dias em relação a data de vencimento
						pCANAL      Obrig. "1"= EMAIL OU "2"= SMS. (1)
						pMSGENV     Obrig. Mensagem
			/****************************************************************************************************************************************/
/*

			cQuery := "BEGIN " + CRLF
			cQuery += " ENVIA_EMAIL_SMS_INADINPLENTES ('"+cEmpAnt+"',   '" + cFormPgt + "','" + cTpcfg + "','" + nqtdDiaEnv + "','" + cCanal + "','"+cMsg+"','1');"
			cQuery += "END;" + CRLF

			If TcSqlExec(cQuery) <> 0	
				QOut("Atenção","Erro na execuçao do envio de boletos.")   
			Else                 
				QOut("Atenção","Execução de envio de boleto finalizada.") 
			EndIf  

		Endif


		DbSelectArea("P12")
		DbSkip()
	Enddo

Return
*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  ±± CABA098F     ±±Autor  ±±Luiz Otavio Campos ±±   14/04/21   ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     ±± Rotina para gerar a previa do envio de Mensagem.          ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA098F()
Local cPerg := "CBA092ENV"
Private cAnoBase := Space(4)
Private cMesBase := Space(2)


//====================================================================================
//INFORMA  MES /ANO BASE E EXECUTA O ENVIO
//====================================================================================
SX1_3(cPerg)

// Pergunta com parametros para a exclusão
IF Pergunte(cPerg, .T.)

	cAnoBase := MV_PAR01
	cMesBase := MV_PAR02


	MsgRun("Aguarde... Gerando relatorio de Previa.",,{|| U_CABA098G()})

EndIf

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  ±± CABA098G    ±±Autor  ±±Luiz Otavio Campos ±±   14/04/21   ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     ±± Rotina para gerar a previa do envio de Mensagem.          ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA098G()
	Local aArea 	  := GetArea()
	Local cMatr 	  := P12->P12_MATTST
	Local cEmailtst   := Iif(P12->P12_TESTE='S', Alltrim(P12->P12_EMAIL),"")
	Local CMSG  	  := Alltrim(P12->P12_MSG)
	Local cAssunto    := P12->P12_TITEMA
	Local cCodCfg     := P12->P12_CODIGO
    Local aDados	  := {}
	Local aCabec	  := {}
	Local CALIASBOl2 := GetNextAlias()

	
	/*
	ENVIA_EMAIL_SMS_SISDEB
	--------------------
	"ENVIA_EMAIL_SMS_SISDEB"  (PEMPRESA IN VARCHAR2,
                                                       pTESTE IN VARCHAR2 DEFAULT 'S',
                                                       pMATRIC IN VARCHAR2,
                                                       pEMAILTESTE IN VARCHAR2,
                                                       pPREVIA IN VARCHAR2,
                                                       pUSUARIO IN VARCHAR2,
                                                       pAssunto IN VARCHAR2) IS                         
	Para Teste Informar
	pTESTE = 'S'       
	pMATRIC     obrigatório para teste
	pEMAILTESTE obrigatório para teste       

	pPREVIA = '2' 1 Para Envio Real
				2 Para previa   
				
	Na Produção a SP (job)
		
	JOB_ENVIA_EMAIL_SMS_SISDEB
	fará esta chamada   

	Nota , sugiro um domínio no campo
	P13_STATUS
	X - Erro no envio

*/

	
	
	//Tipo de configuração de mensagem Pre-Cobrança ou Inadimplencia  
	cTpcfg := P12->P12_TIPO //"1" --> Envio Normal  //"2"--> Rejeição
	If Empty(cTpcfg)
		Alert("Tipo de Configuração é inválido. Favor rever a configuração.")
		Return
	EndIf

	//Canal de Envio da Mensagem							
	cCanal := P12->P12_CANAL //"1" -> Email //   "2" --> SMS
	If Empty (cCanal)
		Alert("Tipo de Configuração é inválido. Favor rever a configuração.")
		Return
	EndIf

	if cEmpAnt="01"
		cEmpresa  :="C"
	Elseif cEmpAnt="02"
		cEmpresa  := "I"
	EndIf


	If Empty(CMSG)
		Alert("É necessário informar uma mensagem para o envio do e-mail automárico. Por favor, atualize a configuração para continuar.")
		Return
	EndIf


	//******************Executa a chamada da procedure para gerar registros de Prévia ************************************	   
	cNameUsr:=UsrFullName(__cUserID)

	cQuery := "BEGIN " + CRLF
	cQuery += " ENVIA_EMAIL_SMS_SISDEB('"+AllTrim(cEmpresa)+"','N', '" + Alltrim(cMatr) + "','" + AllTrim(cEmailtst) + "', '2', '"+AllTrim(cUserName)+"', '"+AllTrim(cAssunto)+"', '"+cCodCfg+"' , '"+cAnoBase+cMesBase+"');"
	cQuery += "END;" + CRLF

/*PROCEDURE "ENVIA_EMAIL_SMS_SISDEB"  (PEMPRESA IN VARCHAR2,
                                     pTESTE IN VARCHAR2 DEFAULT 'S',
                                     pMATRIC IN VARCHAR2,
                                     pEMAILTESTE IN VARCHAR2,
                                     pPREVIA IN VARCHAR2,
                                     pUSUARIO IN VARCHAR2,
                                     pASSUNTO IN VARCHAR2,
                                     pCONFIG IN VARCHAR2,
                                     pREFER IN VARCHAR2) IS
  /*
     PEMPRESA => "CABERJ" 'C','1','01','A'
                  OU
                "INTEGRAL" 'I','2','02'
                "AMBAS" 'A'
    pTESTE       S/N
    pMATRIC     lista de matriculas a filtrar , teste ou não
    pEMAILTESTE email de rederecionamento no teste
    pPREVIA     1 NORMAL 2 PREVIA
    pUSUARIO    usuario protheus do disparo
    pASSUNTO    assunto que vai no email
    pCONFIG     config padrão do usuario tabela P12
    pREFER      AAAAMM (E1_ANOBASE E1_MESBASE) do título, em branco assume ano/mês corrente , não trata aqui no Assunto)
    */


	If TcSqlExec(cQuery) <> 0	
		QOut("Atenção","Erro na execuçao da geração da Prévia.")   
	Else                 
		QOut("Atenção","Execução de envio de boleto finalizada.") 
	EndIf  

	//******************** Busca as previas geradas para exportar arquivo ****************************************************

	aCabec :={"MATRICULA","NOME","CPF","CANAL","EMAIL","SALDO TIT","TITULOS","VENCIMENTO", "REFERENCIAS","LETRAS", "BANCO","OCORRENCIA","DESCRIÇÃO OCORRÊNCIA","MOTIVO", "COD. CONFIGURAÇÃO" }

		// Query para buscar os dados no banco
	cQry:="  SELECT " 
	cQry+="        1 CONTADOR, LOG_ENVIO_EMAIL_SISDEB.*, BA1_NOMUSR, BA1_CPFUSR, P13_BANCO, P13_OCORR, P13_DESOCO,P13_MOTV, E1_VENCREA, CODCFG " 
	cQry+=" FROM  "
	cQry+="         LOG_ENVIO_EMAIL_SISDEB"
	cQry+=" INNER JOIN "+RetSqlName("BA1")+" BA1 ON "
	cQry+=" 	SUBSTR(MATRICULA,1,4) = BA1_CODINT "
	cQry+=" 	AND SUBSTR(MATRICULA,5,4)  = BA1_CODEMP "
	cQry+=" 	AND SUBSTR(MATRICULA,9,6)  = BA1_MATRIC "
	cQry+="  	AND SUBSTR(MATRICULA,15,2) = BA1_TIPREG "
	cQry+="  	AND SUBSTR(MATRICULA,17,1) = BA1_DIGITO "
	cQry+="     AND BA1.d_e_l_e_t_ = ' '
	cQry+="  	INNER JOIN "+RetSqlName("P13")+" P13 ON "
	cQry+="  	P13.R_E_C_N_O_ = LOG_ENVIO_EMAIL_SISDEB.RECNOP13   "

	cQry+="  	INNER JOIN "+RetSqlName("SE1")+" SE1 ON "
	cQry+="  	SE1.E1_FILIAL||SE1.E1_PREFIXO||SE1.E1_NUM||SE1.E1_PARCELA||SE1.E1_TIPO =  P13.P13_FILIAL||P13.P13_PREFIX||P13.P13_TITULO||P13.P13_PARCEL||P13.P13_TIPO  AND BA1.d_e_l_e_t_ = ' '"

	cQry+=" WHERE  PREVIA = '2' "
	cQry+=" ORDER BY  OPERADORA, MATRICULA, DATA   "

	cQry    := ChangeQuery(cQry)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL2,.T.,.T.)

	dbSelectArea(cAliasBOL2)
	(cAliasBOL2)->(dbgotop())	


	//Imprime os dados do relatorio
	If (cAliasBOL2)->(Eof())
		Alert("Não foram encontrados dados!")
	Else

		While  !(cAliasBOL2)->(Eof())       

			aCabec :={"MATRICULA","NOME","CPF","CANAL","EMAIL","SALDO TIT","TITULOS","VENCIMENTO", "REFERENCIAS","LETRAS", "BANCO","OCORRENCIA","DESCRIÇÃO OCORRÊNCIA","MOTIVO", "COD. CONFIGURAÇÃO" }		
			
			Aadd(aDados,{"'"+(cAliasBOL2)->MATRICULA,; 
			(cAliasBOL2)->BA1_NOMUSR,;
			 "'"+(cAliasBOL2)->BA1_CPFUSR,;
			 Iif((cAliasBOL2)->CANAL='1',"E-mail","SMS"),;		
			 (cAliasBOL2)->EMAIL_SMS,;
			 Transform(  (cAliasBOL2)->SALDO,  "@e 999,999,999.99" ) ,;
			 "'"+(cAliasBOL2)->TITULO,;
			 SToD((cAliasBOL2)->E1_VENCREA),;
			 (cAliasBOL2)->REFERENCIA,;
			 "'"+(cAliasBOL2)->LETRA,;
			 "'"+(cAliasBOL2)->P13_BANCO,;
			 "'"+(cAliasBOL2)->P13_OCORR,;
			 "'"+(cAliasBOL2)->P13_DESOCO,;
			 "'"+(cAliasBOL2)->P13_MOTV,;
			 "'"+Transform(  (cAliasBOL2)->CODCFG, "@e 999999"),;
			 Posicione("P12",1,xFilial("P12")+(cAliasBOL2)->CODCFG, "P12_DESCRI") })
			
			(cAliasBOL2)->(DbSkip())
		Enddo   

		DlgToExcel({{"ARRAY","Previa de Envio de Mensagem" ,aCabec,aDados}})
		
		(cAliasBOL2)->(DbCloseArea())

	EndIf


	RestArea(aArea)
Return


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  ±± CABA098H    ±±Autor  ±±Luiz Otavio Campos ±±  01/10/21    ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     ±± Relatório de Titulos X Ocorrências.				          ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA098H()
Local oReport
Local aArea := GetArea()
Private cPerg  := "CABAJ98H"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

Return
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportH()
                                      
Local oSection2
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relação de Titulos X Ocorrências."
Private contador := 1

cDesCRel := cTit

//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????
cDesl:= "Este relatorio tem como objetivo imprimir a relação de Título X OCorrências Bancárias."
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
oReport:SetLandScape()
oReport:SetTotalInLine(.T.)

Pergunte(oReport:uParam,.F.)

		
oSection2 := TRSection():New(oReport,"Associados",{}, , ,) //"Documento"

// Colunas do relatório
TRCell():New(oSection2,"P13_PREFIX"	   ,,"Pref "  	    , "" ,03  ,  ,{|| (cAliasBOL)->P13_PREFIX} 		,"LEFT"  , ,"LEFT" )//Prefixo
TRCell():New(oSection2,"P13_TITULO"	   ,,"Título" 		, "" ,09  ,  ,{|| (cAliasBOL)->P13_TITULO } 	,"LEFT"  , ,"LEFT" )//Numero t?ulo a pagar
TRCell():New(oSection2,"P13_PARCEL"    ,,"Parc"		    , "" ,03  ,  ,{|| (cAliasBOL)->P13_PARCEL }     ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_TIPO"      ,,"Tp"	    	, "" ,03  ,  ,{|| (cAliasBOL)->P13_TIPO }       ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_BANCO"     ,,"Bco"	        , "" ,03  ,  ,{|| (cAliasBOL)->P13_BANCO }      ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_OCORR"     ,,"Ocor"	        , "" ,02  ,  ,{|| (cAliasBOL)->P13_OCORR }      ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_DESOCO"    ,,"Descr Ocorr"	, "" ,20  ,  ,{|| (cAliasBOL)->P13_DESOCO }     ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_MOTV"      ,,"Motivo"	    , "" ,02  ,  ,{|| (cAliasBOL)->P13_MOTV }       ,"LEFTR" , ,"LEFT" )	
TRCell():New(oSection2,"P13_DESCMO"    ,,"Desc Motv"	, "" ,40  ,  ,{|| (cAliasBOL)->EB_DESCMOT }     ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_DTINC"     ,,"Dt.Incl."	    , "" ,08  ,  ,{|| Stod((cAliasBOL)->P13_DTINC) }       ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
TRCell():New(oSection2,"P13_CLIENT"    ,,"Cliente Lj"	, "" ,12  ,  ,{|| (cAliasBOL)->P13_CLIENT +" "+(cAliasBOL)->P13_LOJA }    ,"LEFTR" , ,"LEFT" ) 	
TRCell():New(oSection2,"NOMECLI"       ,,"Nome"	    	, "" ,40  ,  ,{|| (cAliasBOL)->A1_NOME   }    	  ,"LEFTR" , ,"LEFT" )  	
TRCell():New(oSection2,"E1_MATRIC"     ,,"Matricula"	, "" ,25  ,  ,{|| (cAliasBOL)->E1_MATRIC   }   	  ,"LEFTR" , ,"LEFT" )  	
TRCell():New(oSection2,"E1_EMISSAO"    ,,"Emissao"	    , "" ,08  ,  ,{|| Stod((cAliasBOL)->E1_EMISSAO) } ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
TRCell():New(oSection2,"E1_VENCREA"    ,,"Vct.Real"  	, "" ,08  ,  ,{|| Stod((cAliasBOL)->E1_VENCREA) } ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
TRCell():New(oSection2,"E1_VALOR"      ,,"Sld Partida"  , "" ,14  ,  ,{|| Transform((cAliasBOL)->SALDO, "@e 999,999,999.99") } )//Dt. vencimento  	
TRCell():New(oSection2,"E1_MESBASE"    ,,"Mes.Bs"		, "" ,02  ,  ,{|| (cAliasBOL)->E1_MESBASE }       ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
TRCell():New(oSection2,"E1_ANOBASE"    ,,"Ano.Bs"		, "" ,04  ,  ,{|| (cAliasBOL)->E1_ANOBASE }       ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
TRCell():New(oSection2,"P13_DTENV"     ,,"Dt.Envio"	    , "" ,08  ,  ,{|| Stod((cAliasBOL)->P13_DTENV) }  ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_STATUS"    ,,"Status"	    , "" ,2   ,  ,{|| (cAliasBOL)->P13_STATUS }       ,"LEFTR" , ,"LEFT" )
TRCell():New(oSection2,"P13_CODCFG"    ,,"Codigo CFG"	, "" ,06  ,  ,{|| (cAliasBOL)->P13_CODCFG }       ,"LEFTR" , ,"LEFT" )  	
TRCell():New(oSection2,"DESCRCFG"      ,,"Descri"		, "" ,15  ,  ,{|| Posicione("P12",1,xFilial("P12")+(cAliasBOL)->P13_CODCFG, "P12_DESCRI") }         ,"LEFTR" , ,"LEFT" )

TRFunction():New(oSection2:Cell("P13_TITULO"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	

	
RestArea( aAreaSM0 )

Return(oReport)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportPrt(oReport)
//Local oSection1 
Local oSection2 
//Local aUser 

Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 


oSection2 := oReport:Section(1)

// Query para buscar os dados no banco

cQry:=" SELECT P13_PREFIX, P13_TITULO, P13_PARCEL, P13_TIPO, P13_BANCO, P13_OCORR, P13_DESOCO, P13_MOTV, P13_DESCMO, P13_DTINC, P13_DTENV, P13_STATUS, P13_CODCFG, P13_CLIENT, P13_LOJA,"
cQry+=" A1_NOME,  E1_VENCREA, E1_MESBASE, E1_ANOBASE, E1_EMISSAO, E1_CODINT||E1_CODEMP||E1_MATRIC E1_MATRIC, EB_DESCMOT,  E1_VALOR- NVL(E1_VALORNCC,0) SALDO, E1_VALOR, NVL(E1_VALORNCC,0) E1_VALORNCC "
cQry+=" FROM "+RetSqlName("P13")+ " P13 "
cQry+=" INNER JOIN "+RetSqlName("SE1")+" SE1 ON E1_FILIAL = P13_FILIAL AND  E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO = P13_PREFIX||P13_TITULO||P13_PARCEL||P13_TIPO   AND SE1.D_E_L_E_T_ = ' '"
cQry+=" LEFT JOIN  "+RetSqlName("SA1")+"  ON A1_COD = P13_CLIENT AND A1_LOJA = P13_LOJA "
cQry+=" LEFT JOIN  "+RetSqlName("P12")+" P12 ON P12_FILIAL = P13_FILIAL AND P12_CODIGO =  P13_CODCFG  AND P12.D_E_L_E_T_ = ' ' "
cQry+=" LEFT JOIN  "+RetSqlName("SEB")+" SEB ON EB_TIPO = 'R' AND EB_BANCO = P13_BANCO AND EB_REFBAN = P13_OCORR AND EB_MOTSIS= P13_MOTV AND SEB.D_E_L_E_T_ = ' '  "
cQry+=" LEFT JOIN (SELECT NVL(E1_VALOR,0) E1_VALORNCC, P13_2.R_E_C_N_O_ REC2 "
cQry+="         FROM "+RetSqlName("P13")+ " P13_2 "
cQry+="         INNER JOIN "+RetSqlName("SE1")+" SE12 ON SE12.E1_FILIAL = P13_FILIAL "
cQry+="  		AND SE12.E1_TIPO = 'NCC' "
cQry+="         AND SE12.E1_PREFIXO||SE12.E1_NUM||SE12.E1_PARCELA||E1_TIPO = P13_PREFIX||P13_TITULO||P13_PARCEL||'NCC' "
cQry+="         AND SE12.D_E_L_E_T_ = ' ' "
cQry+="         WHERE P13_FILIAL = '"+xFilial("P13")+"' "
cQry+="         AND SE12.E1_FILIAL = '"+xFilial("SE1")+"' "
cQry+="         AND P13_2.D_E_L_E_T_ = ' ' "
cQry+="         AND SE12.E1_TIPO = 'NCC' "


If !Empty(MV_PAR01)
cQry+="         AND P13_BANCO = '"+MV_PAR01+"' "	
EndIf

If !Empty(MV_PAR02)
	cQry+="     AND P13_OCORR = '"+MV_PAR02+"' "
EndIf	

cQry+="         AND P13_TITULO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
cQry+="         AND P13_DTINC BETWEEN '"+DtoS(MV_PAR05)+"' AND '"+DtoS(MV_PAR06)+"'"

If MV_PAR07 = 1
	cQry+="     AND P13_STATUS ='P'" 
Elseif MV_PAR07 = 2
	cQry+="     AND P13_STATUS ='B'" 
Elseif MV_PAR07 = 3
	cQry+="     AND P13_STATUS ='E'" 
Elseif MV_PAR07 = 4
	cQry+="    AND P13_STATUS ='X'" 
EndIf
			
cQry+="        AND P13_CLIENT BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"' "
cQry+="        AND P13_LOJA BETWEEN '"+MV_PAR10+"' AND '"+MV_PAR11+"'  ) P13NCC  ON   P13NCC.REC2 =  P13.R_E_C_N_O_ "

cQry+=" WHERE P13_FILIAL = '"+xFilial("P13")+"' "
cQry+=" AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "
cQry+=" AND P13.D_E_L_E_T_ = ' ' "
cQry+=" AND SA1010.D_E_L_E_T_ = ' ' "

If !Empty(MV_PAR01)
	cQry+=" AND P13_BANCO = '"+MV_PAR01+"' "	
EndIf
If !Empty(MV_PAR02)
	cQry+=" AND P13_OCORR = '"+MV_PAR02+"' "
EndIf	

cQry+=" AND P13_TITULO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
cQry+=" AND P13_DTINC BETWEEN '"+DtoS(MV_PAR05)+"' AND '"+DtoS(MV_PAR06)+"'"

If MV_PAR07 = 1
	cQry+=" AND P13_STATUS ='P'" 
Elseif MV_PAR07 = 2
	cQry+=" AND P13_STATUS ='B'" 
Elseif MV_PAR07 = 3
	cQry+=" AND P13_STATUS ='E'" 
Elseif MV_PAR07 = 4
	cQry+=" AND P13_STATUS ='X'" 
EndIf
	
cQry+=" AND P13_CLIENT BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"' "
cQry+=" AND P13_LOJA BETWEEN '"+MV_PAR10+"' AND '"+MV_PAR11+"' "

cQry+=" ORDER BY P13_TITULO, P13_DTINC "
 

//cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Não foram encontrados dados!")
Else

	oSection2:Init()

	While  !(cAliasBOL)->(Eof())       
			
		oReport:IncMeter()
		oSection2:PrintLine()
			
		(cAliasBOL)->(DbSkip())
	Enddo   
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
//AADD(aHelpPor,"Informe o tipo de relação de contratos que deseja exibir:			")

u_CABASX1(cPerg,"01" ,"Banco "	  	,"","a","MV_CH1"	,"C",3   ,0,0,"G","","SA6","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"02" ,"Ocorrencia"	,"","a","MV_CH2"	,"C",2   ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"03" ,"Titulo De"	,"","a","MV_CH3"	,"C",9   ,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"04" ,"Titulo Até"	,"","a","MV_CH4"	,"C",9   ,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"05" ,"Dt. Inc De"	,"","a","MV_CH5"	,"D",8   ,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"06" ,"Dt. Inc De"	,"","a","MV_CH6"	,"D",8   ,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"07" ,"Status"		,"","a","MV_CH7"	,"C",1   ,0,0,"C","","","","","MV_PAR07","1-Pendente","1-Pendente","1-Pendente","","2-Bloqueado","2-Bloqueado","2-Bloqueado","3-Enviado","3-Enviado","3-Enviado","4-ERRO","4-ERRO","4-ERRO","5-Ambos","5-Ambos","5-Ambos",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"08" ,"Cliente De"	,"","a","MV_CH8"	,"C",6   ,0,0,"G","","SA1","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"09" ,"Cliente Até"	,"","a","MV_CH9"	,"C",6   ,0,0,"G","","SA1","","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"10" ,"Loja De"		,"","a","MV_CHA"	,"C",2   ,0,0,"G","","","","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
u_CABASX1(cPerg,"11" ,"Loja Até"	,"","a","MV_CHB"	,"C",2   ,0,0,"G","","","","","MV_PAR11","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	

Return()





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function SX1_3(cPerg)

Local aHelpPor	:= {} 

aHelpPor := {}
AADD(aHelpPor,"Informe o ano base dos títulos que serao considerados no envio de e-mail")

u_CABASX1(cPerg,"01" ,"Ano Base "	,"","a","MV_CH1"	,"C",4   ,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	

AADD(aHelpPor,"Informe o Mes base dos títulos que serao considerados no envio de e-mail")
u_CABASX1(cPerg,"02" ,"Mes Base"	,"","a","MV_CH2"	,"C",2   ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	

Return()
