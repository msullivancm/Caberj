#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS500GR  ºAutor  ³Microsiga           º Data ³  13/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para calcular o valor original apresentado º±±
±±º          ³facilitando o entendimento da rotina de contas medicas.m    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteracao ³Criada rotina para revalorizar cobranca automaticamente qdo º±±
±±º          ³realizar manutencao em guias GIH.                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS500GR()

Local _cSQL := "" 
Local cCodLDP := &(BCL->BCL_ALIAS+"_CODLDP")
Local cCodPeg := &(BCL->BCL_ALIAS+"_CODPEG")
Local cNumero := &(BCL->BCL_ALIAS+"_NUMERO")
Local cOriMov := &(BCL->BCL_ALIAS+"_ORIMOV")
Local cOpeUsr := &(BCL->BCL_ALIAS+"_OPEUSR")
Local cCodEmp := &(BCL->BCL_ALIAS+"_CODEMP")
Local cMatric := &(BCL->BCL_ALIAS+"_MATRIC")
Local cTipReg := &(BCL->BCL_ALIAS+"_TIPREG")
Local cDigito := &(BCL->BCL_ALIAS+"_DIGITO")
Local dDatPro := &(BCL->BCL_ALIAS+"_DATPRO")
Local cHorPro := &(BCL->BCL_ALIAS+"_HORPRO")
Local dDatAlt := CtoD("")
Local dDatInt := CtoD("")

Local _aABD5 := BD5->(GetArea())
Local _aABE4 := BE4->(GetArea())
Local _aABD6 := BD6->(GetArea())
Local _aABD7 := BD7->(GetArea())
Local _aABB8 := BB8->(GetArea())
Local _aABD3 := BD3->(GetArea())
Local _aABR8 := BR8->(GetArea())
Local _aABCL := BCL->(GetArea())

Local _aArea		:= GetArea()

Local nTotDig := 0
Local nTotGui := 0
Local cNomeBD6 := RetSQLName("BD6")
Local cNomeBD7 := RetSQLName("BD7")
Local aAreaBD6 := BD6->(GetArea())
Local cTipGui	:= paramixb[1] //01, 02 ou 03
Local nOpc		:= paramixb[2] //3 - Incluir, 4-Alterar, 8-Cancelar
Local _aVetRCB	:= {}
Local _nTotRCB := 0
Local _nCt1		:= 0 
Local cCodAna   

If ( nOpc == 3 .or. nOpc == 4 )
	cCodAna := RetCodUsr()
	
	If BCL->BCL_ALIAS == "BD5"
		u_LogBloBD6( BCL->BCL_ALIAS, cCodLDP, cCodPeg, cNumero, cOriMov, CNOMEBD6, cCodAna)	
	EndIf
EndIf
/*
If nOpc >= 3 .and. nOpc <= 4
	//Soma os valores de todos os BD6 com valor apresentado
	_cSQL := " SELECT SUM(BD6_VLRAPR*BD6_QTDPRO) AS TOTGUI, SUM(BD6_YVLDG2*BD6_QTDPRO) AS TOTDIG " 
	_cSQL += " FROM "+cNomeBD6+" BD6 "
	_cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
	_cSQL += " AND BD6_CODOPE = '"+PLSINTPAD()+"' "
	_cSQL += " AND BD6_CODLDP = '"+cCodLDP+"' "
	_cSQL += " AND BD6_CODPEG = '"+cCodPeg+"' "
	_cSQL += " AND BD6_NUMERO = '"+cNumero+"' "
	_cSQL += " AND BD6_ORIMOV = '"+cOriMov+"' "
	_cSQL += " AND BD6_BLOCPA <> '1' "
	_cSQL += " AND BD6_VLRAPR > 0 "
	_cSQL += " AND D_E_L_E_T_ = ' ' "
	PlsQuery(_cSQL,"TRB500GR")
	
	nTotGui := TRB500GR->TOTGUI
	nTotDig := TRB500GR->TOTDIG
	TRB500GR->(DbCloseArea())
	
	_cSQL := " SELECT BD7_SEQUEN, SUM(BD7_VLRAPR*BD6_QTDPRO) AS TOTPORSEQ, SUM(BD7_YVLDG2*BD6_QTDPRO) AS TOTDIGSEQ " 
	_cSQL += " FROM "+cNomeBD6+" BD6, "+cNomeBD7+" BD7 " 
	_cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
	_cSQL += " AND BD6_CODOPE = '"+PLSINTPAD()+"' "
	_cSQL += " AND BD6_CODLDP = '"+cCodLDP+"' "
	_cSQL += " AND BD6_CODPEG = '"+cCodPeg+"' "
	_cSQL += " AND BD6_NUMERO = '"+cNumero+"' "
	_cSQL += " AND BD6_ORIMOV = '"+cOriMov+"' "
	_cSQL += " AND BD6_BLOCPA <> '1' "
	_cSQL += " AND BD6_VLRAPR = 0 "
	_cSQL += " AND BD7_FILIAL = '"+xFilial("BD6")+"' "
	_cSQL += " AND BD7_CODOPE = BD6_CODOPE "
	_cSQL += " AND BD7_CODLDP = BD6_CODLDP "
	_cSQL += " AND BD7_CODPEG = BD6_CODPEG "
	_cSQL += " AND BD7_NUMERO = BD6_NUMERO "
	_cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
	_cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
	_cSQL += " AND BD6.D_E_L_E_T_ = ' ' "
	_cSQL += " AND BD7.D_E_L_E_T_ = ' ' "
	_cSQL += " GROUP BY BD7_SEQUEN, BD6_QTDPRO "
	
	PlsQuery(_cSQL,"TRB500GR")
	
	While !(TRB500GR->(Eof()))
		nTotGui += TRB500GR->(TOTPORSEQ)
		nTotDig += TRB500GR->(TOTDIGSEQ)
		TRB500GR->(DbSkip())
	Enddo
	
	///RestArea(aAreaBD6)
	TRB500GR->(DbCloseArea())   

	//Bianchini - Modificação v12 (Sai BD5-> e troca pra M->)
	If !(cTipGui $ "03|05")
		M->BD5_YTOAPR := nTotGui  
		M->BD5_YVLDIG := IIF(nTotDig>0,nTotDig,nTotGui)   //nTotDig
		If nOpc == 3
			M->BD5_XANALI := cCodAna
			M->BD5_XNOANA := Upper(UsrFullName(cCodAna))
			M->BD5_XDTHRA := DtoC(Date()) + '-' + Time()
		Endif
	Else
		M->BE4_YTOAPR := nTotGui
		M->BE4_YVLDIG := IIF(nTotDig>0,nTotDig,nTotGui)  //nTotDig
		If nOpc == 4
			M->BE4_XANALI := cCodAna
			M->BE4_XNOANA := Upper(UsrFullName(cCodAna))
			M->BE4_XDTHRA := DtoC(Date()) + '-' + Time()
		Endif
	Endif
Endif
*/
If !(cTipGui $ "03|05")
	If nOpc == 3
		M->BD5_XANALI := cCodAna
		M->BD5_XNOANA := Upper(UsrFullName(cCodAna))
		M->BD5_XDTHRA := DtoC(Date()) + '-' + Time()
	Endif
Else
	If nOpc == 4
		M->BE4_XANALI := cCodAna
		M->BE4_XNOANA := Upper(UsrFullName(cCodAna))
		M->BE4_XDTHRA := DtoC(Date()) + '-' + Time()
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Novo tratamento para guias de internacao que tem data de internacao ³
//³ informada. Re-valorizar cobranca de guias de servico fora do periodo³
//³ Somente quando alterar, verificar se a data de internacao foi 		³
//³ informada. Em caso positivo, realizar verificacao e revalorizacao	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
If nOpc == 4 .And. cTipGui == "03"

	dDatAlt := &(BCL->BCL_ALIAS+"_DTALTA")  
	dDatInt := &(BCL->BCL_ALIAS+"_DATPRO")  
	
	//BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+DTOS(BD6_DATPRO)+BD6_CODPAD+BD6_CODPRO+BD6_FASE+BD6_SITUAC+BD6_HORPRO                         
	_cSQL := " SELECT BD5.R_E_C_N_O_  AS REGBD5 "
	_cSQL += " FROM "+RetSQLName("BD5")+ " BD5 "
	_cSQL += " WHERE BD5_FILIAL = '"+xFilial("BD5")+"' "
	_cSQL += " AND BD5_OPEUSR = '"+cOpeUsr+"' "
	_cSQL += " AND BD5_CODEMP  = '"+cCodEmp+"' "
	_cSQL += " AND BD5_MATRIC  = '"+cMatric+"' "
	_cSQL += " AND BD5_TIPREG  = '"+cTipReg+"' "
	_cSQL += " AND BD5_DIGITO  = '"+cDigito+"' "
	_cSQL += " AND BD5_SITUAC = '1' "
	_cSQL += " AND BD5_FASE >= '3' "
	_cSQL += " AND BD5_NUMSE1 = ' ' "
	If !Empty(dDatAlt)
		_cSQL += " AND BD5_DATPRO >= '"+DtoS(dDatPro)+"' "
	Else
		_cSQL += " AND BD5_DATPRO >= '"+DtoS(dDatInt)+"' "
	Endif
	_cSQL += " AND BD5_ORIMOV = '1' "
	_cSQL += " AND BD5.D_E_L_E_T_ = ' ' "
	
	PLSQuery(_cSQL,"TRB500GR")
	
	While !(TRB500GR->(EOF()))	
		aadd(_aVetRCB,TRB500GR->(REGBD5))	
		TRB500GR->(DbSkip())
	Enddo	
	
	TRB500GR->(DbCloseArea())   						
	
	Processa({|| ProcRCB(_nTotRCB,_aVetRCB,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito) }, "Aguarde", "Revalorizando cobrança de guias ambulatoriais...", .T.)	
	
	BDH->(DbCloseArea())	
	_aVetRCB := {}
	
Endif

RestArea(_aArea)
RestArea(_aABD5)
RestArea(_aABD6)
RestArea(_aABD7)
RestArea(_aABB8)
RestArea(_aABD3)
RestArea(_aABR8)
RestArea(_aABCL)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ProcRCB   ºAutor  ³Microsiga           º Data ³  08/13/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ProcRCB(_nTotRCB,_aVetRCB,cMatricUsr)
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
		
		IncProc("Revalorizando: "+StrZero(_nCt1,6)+" de "+StrZero(_nTotRCB,6))	
		PLSA500RCB("BD5",_aVetRCB[_nCt1],Nil,Nil,.F.)		
		
	Next				
	
Endif

RestArea(_aArBD5)

Return Nil   

********************************************************************************************************

User Function LogBloBD6( c_Alias, cCodLDP, cCodPeg, cNumero, cOriMov , CNOMEBD6, c_CodAna)

Local aAreaBloq	:= GetArea()
Local aArBlBD6 	:= BD6->(GetArea())


_cSQL := " SELECT r_e_c_n_o_ RECBD6 " 
_cSQL += " FROM "+cNomeBD6+" BD6 "
_cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
_cSQL += " AND BD6_CODOPE = '"+PLSINTPAD()+"' "
_cSQL += " AND BD6_CODLDP = '"+cCodLDP+"' "
_cSQL += " AND BD6_CODPEG = '"+cCodPeg+"' "
_cSQL += " AND BD6_NUMERO = '"+cNumero+"' "
_cSQL += " AND BD6_ORIMOV = '"+cOriMov+"' "
_cSQL += " AND ( BD6_BLOCPA = '1' AND SUBSTR(BD6_MOTBPF, 1, 3) <> '(L)' ) "
_cSQL += " AND D_E_L_E_T_ = ' ' "

PlsQuery(_cSQL,"LOGBLOCPA")

If !LOGBLOCPA->( EOF() )
     
	While !LOGBLOCPA->( EOF() )
	    
	    dbSelectArea("BD6")
	    dbGoto( LOGBLOCPA->RECBD6 )                     
	    
	    If BD6->BD6_BLOCPA == '1' 

			BD6->(Reclock("BD6",.F.))
               
				BD6->BD6_DESBPF := '(L)' + Alltrim(UsrRetName(c_CodAna)) +'-'+ Alltrim( BD6->BD6_DESBPF )

			BD6->(MsUnlock())    
			
			
		EndIf
		     
	     
		LOGBLOCPA->( dbSkip() )
	
	EndDo

EndIf

LOGBLOCPA->( DbCloseArea() ) 

BD6->(RestArea(aArBlBD6))
RestArea(aAreaBloq)

Return

