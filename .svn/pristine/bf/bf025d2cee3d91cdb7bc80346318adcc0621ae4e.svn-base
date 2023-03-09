#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*                  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABA143   บ Autor ณAltamiro              บ Data ณ 16/10/2018บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ                                          
ฑฑบDescricao ณ Processamento arquivo de retorno ANS -                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA143

Local cMsg			:= ""

Private aArGeral
Private lAbortPrint := .F.
Private cPerg       := "CABA143"
Private cTitulo     := "Processamento do arquivo de Conferencia ANS [ CNX ]"
Private cTab       	:= ' '
Private cHorIni		:= '' 
Private cHorFim		:= ''
Private nLinhasProc	:= 0 
Private lPisPasep                     
private cHora:= StrTran(Time(),':','')   
private cHora1 := substr(cHora,1,2)+':'+substr(cHora,3,2)+':'+substr(cHora,5,2)
private DtHora := substr(dtos(date()),7,2)+'/'+substr(dtos(date()),5,2)+'/'+substr(dtos(date()),1,4)+' - '+cHora1	
PRIVATE cAlPD4 := GetNextAlias()
Private cNomAAnsc   := '' 
Private cNomAAnsi   := ''    
Private cAliastmp   := GetNextAlias() 
Private cAliastmp1  := GetNextAlias()


                                                                         
SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Processamento do arquivo de Conferencia do SIB [ ANS ]" + CRLF

oDlg1      := MSDialog():New( 095,232,368,705,"Processamento dos Arquivos CNX - Conferencia ANS ",,,.F.,,,,,,.T.,,,.T. )

oGrp1      := TGroup():New( 008,012,100,224,"Arquivos CNX - Conferencia ANS ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
oSBtn1     := SButton():New( 112,140,05,{||AjustaSX1(cPerg)}		,oDlg1,,"", )
oSBtn2     := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()}	,oDlg1,,"", )
oSBtn3     := SButton():New( 112,196,02,{||oDlg1:End()}				,oDlg1,,"", )

oDlg1:Activate(,,,.T.)

Return

*****************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function OkLeTxt

Local nCont			:= 0   
Local cNomArqSIB	:= '' 
Local cNomAAnsc   := '' 
Local cNomAAnsi   := ''
Local lContinua		:= .T. 

Private  cNomeArqc	:= "" 
Private  cNomeArqi	:= ""
Private  cMesAdi 	:= ""
Private  cAnoAdi	:= "" 
Private  cCritica   := " " 
Private  cCritImp   := " " 

Private  aDadosInc  := {} 
Private  aDadosRet  := {} 
Private  aDadosCanc	:= {} 

Private  aDadosReat	:= {} 
Private  aDadosMcon	:= {} 

Private  aErroVlr	:= {} 
Private  aErroTit	:= {}
Private  aCertosNT  := {}
			


Pergunte(cPerg,.F.)
                      
cNomeArqc	:= mv_par01         
cNomeArqi	:= mv_par02


cNomAAnsc	:= Substr(cNomeArqc,Rat('\',cNomeArqc)+1,Rat('.',cNomeArqc)-Rat('\',cNomeArqc)+3) 
cNomAAnsi	:= Substr(cNomeArqi,Rat('\',cNomeArqi)+1,Rat('.',cNomeArqi)-Rat('\',cNomeArqi)+3)

If !EMPTY(cNomeArqc)
	If  substr(cNomAAnsc,8,6) <> '324361'  
		MsgStop("Arquivo nใo ้ da CABERJ. Esperado que o nome do arquivo inicie com [ 324361 ] por้m o nome do arquivo inicia com [ " + substr(cNomAAnsc,8,6) + " ]" ,AllTrim(SM0->M0_NOMECOM))
		lContinua := .F.  
	ElseIf  substr(cNomAAnsc,14,6) <> strzero(mv_par03,2) + strzero(mv_par04,4)  
		MsgStop("Competencia do  Arquivo de retorno nao ้ igual ao informadas da CABERJ.")
		lContinua := .F.  	
	EndIf 
EndIf	

If !EMPTY(cNomeArqi)
	If  substr(cNomAAnsi,8,6) <> '415774' 
		MsgStop("Arquivo nใo ้ da INTEGRAL. Esperado que o nome do arquivo inicie com [ 415774 ] por้m o nome do arquivo inicia com [ " + substr(cNomAAnsc,8,6) + " ]" ,AllTrim(SM0->M0_NOMECOM))
		lContinua := .F.     
	ElseIf  substr(cNomAAnsi,14,6) <> strzero(mv_par03,2) + strzero(mv_par04,4)  
		MsgStop("Competencia do  Arquivo de retorno nao ้ igual ao informadas da INTEGRAL.")
		lContinua := .F.  	
	EndIf  	
EndIf 	

 
If lContinua

	cHorIni := Time()
	
	Processa({|| lContinua := Proc143()}, cTitulo, "", .T.)
	
	If lContinua
	
		MsgInfo("                   Processo Finalizado." 		 + CRLF	+ CRLF +;
				"Atualizado tabela de conferencia Ans , Caberj e Integral" )
	 		
	 EndIf

EndIf

Return                 

**************************************************************************

Static Function Proc143

Local nAux 			:= 0
Local cTot 			:= ''
Local lInicio		:= .T.
Local nI			:= 0

Local cCritUsr 		:= ''	
Local cCritMae 		:= '' 
Local cCritMat 		:= ''
Local cArqSIBc		:= ''  
Local cArqSIBi		:= ''       

Private lCritSIB 	:= .F.
Private cAliasSIB 	:= ''
Private cAliasBA1 	:= ''

Private cBuffer1

cNomeArqc := Alltrim(cNomeArqc) 
cNomeArqi := Alltrim(cNomeArqi)

    If !EMPTY(cNomeArqc)
		If !File(cNomeArqc)
		MsgAlert("Arquivo texto: " + cNomeArqc + " nใo Localizado","Atencao!")
		Return .F.    
		EndIf                      
    EndIf

    If !EMPTY(cNomeArqi)
		If !File(cNomeArqi)
		MsgAlert("Arquivo texto: " + cNomeArqi + " nใo Localizado","Atencao!")
		Return .F.    
		EndIf                     
    EndIf

	ProcRegua(0)

	For nI := 1 to 5
		IncProc('Copiando arquivo...')
	Next
	
/// copia dos aquivos de retorno ans - caberj 	
	
	If !EMPTY(cNomeArqc)
		
		cArqSIBc := Right(cNomeArqc,len(cNomeArqc) - RAt('\',cNomeArqc))   
		cArqSIBc := UPPER(cArqSIBc)
		cArqDesC := '\\srvdbp\backup\utl\SIB\' + cArqSIBc
		
		If !MoveFile(cNomeArqc,cArqDesC,.F.)
			MsgStop("Nใo foi possํvel copiar o  arquivo  [ " + cNomeArqc+ " ] para [ " + cArqDesC + " ]","Atencao!")
			Return .F.
		EndIf      
	EndIf	
/// copia dos aquivos de retorno ans - integral 	
	
	If !EMPTY(cNomeArqi)
		cArqSIBi := Right(cNomeArqi,len(cNomeArqi) - RAt('\',cNomeArqi))
		cArqSIBi := UPPER(cArqSIBi)
		cArqDesI := '\\srvdbp\backup\utl\SIB\' + cArqSIBi
		
		If !MoveFile(cNomeArqi,cArqDesI,.F.)
			MsgStop("Nใo foi possํvel copiar o  arquivo  [ " + cNomeArqi+ " ] para [ " + cArqDesI + " ]","Atencao!")
			Return .F.
		EndIf	
	EndIf	

IncProc('Carregando arquivo XML...')   

		cScript := "BEGIN" + CRLF	                                         

	If !EMPTY(cArqSIBc)
		
			cScript += "	CARGA_RETORNO_SIB('C','"+cArqSIBc+"'); "	+ CRLF
		
	EndIf					
	
	If !EMPTY(cArqSIBi)

			cScript += "	CARGA_RETORNO_SIB('I','"+cArqSIBi+"'); "	+ CRLF
			
    EndIf
		
		cScript +="COMMIT; "  + CRLF
		cScript += "END;" 	  + CRLF							  
/*
CARGA_RETORNO_SIB('C','ArqConf3243610720170101.CNX');

CARGA_RETORNO_SIB('I','ArqConf4157740720170101.CNX');

*/

//ARQUIVOS DEVEM ESTAR EM: \\srvdbp\backup\utl\SIB
//OPERADORA: C OU I
//COLOCAR SOMENTE O NOME NO PARAMETRO PARQUIVO: Conf_Caberj_Agosto_15.CNX


/*aRetSP := TcSPExec(	'CARGA_ENVIO_SIB',;
						If(cEmpAnt == '01','CABERJ','INTEGRAL'),;
						cArqSIB;
				  )  */       
				  
				  

nSucesso:= tcsqlexec(cScript)
	If nSucesso == 0
	 
	   MsgStop("SUCESSO !!! Arq. de Conferencia Ans gravado ")
	   
	   fInsqtda()
	
	Else 		                                          
	
	   MsgAlert("---- Arq. de Conferencia Ans NAO FOI gravado com sucesso! , Verifique o processo ou procure a TI---- ","Atencao!")
	
	EndIf	 
			

/*If Empty(aRetSP)
	MsgStop("Erro ao executar a procedure CARGA_RETORNO_SIB","Caberj/Integral")
	Return .F.
EndIf                       
*/			  
//aRetSPc := TcSPExec("CARGA_RETORNO_SIB( 'I' , '"+cArqSIBi+"')")			  				  	  
/*	
If Empty(aRetSPi) 
    MsgStop("Erro ao executar a procedure CARGA_RETORNO_SIB",'integral')
    Return .F.                               
EndIf 
*/
RETURN()

/***************************************************************************************************/
Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 
                          
PutSx1(cPerg,"01",OemToAnsi("Retorno SIB - Caberj ")   		,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('sbx     (*.CNX)            | *.CNX | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Retorno SIB - Integral") 		,"","","mv_ch2","C",060,0,0,"G","U_fGetFile('sbx     (*.CNX)            | *.CNX | ')","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("M๊s da Comp. do Retorno") 		,"","","mv_ch3","N",02 ,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{'Informe o m๊s da comp. de Retorno , '	,' ' ,' '},{},{}) 
PutSx1(cPerg,"04",OemToAnsi("Ano da Comp. do Retorno") 		,"","","mv_ch4","N",04 ,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{'Informe o ano da comp. de Retorno , '	,' ' ,' '},{},{}) 

Pergunte(cPerg,.T.)

Return 

STATIC FUNCTION fInsqtda()    
                                                                               
local cComp := strzero(mv_par04,4)+strzero(mv_par03,2)        
local cQuery  := ' ' 
local cQryIns := ' '                                  
local cEmp    := ' ' 
local nQtda   := 0   

for x:=1 to 2
    If x== 2

       cQuery := "select count(*) qtda from confsib_int where  sib_situac = '1'    "          

    Else 
    
       cQuery := "select count(*) qtda  from confsib_cab where  sib_situac = '1'    "
    
    EndIf    

    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea())  
    Endif 

    TCQuery cQuery  New Alias (cAliastmp)   

    (cAliastmp )->(dbGoTop()) 
         
    cEmp    := strzero(x,2)  
 
    nQtda   := (cAliastmp )->Qtda
    
    cQuery1 := "select count(*) qtda from siga.SOMA_CONF_ANS where sca_emp = '" + cEmp + "' and  sca_comp = '" + cComp + "'  "                            
 
    If Select((cAliastmp1)) <> 0 

       (cAliastmp1)->(DbCloseArea())  

    EndIf 

    TCQuery cQuery1 New Alias (cAliastmp1)   

    (cAliastmp1)->(dbGoTop())   

    If (cAliastmp1)->qtda > 0
     
       cQuery  := " update siga.SOMA_CONF_ANS SET SCA_QTDA = " + cvaltochar(nQtda) + " WHERE SCA_COMP = '" + cComp + "' AND '" + cEmp  +"' "

    Else 
   
       cQuery  := " insert into siga.SOMA_CONF_ANS values ( '" + cEmp  +"'  , '" + cComp + "', " + cvaltochar(nQtda) + " ) " 

    EndIf                                                             

    TcSqlExec(cQuery) >= 0   

Next
       
Return 

/***********************************************************************************************************************/