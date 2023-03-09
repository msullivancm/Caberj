 //////////////////////////////////////////////
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"  
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"
#include "SIGAWIN.CH"
#Include "Ap5Mail.Ch"  
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "Tbiconn.ch"
#INCLUDE "Fileio.ch"


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function caba178()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    
	Private cDemanda   := Space(25)
	Private cGetEmpres := Space(40)
	Private cGetProced := Space(30)
	Private cGetRDA    := Space(40)
	Private cGetSenha  := Space(TAMSX3("PD2_SENHA")[1]) //Angelo Henrique - Data: 12/06/19
	Private cGetUsuari := Space(50)

	private dDatlib    := ' '
	PRIVATE nSenhaAux1 := ' '
	private cProcedm   := Space(30)
    Private recsenha   := 0   
    Private cSenhaux   := Space(TAMSX3("PD2_SENHA")[1]) //Angelo Henrique - Data: 12/06/19
    private cOrigem    := ' ' 
	PRIVATE cAliastmp   := GetNextAlias()    

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oPanel1","oSay1","oSay6","oRMenu1","oCBoxInt","oCBoxLib","oGetSenha","oGrp1","oSay2")
SetPrvt("oSay4","oSay5","oGetEmpresa","oGetUsuario","oGetRDA","oGetProcedim","oGrp2","oBtn1","oBtn3")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

oDlg1      := MSDialog():New( 326,469,613,1025,"Associação de Numero da Demanda a Senha de Internação ",,,.F.,,,,,,.T.,,,.T. )
oPanel1    := TPanel():New( 000,000," ",oDlg1,,.F.,.F.,,,272,136,.T.,.F. )

oSay1      := TSay():New( 040,004,{||"Senha "},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay6      := TSay():New( 040,132,{||"Num. Demanda"},oPanel1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)


oPanel2    := TPanel():New( 004,004,"                                       I N T E R N A Ç Ã O",oPanel1,,.F.,.F.,,,172,032,.T.,.F. )
	   
oGetSenha  := TGet():New( 040,032,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BE4SEN","cGetSenha",,)		
    
//   oGetSenha  := TGet():New( 040,032,{|u| If(PCount()>0,cGetSenha:=u,cGetSenha)},oPanel1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BEASEN","cGetSenha",,)
 
 oGetSenha:bLostFocus:={||fValSen(cGetSenha)}  

oGrp1      := TGroup():New( 052,000,136,272,"Identificação ",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay2      := TSay():New( 060,004,{||"Empresa "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay3      := TSay():New( 080,004,{||"Usuario "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay4      := TSay():New( 100,004,{||"RDA"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSay5      := TSay():New( 120,004,{||"Procedimento "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oGetEmpres := TGet():New( 060,037,{|u| If(PCount()>0,cGetEmpresa:=u,cGetEmpresa)},oGrp1,232,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetEmpresa",,)
oGetUsuari := TGet():New( 079,037,{|u| If(PCount()>0,cGetUsuario:=u,cGetUsuario)},oGrp1,231,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetUsuario",,)
oGetRDA    := TGet():New( 098,037,{|u| If(PCount()>0,cGetRDA:=u,cGetRDA)},oGrp1,231,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetRDA",,)
oGetProced := TGet():New( 119,037,{|u| If(PCount()>0,cGetProcedim:=u,cGetProcedim)},oGrp1,231,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cGetProcedim",,)
oGrp2      := TGroup():New( 000,180,036,272,"Ações ",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 008,184,"&Grava",oGrp2,{||fgravaReg()},084,012,,,,.T.,,"",,,,.F. )
oBtn3      := TButton():New( 021,184,"&Sair",oGrp2,{||oDlg1:End()},084,012,,,,.T.,,"",,,,.F. )
oGet1      := TGet():New( 040,176,{|u| If(PCount()>0,cDemanda:=u,cDemanda)},oPanel1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"PBWAUT","cDemanda",,)
oGet1:bLostFocus:={||oBtn1:SetFocus()}


oDlg1:Activate(,,,.T.)

Return()


static function fZeraVar() 
	
	cGetEmpres := Space(40)
	cGetProced := Space(30)
	cGetRDA    := Space(40)
//	cGetSenha  := Space(15)
	cGetUsuari := Space(50)

	//oGetSenha:Refresh()
	oGetEmpres:Refresh() 
	oGetUsuari:Refresh() 
	oGetRDA:Refresh()   
	oGetProced:Refresh()

Return()

static function fValSen(cSenha1)
	
	local ret:=.T.
	//local cAliastmp      := GetNextAlias()
	Private cQuery       := ""
	//Default cSenha1      := ''  


/*			
			cQuery := "  Select 'SADT' ORIG , bea_senha SENHA ,"
			cQuery += CRLF+ " bea_codrda CODRDA, bea_nomrda NOMRDA, "
			cQuery += CRLF+ " bea_codemp CODEMP, bea_matric MATRIC, bea_tipreg TIPREG, bea_nomusr NOMUSR, "
			cQuery += CRLF+ " bg9_descri DESCEMP, "
			cQuery += CRLF+ " bea_mespag MESPAG, bea_anopag ANOPAG, "
			cQuery += CRLF+ " bea_descid DESCID , "
			cQuery += CRLF+ " bea_tipo  TIPO ,  "
			cQuery += CRLF+ " BEA_XDTLIB XDTLIB ,"
			cQuery += CRLF+ " BEA_YPROJU DEMAN , "
            cQuery += CRLF+ " BEA.R_E_C_N_O_ recno "

			cQuery += CRLF+ "  from  " + RetSqlName("BEA") +" BEA ,  "+ RetSqlName("BG9") +" BG9 "
			cQuery += CRLF+ " where BEA_filial = '"+xFilial('BEA')+ "' and BEA.d_E_L_E_T_ = ' ' "
			cQuery += CRLF+ "   AND BG9_filial = '"+xFilial('BG9')+ "' and BG9.d_E_L_E_T_ = ' ' "
			cQuery += CRLF+ "   and bg9_codigo = bea_codemp  "
			cQuery += CRLF+ "   and bea_codldp <> '0000' "
			cQuery += CRLF+ "   and BEa_senha = '"+trim(cGetSenha)+"' "
			
*/

			cQuery := " Select 'INTE' ORIG,  BE4_senha SENHA , "
			cQuery += CRLF+ "BE4_codrda CODRDA, BE4_nomrda NOMRDA , "
			cQuery += CRLF+ "BE4_codemp CODEMP, BE4_matric MATRIC, BE4_tipreg TIPREG, BE4_nomusr NOMUSR , "
			cQuery += CRLF+ "bg9_descri DESCEMP , "
			cQuery += CRLF+ "BE4_mespag MESPAG, BE4_anopag ANOPAG , "
			cQuery += CRLF+ "BE4_descid DESCID, "
			cQuery += CRLF+ "BE4_XDTLIB  XDTLIB , "
			cQuery += CRLF+ "BE4_YPROJU DEMAN ," 
            cQuery += CRLF+ "BE4.R_E_C_N_O_ recno "
			cQuery += CRLF+ "  from  " + RetSqlName("BE4") +" BE4 ,  "+ RetSqlName("BG9") +" BG9 "
			cQuery += CRLF+ "where BE4_filial = '  ' and BE4.d_E_L_E_T_ = ' ' "
			cQuery += CRLF+ "AND BG9_filial = '  ' and BG9.d_E_L_E_T_ = ' ' "
			cQuery += CRLF+ "and bg9_codigo = BE4_codemp "
//			cQuery += CRLF+ "and be4_codldp <> '0000' "
			cQuery += CRLF+ "and BE4_senha = '"+trim(cSenha1)+"' "
		
	If Select((cAliastmp)) <> 0
			(cAliastmp)->(DbCloseArea())
	Endif
		
	TCQuery cQuery New Alias (cAliastmp)
	
	If (cAliastmp)->(Eof())//Select((cAliastmp)) == 0
		msgBox("Senha inexistente na base" ,"Verifique o Número da Senha !!!!!","INFO")
		oGetSenha:SetFocus()
	Else
        
		cGetEmpresa := (cAliastmp)->DESCEMP
		cGetUsuario := (cAliastmp)->NOMUSR
		cGetRDA     := (cAliastmp)->NOMRDA
		cGetProcedim:= (cAliastmp)->DESCID
		dDatlib     := (cAliastmp)->XDTLIB
		cProcedm    := (cAliastmp)->DESCID
		cDemanda    := (cAliastmp)->DEMAN
		recsenha    := (cAliastmp)->recno
        
		cOrigem     := trim((cAliastmp)->ORIG)
		
		oGetEmpres  :refresh()
		oGetUsuari  :refresh()
		oGetRDA     :refresh()
		oGetProced  :refresh()
	    oGet1	    :refresh()	
   
	EndIf
	
Return()

static function fgravaReg()
If  msgyesno("Deseja Gravar o Numero da Demanda na Senha ")

    fGrvproc(recsenha , cDemanda, cOrigem)
  
EndIf
 

Return()

static function fGrvproc(recarq , cdeman, origem)
 
			dbSelectArea("BE4")

			   DBGOTO(RECARQ)            
		
			RecLock("BE4",.F.)
				
				BE4->BE4_YPROJU  := cDemanda
				
			BE4->(MsUnlock())

/*
			dbSelectArea("BEA")

			BEA->(DBGOTO(RECARQ))            
		
				RecLock("BEA",.F.)
				
			BEA->BEA_YPROJU  := cDemanda
				
			BEA->(MsUnlock())	
				
*/ 

	msgAlert(" Numero da Demanda gravada na Senha !!!")
   
    oDlg1:End()

Return()
	

