#include "topconn.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MMXA064   ºAutor  ³Wellington Tonieto  º Data ³  10/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta tela com tabelas cadastradas na rotina MMX64CAD()    º±±
±±º          ³ para consulta registros de log fo audit Trail              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

******************************               
User Function CABR126()
******************************
Local oDlg       := Nil
Local oFont      := Nil
Local oChk       := Nil
Local oLbx2      := Nil
Local dDataFim   := dDataBase
Local dDataIni   := dDataBase
Local cPesq      := Space(40)
Local aGrupoUsr
Local nchave     := 0
Local cTitulo    := "Consulta Tabelas de Log"
Private aVetTables := {}


DbSelectArea("PBO")
DbSetOrder(1)

CursorArrow()
MontaVet()

DEFINE FONT oFont NAME "Ms Sans Serif" BOLD
DEFINE MSDIALOG oDlg TITLE "Consulta Log de Registros " FROM 0,0 TO 290,480 OF oDlg PIXEL

@ 004,12 TO 100,228 LABEL "Tabela para consulta"   OF oDlg PIXEL

@ 10,15 LISTBOX oLbx2 FIELDS HEADER "Tabela", "Descrição" SIZE 208,085 OF oDlg PIXEL
oLbx2:SetArray( aVetTables )
oLbx2:bLine := {|| {aVetTables[oLbx2:nAt,1],aVetTables[oLbx2:nAt,2]}}

@ 105, 015 SAY   "Pequisar Por..:"     SIZE 45,8   OF oDlg PIXEL FONT oFont
@ 103, 070 MSGET cPesq   PICTURE "@!"  SIZE 120,10 OF oDlg PIXEL FONT oFont


DEFINE SBUTTON FROM 120, 085 TYPE  14 ACTION ( BRWA064(aVetTables[oLbx2:nAt,1]),oDlg:end()) ENABLE OF oDlg
DEFINE SBUTTON FROM 120, 125 TYPE  2  ACTION oDlg:end()  ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MMXA064   ºAutor  ³Microsiga           º Data ³  10/10/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

*******************************
Static Function BRWA064(cAlias)
*******************************

Private aRotina := {{"Pesquisar   "  , "AxPesqui"       ,0,1} ,;
                    {"Visualizar  "  , "AxVisual"       ,0,2} ,;
                    {"Consulta Log"  , "MSAguarde({|| U_FcLog('" + cAlias + "') },'Aguarde... Consultado Tabela de Logs.')",0,3}}

DbSelectArea(cAlias)
cCadastro := "Log de registros"
MBrowse(006,001,022,075,cAlias,,,,,1,)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MMXA064   ºAutor  ³Wellington Tonieto  º Data ³  10/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que mostra resultado da consulta log do              º±±
±±º          ³Audit Trail.                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

****************************
User Function FcLog(cAlias)
****************************
Local cQuery    := " "

// Local cPathBD   := AllTrim(SuperGetMv("MV_XPTLOG")) //CRIAR LINK
// Local cIpBD     := AllTrim(SuperGetMv("MV_XIPLOG"))     
// Local cPorta    := GetMv("MV_XPORTA")

Local nRecnoTmp := &(CaLIAS)->(RECNO())

//Local _nLink    := TCLink(cPathBD,cIpBD, cPorta)
Local oDlg      := Nil
Local oLbx      := Nil
Local cTitulo   := "Consulta Log de registros"
Local aVetDados := {}
Local nPosV     := 0


cQuery := "  SELECT AT_NAME, AT_TIME, AT_DATE, AT_OP, AT_TABLE, AT_RECID, AT_FIELD, AT_CONTENT, AT_ID , AT_NEWCONT "
cQuery += "  FROM adt.AUDIT_TRAIL@adt_dblink "
cQuery += "  WHERE  AT_RECID = '" + Alltrim(str(nRecnoTMP,6)) + "' AND AT_TABLE like '" + RetSqlName(cAlias) + "%'" // '" + Alltrim(str(nRecnoTMP,6)) + "'
cQuery += "  ORDER BY AT_DATE "

TcQuery cQuery Alias "TLOG" New

memowrit("C:\TEMP\at.SQL",cQuery)
While !eof()
	
	aAdd(aVetDados,{Alltrim(TLOG->AT_NAME),STOD(TLOG->AT_DATE),TLOG->AT_TIME,fDescOp(TLOG->AT_OP),Substr(TLOG->AT_FIELD,1,10),TLOG->AT_CONTENT,;
				TLOG->AT_NEWCONT  })
	
	DbSkip()     
	
Enddo

If Len(aVetDados) == 0
	Aviso( cTitulo, "Nao existe Log para o registro selecionado!", {"Ok"} )
	TLOG->( dbCloseArea() )
	Return
Endif   

TLOG->( dbCloseArea() )

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 300,670 PIXEL

@ 10,10 LISTBOX oLbx FIELDS HEADER "Usuario", "Data", "Hora", "Operacao", "Campo" , "Valor Anterior" , "Valor Novo";
SIZE 320,115 OF oDlg PIXEL

oLbx:SetArray( aVetDados )
oLbx:bLine := {|| {aVetDados[oLbx:nAt,1],;
aVetDados[oLbx:nAt,2],;
aVetDados[oLbx:nAt,3],;
aVetDados[oLbx:nAt,4],;
aVetDados[oLbx:nAt,5],;
aVetDados[oLbx:nAt,6],;
aVetDados[oLbx:nAt,7]}}

DEFINE SBUTTON FROM 135,305 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTER

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MMXA064   ºAutor  ³Microsiga           º Data ³  10/13/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela modelo2 para cadastro de grupos e tabelas para log do  º±±
±±º          ³Audit Trail.                                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

************************
User Function MMX64CAD()
************************

Private cCadastro := "Cadastro de Tabelas para Log"
Private cDelFunc  := ".T."
Private aRotina   := {  {"Pesquisar ","AxPesqui     ",0,1} ,;
                        {"Visualizar","U_INCMMX064('V')",0,2} ,;
                        {"Incluir   ","U_INCMMX064('I')",0,3} ,;
                        {"Alterar   ","U_INCMMX064('A')",0,4} ,;
                        {"Excluir   ","AxDeleta        ",0,5} }

//fAtuGrp() //Atualizar Tabela de grupos para consulta.

dbSelectArea("PBO")
mBrowse( 6,1,22,75,"PBO")

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MMXA064   ºAutor  ³Microsiga           º Data ³  10/23/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function INCMMX064(_cOp)

Local _l := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_nGrupo  := 0
_nDescGr := 0
_nTabela := 0
_nDescTb := 0
_sAlias  := Alias()
_sRec    := Recno()
cObs     := Space(40)
nopcx    := If(inclui .or. Altera,3,1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("Sx3")
dbSetOrder(1)
dbSeek("PBO")
nUsado  :=0
aHeader := {}
While !Eof() .And. (x3_arquivo == "PBO")
	If  AllTrim(X3_CAMPO)== "PBO_USUARI" .Or. AllTrim(X3_CAMPO)=="PBO_NOME  " .Or. AllTrim(X3_CAMPO)== "PBO_OBS"
		dbSkip()
		Loop
	Endif
	IF X3USO(x3_usado) .AND. cNivel >= x3_nivel
		nUsado:=nUsado+1
		cNome := AllTrim(X3_CAMPO)
		AADD(aHeader,{ TRIM(x3_titulo), AllTrim(x3_campo), x3_picture,;
		x3_tamanho, x3_decimal, x3_vlduser, x3_usado, x3_tipo, x3_arquivo, x3_context } )
	Endif
	dbSkip()
End
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF _cOp == "I"
	
	aCols:=Array(1,nUsado+1)

	dbSelectArea("Sx3")
	dbSeek("PBO")
	nUsado:=0
	While !Eof() .And. (x3_arquivo == "PBO")
		If AllTrim(X3_CAMPO) == "PBO_USUARI" .Or. AllTrim(X3_CAMPO)=="PBO_NOME  " .Or. AllTrim(X3_CAMPO)=="PBO_OBS"
			dbSkip()
			Loop
		Endif
		IF X3USO(x3_usado) .And. cNivel >= x3_nivel
			IF nOpcx == 3
				nUsado:=nUsado+1
				IF x3_tipo == "C"
					aCOLS[1][nUsado] := SPACE(x3_tamanho)
				Elseif x3_tipo == "N"
					aCOLS[1][nUsado] := 0
				Elseif x3_tipo == "D"
					aCOLS[1][nUsado] := dDataBase
				Elseif x3_tipo == "M"
					aCOLS[1][nUsado] := ""
				Else
					aCOLS[1][nUsado] := .F.
				Endif
			Endif
		Endif
		dbSkip()
	End
	aCOLS[1][nUsado+1] := .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Variaveis do Cabecalho do Modelo 2                           ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      cUsuar   := Space(06)
      cDescgr  := Space(30)
      cObs     := Space(40) 
Else
	aCols   := {}
	cUsuar  := PBO->PBO_USUARI
	cDescgr := PBO->PBO_NOME  
	cObs    := PBO->PBO_OBS
	
	PBO->(DBSEEK(xFilial("PBO")+ cUsuar))
	While !EOF() .And. cUsuar == PBO->PBO_USUARI
		aAdd(aCols,{PBO->PBO_TABELA,PBO->PBO_DESCTB,.F.})
		PBO->(dbSkip())
	EndDo

Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo:="Cadastro de Logs"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}

AADD(aC,{"cUsuar " ,{15,03} ,"C¢digo  do  Grupo   ","@!" ,'ExistChav("PBO",cUsuar)',"XL_",IIf(_cOp == "I",.T.,.F.)})//
AADD(aC,{"cDescGr" ,{30,03} ,"Descrição do Grupo","@!" ,,,IIf(nOpcx == 1,.T.,.F.)})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
AADD(aR,{"cObs" ,{95,03},"Observa‡„o"    ,"@!",,,})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCGD:={50,04,90,105} //50,04,70,95
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk := 'AllwaysTrue()' //"ExecBlock('Y1LINOK',.f.,.f.)"
cTudoOk  := 'AllwaysTrue()' //"ExecBlock('Y1TUDOK',.f.,.f.)"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

_nTabela := aScan(aHeader,{|x| x[2]=="PBO_TABELA" })
_nDescTb := aScan(aHeader,{|x| x[2]=="PBO_DESCTB" })

IF _cOp == "V"
	dbSelectArea(_sAlias)
	dbGoto(_sRec)
	Return
Else
	
	If lRetMod2 // Gravacao. . .
		For _l := 1 To Len(aCols)
			If !aCols[_l,Len(aHeader)+1]
				DbSelectArea("PBO")
				DbSetOrder(1)
				If !dbSeek(xFilial("PBO")+cUsuar+ aCols[_l,_nTabela ])
				    RecLock("PBO",.T.)
				Else
				    RecLock("PBO",.F.)
				Endif    
				PBO->PBO_FILIAL  := xFilial("PBO")
				PBO->PBO_USUARI  := __cUserId   //aCols[_l,_nGrupo  ]
				PBO->PBO_NOME    := UsrFullName( __cUserId )  //aCols[_l,_DescGrp ]
				PBO->PBO_TABELA  := aCols[_l,_nTabela ]
				PBO->PBO_DESCTB  := aCols[_l,_nDescTb ]
				PBO->PBO_OBS         := cObs
				MsUnLock()
			Else
				dbSelectArea("PBO")
				dbSetOrder(1)
				If dbSeek(xFilial("PBO")+cUsuar+ aCols[_l,_nTabela ])
					RecLock("PBO",.F.)
					dbDelete()
					MsUnLock()
				Endif
			EndIf
		Next _l
	Endif
Endif
dbSelectArea(_sAlias)
dbGoto(_sRec)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MMXA064   ºAutor  ³Microsiga           º Data ³  10/26/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fAtuGrp()

Local aAllGroup := AllGroups()
Local cTabGrp   := "XL" //AllTrim(SuperGetMv("MV_XTABGRP"))
Local I         := 0

DbSelectArea("SX5")
DbSetOrder(1)

For I := 1 To Len(aAllGroup)
   If !DbSeek(xFilial("SX5")+cTabGrp+aAllGroup[I][1][1])
       RecLock("SX5",.T.)
       X5_FILIAL  := xFilial("SX5")
       X5_TABELA  := cTabGrp
       X5_CHAVE   := aAllGroup[I][1][1]
       X5_DESCRI  := aAllGroup[I][1][2]
       X5_DESCSPA := aAllGroup[I][1][2]
       X5_DESCENG := aAllGroup[I][1][2]
       MsUnlock()
   Endif
Next

Return   

**************************
Static Function fDescOp(_cOp)
**************************

If _cOp == "I"
   cRet := "INCLUIDO"
ElseIf _cOp == "U"       
   cRet := "ALTERADO"
ElseIf _cOp == "D"       
   cRet := "DELETADO"
Else
   cRet := "TRANSACAO"
Endif

Return cRet      

**'----------------------------------------------------------------------------------------------------'**
Static Function MontaVet()
**'----------------------------------------------------------------------------------------------------'**

	Local c_Emp	   	:= ''	
	Local a_Area	:= GetArea()                   
	Local c_Qry 	:= ""
	
	c_Qry := " select distinct substr(at_table, 1, 3) tabela     "
	c_Qry += " from adt.AUDIT_TRAIL@adt_dblink  "
   //	c_Qry += " group by substr(at_table, 1, 3)  "
	c_Qry += " order by 1  "

	TCQUERY c_Qry ALIAS "QRYLIT" NEW	
	
	While !QRYLIT->( EOF() )          

  		aAdd(aVetTables,{ trim(QRYLIT->tabela),RetNomTab( QRYLIT->tabela ) } )
		
		QRYLIT->( dbSkip() )
	
	EndDo

	QRYLIT->( dbCLoseArea() )

Return Nil

Static Function RetNomTab( c_Alias )

	Local a_AreaX2  := SX2->( GetArea() )	
    Local c_Ret 	:= ""

	dbSelectArea("SX2")
	dbSetOrder(1)
	If dbSeek( c_Alias )

		c_Ret	:= X2Nome()

	EndIf 
	
	RestArea( a_AreaX2 )
	
Return c_Ret

Static Function fPegaCont(c_Tabela, c_Campo, n_Recno)

	Local c_Ret        
	Local a_Area := GetArea(c_Tabela)
	
	If !Empty(c_Campo)
		
		dbGoto( n_Recno )
		c_Ret :=   &(c_Tabela + '->' + c_Campo)
	
	EndIf
	
	
Return c_Ret