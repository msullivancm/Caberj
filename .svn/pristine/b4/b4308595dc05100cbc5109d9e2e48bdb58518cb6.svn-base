#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"

/*/
*****************************************************************************
***Programa  CABA153     * Autor * Motta             * Data *  jun/19     ***
*****************************************************************************
***Descricao * Cadastro de Auditores Medicos                              ***
*****************************************************************************
/*/

User Function CAB153M()

//********************************************************************** 
// Declaracao de Variaveis                                             *
//**********************************************************************

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PDA"

dbSelectArea("PDA")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Auditores Medicos - PLS",cVldExc,cVldAlt)

Return

User Function CAB153D()

//********************************************************************** 
// Declaracao de Variaveis                                             *
//**********************************************************************

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PDB"

dbSelectArea("PDB")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de Aud Med X RDA - PLS",cVldExc,cVldAlt)

Return

User Function CAB153S()

Local cRet := ""
local cQry := ""

	cQry := " SELECT LPAD((NVL(MAX(TO_NUMBER(PDA_CODIGO)),0)+1),3,'0') SEQ " + CRLF
	cQry += " FROM " + RetSqlName('PDA') + " PDA " + CRLF
	cQry := ChangeQuery(cQry) 
	//memowrite("C:\TEMP\CABA153S.TXT",cQry) 

	If Select("TMPSeqPDA") > 0
      dbSelectArea("TMPSeqPDA")
      dbclosearea()
    Endif 
    TCQuery cQry Alias "TMPSeqPDA" New  
    TMPSeqPDA->(dbGoTop())
    While !TMPSeqPDA->(EOF())
      cRet :=  TMPSeqPDA->SEQ	
      TMPSeqPDA->(DbSkip()) 
    Enddo  
    dbclosearea()

Return cRet 
