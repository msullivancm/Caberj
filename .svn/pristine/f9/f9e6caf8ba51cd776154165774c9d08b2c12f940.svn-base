#Include "PROTHEUS.CH"
#Include "UTILIDADES.CH"
#INCLUDE "rwmake.ch"

/*-----------------------------------------------------------------------
| Funcao   | CABR184  | Autor | Otavio Pinto         | Data | 29/05/2015 |
|------------------------------------------------------------------------|
| Descricao| Consulta Transferencias de Protocolo de Atendimento         |
|------------------------------------------------------------------------|
|          |     |                                                       |
|          |     |                                                       |
 -----------------------------------------------------------------------*/

user function CABR184()

local aSalvAmb := {}
local aVetor   := {}
local oDlg     := Nil
local oLbx     := Nil
local cTitulo  := "Consulta Transferencias"  

private cCRLF     := CHR(13)+CHR(10)
private cStrSQL
private cAgencia := ""
private _cDirDocs   := MsDocPath()
private _cPath		:= "C:\TEMP\"
private _cArquivo  	:= "CABR184.csv"    // Alterada a extensão de TXT para CSV 

begin sequence

aSalvAmb := GetArea()

cAgencia := Alltrim(u_PegaCC( cUserName, 1 ))

/*-----------------------------------------------------------------------
| Montagem da query                                                      |
 -----------------------------------------------------------------------*/
cStrSQL := "  SELECT ZX_SEQ      PROTOCOLO " + cCRLF
cStrSQL += "       , ZX_CODINT||ZX_CODEMP||ZX_MATRIC||ZX_TIPREG||ZX_DIGITO  MATRICULA " + cCRLF
cStrSQL += "       , ZX_NOMUSR   NOME " + cCRLF 
cStrSQL += "       , ZY_DTSERV   DTINICIO " + cCRLF
cStrSQL += "       , ZY_USDIGIT  ATENDENTE " + cCRLF
cStrSQL += "       , ZY_YCUSTO   AGENCIA " + cCRLF
//cStrSQL += "      , ZY_SEQSERV  SEQUENCIA " + cCRLF
cStrSQL += " FROM "+RetSqlName("SZX")+" ZX " + cCRLF 
cStrSQL += "    , "+RetSqlName("SZY")+" ZY " + cCRLF 
cStrSQL += " WHERE ZX_FILIAL = ZY_FILIAL " + cCRLF
cStrSQL += "   AND ZX_SEQ    = ZY_SEQBA  " + cCRLF
cStrSQL += "   AND ZY_YCUSTO = '"+cAgencia+"' " + cCRLF
cStrSQL += "   AND ZX_TPINTEL = '1' " + cCRLF  // Pendentes
cStrSQL += "   AND ZY_YCUSTO = (SELECT ZY1.ZY_YCUSTO " + cCRLF
cStrSQL += "                    FROM "+RetSqlName("SZY")+" ZY1 " + cCRLF 
cStrSQL += "                    WHERE ZY_SEQBA = ZX.ZX_SEQ " + cCRLF
cStrSQL += "                      AND ZY_YCUSTO = ZY.ZY_YCUSTO " + cCRLF
cStrSQL += "                      AND ZY1.D_E_L_E_T_ = ' ' " + cCRLF
cStrSQL += "                      AND ZY_SEQSERV = (SELECT MAX(ZY2.ZY_SEQSERV)  " + cCRLF
cStrSQL += "                                        FROM "+RetSqlName("SZY")+" ZY2 " + cCRLF 
cStrSQL += "                                        WHERE ZY2.ZY_SEQBA = ZX.ZX_SEQ AND ZY2.ZY_YCUSTO = ZY.ZY_YCUSTO AND ZY2.D_E_L_E_T_ = ' '  ) " + cCRLF
cStrSQL += "                     ) " + cCRLF
cStrSQL += "   AND ZX.D_E_L_E_T_ = ' ' " + cCRLF
cStrSQL += "   AND ZY.D_E_L_E_T_ = ' '    " + cCRLF
cStrSQL += " ORDER BY PROTOCOLO " + cCRLF

/*-----------------------------------------------------------------------
| Escreve a query na pasta TEMP                                          |
 -----------------------------------------------------------------------*/
MemoWrite(Alltrim(_cPath)+"CABR184.SQL", cStrSQL)
                               
/*-----------------------------------------------------------------------
| Otimiza a query                                                        |
 -----------------------------------------------------------------------*/
cStrSQL := ChangeQuery( cStrSQL )                            

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        

TRB->( dbGoTop() )

// Se não encontrar nada, exibe mensagem e... sai.
if TRB->( Eof() )  

   Aviso( cTitulo, "Não há transferência(s) para a agencia "+upper(Alltrim(u_PegaCC( cUserName, 2 )))+" !", {"Ok"} )

   //MsgAlert("Não há transferência(s) para a agencia "+Alltrim(u_PegaCC( cUserName, 2 ))+" !"+CHR(13)+CHR(13)+; 
   //         "", "AVISO" )
   
   break  
endif   

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+
while TRB->( !Eof() )
   cDataIni := SUBSTR(TRB->DTINICIO,7,2)+"/"+SUBSTR(TRB->DTINICIO,5,2)+"/"+SUBSTR(TRB->DTINICIO,1,4)
   aAdd( aVetor, { TRB->PROTOCOLO,TRB->MATRICULA,TRB->NOME,cDataIni,TRB->ATENDENTE,TRB->AGENCIA } )
   TRB->( dbSkip() )
end

if Len( aVetor ) == 0
   Aviso( cTitulo, "Nao existe dados a consultar", {"Ok"} )
   break
endif

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,800 PIXEL

@ 10,10 LISTBOX oLbx FIELDS HEADER ;
   "Protocolo", "Matricula", "Nome","DT_Inicio","Atendente", "Agencia" ;  	//nome do cabecalho
   SIZE 380,095 OF oDlg PIXEL	

//define com qual vetor devera trabalhar
oLbx:SetArray( aVetor )
//lista o conteudo dos vetores, variavel nAt eh a linha pintada (foco) e o numero da coluna
oLbx:bLine := {|| {aVetor[oLbx:nAt,1],;
                   aVetor[oLbx:nAt,2],;
                   aVetor[oLbx:nAt,3],;
                   aVetor[oLbx:nAt,4],;
                   aVetor[oLbx:nAt,5],;
                   aVetor[oLbx:nAt,6]}}
	                    
DEFINE SBUTTON FROM 107,350 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

RestArea( aSalvAmb )

endsequence

return 

// Fim do CABR184.PRW