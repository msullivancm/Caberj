#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AJUSODON ³ Autor ³ Jean Schulz            ³ Data ³ 29.10.07  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Rotina para ajuste de co-part odontologico.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Advanced Protheus                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function AJUSODON()
					
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis padroes para todos os relatorios...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin     := 60
PRIVATE cTamanho    := "G"
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BD6"
PRIVATE cPerg       := "YAJODO"
PRIVATE cRel        := "YAJODO"
PRIVATE nli         := 80
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrderns    := {}
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.

PRIVATE aCritica	:= {}

PRIVATE _cSeqNom	:= ""

While .T.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama Pergunte Invariavelmente                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1(cPerg)
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/*
	cRel := SetPrint(	cAlias		,cRel		,cPerg		,@cTitulo	,;
						cDesc1		,cDesc2		,cDesc3		,lDicion	,;
						aOrderns	,lCompres	,cTamanho	,{}			,;
						lFiltro		,lCrystal)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi cancelada a operacao (padrao)                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
	If LastKey()  == 27
		Return
	Endif
	
	cCodInt := mv_par01
	cCodEmp := mv_par02
	cMatric := mv_par03
	cNUMSE1 := mv_par04
	
	cQuery := " " 
	
	cQuery := " SELECT BD5010.R_E_C_N_O_ REGBD5 "
	cQuery += " FROM "+RetSQLName("BD5")+" BD5010, "+RetSQLName("BD6")+" BD6010 "
	cQuery += " WHERE BD6_FILIAL = '  ' "
	cQuery += " AND BD6_OPEUSR = '"+cCodInt+"' "
	cQuery += " AND BD6_CODEMP = '"+cCodEmp+"' "
	cQuery += " AND BD6_MATRIC = '"+cMatric+"' "
	cQuery += " AND BD6_ANOPAG = '2007' "
	cQuery += " AND BD6_MESPAG <= '08' "
	cQuery += " AND BD6_STAFAT = '0' "
	cQuery += " AND SubStr(BD6_CODPRO,1,2) = '99' "
	cQuery += " AND BD6_SEQPF <> ' ' "
	cQuery += " AND BD6_NUMFAT = 'BLQODONT' "
	cQuery += " AND BD5_FILIAL = '  ' "
	cQuery += " AND BD5_CODOPE = BD6_CODOPE "
	cQuery += " AND BD5_CODLDP = BD6_CODLDP "
	cQuery += " AND BD5_CODPEG = BD6_CODPEG "
	cQuery += " AND BD5_NUMERO = BD6_NUMERO "
	cQuery += " AND BD5010.D_E_L_E_T_ = ' ' "
	cQuery += " AND BD6010.D_E_L_E_T_ = ' ' "
	
	PLSQUERY(cQuery,"TRB")
	
	While !TRB->(Eof())
		BD5->(DbGoTo(TRB->REGBD5))
		BD5->(RecLock("BD5", .F.))
		BD5->BD5_NUMSE1 := 'PLS'+cNUMSE1+' DP '
		BD5->BD5_STAFAT = '0'
		BD5->BD5_OPEFAT = '0001'
		BD5->BD5_NUMFAT = 'BLQODONT'
		BD5->(MsUnlock()) 	    
		TRB->(DbSkip())
	Enddo
	
	TRB->(DBCloseArea())
	
	cQuery := " " 
	cQuery := " SELECT BD6010.R_E_C_N_O_ REGBD6 "
	cQuery += " FROM "+RetSQLName("BD6")+" BD6010 "
	cQuery += " WHERE BD6_FILIAL = '  ' "
	cQuery += " AND BD6_OPEUSR = '"+cCodInt+"' "
	cQuery += " AND BD6_CODEMP = '"+cCodEmp+"' "
	cQuery += " AND BD6_MATRIC = '"+cMatric+"' "
	cQuery += " AND BD6_ANOPAG = '2007' "
	cQuery += " AND BD6_MESPAG <= '08' "
	cQuery += " AND BD6_STAFAT = '0' "
	cQuery += " AND SubStr(BD6_CODPRO,1,2) = '99' "
	cQuery += " AND BD6_SEQPF <> ' ' "
	cQuery += " AND BD6_NUMFAT = 'BLQODONT' "
	cQuery += " AND D_E_L_E_T_ = ' ' "
	PLSQUERY(cQuery,"TRB")
	
	While !TRB->(Eof())
		BD6->(DbGoTo(TRB->REGBD6))
		BD6->(RecLock("BD6", .F.))
		BD6->BD6_NUMSE1 := 'PLS'+cNUMSE1+' DP '
		BD6->(MsUnlock()) 	    
		TRB->(DbSkip())
	Enddo
	
	TRB->(DBCloseArea())
	
	cQuery := " " 
	cQuery := " SELECT BDH010.R_E_C_N_O_ REGBDH "
	cQuery += " FROM "+RetSQLName("BDH")+" BDH010 "
	cQuery += " WHERE BDH_FILIAL = '  ' "
	cQuery += " AND BDH_CODINT = '"+cCodInt+"' "
	cQuery += " AND BDH_CODEMP = '"+cCodEmp+"' "
	cQuery += " AND BDH_MATRIC = '"+cMatric+"' "
	cQuery += " AND BDH_NUMFAT = 'BLQODONT' "
	cQuery += " AND D_E_L_E_T_ = ' ' "
	PLSQUERY(cQuery,"TRB")
	
	While !TRB->(Eof())
		BDH->(DbGoTo(TRB->REGBDH))
		BDH->(RecLock("BDH", .F.))
		BDH->BDH_NUMSE1 := 'PLS'+cNUMSE1+' DP '
		BDH->(MsUnlock()) 	    
		TRB->(DbSkip())
	Enddo
	
	TRB->(DBCloseArea())
	
	MsgAlert("Ajuste realizado para parametros repassados!")
	
Enddo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaSX1   ºAutor  ³ Jean Schulz        º Data ³  10/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria / atualiza parametros solicitados na geracao do boleto.º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("CodInt") 		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("CodEmp") 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Matric")		,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("E1_NUM") 		,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})

Return