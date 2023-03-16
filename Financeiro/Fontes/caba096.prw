#INCLUDE "PROTHEUS.CH"   
#INCLUDE "TOPCONN.CH"     
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#DEFINE CRLF Chr(13)+Chr(10)


*----------------------------------*
/*/{Protheus.doc} UNIA005

@project Gestใo de inadimpl๊ncia 
@description Tela de Configura็ใo para o envio de cobran็a aos clientes indamplentes 
@author Luiz Otแvio Campos
@since 26/03/2021
@version 1.0		

@return

@see www.thebestconsulting.com.br/
/*/               

#Include "Protheus.Ch"

*---------------------*
User Function CABA096()
*---------------------*
Local aLegenda 		:= {{"PDK_ATIVO='N'"  ,"BR_VERMELHO"},;
					    {"PDK_TESTE ='S'" ,"BR_AMARELO"	},;
					    {"PDK_ATIVO ='S'" ,"BR_VERDE"	}}

Private cCadastro   := "Configura็ใo de cobran็a de Inadimplentes"
Private aRotina     := {}   

DbSelectArea( "PDK" ) 
DbGoTop() 

aRotina     		:= {  { "Pesquisar"  	, "AxPesqui"  , 00, 01 } ,;
						  { "Visualizar" 	, "AxVisual"  , 00, 02 } ,;
						  { "Incluir"	 	, "AxInclui"  , 00, 03 } ,;
						  { "Alterar"	 	, "AxAltera"  , 00, 04 } ,;
						  { "Legenda"       , "U_CABA096C", 00, 02 } ,;
						  { "Excluir"	 	, "U_CABA096B", 00, 05 } ,;
						  { "Rel.Mat. Bloq ", "U_CABA096H", 00, 04 } ,;
						  { "Previa  Envio" , "U_CABA096F", 00, 04 } ,; 						  
						  { "Envia Cobran็a", "U_CABA096A", 00, 04 } ,;
						  { "Rel.Log Envio"	, "U_CABA096D", 00, 04 } ,;
						  { "Bloq/Desbloq"	, "U_CABA096J", 00, 04 } }

DbSelectArea( "PDK" ) 
DbGoTop() 
mBrowse( 06, 01, 22, 75, "PDK",,,,,,aLegenda)


Return


*---------------------------*
User Function CABA096A
*---------------------------*
Private cFormPgt :=""
Private cTpcfg   :=""
Private cCanal 	 := ""
Private nqtdDiaEnv := PDK_QTDENV //Quantidade de dias a partir da data de vencimento para enviar o boleto. Antes ou depois de acordo com o Tipo "PDK_TIPO"
//Private lRepet	  := (PDK->PDK_REPETE="S")  
//Private nQtdDRpt  := PDK->PDK_QDTRPT // Quantidade de dias para repetir o envio de mensagem
//Private nQtdDStop := PDK->PDK_QDSTOP //Quantidade de dias do vencimento que o sistema irแ parar de enviar mensagens
Private cEmpresa  :=""
Private cTeste    := PDK->PDK_TESTE
Private cMatr 	  := PDK->PDK_MATTST
Private cEmailtst := Alltrim(PDK->PDK_EMAIL)
Private CMSG  	  := STRTRAN(PDK->PDK_MSG, Chr(13) + Chr(10) , '<br>')  
Private cMSGSMS	  := PDK->PDK_MSGSMS
Private cTpTeste  := Alltrim(PDK->PDK_TPTEST)
Private cAssunto  := Alltrim(PDK->PDK_TITEMA)
Private cTpBenef  := Iif(Empty(PDK->PDK_BLOQ),"3",PDK->PDK_BLOQ)
Private cCelTST   :=  Alltrim(PDK->PDK_CELTST)


if cTeste="S"

	If (PDK->PDK_CANAL = '1' .AND. Empty(cEmailtst)) 
		Alert("MODO TESTE. E-mail de teste nใo informado para envio da mensagem. Favor informar!")
		return()
	Endif

	If 	(PDK->PDK_CANAL = '2' .AND. Empty(cCelTST))
		Alert("MODO TESTE. Celular de teste nใo informado para o envio de mensagem. Favor Informar!")
		return()
	Endif


	If Empty(cMatr)
			Alert("MODO TESTE. Nใo foi identificado as matriculas que serใo consideradas no teste de envio. Favor informar!")
			Return
	EndIf

EndIf 

/*
If PDK->PDK_CANAL = '1' .and. Empty(cAssunto)
	Alert("O assunto do e-mail nใo foi preenchido. Favor informar!")
	Return
EndIf*/

IF PDK->PDK_DTUENV= dDatabase
	If aviso("A T E N ว ร O","Jแ foi enviado mensagem para os clientes com esta configura็ใo no dia de hoje. Deseja continuar?",{"Sim","Nใo"})=2
		Return
	EndIf
EndIf


If PDK_ATIVO = "N"
	Alert("Configura็ใo selecionada nใo estแ habilitada para uso.")
	Return
EndIf


//Forma de Pagamento do cliente                        
cFormPgt:= PDK->PDK_FPGTO    //"04" --> Boleto   //"06" -> Debito Automatico
If Empty(cFormPgt)
	alert("Forma de Pagamento nใo poderแ estar vazia. Favor preencher.")		
	Return
EndIf


//Tipo de configura็ใo de mensagem Pre-Cobran็a ou Inadimplencia  
cTpcfg := PDK->PDK_TIPO //"1" --> pre-cobranca  //"2"--> inadimplencia
If Empty(cTpcfg)
	Alert("Tipo de Configura็ใo ้ invแlido. Favor rever a configura็ใo.")
	Return
EndIf


//Canal de Envio da Mensagem						
cCanal := PDK->PDK_CANAL //"1" -> E-mail //   "2" --> SMS
If Empty (cCanal)
	Alert("Tipo de Canal de Envio ้ invแlido. Favor rever a configura็ใo.")
	Return
EndIf

//Canal de Envio da Mensagem
If cCanal= "2"
	If aviso("A T E N ว ร O","Serแ disparado o envio de mensagem via SMS e isto terแ custo. Tem certeza que deseja continuar?",{"Sim","Nใo"})=2
		Return
	EndIf	
EndIf

if cEmpAnt="01"
	cEmpresa  :="C"
Elseif cEmpAnt="02"
	cEmpresa  := "I"
EndIf


If (cCanal='1' .And. Empty(CMSG)) .or. (cCanal='2' .and. Empty(cMSGSMS)) 
	Alert("ษ necessแrio informar uma mensagem para o envio do e-mail automแrico. Por favor, atualize a configura็ใo para continuar.")
	Return
EndIf


Processa({||EnvAviso()},'Processando...')

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  EnvAviso  บAutor  ณLuiz Otavio Campos  บ Data ณ  30/03/2021  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para disparar os e-mails via Procedure no Oracle     บฑฑ
ฑฑบ          ณ                										      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvAviso

	Local cQuery := ""

	ProcRegua(1000)

	Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio...')




	/****************************************************************************************************************************************
	PROCEDURE "ENVIA_EMAIL_SMS_INADIMPLENTES" (pEMPRESA IN VARCHAR2,
                                                             pFORMAPGTO IN VARCHAR2,
                                                             pTPCONFIG IN VARCHAR2,
                                                             pQTDDIASENV IN NUMBER,
                                                             pCANAL IN VARCHAR2,
															 pASSUNTO IN VARCHAR2,
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
						pTPCONFIG   Obrig. "1"= Pr้-Cobran็a ou "2"=Inadimpl๊ncia.
						pQTDDIASENV Obrig. Quantidade de Dias em rela็ใo a data de vencimento
						pCANAL      Obrig. "1"= EMAIL OU "2"= SMS. (1)
						pMSGENV     Obrig. Mensagem
						PASSUNTO 	 Obrig. Titulo/Assunto do e-mail
						pTESTE      S SIM N NAO , CASO DIRECIONA PARA pEMAILTESTE SE NA LISTA DE MATVIDS
						pTIPOTESTE  A ASSOCIADO C CONTRATO	
						PMATVID     LISTA DE MATVIDS PARA TESTE (IGNORADO FORA TESTE))
						pEMAILTESTE EMAIL DE REDIRECIONAMENTO
	/****************************************************************************************************************************************/

	cNameUsr:=UsrFullName(__cUserID)
    
	cQuery := "BEGIN " + CRLF
	cQuery += " ENVIA_EMAIL_SMS_INADIMPLENTES('"+cEmpresa+"', '" + cFormPgt + "','" + cTpcfg + "'," + cValtochar(nqtdDiaEnv) +" ,'" + cTpBenef + "','" + cCanal + "','"+Alltrim(cAssunto)+"','"+Alltrim(cMsg)+"', '"+cTeste+"','"+cTpTeste+"','"+cMatr+"','"+cEmailtst+"','1','"+cNameUsr+"' );"
	cQuery += "END;" + CRLF

	If TcSqlExec(cQuery) <> 0	
		Alert("Erro na execu็ao do envio de boletos.")   
	Else                 
		Aviso("Aten็ใo","Envio de mensagem finalizada com sucesso!.",{"OK"}) 

		//Registra a Data do ultimo envio
		DbSelectArea("PDK")
		Reclock("PDK",.f.)
		PDK->PDK_DTUENV := dDatabase
		Msunlock()
	EndIf  
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096B     ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/04/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Exclusใo da configura็ใo de envio de mensagens           ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA096B()

If Empty(PDK->PDK_DTUENV)
	DbSelectArea("PDK")
	axDeleta("PDK",Recno(),5)

Else
	Alert("Nใo ้ possํvel excluir ")		
EndIf

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096C     ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/04/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Mostrar a Legenda de status do Recebimento de NF           ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA096C()

BrwLegenda("CENTRAL DE INADIMPLสNCIA ","Legenda",{   {"BR_VERMELHO"         ,"Configura็ใo Inativa."      },;
															{"BR_AMARELO"	,"Configura็ใo em Teste"},;
															{"BR_VERDE"		,"Configura็ใo Ativa"	    }})
															 

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096D     ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/04/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Gera Relat๓rio de Log de mensagens enviadas		           ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA096D()
Local oReport
Local aArea := GetArea()
Private cPerg  := "CABAX96"

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
Local cTit := "Relat๓rio de Log de Envio de Mensagens - Inadimpl๊ncia"
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


	oSection2 := TRSection():New(oReport,"Movimentos",{}, , ,) //"Documento"
	// Colunas do relat๓rio
	TRCell():New(oSection2,"OPERADORA"	  ,,"Empresa"			, ""	,7	   ,  ,{|| Iif((cAliasBOL)->OPERADORA="C","Caberj","Integral")  }  			,"LEFT"  , ,"LEFT" ) 
	TRCell():New(oSection2,"ENVIO"		  ,,"Dt.Env"  			, ""	,10	   ,  ,{|| (cAliasBOL)->ENVIO } 												,"LEFT"  , ,"LEFT" )//Prefixo
	TRCell():New(oSection2,"HORA"		  ,,"Hr.Env" 			, ""	,5	   ,  ,{|| (cAliasBOL)->HORA } 												,"LEFT"  , ,"LEFT" )//Numero t?ulo a pagar
	TRCell():New(oSection2,"MATRICULA"	  ,,"Matricula"			, ""	,18	   ,  ,{|| (cAliasBOL)->MATRICULA  }  										,"LEFT"  , ,"LEFT" )
	TRCell():New(oSection2,"CPF"          ,,"CPF"			    , ""	,20	   ,  ,{|| (cAliasBOL)->BA1_CPFUSR }                                   ,"LEFTR" , ,"LEFT" )
	TRCell():New(oSection2,"NOMUSR"		  ,,"Beneficiแrio"		, ""	,30	   ,  ,{|| (cAliasBOL)->BA1_NOMUSR             }  												,"LEFTR" , ,"LEFT" )
	TRCell():New(oSection2,"CANAL" 		  ,,"Canal"   			, "" 	,7	   ,  ,{|| Iif((cAliasBOL)->CANAL='1',"E-mail","SMS")   } 					,"LEFT"  , ,"LEFT" )//N?ero do t?ulo a receber
	TRCell():New(oSection2,"TPCONFIG" 	  ,,"Tp.Config"      	, ""	,12	   ,  ,{|| Iif((cAliasBOL)->TPCONFIG="1","Pre-Cobran","Inadimplen")  } ,"LEFT"  , ,"LEFT" )//Parcela
	TRCell():New(oSection2,"EMAIL_SMS" 	  ,,"Email\SMS."	    , ""	,20	   ,  ,{|| (cAliasBOL)->EMAIL_SMS        } 									 ,"LEFT" , ,"LEFT" )//Tipo
	//TRCell():New(oSection2,"HTML"		  ,,"HTML"     			, ""	,10	   ,  ,{|| (cAliasBOL)->HTML    } 									         ,"LEFT" , ,"LEFT" )//Natureza 	
	TRCell():New(oSection2,"FORMAPGTO"	  ,,"Form.Pgto"  	    , ""  	,8	   ,  ,{|| Iif((cAliasBOL)->FORMAPGTO="04","Boleto","Deb.Aut") 	 }   ,"LEFT" , ,"LEFT" )//Dt. emissao
	TRCell():New(oSection2,"SALDO_TOTAL"  ,,"Saldo Tit"	  	    , ""	,14	   ,  ,{|| Transform(  (cAliasBOL)->SALDO_TOTAL,  "@e 999,999,999.99" ) }  	)
	TRCell():New(oSection2,"TITULOS"  	  ,,"Ref. " 	        , ""	,27	   ,  ,{|| (cAliasBOL)->TITULOS		   }                 				,"LEFT"  , ,"LEFT" )//
	TRCell():New(oSection2,"REFERENCIAS"  ,,"Dt. Ref. " 	    , ""	,21	   ,  ,{|| (cAliasBOL)->REFERENCIAS	   }                 				,"LEFT"  , ,"LEFT" )//
	TRCell():New(oSection2,"LETRAS"       ,,"Letra Ref. " 	    , ""	,15    ,  ,{|| (cAliasBOL)->LETRAS	   }             				,"LEFT"  , ,"LEFT" )//
	TRCell():New(oSection2,"QTDDIASENV"	  ,,"Qtd.Dias "			, ""	,2	   ,  ,{|| Transform(  (cAliasBOL)->QTDDIASENV, "@e 999") 	} 				,"LEFT"  , ,"LEFT" )//Qtd Dias Envio 
	//TRCell():New(oSection2,"VENC"		  ,,"Vencimento" 		, ""	,10	   ,  ,{|| Iif((cAliasBOL)->TPCONFIG="1", Stod((cAliasBOL)->ENVIO)+(cAliasBOL)->QTDDIASENV, Stod((cAliasBOL)->ENVIO)-(cAliasBOL)->QTDDIASENV) } 												,"LEFT"  , ,"LEFT" )//Prefixo
	TRCell():New(oSection2,"ENVIADO"	  ,,"Enviado?"		    , ""	,4	   ,  ,{|| (cAliasBOL)->ENVIADO       }                       				,"LEFT"  , ,"LEFT" )//Enviado 
	TRCell():New(oSection2,"MOTIVO"	 	  ,,"Motivo.Nao.Env "	, ""	,4	   ,  ,{|| (cAliasBOL)->MOTIVO       }                        				,"LEFT"  , ,"LEFT" )//Motivo de envio

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
cQry+="         1 CONTADOR, LOG_ENVIO_EMAIL_INAD.*, BA1_NOMUSR, BA1_CPFUSR " 
cQry+=" FROM  "
cQry+="         LOG_ENVIO_EMAIL_INAD"
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

If MV_PAR04= 1
	cQry+="         AND   FORMAPGTO= '04'"
ElseIf MV_PAR04= 2
	cQry+="         AND   FORMAPGTO= '06'"
EndIf

If MV_PAR05 = 1
	cQry+=" AND  CANAL = '1' "  // E-mail
ElseIf MV_PAR05 = 2
	cQry+=" AND  CANAL = '2' "  // SMS
EndIf

If MV_PAR06 = 1
	cQry+="  AND TPCONFIG = '1' "
elseif MV_PAR06 = 2
	cQry+=" AND TPCONFIG = '2'"
EndIf

If MV_PAR07 = 1
	cQry+=" AND ENVIADO = 'SIM' "
elseif MV_PAR07 = 2
	cQry+=" AND ENVIADO = 'NAO'"
EndIf

cQry+=" AND  MATRICULA >= '"+MV_PAR08+" ' and  MATRICULA <= '"+MV_PAR09+"' "


cQry+=" ORDER BY  OPERADORA, MATRICULA, DATA   "

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nใo foram encontrados dados!")
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

 u_CABASX1(cPerg,"01","Empresa:"		,"","a","MV_CH1"	,"C",1   ,0,0,"C","","","","","MV_PAR01","1-CABERJ","1-CABERJ","1-CABERJ","","2-INTEGRAL","2-INTEGRAL","2-INTEGRAL","3-AMBOS","3-AMBOS","3-AMBOS","","","","","","",aHelpPor,{},{},"")	
 u_CABASX1(cPerg,"02","Dt Envio De: "	,"","a","MV_CH2"	,"D",8   ,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"03","Dt. Envio Ate:"	,"","a","MV_CH3"    ,"D",8   ,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"04","Form Pgto De: "	,"","a","MV_CH4"	,"C",1	 ,0,0,"C","","","","","MV_PAR04","1-Boleto","1-Boleto","1-Boleto","","2-Deb.Automatico","2-Deb.Automatico","2-Deb.Automatico","3-Ambos","3-Ambos","3-Ambos","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"05","Canal?"		    ,"","a","MV_CH5"	,"C",1   ,0,0,"C","","","","","MV_PAR05","1-Email","1-Email","1-Email","","2-SMS","2-SMS","2-SMS","3-Ambos","3-Ambos","3-Ambos","","","","","","",aHelpPor,{},{},"")	
 u_CABASX1(cPerg,"06","Tp. Config?"	    ,"","a","MV_CH6"	,"C",1   ,0,0,"C","","","","","MV_PAR06","1-Pre-cobranca","1-Pre-cobranca","1-Pre-cobranca","","2-Inadimplencia","2-Inadimplencia","2-Inadimplencia","3-Ambos","3-Ambos","3-Ambos","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"07","Enviado?"	    ,"","a","MV_CH7"	,"C",1   ,0,0,"C","","","","","MV_PAR07","1-Sim","1-Sim","1-Sim","","2-Nao","2-Nao","2-Nao","3-Ambos","3-Ambos","3-Ambos","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"08","Matricula De: "	,"","a","MV_CH8"	,"C",nTamMat ,0,0,"G","","CABC03","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"09","Matricula Ate: "	,"","a","MV_CH9"	,"C",nTamMat ,0,0,"G","","CABC03","","","MV_PAR09","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")


Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096D     ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/04/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Rotina automatica de envio de mensagem		           ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA096e(lSchedule)

	Default lSchedule 	:= .T.
	
	QOut("INอCIO PROCESSAMENTO - SCHEDULE CABA611 - "+Time())

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
  		
	// Query buscar as informa็๕es dos arquivo  
	if cEmpAnt == '01'
		cRegAns := '324361'
		QOut("INอCIO PROCESSAMENTO - SCHEDULE CABA096E - CABERJ - "+Time())
	else	
		 cRegAns :=  '415774'		
		 QOut("INอCIO PROCESSAMENTO - SCHEDULE CABA096E - INTEGRAL - "+Time())
	endif 
	

	DbSelectArea("PDK")
	Dbgotop()

	While !PDK->(Eof())

		If PDK->PDK_ATIVO="S" .and. PDK->PD_AUTO ="S"

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
						pTPCONFIG   Obrig. "1"= Pr้-Cobran็a ou "2"=Inadimpl๊ncia.
						pQTDDIASENV Obrig. Quantidade de Dias em rela็ใo a data de vencimento
						pCANAL      Obrig. "1"= EMAIL OU "2"= SMS. (1)
						pMSGENV     Obrig. Mensagem
			/****************************************************************************************************************************************/
/*
			nqtdDiaEnv := PDK_QTDENV

			cQuery := "BEGIN " + CRLF
			cQuery += " ENVIA_EMAIL_SMS_INADINPLENTES ('"+cEmpAnt+"',   '" + cFormPgt + "','" + cTpcfg + "','" + nqtdDiaEnv + "','" + cCanal + "','"+cMsg+"','1');"
			cQuery += "END;" + CRLF

			If TcSqlExec(cQuery) <> 0	
				QOut("Aten็ใo","Erro na execu็ao do envio de boletos.")   
			Else                 
				QOut("Aten็ใo","Execu็ใo de envio de boleto finalizada.") 
			EndIf  

		Endif


		DbSelectArea("PDK")
		DbSkip()
	Enddo

Return
*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096F     ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/04/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Rotina para gerar a previa do envio de Mensagem.          ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA096F()


	MsgRun("Aguarde... Gerando relatorio de Previa.",,{|| U_CABA096G()})


Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096G    ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/04/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Rotina para gerar a previa do envio de Mensagem.          ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA096G()
	Local aArea 	  := GetArea()
	Local cTeste      := PDK->PDK_TESTE
	Local cTpTeste    := Alltrim(PDK->PDK_TPTEST)
	Local cMatr 	  := PDK->PDK_MATTST
	Local cEmailtst   := Alltrim(PDK->PDK_EMAIL)
	Local CMSG  	  := Alltrim(PDK->PDK_MSG)
    Local nQtdDiaEnv  := PDK->PDK_QTDENV
	Local cAssunto    := PDK->PDK_TITEMA
	Local aDados	  := {}
	Local aCabec	  := {}
	Local CALIASBOl2  := GetNextAlias()
	Local cTpBenef    := Iif(Empty(PDK->PDK_BLOQ),"3",PDK->PDK_BLOQ)

	/*
	LOG_ENVIO_EMAIL_INAD
	--------------------
	SEQIQ        NUMBER(8,0)            CHAVE ARTIFICIAL CRIADA POR SEQUENCE
	OPERADORA    VARCHAR2(1 BYTE)   
	MATRICULA    VARCHAR2(25 BYTE)    MATRICULA OP/EMP/MAT/TREG/DV OU EMP/CONT/SUB
	DATA        VARCHAR2(8 BYTE)   
	HORA        VARCHAR2(8 BYTE)   
	ENVIO        DATE   
	CANAL        VARCHAR2(1 BYTE)    1 EMAIL 2 SMS
	TPCONFIG    VARCHAR2(1 BYTE)    1 PRE-COBRANวA 2 INADIMPLENCIA
	EMAIL_SMS    VARCHAR2(4000 BYTE)   
	HTML        VARCHAR2(100 BYTE)   
	ENVIADO        VARCHAR2(3 BYTE)   
	MOTIVO        VARCHAR2(200 BYTE)   
	FORMAPGTO    VARCHAR2(2 BYTE)    FORMREC BA3_TIPPAG E1_FORMREC PRINCIPAIS
	SALDO_TOTAL    NUMBER(12,2)        SALDO TOTAL NO DIA EMISSAO 
	TITULOS    VARCHAR2(4000 BYTE)    REFERENCIAS EM ABERTO EX "12/2020 01/2021"
	QTDDIASENV    NUMBER(4,0)            QTD DIAS RELACAO DT VENCTO MENSAGEM FUNCIONA CONJ TPCONFIG. TIPO  1 ANTES 2 DEPOIS
	PREVIA        VARCHAR2(1 BYTE)    CONTROLE DE PRE ENVIO PARA CHECAGEM 1 NAO 2 SIM

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
	
	*/

	If cEmpAnt = '01'
		cEmpresa := "C"
	Elseif cEmpAnt = '02'
		cEmpresa := "I"
	Else	
		cEmpresa := cEmpAnt
	EndIf

	
	//Forma de Pagamento do cliente                        
	cFormPgt:= PDK->PDK_FPGTO    //"04" --> Boleto   //"06" -> Debito Automatico
	If Empty(cFormPgt)
		alert("Forma de Pagamento nใo poderแ estar vazia. Favor preencher.")		
		Return			
	EndIf


	//Tipo de configura็ใo de mensagem Pre-Cobran็a ou Inadimplencia  
	cTpcfg := PDK->PDK_TIPO //"1" --> pre-cobranca  //"2"--> inadimplencia
	If Empty(cTpcfg)
		Alert("Tipo de Configura็ใo ้ invแlido. Favor rever a configura็ใo.")
		Return
	EndIf


	//Canal de Envio da Mensagem							
	cCanal := PDK->PDK_CANAL //"1" -> Email //   "2" --> SMS
	If Empty (cCanal)
		Alert("Tipo de Configura็ใo ้ invแlido. Favor rever a configura็ใo.")
		Return
	EndIf

	if cEmpAnt="01"
		cEmpresa  :="C"
	Elseif cEmpAnt="02"
		cEmpresa  := "I"
	EndIf


	If Empty(CMSG)
		Alert("ษ necessแrio informar uma mensagem para o envio do e-mail automแrico. Por favor, atualize a configura็ใo para continuar.")
		Return
	EndIf

	//******************Executa a chamada da procedure para gerar registros de Pr้via ************************************	   
	cNameUsr:=UsrFullName(__cUserID)

	cQuery := "BEGIN " + CRLF
	cQuery += " ENVIA_EMAIL_SMS_INADIMPLENTES('"+cEmpresa+"', '" + cFormPgt + "','" + cTpcfg + "'," + cValtochar(nqtdDiaEnv) +" ,'" + cTpBenef + "', '" + cCanal + "', '"+Alltrim(cAssunto)+"', '"+Alltrim(cMsg)+"', '"+cTeste+"','"+cTpTeste+"','"+cMatr+"','"+cEmailtst+"','2','"+cNameUsr+"' );"
	cQuery += "END;" + CRLF

	If TcSqlExec(cQuery) <> 0	
		QOut("Aten็ใo","Erro na execu็ao da gera็ใo da Pr้via.")   
	Else                 
		QOut("Aten็ใo","Execu็ใo de envio de boleto finalizada.") 
	EndIf  

	//******************** Busca as previas geradas para exportar arquivo ****************************************************

	aCabec :={"MATRICULA","NOME","CPF","CANAL","TP.CONFIGURAวAO","EMAIL_SMS","FORMA PGTO","SALDO TIT","TITULOS","REFERENCIAS","LETRAS","QTD.DIAS" }

		// Query para buscar os dados no banco
	cQry:="  SELECT " 
	cQry+="        1 CONTADOR, LOG_ENVIO_EMAIL_INAD.*, BA1_NOMUSR, BA1_CPFUSR " 
	cQry+=" FROM  "
	cQry+="         LOG_ENVIO_EMAIL_INAD"
	cQry+=" INNER JOIN "+RetSqlName("BA1")+" BA1 ON "
	cQry+=" 	SUBSTR(MATRICULA,1,4) = BA1_CODINT "
	cQry+=" 	AND SUBSTR(MATRICULA,5,4) = BA1_CODEMP "
	cQry+=" 	AND SUBSTR(MATRICULA,9,6) = BA1_MATRIC "
	cQry+="  	AND SUBSTR(MATRICULA,15,2) = BA1_TIPREG "
	cQry+="  	AND SUBSTR(MATRICULA,17,1) = BA1_DIGITO "
	cQry+=" WHERE  BA1.d_e_l_e_t_ = ' ' AND PREVIA = '2' "
	cQry+=" ORDER BY  OPERADORA, MATRICULA, DATA   "

	cQry    := ChangeQuery(cQry)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL2,.T.,.T.)

	dbSelectArea(cAliasBOL2)
	(cAliasBOL2)->(dbgotop())	


	//Imprime os dados do relatorio
	If (cAliasBOL2)->(Eof())
		Alert("Nใo foram encontrados dados!")
	Else

		While  !(cAliasBOL2)->(Eof())       
			
			Aadd(aDados,{"'"+(cAliasBOL2)->MATRICULA, (cAliasBOL2)->BA1_NOMUSR, "'"+(cAliasBOL2)->BA1_CPFUSR,;
			 Iif((cAliasBOL2)->CANAL='1',"E-mail","SMS"),;
			 Iif((cAliasBOL2)->TPCONFIG="1","Pre-Cobran","Inadimplen"),;
			 (cAliasBOL2)->EMAIL_SMS,;
			 Iif((cAliasBOL2)->FORMAPGTO="04","Boleto","Deb.Aut"),;
			 Transform(  (cAliasBOL2)->SALDO_TOTAL,  "@e 999,999,999.99" ) ,;
			 "'"+(cAliasBOL2)->TITULOS,;
			 (cAliasBOL2)->REFERENCIAS,;
			 "'"+(cAliasBOL2)->LETRAS,;
			 "'"+Transform(  (cAliasBOL2)->QTDDIASENV, "@e 999")    })
			
			(cAliasBOL2)->(DbSkip())
		Enddo   


		DlgToExcel({{"ARRAY","Previa de Envio de Mensagem" ,aCabec,aDados}})
		
		(cAliasBOL2)->(DbCloseArea())

	EndIf



	RestArea(aArea)
Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑ Programa  ฑฑ CABA096H    ฑฑAutor  ฑฑLuiz Otavio Campos ฑฑ   14/06/21   ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑ Desc.     ฑฑ Relat๓rio de Matriculas Bloqueadas.				          ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function CABA096H()
Local oReport
Local aArea := GetArea()
Private cPerg  := "CABA096H"

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
Local cTit := "Rela็ใo de Associados\Contratos desabilitados para receber mensagens."
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
cDesl:= "Este relatorio tem como objetivo imprimir a rela็ใo de Associados\Contratos que nใo receberใo notifica็ใo por mensagens."
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
oReport:SetLandScape()
oReport:SetTotalInLine(.T.)

Pergunte(oReport:uParam,.F.)


	If MV_PAR01 = 1 
		
		oSection2 := TRSection():New(oReport,"Associados",{}, , ,) //"Documento"

		// Colunas do relat๓rio
		TRCell():New(oSection2,"MATRICULA"	  ,,"Matricula"  		, ""	,10	   ,  ,{|| (cAliasBOL)->BA1_CODINT+BA1_CODEMP+BA1_MATRIC } 			,"LEFT"  , ,"LEFT" )//Prefixo
		TRCell():New(oSection2,"NOMEBENEF"	  ,,"Beneficiแrio " 	, ""	,30	   ,  ,{|| (cAliasBOL)->BA1_NOMUSR } 								,"LEFT"  , ,"LEFT" )//Numero t?ulo a pagar
		TRCell():New(oSection2,"CPF"          ,,"CPF"			    , ""	,15	   ,  ,{|| (cAliasBOL)->BA1_CPFUSR }                                ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
		TRCell():New(oSection2,"CLIENTE"      ,,"Cliente + Lj"	    , ""	,10	   ,  ,{|| (cAliasBOL)->BA3_CODCLI +" "+(cAliasBOL)->BA3_LOJA }         ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
		TRCell():New(oSection2,"NOMECLI"      ,,"Nome Cliente"	    , ""	,40	   ,  ,{|| (cAliasBOL)->A1_NOME }                                   ,"LEFTR" , ,"LEFT" )//Dt. vencimento  	
	

		TRFunction():New(oSection2:Cell("MATRICULA"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	

	Else 

		oSection2 := TRSection():New(oReport,"Contratos",{}, , ,) 

		// Colunas do relat๓rio
		TRCell():New(oSection2,"CODINT	"	  ,,"Cod.Int"  			, ""	,05	   ,  ,{|| (cAliasBOL)->BQC_CODINT} 			,"LEFT"  , ,"LEFT" )
		TRCell():New(oSection2,"CODEMP	"	  ,,"Cod.Emp"  			, ""	,05	   ,  ,{|| (cAliasBOL)->BQC_CODEMP} 			,"LEFT"  , ,"LEFT" )
		TRCell():New(oSection2,"BQC_NUMCON"	  ,,"Contrato"  		, ""	,10	   ,  ,{|| (cAliasBOL)->BQC_NUMCON } 			,"LEFT"  , ,"LEFT" )
		TRCell():New(oSection2,"BQC_SUBCON"	  ,,"Sub.Contrato"  	, ""	,10	   ,  ,{|| (cAliasBOL)->BQC_NUMCON } 			,"LEFT"  , ,"LEFT" )
		TRCell():New(oSection2,"DESCRI"	  	  ,,"Descri็ใo " 		, ""	,40	   ,  ,{|| (cAliasBOL)->BA1_NOMUSR } 			,"LEFT"  , ,"LEFT" )
		TRCell():New(oSection2,"BQC_CNPJ"     ,,"CPF"			    , ""	,14	   ,  ,{|| (cAliasBOL)->BA1_CPFUSR }            ,"LEFTR" , ,"LEFT" )  	
		TRCell():New(oSection2,"CLIENTE"      ,,"Cliente"		    , ""	,20	   ,  ,{|| (cAliasBOL)->BQC_CODCLI +" "+(cAliasBOL)->BQC_LOJA }         ,"LEFTR" , ,"LEFT" )
		TRCell():New(oSection2,"NOMECLI"      ,,"Nome Cliente"	    , ""	,20	   ,  ,{|| (cAliasBOL)->A1_NOME }               ,"LEFTR" , ,"LEFT" )

		TRFunction():New(oSection2:Cell("BQC_SUBCON"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	
	
	EndIf
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

If MV_PAR01 = 1 // Relacao de Associado

	cQry:=" SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_CPFUSR, BA1_NOMUSR, BA3_CODCLI, BA3_LOJA, A1_NOME"
	cQry+="	FROM "+RetSqlName("BA3")+" BA3 "
	cQry+="	INNER JOIN "+RetSqlName("BA1")+" BA1 "
	cQry+="    ON BA1_CODINT = BA3_CODINT AND BA1_CODEMP=BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC    "
	cQry+="	INNER JOIN "+RetSqlName("SA1")+" SA1  "
	cQry+="    ON BA3_CODCLI = A1_COD AND BA3_LOJA = A1_LOJA "
	cQry+=" WHERE BA1.D_E_L_E_T_ = ' ' "
	cQry+=" AND BA3.D_E_L_E_T_ = ' ' "
	cQry+=" AND SA1.D_E_L_E_T_= ' ' "
	cQry+=" AND BA3_XMINAD = 'N' "
	cQry+=" AND BA1_TIPUSU = 'T' "
	cQry+=" ORDER BY  A1_NOME   "
Else

	cQry:=" SELECT BQC_CODINT, BQC_CODEMP, BQC_NUMCON, BQC_SUBCON, BQC_DESCRI, BQC_CNPJ, BQC_CODCLI, BQC_LOJA , A1_NOME " 
	cQry+=" FROM "+RetSqlName("BQC")+" BQC "
    cQry+=" INNER JOIN "+RetSqlName("SA1")+" SA1  " 
    cQry+="     ON BQC_CODCLI = A1_COD AND BQC_LOJA = A1_LOJA "
	cQry+=" WHERE SA1.D_E_L_E_T_ = ' ' "
    cQry+=" AND BQC.D_E_L_E_T_ = ' ' "
    cQry+=" AND A1_FILIAL = '"+xFilial("SA1")+"'  "
    cQry+=" AND BQC_FILIAL = '"+xFilial("BQC")+" '  "
    cQry+=" AND BQC_XMINAD = 'N' "
	cQry+=" ORDER BY BQC_DESCRI "

Endif

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nใo foram encontrados dados!")
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
AADD(aHelpPor,"Informe o tipo de rela็ใo de contratos que deseja exibir:			")

 u_CABASX1(cPerg,"01","Tipo Beneficiario"		,"","a","MV_CH1"	,"C",1   ,0,0,"C","","","","","MV_PAR01","1-Famํlia","1-Famํlia","1-Famํlia","","2-Sub-Contrato","2- Sub.Contrato","Sub.Contrato","","","","","","","","","",aHelpPor,{},{},"")	
 

Return()



//////////////////////////////////////////////////////////////////////////////////////
/*     A fun็ใo a seguir seleciona os usuarios e habilita ou desabilita o envio 	/
/de email para eles em caso de inadimpl๊ncia                                       */
///////////////////////////////////////////////////////////////////////////////////

User Function CABA096J

/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Declara็ใo de cVariable dos componentes                                 ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
Local nOpc := GD_INSERT+GD_DELETE+GD_UPDATE
Private aCoBrw1 := {}
Private aHoBrw1 := {}
Private noBrw1  := 0
Private cAcao	:= Space(11)

/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Declara็ใo de Variaveis Private dos Objetos                             ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
SetPrvt("oDlg1","oSay1","oSay2","oBrw1","oCBox2","oBtn1","oBtn2", "oBtn3")

/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Definicao do Dialog e todos os seus componentes.                        ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
oDlg1      := MSDialog():New( 181,464,577,920,"Bloqueia/Desbloqueia Envio de E-mail",,,.F.,,,,,,.T.,,,.T. )
oSay2      := TSay():New( 016,016,{||"A็ใo"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,065,009)
oSay1      := TSay():New( 048,016,{||"Beneficiแrio"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,065,009)
MHoBrw1()
MCoBrw1()
oBrw1      := MsNewGetDados():New(060,016,154,208,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw1,aCoBrw1 )
oCBox2     := TComboBox():New( 028,016,bSetGet(cAcao),{"Bloquear","Desbloquear"},072,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,"cAcao" )
oBtn1      := TButton():New( 175,108,"OK",oDlg1,{||U_CABA096L()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 175,176,"SAIR",oDlg1,{||oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 028,136,"Importar Arquivo",oDlg1,{||U_CABA096M()},072,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

Return

/*ฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
Function  ณ MHoBrw1() - Monta aHeader da MsNewGetDados para o Alias: 
ฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
Static Function MHoBrw1()

Aadd(aHoBrw1, {"MATRอCULA", "MATRICULA", 	"@!", 14, 00, "U_CABA096K(M->MATRICULA)", "", "C", "CABC03"})
Aadd(aHoBrw1, {"NOME"	  ,	"NOME"	   ,	"@!", 30, 00, ".T.", "", "C"})

Return
/*ฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
Function  ณ MCoBrw1() - Monta aCols da MsNewGetDados para o Alias: 
ฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
Static Function MCoBrw1()
/*
Local aAux := {}

Aadd(aCoBrw1,Array(noBrw1+1))
For nI := 1 To noBrw1
   aCoBrw1[1][nI] := CriaVar(aHoBrw1[nI][2])
Next
aCoBrw1[1][noBrw1+1] := .F.
*/
Return

User Function CABA096K(cMatricula)

cQry:="  SELECT " 
	cQry+=" BA1_NOMUSR " 
	cQry+=" FROM  "
	cQry+= RetSqlName("BA1")+" BA1 "
	cQry+=" INNER JOIN "+RetSqlName("BA3")+" BA3 ON (BA1_CODINT = BA3_CODINT AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC =  BA3_MATRIC )"
	cQry+=" WHERE  BA1.d_e_l_e_t_ = ' ' "
	cQry+=" AND BA3.d_e_l_e_t_ = ' ' "
	cQry+=" AND BA1_FILIAL = '"+ XFILIAL("BA1")+"'"
	cQry+=" AND (BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = '"+ cMatricula +"'"
	cQry+=" OR BA3_CODINT || BA3_CODEMP || BA3_MATRIC = '"+ cMatricula +"')"
	
	If ( Select("QRY") > 0 )
		QRY->( dbCloseArea() )
	EndIf

	TcQuery cQry Alias "QRY" New

	if eof()
		Alert("Nenhum usuแrio foi encontrado")
		QRY->( dbCloseArea() )
		return
	endif	
	
	acols[N][2] := QRY->BA1_NOMUSR

Return .T.

//////////////////////////////////////////////////////////////////////

User Function CABA096L
local nI


	IF cAcao = 'Bloquear'
		
		FOR nI:= 1 TO LEN(oBrw1:acols) 

		DbSelectArea("BA3")
		DbSetOrder(1)
		IF DBSEEK( XFILIAL("BA3")+SUBSTR(oBrw1:acols[nI][1], 1, 14 )) 

			RecLock("BA3", .F.)
			BA3->BA3_XMINAD := "N"
				
			MsUnlock()

		ENDIF
		
		NEXT
		MsgInfo("Usuแrio(s) Bloqueado(s) com sucesso! A partir de agora esses usuแrios nใo receberใo mais e-mails de cobran็a de inadimpl๊ncia ", "Bloqueado com Sucesso" )
		{||oDlg1:End()}
	ENDIF
	IF cAcao = 'Desbloquear'
		

		FOR nI:= 1 TO LEN(oBrw1:acols) 

		DbSelectArea("BA3")
		DbSetOrder(1)
		IF DBSEEK( XFILIAL("BA3")+SUBSTR(oBrw1:acols[nI][1], 1, 14 )) 

			RecLock("BA3", .F.)
			BA3->BA3_XMINAD := " "
				
			MsUnlock()

		ENDIF
		
		NEXT
		
		MsgInfo("Usuแrio(s) Desbloqueado(s) com sucesso! A partir de agora esses usuแrios receberใo e-mails de cobran็a de inadimpl๊ncia ", "Desbloqueado com Sucesso" )
		{||oDlg1:End()}
	ENDIF

Return

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑบPrograma ณCABA096M บAutor ณMarcos Oliveira Cantalice บ Data ณ  02/02/22 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.    ณ PE que permite realizar a importa็ใo de matriculas para     บฑฑ
ฑฑบ         ณ Bloquear ou Desbloquear do envio de e-mail de inadimpl๊ncia บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

*/
User Function CABA096M()					
			
	If Aviso("Aten็ใo!","Deseja importar as matrํculas de uma planilha externa?",{"Sim","Nใo"})=1			
		IMPPLN()
	EndIf
			
Return({3000,1}) //{\Valor do Rateio,Flag com a tela de op็๕es do rateio}\

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณIMPPLN  ณAutor ณMarcos Oliveira Cantalice บ Data ณ  02/02/22 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Importa็ใo da planilha de matriculas                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function IMPPLN()

	Private oLeTxt, cFile
	Private _cPath := "\INVENTARIO\"	
	Private aFiles := Directory(_cPath+"*.CSV" )
	Private cTipo    := "Arquivos .CSV          (*.CSV)  | *.CSV | "

	_cPath := cArquivo := upper( cGetFile( 'Arquivo *|*.*|Arquivo CSV|*.csv' , 'Arquivo Destino' , 2 , , .F. , , )) 
	
	If !empty( alltrim( cArquivo ))
              cArquivo := alltrim(upper( cArquivo ))
            
          OkLeTxt()	
     Else
           alert('Nenhum arquivo selecionado!')
             lRet := .F.
    Endif   
Return


Static Function OkLeTxt()

	Private cArqTxtL := Substr(_cPath,1,Len(Alltrim(_cPath))-4)+"_"+DTOS(DATE())+"_"+Replace(Time(),":","")+".LOG"
	Private nHdlL    
	Private cEOL := "CHR(13)+CHR(10)"

	If Empty(cEOL)
		cEOL := CHR(13) + CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif

	cArqTxt := _cPath
	nHdl    := fOpen(cArqTxt,68)

	If Empty(cArqTxt)
		MsgAlert("Selecione um arquivo.","Atencao!")
		Return
	Endif

	If nHdl == -1
		MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser aberto! Verifique os parametros.","Atencao!")
		Return
	Endif

	//Inicializa a regua de processamento
	Processa({|| RunCont() },"Processando ...")
	
	//RunCont()
	
	fClose(nHdl)

	//MsgBox("Concluํdo.","ATENวรO!!!")

Return



Static Function RunCont

	Local aCampos := {}
	Local cLog    := "" 
	Local lValid := .T.
	Local lErro  := .F.
	Private lMsErroAuto := .F.
	Private tInicProc := Time()
	Private nLidos   := 0
	Private nGrava1  := 0
	Private aAux := {}

	// Cria arquivo ARQTMP.DBF
	_aArquivo := { }
	AADD (_aArquivo,{ "DADO","C",300,0 })
	DBCREATE ( "ARQTMP", _aArquivo )
	dbUseArea( .T. ,, "ARQTMP" , "TMPX" )
	APPEND FROM &cArqTxt SDF

	// Inicia regua de processamento
	DbSelectArea("TMPX")
	dbGoTop()
	ProcRegua( LastRec() )
	If !EOF()
		aCampos := StrTokArr(TMPX->DADO+";",";")

		//nMatricula := aScan(aCampos,"MATRICULA")       	
		nMatricula := 1

		dbSkip()	//SKIP A LINHA DE CABEวALHO
		
	EndIf

	DbSelectArea("TMPX")
	
	// Loop para leitura no arquivo
	While !Eof()
	
		// Leitura da linha
		cLinha := StrTran(TMPX->DADO+";",";;",";")
		cLinha := StrTran(StrTran(cLinha,"'"," "),'"',' ') 
		cLinha := IIF(Substr(cLinha,1,1)=";"," "+cLinha,cLinha) 
		aDados := StrTokArr(cLinha,";")

		lValid := .T.
		
		nLidos ++
		IncProc("Importando linha "+cValtoChar(nLidos))

		If Len(aDados) < nMatricula
			dbSelectArea("TMPX")
			dbSkip()
			Loop
		EndIf

		// Valida Matrํcula
		If !Empty(aDados[nMatricula]) 
			DbSelectArea("BA1")
			BA1->(dbSetOrder(2))
			If !BA1->(dbSeek(xFilial("BA1")+aDados[nMatricula]))							
				DbSelectArea("BA3")
				BA3->(dbSetOrder(1))
				If !BA3->(dbSeek(xFilial("BA3")+SUBSTR(aDados[nMatricula], 1, 14)))	
					cLog += "Matrํcula Invแlida: "+aDados[nMatricula]+" - Linha:"+cValtochar(nLidos)+cEOL
					MsgAlert("Matrํcula Invแlida: "+aDados[nMatricula]+" - Linha:"+cValtochar(nLidos)+cEOL, 'Erro')
					lValid:=.F.
				EndIf				
			EndIf	
			DbSelectArea("BA1")
			BA1->(dbSetOrder(2))
			BA1->(dbSeek(xFilial("BA1")+SUBSTR(aDados[nMatricula], 1, 14)))			
        EndIf
        
       //Grava Informacoes     
        If lValid
        	DbSelectArea("TMPX")
			 IF nLidos = 1
				oBrw1:acols[1][1] := aDados[nMatricula]
				oBrw1:acols[1][2] := BA1->BA1_NOMUSR
			 else
			 //oBrw1:acols[nLidos][1] := aDados[nMatricula]
				Aadd(oBrw1:acols, {aDados[nMatricula], BA1->BA1_NOMUSR , .F.})
			 ENDIF
			Aadd(aAux, aDados[nMatricula])

        Else 
        	dbSelectArea("TMPX")
        	dbSkip()
        	Loop
    
        	If !lErro
        		nHdlL := fCreate(cArqTxtL)
        		lErro  := .T.
        	EndIf
        EndIf
          
    		
		If !Empty(cLog)
			fWrite(nHdlL,cLog,Len(cLog))
			cLog := ""
		EndIf

		dbSelectArea("TMPX")
		dbSkip()
	
	Enddo
	//oBrw1:acols := aAux	

	// If !Empty(cLog)
	// 	fWrite(nHdlL,cLog,Len(cLog))
	// EndIf
	dbSelectArea("TMPX")
	dbCloseArea()
    
    If lErro
    	Alert("Existem erros na planilha de matrํcula. Por favor verificar o Log gerado no mesmo diret๓rio do arquivo de origem.")
    	
		nTempo1:= HtoM( tInicProc )
		nTempo2:= HtoM( Time() )
	
		cLog := 'ARQUIVO IMPORTADO: '+cArqTxt+cEOL+cEOL
		fWrite(nHdlL,cLog,Len(cLog))
		cLog := 'TEMPO TOTAL DE PROCESSAMENTO: '+Str(IIF((nTempo2 - nTempo1)<0,(nTempo2 - nTempo1)+1440,(nTempo2 - nTempo1)),10,2)+' MINUTOS'+cEOL
		fWrite(nHdlL,cLog,Len(cLog))
		cLog := 'QUANTIDADE DE REGISTROS LIDOS: '+Str(nLidos,12,0)+cEOL
		fWrite(nHdlL,cLog,Len(cLog))
		cLog := 'QUANTIDADE DE REGISTROS GRAVADOS NA TABELA: '+Str(nGrava1,12,0)+cEOL
		fWrite(nHdlL,cLog,Len(cLog))
		cLog := Replicate("-",80)+cEOL
		fWrite(nHdlL,cLog,Len(cLog))
		fClose(nHdlL)
	EndIf	
Return                                  
