#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BusChvRc    ºAutor  ³ Jean Schulz      º Data ³  11/12/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca chave da guia original relativa a guia de ressarcimen-º±±
±±º          ³to, conforme regra da Caberj.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BusChvRc(cChave)
Local cRet := ""
Local cSQL := ""    
Local nPosTraco := 3
Local cNumImp := ""
Local aAreaBD5 := BD5->(GetArea())
Local aAreaBE4 := BE4->(GetArea())

If Upper(substr(cChave,1,3)) == "REC"
	
	nPosTraco := Iif(At("-",cChave)==0,3,At("-",cChave))
	cNumImp := StrZero(Val(Substr(cChave,nPosTraco+1)),20)
	
	BD5->(DbSetOrder(6))
	If BD5->(MsSeek(xFilial("BD5")+cNumImp))
		cRet := BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)
	Endif
	
	If Empty(cRet)
		BE4->(DbSetOrder(6))
		If BE4->(MsSeek(xFilial("BD5")+cNumImp))
			cRet := BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)
		Endif	
	Endif    
	
	If Empty(cRet)
		MsgAlert("Guia de recurso de glosa! Não foi encontrada a guia origem!")
	Endif
   
/*
	cSQL := " SELECT BD5_CODOPE, BD5_CODLDP, BD5_CODPEG, BD5_NUMERO, BD5_ORIMOV "
	cSQL += " FROM "+RetSQLName("BD5")+" BD5 "
	cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' "
	cSQL += " AND BD5_SENHA = '"+StrZero(Val(cNumImp))+"' " 
	cSQL += " AND BD5_SITUAC = '1' "
	cSQL += " AND D_E_L_E_T_ = ' ' "   
	
	PLSQuery(cSQL,"TRBCHV")
	
	If Empty(TRBCHV->BD5_CODOPE)
	
		TRBCHV->(DbCloseArea())
		cSQL := " SELECT BE4_CODOPE, BE4_CODLDP, BE4_CODPEG, BE4_NUMERO, BE4_ORIMOV "
		cSQL += " FROM "+RetSQLName("BE4")+" BE4 "
		cSQL += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
		cSQL += " AND BE4_SENHA = '"+StrZero(Val(cNumImp))+"' " 
		cSQL += " AND BE4_SITUAC = '1' "
		cSQL += " AND D_E_L_E_T_ = ' ' "   
		
		PLSQuery(cSQL,"TRBCHV")
		
		cRet := TRBCHV->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)
			
	Else
		cRet := TRBCHV->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)
	Endif
	
	TRBCHV->(DbCloseArea())
*/
	
	//cRet := "000100011234567898765431"
	
Endif

If Empty(cRet) 
	cRet := Space(25)
Endif

RestArea(aAreaBD5)
RestArea(aAreaBE4)
	
Return cRet