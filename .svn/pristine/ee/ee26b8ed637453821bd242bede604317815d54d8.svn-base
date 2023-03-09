#Include 'TopConn.ch'
#include "totvs.ch"
#Include "protheus.ch"
#Include "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณORTEXPCT2   บ Autor ณ Artur Silveir@180  บ Data ณ  27/05/15 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ ROTINA PARA EXPORTAR LANวAMENTOS CONTABEIS V12 PARA V11    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINANCEIRO                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User function ORTP098()

Local nx	   	:= 0    
Local aSays	   	:= {} 
Local aButtons 	:= {}  
Local lConfirm 	:= .F. 
Private cPerg  	:= 'ORTP098'   

if !ValidPerg(cPerg)
    Return
endif    
   
AADD(aSays, OemToAnsi("Rotina para exporta็ใo de Lan็amentos contabeis,"))   
AADD(aSays, OemToAnsi("gerados no Protheus V12, para o Protheus V11."))   
AADD(aSays, OemToAnsi("Antes de continuar, verifique os parโmetros!"))   
AADD(aSays, OemToAnsi("Deseja Continuar?"))   
	
AADD(aButtons, { 5,.T.,{|| ValidPerg(cPerg) } } )
AADD(aButtons, { 1,.T.,{|o| lConfirm := .T. , o:oWnd:End()}} )
AADD(aButtons, { 2,.T.,{|o| o:oWnd:End() }} )

FormBatch( OemToAnsi('Exporta็ใo de Lan็amentos'), aSays, aButtons ,,,500)

if lConfirm
	Processa({|| fProcExp()},"Aguarde...","Processando Exporta็ใo de Lan็amentos...")
endif
return


// Parametros
Static Function ValidPerg()
	
local cLoad	    := cPerg + cEmpAnt
local cFileName := RetCodUsr() +"_"+ cLoad
local lRet		:= .F.                    
local aPergs	:= {}

MV_PAR01 := space(TamSx3("CT2_LOTE")[1])
MV_PAR02 := STOD('') 

aAdd( aPergs ,{1,"LOTE?" 	   ,MV_PAR01 ,"@!"		,"NAOVAZIO()",'','.T.',50,.F.})	
aAdd( aPergs ,{1,"DATA LANC? " ,MV_PAR02 ,""  		,"NAOVAZIO()",'','.T.',50,.F.})	  
 	
If ParamBox(aPergs ,"Exporta็ใo de Lan็amentos",,,,,,,,cLoad,.T.,.T.)   
    lRet := .T.  
endif

Return(lRet)  



//Exporta Lan็amentos
Static Function fProcExp()

Local aArea     := GetArea()
local nRegAtu   := 0
local nTotReg   := 0    
local nLimite   := 300
local cQuery	:= '' 
local cConteudo	:= '' 
local aTemp		:= {}
local cTemp  	:= ''  
local nTemp  	:= 0  
local nI	  	:= 0  
local aItens	:= {}
local aRet 		:= {}   
local aStruct	:= {}  
local oSrv		:= Nil
local aSrv 	    := U_fRetUnV11(cEmpAnt) 
local cChave1	:= ""   
local nTenRpc 	:= 0    
local oSrv    	:= nil
//local lProd     := cEmpant $ ('21|22|30|51|52|53|54|55|56|57|65|68|71|72|73')  
local lProd     := cEmpant $ ('01|02') 
local cDbLink	:= "@DB"+cEmpant  
local nRetTc	:= 0    
private nProc	:= 0
private aErro	:= {}
private cTexto	:= '' 
private nTotGer := 0    

ProcRegua(0) 

if lProd
	cDbLink	:= "@PROD" 
endif

nRetTc := TcSqlExec("SELECT CT2_FILIAL FROM SIGA."+RetSqlName("CT2")+cDbLink+" " )

cQuery	:= " SELECT * "  
cQuery	+= " FROM "+RetSqlName("CT2")+" CT2 "  
cQuery	+= " WHERE CT2.CT2_FILIAL = '" + xFilial('CT2') + "' "  
cQuery	+= "  AND CT2.CT2_DATA    = '" + DTOS(MV_PAR02) + "' "  
cQuery	+= "  AND CT2.CT2_LOTE    = '" + MV_PAR01 + "' "  
cQuery	+= "  AND CT2.D_E_L_E_T_  = ' ' "     

if nRetTc == 0
	cQuery	+= "  AND NOT EXISTS "     
    cQuery	+= "  ( SELECT * FROM SIGA."+RetSqlName("CT2")+cDbLink+" C "
    cQuery	+= "  WHERE C.CT2_FILIAL = CT2.CT2_FILIAL  "
    cQuery	+= "   AND C.CT2_DATA    = CT2.CT2_DATA   "
    cQuery	+= "   AND C.CT2_LOTE    = CT2.CT2_LOTE  "
    cQuery	+= "   AND C.D_E_L_E_T_  = ' ' "     
    cQuery	+= "   AND C.CT2_KEY     <> ' ' "   
    cQuery	+= "   AND C.CT2_KEY     = CT2.CT2_FILIAL || CT2.CT2_DATA || CT2.CT2_LOTE || "
    cQuery	+= "   					   CT2.CT2_SBLOTE || CT2.CT2_DOC || CT2.CT2_LINHA || "
    cQuery	+= "   					   CT2.CT2_EMPORI || CT2.CT2_FILORI || CT2.CT2_MOEDLC || CT2.CT2_SEQIDX ) "
endif  

If Select("XCT2") > 0
	XCT2->(dbCloseArea())
EndIf

TcQuery cQuery Alias "XCT2" New
XCT2->(DbGoTop())
Count To nTotReg 
if nTotReg < 1
	MsgStop('Nใo existem registros para essa consulta, favor verificar os parโmetros!')
	RestArea(aArea) 
	return
endif
XCT2->(dbGoTop())  
nTotGer := nTotReg
nTotReg += 2
ProcRegua(nTotReg)      

dbselectarea('CT2')
aStruct	:= CT2->(DbStruct())
	   
XCT2->(dbGoTop())
While !XCT2->(Eof()) 
		  	
	nTemp := 0   	
	aItens	:= {}

	While !XCT2->(Eof()) .and. nTemp < nLimite  	

		nRegAtu++
		IncProc("Exportando Lan็. - Status: " + IIF((nRegAtu/nTotReg)*100 <= 99, StrZero((nRegAtu/nTotReg)*100,2), STRZERO(99,2)) + "%")	
	  	
	  	nTemp++
	  	
		aTemp	:= {}
		cChave1 := XCT2->( CT2_FILIAL+CT2_DATA+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA+CT2_EMPORI+CT2_FILORI+CT2_MOEDLC+CT2_SEQIDX )	

		For nI := 1 TO LEN(aStruct) 
		
			cConteudo := 'XCT2->'+aStruct[nI][1]
		
			If aStruct[nI][2] == "D"
				AADD(aTemp, {aStruct[nI][1] , stod(&cConteudo) })    
			elseif Alltrim(aStruct[nI][1]) == "CT2_KEY"
				AADD(aTemp, { "CT2_KEY" , cChave1 })    
			else 	
				AADD(aTemp, {aStruct[nI][1] , &cConteudo })    
			EndIf
		Next nI  
		
		AADD( aItens, aTemp )
				
		XCT2->(DbSkip())       			
	end		
		
	nTenRpc := 0      
	oSrv    := nil
	while valtype(oSrv) <> "O" .and. nTenRpc <= 5
		nTenRpc++
		oSrv := RpcConnect(aSrv[1,2], aSrv[1,3], aSrv[1,4], aSrv[1,5], aSrv[1,6])
		//oSrv := RpcConnect('10.0.100.208', 1250, 'COMPPR', '10', '02')   
	end

	If ValType( oSrv ) <> "O"
		cTemp  := "Falha na conexใo RPC, erro ao conectar na unidade: " + cEmpAnt + " (RPC Connect) " +CRLF	
		cTexto += cTemp
		aadd(aErro,{ cTemp , '' })	
	else
		aRet := oSrv:CallProc( 'U_ORTGERLA', aItens, MV_PAR02)	
		If ValType( aRet ) == "A"
			if aRet[1]
				nProc += aRet[2]
			else
				cTemp  := "Erro na exporta็ใo dos lan็amentos para a unidade: " + cEmpAnt + " Erro: " + aRet[2] +CRLF	
				cTexto += cTemp
				aadd(aErro,{ cTemp , '' })	
			endif	
		else
			cTemp  := "Erro na exporta็ใo dos lan็amentos para a unidade: " + cEmpAnt + " Erro: Retorno inesperado! " +CRLF	
			cTexto += cTemp
			aadd(aErro,{ cTemp , '' })	
		endif
  		RpcDisconnect(oSrv)
  	endif        
End

nRegAtu++
IncProc("Atualizando Saldos - Status: " + IIF((nRegAtu/nTotReg)*100 <= 99, StrZero((nRegAtu/nTotReg)*100,2), STRZERO(99,2)) + "%")	
   
nTenRpc := 0      
oSrv    := nil
while valtype(oSrv) <> "O" .and. nTenRpc <= 5
	nTenRpc++
	oSrv := RpcConnect(aSrv[1,2], aSrv[1,3], aSrv[1,4], aSrv[1,5], aSrv[1,6])
	//oSrv := RpcConnect('10.0.100.208', 1250, 'COMPPR', '10', '02')   
end
If ValType( oSrv ) == "O"	
	cTemp := oSrv:CallProc( 'CTBA190', .t.,MV_PAR02-1,Date()) 					
	RpcDisconnect(oSrv)
endif

nRegAtu++
IncProc("Status: " + IIF((nRegAtu/nTotReg)*100 <= 99, StrZero((nRegAtu/nTotReg)*100,2), STRZERO(100,2)) + "%")	

fLogExp() 
RestArea(aArea) 
return


//Tela de Log de Processamento
static function fLogExp()  
Local cTemp := ''

cTemp += "Log de Exporta็ใo de Lan็amentos "+CRLF+CRLF
cTemp += "Lan็amentos Exportados: "+Alltrim(str(nProc))+CRLF
cTemp += "Lan็amentos nใo Exportados: "+Alltrim(str(nTotGer - nProc))+CRLF+CRLF
if (nTotGer - nProc) > 0
	cTemp += "Log de erros: "+CRLF+CRLF 
endif	
cTexto := cTemp + cTexto    

DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   
DEFINE MSDIALOG oDlgl TITLE "Exporta็ใo Concluida." From 3,0 to 340,417 PIXEL
@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlgl PIXEL
oMemo:bRClicked := {|| AllwaysTrue()}
oMemo:oFont:=oFont
DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlgl:End() ENABLE OF oDlgl PIXEL  
DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION  fSalvaLog() ENABLE OF oDlgl PIXEL 
ACTIVATE MSDIALOG oDlgl CENTER
return  


//Salva de Log de Processamento
static function fSalvaLog()  
Local cMascara  := "Diretorios|."
Local cTitulo   := "Escolha o Diretorio"
Local cFile     := ''
Local nMascpad  := 0
Local cDirini   := "C:\"
Local lSalvar   := .F.    
Local lArvore   := .F.  
Local nOpcoes   := GETF_LOCALHARD 
Local cArq		:= 'ORTUPCTA_D'+dtos(Date())+'_H'+strtran(Alltrim( Time()),":","")+'.txt'
Local nHandle   := 0
Local nx	    := 0

cFile := cGetFile( cMascara, cTitulo, nMascpad, cDirIni, lSalvar, nOpcoes, lArvore)   

If !Empty(cFile)
	cFile := strtran(Alltrim(cFile),".","") + cArq  
	
	nHandle := FCREATE(cFile)
	if nHandle == -1
    	MsgAlert("O Arquivo nใo foi criado:" + STR(FERROR()))
		return
	else
		
		FWRITE(nHandle, "PRODUTO;CONTA;ERRO"+CRLF )
		
		if Len(aErro) > 0
			for nx:=1 to Len(aErro)		
				FWRITE(nHandle, aErro[nx,1] + " - " + aErro[nx,2] +CRLF )
			next nx	
		else
			FWRITE(nHandle, cTexto)
		endif
		
        FCLOSE(nHandle)
		if file(cFile)
			MsgInfo('Arquivo salvo com sucesso em '+cFile)
		endif 
	endif
endif                                    
return 



Static Function fExistCt2(_cChave1)
Local aArea    	:= GetArea()
local cQuery    := ''
local lRet      := .f.
default _cChave1:= ''

if !Empty(Alltrim(_cChave1))

	cQuery	:= " SELECT COUNT(*) XEXIST "  
	cQuery	+= " FROM "+RetSqlName("CT2")+" "  
	cQuery	+= " WHERE CT2_FILIAL = '" + xFilial('CT2') + "' "  
	cQuery	+= "  AND CT2_DATA = '" + Substr(_cChave1,3,8) + "' "  
	cQuery	+= "  AND CT2_KEY = '" + Alltrim(_cChave1) + "' "  
	cQuery	+= "  AND D_E_L_E_T_ = ' ' "      
	If Select("YCT2") > 0
		YCT2->(dbCloseArea())
	EndIf
	TcQuery cQuery Alias "YCT2" New
	lRet := YCT2->XEXIST > 0  
endif	
	
RestArea(aArea)
return lRet
   
