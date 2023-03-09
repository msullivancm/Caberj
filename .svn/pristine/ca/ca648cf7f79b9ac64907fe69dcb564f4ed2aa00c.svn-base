/*********************************** */
#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"                                                                                   
#Include "Ap5Mail.Ch"      
#Include 'Tbiconn.ch'           
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

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

User Function CABA224()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCCompte   := ' '
Private cEqExec   
Private cEqVend   

Private nQtdaCol   := 0
Private nVlrTot    := 0

Private _cUsuario    := SubStr(cUSUARIO,7,15)
private cDthr        := (dtos(DATE()) + "-" + Time())    

Private _cIdUsuar    := RetCodUsr()

private aDados       := {}


PRIVATE cAliastmp    := GetNextAlias()
PRIVATE cAliastmp1   := GetNextAlias()
PRIVATE cAliastmp2   := GetNextAlias()

private cCompeFol    :=  dtos(DATE()) //GetNewPar("MV_COTFOL"," ")   
PRIVATE    cAno      := ' ' 
PRIVATE    cMes      := ' '

   //cAno         := Substr(cCompeano,1,4) 
   //cMes         := Substr(cCompemes,5,2)

    //Processa({||Processa1()},"Buscando Dados no Servidor", "Comissão Colaboradores, Guarde ....", .T.)   

    fMontatela()

    MsgInfo("Processo finalizado")

return()

Static Function fMontatela()


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private cCompte    := Space(7)
Private nEmpresa  
Private nQtdGuiaR  := 0
Private nQtdGuiaS  := 0
Private nQtdGuiaT  := 0
Private nVlrCobrR  := 0
Private nVlrCobrS  := 0
Private nVlrCobrT  := 0
Private nVlrCustoR := 0
Private nVlrCustoS := 0
Private nVlrCustoT := 0
Private nVlrDifR   := 0
Private nVlrDifS   := 0
Private nVlrDifT   := 0

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg224","oGrp1","oBtn1","oBtn2","oBtn3","oGrp2","oSay1","oSay2","oSay3","oSay5","oGet1","oGet2")
SetPrvt("oGet4","oGrp3","oSay8","oGet6","oRMenu1","oGrp4","oSay4","oSay6","oSay7","oSay9","oGet5","oGet7")
SetPrvt("oGet9","oGrp5","oSay10","oSay11","oSay12","oSay13","oGet10","oGet11","oGet12","oGet13")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg224    := MSDialog():New( 099,275,617,986,"Parameteros e Status da Atualização das guias Riwa e Serjus",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,004,032,344,"Controles",oDlg224,CLR_BLACK,CLR_WHITE,.T.,.F. )

oBtn1      := TButton():New( 012,020,"Relatorio de Guias(Excel)",oGrp1,{||fExcel(), oDlg224:End()},068,012,,,,.T.,,"",,,,.F. )

oBtn2      := TButton():New( 012,142,"Atualiza Valores",oGrp1,{||fAtualiza(), oDlg224:End()},068,012,,,,.T.,,"",,,,.F. )

oBtn3      := TButton():New( 012,264,"Sair",oGrp1,{||oDlg224:End()},068,012,,,,.T.,,"",,,,.F. )

oGrp2      := TGroup():New( 080,004,136,344,"Dados das Guias - Serjus ",oDlg224,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 094,044,{||"Quant. Guias"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay2      := TSay():New( 094,124,{||"Valor Custo "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay3      := TSay():New( 094,196,{||"Valor Cobrando "},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay5      := TSay():New( 094,297,{||"Diferença"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oGet1      := TGet():New( 108,020,{|u| If(PCount()>0,nQtdGuiaS:=u,nQtdGuiaS)},oGrp2,060,008,'@E 999,999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdGuiaS",,)
oGet2      := TGet():New( 108,102,{|u| If(PCount()>0,nVlrCustoS:=u,nVlrCustoS)},oGrp2,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCustoS",,)
oGet3      := TGet():New( 108,184,{|u| If(PCount()>0,nVlrCobrS:=u,nVlrCobrS)},oGrp2,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCobrS",,)
oGet4      := TGet():New( 108,266,{|u| If(PCount()>0,nVlrDifS:=u,nVlrDifS)},oGrp2,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrDifS",,)
oGrp3      := TGroup():New( 032,004,076,184,"Competencia",oDlg224,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay8      := TSay():New( 040,064,{||"Competência do Custo "},oGrp3,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oGet6      := TGet():New( 056,064,{|u| If(PCount()>0,cCompte:=u,cCompte)},oGrp3,060,008,'@E 9999\99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCompte",,)

oGet6:bLostFocus:={||Processa({||fCarga(cCompte)},"Buscando Dados no Servidor", "Comissão Colaboradores, Guarde ....", .T.)}

GoRMenu1   := TGroup():New( 032,188,076,344,"Empresa a Processar ",oDlg224,CLR_BLACK,CLR_WHITE,.T.,.F. )
oRMenu1    := TRadMenu():New( 036,194,{"Serjus","Riwa","Todas ","Nenhuma"},{|u| If(PCount()>0,nEmpresa:=u,nEmpresa)},oDlg224,,,CLR_BLACK,CLR_WHITE,"",,,136,11,,.F.,.F.,.T. )

oGrp4      := TGroup():New( 137,004,193,345,"Dados das Guias - Riwa ",oDlg224,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay4      := TSay():New( 151,044,{||"Quant. Guias"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay6      := TSay():New( 151,124,{||"Valor Custo "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay7      := TSay():New( 151,196,{||"Valor Cobrando "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay9      := TSay():New( 151,297,{||"Diferença"},oGrp4,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oGet5      := TGet():New( 165,020,{|u| If(PCount()>0,nQtdGuiaR:=u,nQtdGuiaR)},oGrp4,060,008,'@E 999,999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdGuiaR",,)
oGet7      := TGet():New( 165,102,{|u| If(PCount()>0,nVlrCustoR:=u,nVlrCustoR)},oGrp4,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCustoR",,)
oGet8      := TGet():New( 165,184,{|u| If(PCount()>0,nVlrCobrR:=u,nVlrCobrR)},oGrp4,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCobrR",,)
oGet9      := TGet():New( 165,266,{|u| If(PCount()>0,nVlrDifR:=u,nVlrDifR)},oGrp4,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrDifR",,)
oGrp5      := TGroup():New( 194,004,250,345,"Dados das Guias - Total ",oDlg224,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay10     := TSay():New( 208,044,{||"Quant. Guias"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
oSay11     := TSay():New( 208,124,{||"Valor Custo "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay12     := TSay():New( 208,196,{||"Valor Cobrando "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oSay13     := TSay():New( 208,297,{||"Diferença"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,027,008)
oGet10     := TGet():New( 222,020,{|u| If(PCount()>0,nQtdGuiaT:=u,nQtdGuiaT)},oGrp5,060,008,'@E 999,999,999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nQtdGuiaT",,)
oGet11     := TGet():New( 222,102,{|u| If(PCount()>0,nVlrCustoT:=u,nVlrCustoT)},oGrp5,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCustoT",,)
oGet12     := TGet():New( 222,184,{|u| If(PCount()>0,nVlrCobrT:=u,nVlrCobrT)},oGrp5,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrCobrT",,)
oGet13     := TGet():New( 222,266,{|u| If(PCount()>0,nVlrDifT:=u,nVlrDifT)},oGrp5,060,008,'@E 9,999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrDifT",,)

oBtn2:Disable() 

oDlg224:Activate(,,,.T.)

Return()

/////////////////////////

Static Function fValbuton(nEmpresa)
  
    local lRet := .T.

        If  nVlrCobrS == nVlrCustoS .and. nEmpresa == 1

            Alert("Não A Ajuste a Fazer na Serjus")
            lRet := .F.
            
        EndIf 

        If  nVlrCobrR == nVlrCustoR .and. nEmpresa == 2

            Alert("Não A Ajuste a Fazer na Riwa")
            lRet := .F.

        EndIf  

        If  nVlrDifT > 0 .and. nEmpresa == 3

            Alert("Não A Ajuste a Fazer.")
            lRet := .F.

        EndIf  

        If  nEmpresa == 4

            Alert("Não Foi Selecionado opção Valida para Ajuste")
            lRet := .F.
  
        EndIf  

Return(lRet)

static Function fCarga(cCompte) 

local ret       := 0
local cQuery    := " "   

 nQtdGuiaR  := 0
 nQtdGuiaS  := 0
 nQtdGuiaT  := 0
 nVlrCobrR  := 0
 nVlrCobrS  := 0
 nVlrCobrT  := 0
 nVlrCustoR := 0
 nVlrCustoS := 0
 nVlrCustoT := 0
 nVlrDifR   := 0
 nVlrDifS   := 0
 nVlrDifT   := 0

cAno         := Substr(cCompte,1,4) 
cMes         := Substr(cCompte,6,2)

oBtn2:Disable() 

cQuery := CRLF + " SELECT /*+first_rows index_asc(BD7 BD70105)*/    "
cQuery += CRLF + "        substr(BD7F.bd7_numlot,1,6) compte_custo  "   
cQuery += CRLF + "        , BD7F.bd7_anopag||BD7F.bd7_mespag compte_aviso "   
cQuery += CRLF + "        , RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) CONTRATO "          
cQuery += CRLF + "        , Sum(BD7F.VLRPAG)     VlAprov "  
cQuery += CRLF + "        , sum(bd6f.bd6_vlrpf)  Vlpf "          
cQuery += CRLF + "        , bd6f.bd6_pertad      Perc_Tx "        
cQuery += CRLF + "        , Sum(BD6F.bd6_vlrtad) Taxa    "      
cQuery += CRLF + "        , Sum(BD6F.BD6_VLRTPF) Tot_cob "   
cQuery += CRLF + "        , Bd6f.Bd6_numfat numfat "           
cQuery += CRLF + "        , bd6f.bd6_seqpf seqpf "     
cQuery += CRLF + "        , bd7f.bd7_conemp conemp" 
cQuery += CRLF + "        , bd6f.bd6_codemp codemp "
cQuery += CRLF + "        , bd6f.bd6_matric matric " 
cQuery += CRLF + "        , bd6f.bd6_tipreg tipreg"
cQuery += CRLF + "        , DECODE(BD6F.BD6_BLOCPA,'1', 'Sim','Não' ) bloqCob "
cQuery += CRLF + "        , BD6_CODRDA CODRDA" 
cQuery += CRLF + "        , BD7f.BD7_CODLDP CODLDP"
cQuery += CRLF + "        , BD7f.BD7_CODPEG CODPEG"
cQuery += CRLF + "        , BD7f.BD7_NUMERO NUMERO"
cQuery += CRLF + "        , BD7f.BD7_SEQUEN SEQUEN"
cQuery += CRLF + "        , bd7f.bd7_datpro datpro"
cQuery += CRLF + "        , bd6_tipgui tipgui"
cQuery += CRLF + "        , BD6F.BD6_DESPRO DESPRO"
cQuery += CRLF + "        , bd6f.R_E_C_N_O_ BD6REC"  
cQuery += CRLF + "        , BD7f.BD7_CODOPE BD7CODOPE"
cQuery += CRLF + "   FROM " 

cQuery += CRLF + "        (SELECT BD7.BD7_FILIAL,BD7_CODPLA,SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')) EXPOS, "    
cQuery += CRLF + "                BD7.BD7_OPELOT,BD7.BD7_NUMLOT , "    
cQuery += CRLF + "                BD7.BD7_CODOPE , BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, bd7_mespag , bd7_anopag , "    
cQuery += CRLF + "                BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG , "    
cQuery += CRLF + "                COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE , "  
cQuery += CRLF + "                bd7.bd7_conemp , bd7.bd7_datpro "
cQuery += CRLF + "           FROM BD7010 BD7 "   
cQuery += CRLF + "          WHERE BD7.BD7_FILIAL=' ' "    
cQuery += CRLF + "            AND BD7.BD7_CODOPE = '0001' "    
cQuery += CRLF + "            AND BD7.BD7_SITUAC = '1' "    
cQuery += CRLF + "            AND BD7.BD7_FASE = '4' "    
cQuery += CRLF + "            AND BD7.BD7_BLOPAG <> '1' "   
cQuery += CRLF + "            AND BD7.BD7_NUMLOT BETWEEN  '"+cAno+cmes+"0000'  AND '"+cAno+cmes+"9999' " 
cQuery += CRLF + "            AND BD7.bd7_VLRPAG <> 0 "   
cQuery += CRLF + "            AND BD7_CODEMP in ('0013','0017') " 
cQuery += CRLF + "            and substr(bd7_datpro,1,6)>= '202108' "
cQuery += CRLF + "            AND BD7.D_E_L_E_T_ = ' ' "  
cQuery += CRLF + "          GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO,bd7_mespag , bd7_anopag , "   
cQuery += CRLF + "                SIGA_TIPO_EXPOSICAO_ANS(BD7_CODEMP,BD7_MATRIC,BD7_TIPREG,To_Date(Trim(BD7_DATPRO),'YYYYMMDD')),"    
cQuery += CRLF + "                BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN,bd7_conemp, bd7_datpro) BD7F, "   
cQuery += CRLF + "                BD6010 BD6F , BI3010 BI3 ,ZZT010 ZZT "
cQuery += CRLF + "   WHERE ZZT_FILIAL=' ' "   
cQuery += CRLF + "     AND BI3_FILIAL=' ' "   
cQuery += CRLF + "     AND BD6F.BD6_FILIAL=' ' "    
cQuery += CRLF + "     AND substr(BD7F.BD7_NUMLOT,1,6) >= '"+cAno+cmes+"'"
cQuery += CRLF + "     AND substr(BD7F.BD7_NUMLOT,1,6) <= '"+cAno+cmes+"'" 
cQuery += CRLF + "     AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "   
cQuery += CRLF + "     AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "   
cQuery += CRLF + "     AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "   
cQuery += CRLF + "     AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "   
cQuery += CRLF + "     AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "   
cQuery += CRLF + "     AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "   
cQuery += CRLF + "     AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "   
cQuery += CRLF + "     AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "   
        
cQuery += CRLF + "     and bd7f.vlrpag > 0   " 
     
cQuery += CRLF + "     AND BI3_FILIAL =BD7_FILIAL "   
cQuery += CRLF + "     AND BI3_CODINT =BD7_CODOPE "   
cQuery += CRLF + "     AND BI3_CODIGO =BD7_CODPLA "   
cQuery += CRLF + "     AND BD6_YNEVEN =ZZT_CODEV  "  

cQuery += CRLF + "     AND BD6F.D_E_L_E_T_ = ' '  "  
cQuery += CRLF + "     AND BI3.D_E_L_E_T_  = ' '  "  
cQuery += CRLF + "     AND ZZT.D_E_L_E_T_  = ' '  "
cQuery += CRLF + "   GROUP BY /*+first_rows index_asc(BD7 BD70105)*/ "    
cQuery += CRLF + "         substr(BD7F.bd7_numlot,1,6) , "
cQuery += CRLF + "         BD7F.bd7_anopag||BD7F.bd7_mespag , "    
cQuery += CRLF + "         RETORNA_DESC_CONTRATO('C',BD6_OPEUSR,BD6_CODEMP,BD6_CONEMP) , "   
cQuery += CRLF + "         bd6f.bd6_pertad , Bd6f.Bd6_numfat , bd6f.bd6_seqpf , bd7f.bd7_conemp , "
cQuery += CRLF + "         bd6f.bd6_codemp , bd6f.bd6_matric , bd6f.bd6_tipreg , DECODE(BD6F.BD6_BLOCPA,'1', 'Sim','Não' ) , "
cQuery += CRLF + "         BD6_CODRDA , BD7f.BD7_CODLDP , BD7f.BD7_CODPEG , BD7f.BD7_NUMERO , BD7f.BD7_SEQUEN , bd7f.bd7_datpro , "
cQuery += CRLF + "         bd6_tipgui , BD6F.BD6_DESPRO , bd6f.R_E_C_N_O_  , BD7f.BD7_CODOPE  "


If Select((cAliastmp)) <> 0 

   (cAliastmp)->(DbCloseArea())  

Endif                  
  
TCQuery cQuery New Alias (cAliastmp)   

(cAliastmp)->( DbGoTop() )  

While !(cAliastmp)->(Eof())

    if  (cAliastmp)->codemp == '0013' 

        nQtdGuiaS  :=  nQtdGuiaS + 1
        nVlrCobrS  := (cAliastmp)->Tot_cob + nVlrCobrS
        nVlrCustoS := (cAliastmp)->VlAprov + nVlrCustoS
        nVlrDifS   :=  nVlrCustoS - nVlrCobrS 
    
    ElseIf  (cAliastmp)->codemp == '0017' 

        nQtdGuiaR  :=  nQtdGuiaR + 1
        nVlrCobrR  := (cAliastmp)->Tot_cob + nVlrCobrR
        nVlrCustoR := (cAliastmp)->VlAprov + nVlrCustoR
        nVlrDifR   :=  nVlrCustoR - nVlrCobrR 

    EndIf 

    nQtdGuiaT  :=  nQtdGuiaT + 1
    nVlrCobrT  := (cAliastmp)->Tot_cob + nVlrCobrT
    nVlrCustoT := (cAliastmp)->VlAprov + nVlrCustoT
    nVlrDifT   :=  nVlrCustoT - nVlrCobrT 

    (cAliastmp)->(DbSkip())

Enddo

oGet1:ctrlrefresh()
oGet2:ctrlrefresh()
oGet3:ctrlrefresh()
oGet4:ctrlrefresh()

oGet5:ctrlrefresh()
oGet7:ctrlrefresh()
oGet8:ctrlrefresh()
oGet9:ctrlrefresh()

oGet10:ctrlrefresh()
oGet11:ctrlrefresh()
oGet12:ctrlrefresh()
oGet13:ctrlrefresh() 

nEmpresa:= 4

if  nVlrDifT > 0
    oBtn2:Enable()
EndIf 

//oRMenu1:ctrlrefresh()

Return (ret)
//////// atualização 

static function fAtualiza() 

If fValbuton(nEmpresa) 
 
    (cAliastmp)->( DbGoTop() )     

    dbselectarea("BD6")

    If nEmpresa   != 4

        While !(cAliastmp)->(Eof())

            Dbgoto((cAliastmp)->BD6REC)

            RecLock("BD6",.F.)     

            If nEmpresa   == 1 .AND. (cAliastmp)->codemp != '0013' 

               (cAliastmp)->(DbSkip()) 

               Loop
        
            ElseIf nEmpresa   == 2 .AND. (cAliastmp)->codemp != '0017' 

               (cAliastmp)->(DbSkip()) 
    
               Loop
     
            EndIf 
            
            RecLock("BD6",.F.) 
            
                Bd6_vlrbpf  :=  (cAliastmp)->VlAprov 
                Bd6_vlrpf   :=  (cAliastmp)->VlAprov 
                Bd6_pertad  :=  0 
                bd6_blocpa  := '0'
                bd6_opeori  := (cAliastmp)->BD7CODOPE
                bd6_vlrtpf  := (cAliastmp)->VlAprov 

            BD6->(MsUnLock())    

           (cAliastmp)->(DbSkip())

        EndDo
 
    EndIf

EndIf 

Return()

//////// atualização 

static function fExcel() 

	AADD(aDados,{"Compte Custo",;
	             "Compte Aviso",;
	             "Contrato",;
	             "Valor Pago",;
	             "Valor Participação",;
	             "percentual Taxa",;
                 "Valor  Taxa",;
	             "Valor Cobrando",;
	             "Numero Fatura Receber",;
	             "Sequen. Consolidação",;
	             "Contrato Empresa",;
	             "Codigo Emperesa",;
	             "Matricula Benef.",;
	             "tip. Reg",;
	             "Cobrança Bloq",;
	             "Codigo RDA",;
	             "Local Digitação",;
	             "Codigo Peg",;
	             "Numero Guia",;
	             "Seq. Lançamento",; 
	             "Data Procedimento",;
	             "Tipo Guia",;
	             "Desc. Procedimento",;
	             "Controle Interno",;
	             "cod Operadora"})


    (cAliastmp)->( DbGoTop() )  

    If nEmpresa   != 4

        While !(cAliastmp)->(Eof())

            If nEmpresa   == 1 .AND. (cAliastmp)->codemp != '0013' 

               (cAliastmp)->(DbSkip()) 

               Loop
        
            ElseIf nEmpresa   == 2 .AND. (cAliastmp)->codemp != '0017' 

               (cAliastmp)->(DbSkip()) 
    
               Loop
                
            EndIf 

            Aadd(aDados,{(cAliastmp)->compte_custo    ,;   
                         (cAliastmp)->compte_aviso    ,;   
                         (cAliastmp)->CONTRATO        ,;
                         Transform((cAliastmp)->VlAprov ,'@E  999,999,999.99') ,;          
                         Transform((cAliastmp)->Vlpf ,'@E  999,999,999.99') ,;
                         Transform((cAliastmp)->Perc_Tx ,'@E  999.99') ,;          
                         Transform((cAliastmp)->Taxa ,'@E  999,999,999.99') ,;
                         Transform((cAliastmp)->Tot_cob ,'@E  999,999,999.99') ,;
                         (cAliastmp)->numfat          ,;           
                         (cAliastmp)->seqpf           ,;     
                         (cAliastmp)->conemp          ,; 
                         (cAliastmp)->codemp          ,;
                         (cAliastmp)->matric ,; 
                         (cAliastmp)->tipreg ,;
                         (cAliastmp)->bloqCob         ,;
                         (cAliastmp)->CODRDA      ,; 
                         (cAliastmp)->CODLDP ,;
                         (cAliastmp)->CODPEG ,;
                         (cAliastmp)->NUMERO ,;
                         (cAliastmp)->SEQUEN ,;
                         substr((cAliastmp)->datpro,7,2)+'/'+substr((cAliastmp)->datpro,5,2)+'/'+substr((cAliastmp)->datpro,1,4) ,;
                         (cAliastmp)->tipgui      ,;
                         (cAliastmp)->DESPRO ,;
                         (cAliastmp)->BD6REC          ,;  
                         (cAliastmp)->BD7CODOPE} )

           (cAliastmp)->(DbSkip())

        EndDo
 	//
	    DlgToExcel({{"ARRAY","","",aDados}})
    //
    EndIf  

return()
///////////////////////////
