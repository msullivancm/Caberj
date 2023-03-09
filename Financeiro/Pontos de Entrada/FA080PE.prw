*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | FA080PE  | Autor | Edilson Leal  (Korus Consultoria)       |*
*+------------+------------------------------------------------------------+*
*|Data        | 18.12.2007                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Ponto de entrada na baixa contas a pagar. Cria titulo de   |*
*|            | Despesa Juridica com o valor da baixa, caso Motivo da      |*
*|            | Baixa seja Desp. Juridica.                                 |*
*+------------+------------------------------------------------------------+*
*|Arquivos    | SE2                                                        |*
*+------------+------------------------------------------------------------+*
*|Alteracoes  | 														                  |*
*+-------------------------------------------------------------------------+*
*****************************************************************************

#Include "Rwmake.ch"
#Include "Topconn.ch"

************************
User Function FA080PE() 
************************
 
 Private aArea := GetArea()
 Private cTrb  := GetNextAlias()
 Private cQry  := ""
 Private aTit  :={}


 If TrazCodMot(cMotBx) <> "DPJ"
    Return 
 EndIf
 
 cQry := " SELECT E2_NUM "
 cQry += " FROM "+RetSqlName("SE2") 
 cQry += " WHERE D_E_L_E_T_ <> '*'"
 cQry += "    AND E2_FILIAL  = '"+xFilial("SE2")+"'"
 cQry += "    AND E2_NUM     = '"+SE2->E2_NUM+"'"
 cQry += "    AND E2_PREFIXO = 'DPJ'" 
 cQry += "    AND E2_PARCELA = '"+SE2->E2_PARCELA+"'"
 cQry += "    AND E2_TIPO    = 'DP'"  
 cQry += "    AND E2_FORNECE = '"+SE2->E2_FORNECE+"'"
 cQry += "    AND E2_LOJA    = '"+SE2->E2_LOJA+"'"       
 cQry += "    AND E2_HIST    = '"+cHist070 +"'" 
 
 If Select((cTrb)) > 0;(cTrb)->(DbCloseArea());EndIf 
 DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), cTrb, .F., .T.)    
 (cTrb)->(DbGoTop())
 
 If (cTrb)->(!Eof())
    MsgBox("ATENÇÃO : já existe este titulo como Despesa Juridica !!! DPJ não gerado. Verifique.")
    If Select(cTrb)>0;(cTrb)->(DbCloseArea());EndIf 
    Return 
 EndIf 
 
 AADD(aTit,{"E2_NUM"    ,SE2->E2_NUM                         ,NIL})
 AADD(aTit,{"E2_PREFIXO","DPJ"                               ,NIL})
 AADD(aTit,{"E2_PARCELA",SE2->E2_PARCELA                     ,NIL})
 AADD(aTit,{"E2_TIPO"   ,"DP"                                ,NIL})
 AADD(aTit,{"E2_NATUREZ","12605"                             ,NIL})
 AADD(aTit,{"E2_FORNECE",SE2->E2_FORNECE                     ,NIL})
 AADD(aTit,{"E2_LOJA"   ,SE2->E2_LOJA                        ,NIL})
 AADD(aTit,{"E2_EMISSAO",dDataBase                           ,NIL})
 AADD(aTit,{"E2_VENCTO" ,dDataBase+30                        ,NIL})
 AADD(aTit,{"E2_VENCREA",dDataBase+30                        ,NIL})
 AADD(aTit,{"E2_VALOR"  ,nValPgto                            ,NIL})               
 AADD(aTit,{"E2_VLCRUZ" ,nValPgto                            ,NIL}) 
 AADD(aTit,{"E2_HIST"   ,cHist070                            ,NIL})
 AADD(aTit,{"E2_CCD"    ,Iif(cEmpAnt == '01','998','99999')  ,NIL})
 AADD(aTit,{"E2_YNPARCE",SE2->E2_YNPARCE                     ,NIL}) 
 

 
 lMsErroAuto:=.F.
 lRetF050   :=.T.

 Begin Transaction    
    MSExecAuto({|x,y| FINA050(x,y)}, aTit, 3)
    If lMsErroAuto
       DisarmTransaction()    
    EndIf 
 End Transaction
 
 If lMsErroAuto
    lRetF050:=.F.
    MostraErro()
 EndIf
 
 If lMsErroAuto
    MsgBox("Não foi possivel criar o titulo de Despesa Juridica !!! Entre em contato com o Administrador do Sistema.")    
 Else
    MsgInfo("Titulo de Despesa Juridica criado com sucesso !!!") 
 EndIf
 
 If Select(cTrb) > 0;(cTrb)->(DbCloseArea());EndIf 
 
 RestArea(aArea) 
 
Return


