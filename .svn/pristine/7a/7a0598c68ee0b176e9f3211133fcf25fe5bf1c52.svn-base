#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"  
#INCLUDE "TOTVS.CH"  

#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRIAFJW  ºAutor  ³ Altamiro	           º Data ³   22/10/2020º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ INSERIR DADOS NAS TABELAS DE INSS RETENÇÃO OUTRAS FONTES   º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CRIAFWJ()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//PRIVATE cPath  := ""                        

local cQuery := ' '

PRIVATE cAlias := "SE2" 

PRIVATE cPerg	:= "CABA409"

PRIVATE cNomeProg   := "CABA181"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de Liberação Titulos de Comissão"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "CABA181"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Controle de Liberação de Titulos Comercial"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
Private cFiltro     := ' '
private cDthr       := (dtos(DATE()) + "-" + Time()) 
private _cUsuario   := subStr(cUSUARIO,7,15)  
Private cAliastmp   := GetNextAlias()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
/*
cQuery := CRLF + "  SELECT A2_filial  Filial  , "
cQuery += CRLF + "         BAU_CODSA2 CodFor  , "
cQuery += CRLF + "         a2_loja    lojaFor , "
cQuery += CRLF + "         A2_NOME    Nomefor , "
cQuery += CRLF + "         '000001'   Seq     , "
cQuery += CRLF + "         BBC_VLDINI valinic , "
cQuery += CRLF + "         BBC_VLDFIM Valfim  , "
cQuery += CRLF + "         ' '        entida  , "
cQuery += CRLF + "         '1'        tppessoa, "
cQuery += CRLF + "         BBC_CNPJ   CNPJ    , "
cQuery += CRLF + "         BBC_VALOR  VALORB  , "
cQuery += CRLF + "         671.12     INSS "
        
cQuery += CRLF + "    FROM BBC020 BBC , SA2020 BAU, BAU020 BAU "
cQuery += CRLF + "   WHERE BBC_FILIAL = ' ' AND BBC.D_e_l_e_t_ = ' ' "
cQuery += CRLF + "     AND BBC_VLDFIM >= '20201001' "
//cQuery += CRLF + "      OR BBC_VLDFIM = ' ') "
cQuery += CRLF + "     AND BBC_CODIGO = BAU_CODIGO " 
cQuery += CRLF + "     AND A2_COD = BAU_CODSA2 "
 

cQuery := CRLF + "    SELECT COMPTE          compte  , "
cQuery += CRLF + "           OPER            oper    , "
cQuery += CRLF + "      TRIM(MATRIC)         matric  , "
cQuery += CRLF + "           CODLAN          codlan  , "
cQuery += CRLF + "           CODLINT         codlint , "
cQuery += CRLF + "           CODPLA          codpla  , "
cQuery += CRLF + "           DATAREAL        datareal, "
cQuery += CRLF + "           IDPROF          idprof  , "
cQuery += CRLF + "      TRIM(CODRDA)         codrda  , "
cQuery += CRLF + "           PROJET          projet  , "
cQuery += CRLF + "           CODTAB          codtab  , "
cQuery += CRLF + "           CODPRO          codpro  , "
cQuery += CRLF + "           DATAPRE         datapre , "
cQuery += CRLF + "           NVL(LANCAB,' ') lancab
cQuery += CRLF + "           FROM  siga.moviw "   
 */    


cQuery := CRLF + "   select e2_prefixo prefixo ,e2_num num , e2_parcela parcela  , e2_tipo tipo , e2_fornece fornece,"
cQuery += CRLF + "          substr(e2_vencrea,7,2)||'/'||substr(e2_vencrea,5,2)||'/'||substr(e2_vencrea,1,4) VENCRA, "
cQuery += CRLF + "          nvl(pby_qtdpar, 0) qtdtotp , nvl(pby_proces, ' ') demada "
cQuery += CRLF + "     from se2020 se2 ,  PBY020 pby "
cQuery += CRLF + "    where e2_filial      = '01' and se2.d_E_L_E_T_    = ' ' "
cQuery += CRLF + "      and pby_filial(+)  = ' '  and pby.d_E_L_E_T_(+) = ' ' "
cQuery += CRLF + "      and e2_prefixo     = 'RPD' "
cQuery += CRLF + "      AND E2_Saldo       = e2_valor "
cQuery += CRLF + "      and pby_prefpg(+)  = e2_prefixo "  
cQuery += CRLF + "      and PBY_TITPGT(+)  = e2_num "
cQuery += CRLF + "      and pby_parcpg(+)  = e2_parcela "
cQuery += CRLF + "      and pby_tipopg(+)  = e2_tipo"
cQuery += CRLF + "      and pby_codfor(+)  = e2_fornece " 

If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   

(cAliastmp)->(dbGoTop()) 

DBSelectArea('PEB')    

If (cAliastmp)->(!EOF())    
   
   Do while !(cAliastmp)->(eof()) 

            RecLock("PEB",.T.)

               PEB_FILIAL   := xFilial("PEB")  
               PEB_DEMAND   := (cAliastmp)->demada 

               PEB_PREFIX   := (cAliastmp)->prefixo 
               PEB_NUM      := (cAliastmp)->num
               PEB_PARCEL   := (cAliastmp)->parcela
               PEB_TIPO     := (cAliastmp)->tipo
               PEB_FORNEC   := (cAliastmp)->fornece 
               PEB_VLRTIT   := 0.00  
               PEB_VLRAJA   := 0.00   
               PEB_VLRAJD   := 0.00   
               PEB_DATAAJ   := CtoD("  /  /    ")  
               PEB_USARAR   := ' ' //_cIdUsuar +' - '+_cUsuario + ' - ' + cDthr  
               PEB_MODCAL   := '2'   
               PEB_VENC     := CtoD((cAliastmp)->VENCRA)
               PEB_PARTOT   := (cAliastmp)->qtdtotp
               
            Msunlock("PEB")

            (cAliastmp)->(DbSkip())

   
	//
  /*
  RECLOCK("PE8", .T. )

PE8_FILIAL   :=  xFilial('PE8')   
PE8_COMPTE   := (cAliastmp)->COMPTE   
PE8_OPER     := (cAliastmp)->OPER  
PE8_MATRIC   := (cAliastmp)->MATRIC 
PE8_CODLAN   := (cAliastmp)->CODLAN  
PE8_CODLIN   := (cAliastmp)->CODLINT  
PE8_CODPLA   := (cAliastmp)->CODPLA   
PE8_DTREAL   := (cAliastmp)->datareal  
PE8_IDPROF   := (cAliastmp)->idprof   
PE8_CODRDA   := (cAliastmp)->CODRDA   
PE8_PROJET   := (cAliastmp)->PROJET   
PE8_CODTAB   := (cAliastmp)->CODTAB   
PE8_CODPRO   := (cAliastmp)->CODPRO 
PE8_DTPRE    := (cAliastmp)->DATAPRE  
PE8_LANCAB   := (cAliastmp)->LANCAB  
  
 (MSUNLOCK())

 (cAliastmp)->(DbSkip())
 */
    /*
      RECLOCK("FLX", .T. )

         FLX_FILIAL := (cAliastmp)->Filial  
         FLX_FORNEC := (cAliastmp)->CodFor  
         FLX_LOJA   := (cAliastmp)->lojaFor 
         FLX_NOME   := (cAliastmp)->Nomefor 
         FLX_ITEM   := trim((cAliastmp)->Seq)     
         FLX_DTINI  := stod((cAliastmp)->valinic) 
         FLX_DTFIM  := stod((cAliastmp)->Valfim)  
         FLX_ENTIDA := (cAliastmp)->entida  
         FLX_TIPO   := (cAliastmp)->tppessoa
         FLX_CNPJ   := (cAliastmp)->CNPJ    
         FLX_BASE   := (cAliastmp)->VALORB  
         FLX_INSS   := (cAliastmp)->INSS 

     (MSUNLOCK())

      RECLOCK("FJW", .T. )
      
         FJW_FILIAL := (cAliastmp)->Filial  
         FJW_FORNEC := (cAliastmp)->CodFor  
         FJW_LOJA   := (cAliastmp)->lojaFor 
         FJW_NOME   := (cAliastmp)->Nomefor 

	  (MSUNLOCK())

	(cAliastmp)->(DbSkip())
   */
	//    
	EndDo

EndIf

Return()  
