#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"                                                           
#include "SIGAWIN.CH"
                                                                                                                      
/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR189   º Autor ³Altamiro              º Data ³ 18/05/2018º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para atualizar tabela de controle de Debito/Credito º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR321()

Private cDpj        := 'Não'   
private cImp        := 'Não'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR321"
Private cTitulo     := "Carga da safra - carga da matriz "
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .T.
private lDesfaz     := .F.
Private nLocaliz    := 0         
PRIVATE CEmpIesa    :=  Iif(cempant == '01','Caberj','Integral')  
Private cAliastmp   := GetNextAlias()
Private cAliasEmpB  := GetNextAlias()

Private cAliasVcC   := GetNextAlias()
Private cAliasVcV   := GetNextAlias()

Private cAliasMV    := GetNextAlias()

Private cAliasCR    := GetNextAlias()

private aDados      := {}
Private aDadoData   := {}

private aDadosTC    :={}

private aDadosPl    :={}
private aDadosEPl   :={}
private aDadosEmp   :={}

private aDadosMV    := {}

private adadosc     := {}

private cDiaFim     :='30'

private cCompte0    :='202106'
private cCompte1    :=' '
private cCompte2    :=' '
private cCompte3    :=' '
private cCompte4    :=' '
private cCompte5    :=' '
private cCompte6    :=' '
private cCompte7    :=' '
private cCompte8    :=' '
private cCompte9    :=' '
private cCompte10   :=' '
private cCompte11   :=' '
private cCompte12   :=' '
private cCompte13   :=' '
private cCompte14   :=' '
private cCompte15   :=' '
private cCompte16   :=' '
private cCompte17   :=' '
private cCompte18   :=' '
private cCompte19   :=' '
private cCompte20   :=' '
private cCompte21   :=' '
private cCompte22   :=' '
private cCompte23   :=' '
private cCompte24   :=' '

Private nCont       := 0

private nDesv0T     := 0 
private nDesv1T     := 0  
private nDesv2T     := 0  
private nDesv3T     := 0  
private nDesv4T     := 0  
private nqtdavid    := 0
          
private cAno        := 0
private cMes        := 0

private cdate       := ' '

private CEmpI       := ' ' 
private cDesvP      := 1
private cTpProg     := 1
// private cEmpI       := ' ' 
private cEmpF       := ' '

private lPrim       :=.F.

private nVlrAntT    := 0.00
private nQtdAntT    := 0

private nVlrAntE    := 0.00
private nQtdAntE    := 0       

private nQtdAntA    := 0 
private nVlrAntA    := 0.00

private nQtdAtuT    := 0
private nVlrAtuT    := 0.00
       
private nQtdAtuE    := 0 
private nVlrAtuE    := 0.00

private nQtdAtuA    := 0
private nVlrAtuA    := 0.00

Private nVcmhEmp   := 0.00

Private nVcmhAds   := 0.00

Private nVcmhTot   := 0.00

Private QtVidAnt := 0
Private QtVidAtu := 0
Private CustoAnt := 0.00
Private CustoAtu := 0.00

private cCompinc := ' '  
private cComptblo:= ' '
private cComptCR := ' '

private nCusto   := 0
private nReceit  := 0
private nExposto := 0
private cRefer   := ' '

Private cCompCont:= substr(dtos(date()),1,6)

AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cEmpI       := Mv_Par02
cEmpF       := Mv_Par03
cDesvP      := Mv_Par04
cCompte0    := Mv_Par01 
cTpProg     := Mv_Par05

if mv_par06 == 1
   
   cTitulo     := "Carga da safra - carga da matriz"

   Processa({||Processa3()}, cTitulo, ' ', .T.)

Elseif mv_par06 == 2 

   cTitulo     := "Carga dos 3 disvio padrao - carga da matriz "
   
   Processa({||Processa3()}, cTitulo, "", .T.)

Elseif mv_par06 == 3 

   cTitulo     := "Calculo do VCMH - Saida Em Planilha"
   
   Processa({||VCMH()}, cTitulo, "", .T.)   

Elseif mv_par06 == 4 

   cTitulo     := "Meta de Vendas - Saida Em Planilha"
   
   Processa({||MetaVenda()}, cTitulo, "", .T.)   


EndIf 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MsgInfo("Processo finalizado")

Return()                 

Static Function Processa3()
local cQuery    := ' ' 

cQuery :=      "  select bqc_codemp codemp , count(*) qtda "
cQuery += CRLF +"   FROM "+ RetSqlName("BQC") +" BQC "
cQuery += CRLF +"  where BQC_filial ='"+xFilial("BQC")+"' AND BQC.D_e_l_e_t_ = ' ' "
If  mv_par05 == 1  
    cQuery += CRLF +"    and bqc_datblo = ' ' "
EndIF      
cQuery += CRLF +"  and bqc_codemp >='"+cEmpI+"' and bqc_codemp <= '"+cEmpF+"'"
cQuery += CRLF +"  group by bqc_codemp"
cQuery += CRLF +"  Order by bqc_codemp"

If Select((cAliasEmpB)) <> 0 
    (cAliasEmpB)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliasEmpB)   

(cAliasEmpB)->(dbGoTop()) 
  
While (cAliasEmpB)->(!EOF())
   
   If (cAliasEmpB)->Qtda > 0

      CEmpI:= (cAliasEmpB)->codemp 

      if mv_par06 == 1

         Processa1()
         
      Else 

         Processa2()
      
      EndIf 

   EndIf 
  
     (cAliasEmpB)->(DbSkip())  

      nDesv0T := 0
 	   nDesv1T := 0
      nDesv1  := 0
      nDesv2T := 0 
      nDesv2  := 0
      nDesv3T := 0 
      nDesv3  := 0
      nDesv4T := 0
      nqtdavid:= 0

EndDo

return()
/**************************************************************************/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Processa1() 

local cQuery    := ' ' 
local CodEmpAux := ' ' 
local cComptaux := ' '
local nqtdaaux  := 0
local nqtdabaux := 0

cQuery :=       "  SELECT ATV.CODEMP  codempatv , ATV.DATINC datincatv, BLOQ.DATBLO DATBLObloq , ATV.QTDATOT QTDATOTatv, NVL(BLOQ.QTDABLOQ ,0) qtdabloq " 
cQuery += CRLF +"    FROM (SELECT BA1_CODEMP CODEMP , SUBSTR(BA1_DATINC,1,6) DATINC , '000000' DATBLO, COUNT(*) QTDATOT " 
cQuery += CRLF +"            FROM "+ RetSqlName("BA1") +" BA1  "
cQuery += CRLF +"           where BA1_filial ='"+xFilial("BA1")+"' AND BA1.D_e_l_e_t_ = ' ' "
cQuery += CRLF +"             AND ba1_codemp >= '"+cEmpI+"' AND ba1_codemp <= '"+cEmpF+"' "

cQuery += CRLF +"           AND SUBSTR(BA1_DATINC,1,6)>= '200907'  AND SUBSTR(BA1_DATINC,1,6)<= '200910' "

cQuery += CRLF +"           GROUP BY BA1_CODEMP, SUBSTR(BA1_DATINC,1,6)) ATV , "

cQuery += CRLF +"         (SELECT BA1_CODEMP CODEMP , SUBSTR(BA1_DATINC,1,6) DATINC , " 
cQuery += CRLF +"                 DECODE(NVL(TRIM(SUBSTR(BA1_DATBLO,1,6)),' '),' ','  ',SUBSTR(BA1_DATBLO,1,6)) DATBLO , "
cQuery += CRLF +"                 COUNT(*) QTDABLOQ  "
cQuery += CRLF +"           FROM "+ RetSqlName("BA1") +" BA1  "
cQuery += CRLF +"          where BA1_filial ='"+xFilial("BA1")+"' AND BA1.D_e_l_e_t_ = ' ' "
cQuery += CRLF +"            AND ba1_codemp >= '"+cEmpI+"' AND ba1_codemp <= '"+cEmpF+"'" 

cQuery += CRLF +"            AND SUBSTR(BA1_DATINC,1,6)>= '200907'  AND SUBSTR(BA1_DATINC,1,6)<= '200910'  "

cQuery += CRLF +"          GROUP BY BA1_CODEMP, SUBSTR(BA1_DATINC,1,6) ,  SUBSTR(BA1_DATBLO,1,6) )bloq " 

cQuery += CRLF +"    WHERE  ATV.CODEMP  = BLOQ.CODEMP(+) AND ATV.DATINC = BLOQ.DATINC(+) "
cQuery += CRLF +"    ORDER BY 1,2,3,4 "

If Select((cAliastmp)) <> 0 
    (cAliastmp)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   

(cAliastmp)->(dbGoTop()) 
  
While (cAliastmp)->(!EOF())

   If cComptaux  != (cAliastmp)->datincatv .or. (cAliastmp)->codempatv != CodEmpAux

        nqtdaaux   := (cAliastmp)->QTDATOTatv
        
        CodEmpAux  := (cAliastmp)->codempatv   
 
        cComptaux  := (cAliastmp)->datincatv

        nqtdabaux  := (cAliastmp)->qtdabloq

        cComptCR   := (cAliastmp)->DATBLObloq
// abate bloqueadas no periodo no mesmo mes
        nqtdaaux   := (nqtdaaux - (cAliastmp)->qtdabloq)
////
         if Empty(trim((cAliastmp)->DATBLObloq))
            lPrim      := .T.
         EndIf 


   ElseIf cComptaux  == (cAliastmp)->datincatv .and. (cAliastmp)->codempatv == CodEmpAux       

      if  fcompt(cComptCR) == trim((cAliastmp)->DATBLObloq)

         nqtdaaux   := (nqtdaaux - (cAliastmp)->qtdabloq)
         If lPrim   == .T.   
            nqtdabaux  :=  (cAliastmp)->qtdabloq
            lPrim      := .F.
         Else 
            nqtdabaux  := (nqtdabaux + (cAliastmp)->qtdabloq)
         EndIf
      EndIf        
   EndIf
 

  if (cAliastmp)->DATBLObloq > fcompt(cComptCR)
  
    cComptblo:= fcompt(cComptCR)
     
  else 

    cComptblo:= (cAliastmp)->DATBLObloq
 
  EndIf 

  cCompinc  := cComptaux 
  cComptCR  := cComptblo
   

fcargaCR()  
//fcompt(cComptCR)

//cComptCR   := (cAliastmp)->DATBLObloq

      if cRefer == trim((cAliastmp)->DATBLObloq)
   	
      	Aadd(aDados,{trim((cAliastmp)->codempatv)  ,;
                      trim((cAliastmp)->datincatv)  ,;
                      trim((cAliastmp)->DATBLObloq) ,;
				                nqtdabaux               ,;
                            nqtdaaux                ,;
                           (cAliastmp)->QTDATOTatv  ,;
                           (cAliastmp)->qtdabloq    ,;
                            nqtdaaux+(cAliastmp)->qtdabloq,;
                           nCusto,;
                           nReceit,;
                           nCusto / nReceit ,; 
                           nExposto})
              
                     Cnt1:=  trim((cAliastmp)->codempatv)  
                     Cnt2:=  trim((cAliastmp)->datincatv)  
                     Cnt3:=  trim((cAliastmp)->DATBLObloq) 
				         Cnt4:=        nqtdabaux               
                     Cnt5:=        nqtdaaux                
                     Cnt6:=       (cAliastmp)->QTDATOTatv  
                     Cnt7:= 0   
                     Cnt8:= nqtdaaux+(cAliastmp)->qtdabloq

           (cAliastmp)->(DbSkip())

      Else 

     	   Aadd(aDados,{Cnt1  ,;
                      Cnt2  ,;
                      cRefer  ,;
                      Cnt4  ,;
                      Cnt5  ,;
                      Cnt6  ,;
                      Cnt7  ,;
                      Cnt8 ,;
                      nCusto,;
                      nReceit,;
                      nCusto / nReceit ,; 
                      nExposto})

               If  nqtdaaux    == 0 .or. cCompCont == cComptblo

                  (cAliastmp)->(DbSkip())

               EndIf

               cRefer   := ' '
               nCusto   := 0
               nReceit  := 0
               nExposto := 0 

 	   EndIf 

   cRefer   := ' '
   nCusto   := 0
   nReceit  := 0
   nExposto := 0 
      
  EndDo 

  FGrvPlan1()
 
RETURN()

Static Function fCargaCR()    

local cQuery    := ' ' 

cQuery :=       "  SELECT  codemp codemp , SUBSTR(BA1_DATINC,1,6), trim(to_char(mes_ano_ref,'YYYYMM')) refer ,  sum(mensa) mensa , sum(APROVADO) custo , COUNT(*) Qtda "
cQuery += CRLF +"            FROM "+ RetSqlName("BA1") +" BA1  , "
	
   If  cEmpAnt =='02'
		cQuery +=CRLF+" COB_SINISTRALIDADE_MS_INT sinst "
	Else
		cQuery +=CRLF+" COB_SINISTRALIDADE_MS_CAB sinst "
	EndIf	  

cQuery += CRLF +"           where BA1_filial ='"+xFilial("BA1")+"' AND BA1.D_e_l_e_t_ = ' ' "
cQuery += CRLF +"             AND ba1_codemp >= '"+cEmpI+"' AND ba1_codemp <= '"+cEmpF+"' " 

cQuery += CRLF +"     and ba1_codemp = codemp " 
cQuery += CRLF +"     and ba1_matric = matric "
cQuery += CRLF +"     and ba1_tipreg = tipreg "         
cQuery += CRLF +"     AND SUBSTR(BA1_DATINC,1,6) = '"+cCompinc+"' " 
cQuery += CRLF +"     AND (SUBSTR(BA1_DATBLO,1,6) >= '"+cComptblo+"' OR SUBSTR(BA1_DATBLO,1,6) =  ' ') "
cQuery += CRLF +"     AND MES_ANO_REF =  TO_DATE('"+cComptblo+"'||'01' ,'YYYYMMDD') "
cQuery += CRLF +"     GROUP BY codemp , to_char(mes_ano_ref,'YYYYMM'), SUBSTR(BA1_DATINC,1,6) "

If Select(cAliasCR) <> 0 
    (cAliasCR)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliasCR)   

(cAliasCR)->(dbGoTop()) 
  
While (cAliasCR)->(!EOF())

   cRefer   := (cAliasCR)->refer
   nCusto   := (cAliasCR)->custo
   nReceit  := (cAliasCR)->mensa
   nExposto := (cAliasCR)->Qtda 

     (cAliasCR)->(DbSkip())

EndDo 

Return()

Static Function FGrvPlan1()    

   LOCAL nCount:= 1
   //cNomDadCab:= 'Dados da Reserva'
   //cComp     :=  cCompte
   //cNomPla   := 'Dados da Reserva'            

   	cNomeArq := "C:\TEMP\SAFRA-"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)
     
        cMontaTxt := "Codemp     ;" 
        cMontaTxt += "DatInc     ;" 
        cMontaTxt += "DatBlo     ;" 
        cMontaTxt += "QtdabloqS  ;"
        cMontaTxt += "SaldoAtiv  ;"
        cMontaTxt += "TotVidC    ;"      
        cMontaTxt += "Qtdabloq   ;"  
        cMontaTxt += "QtdaSbloqM ;"  
        cMontaTxt += "Custo      ;"    
        cMontaTxt += "Receita    ;"    
        cMontaTxt += "Sinist%    ;"
        cMontaTxt += "Qtda Incid ;"        
     	  cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDados)
      
          cMontaTxt := trim(aDados[nCount][1]) + ";"		 
          cMontaTxt += trim(aDados[nCount][2]) + ";"		
          cMontaTxt += trim(aDados[nCount][3]) + ";"		
          cMontaTxt += Transform(aDados[nCount][4],'@E  99,999')+ ";"   	
          cMontaTxt += Transform(aDados[nCount][5],'@E  99,999')+ ";"   
          cMontaTxt += Transform(aDados[nCount][6],'@E  99,999')+ ";"  
          cMontaTxt += Transform(aDados[nCount][7],'@E  99,999')+ ";"
          cMontaTxt += Transform(aDados[nCount][8],'@E  99,999')+ ";" 
          cMontaTxt += Transform(aDados[nCount][ 9],'@E  999,999,999.99')+ ";"   	
          cMontaTxt += Transform(aDados[nCount][10],'@E  999,999,999.99')+ ";"   
          cMontaTxt += Transform(aDados[nCount][11],'@E  9999.9999')+ ";"  
          cMontaTxt += Transform(aDados[nCount][12],'@E  99,999')+ ";"  
       	 cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra gravação no arquivo?
		FClose(nHandle)
		//cNomeArq+= cNomeArq + CRLF
 	    //MsgAlert("Relatorio salvo em: "+cNomeArq)
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq)

	EndIf                                 
	           
Return ()    

Static Function FGrvPlan3()    

   LOCAL nCount:= 1
   //cNomDadCab:= 'Dados da Reserva'
   //cComp     :=  cCompte
   //cNomPla   := 'Dados da Reserva'            

   	cNomeArq := "C:\TEMP\SAFRA-"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)
     
        cMontaTxt := "Codemp     ;" 
        cMontaTxt += "DatInc     ;" 
        cMontaTxt += "DatBlo     ;" 
        cMontaTxt += "Qtdabloq   ;"
        cMontaTxt += "Qtdabloqtot;"
        cMontaTxt += "QtdaAtiv   ;"        
     		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDados)
      
          cMontaTxt := trim(aDados[nCount][1]) + ";"		 
          cMontaTxt += trim(aDados[nCount][2]) + ";"		
          cMontaTxt += trim(aDados[nCount][3]) + ";"		
          cMontaTxt += Transform(aDados[nCount][4],'@E  99,999')+ ";"   
          cMontaTxt += Transform(aDados[nCount][5],'@E  99,999')+ ";"  
          cMontaTxt += Transform(aDados[nCount][6],'@E  99,999')+ ";"  
    
      	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra gravação no arquivo?
		FClose(nHandle)
		//cNomeArq+= cNomeArq + CRLF
 	    //MsgAlert("Relatorio salvo em: "+cNomeArq)
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq)

	EndIf                                 
	           
Return ()    


Static Function FGrvPlan4()    

   LOCAL nCount:= 1
   
   //cNomDadCab:= 'Dados da Reserva'
   //cComp     :=  cCompte
   //cNomPla   := 'Dados da Reserva'            

   	cNomeArq := "C:\TEMP\VCMH -"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)

      cMontaTxt := "Periodo de "+ cCompte1 + " a "+ cCompte24 +" " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt += "CempIesa de "+cEmpI+" a "+ cEmpF +" " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := " " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := " " + CRLF      
      cMontaTxt := "Tipo de Contratação " + CRLF
      FWrite(nHandle,cMontaTxt)

        cMontaTxt := "Tipo Contratação ;"
        cMontaTxt += "CempIesa (quando Houver) ;"        
        cMontaTxt += "Plano (quando Houver) ;" 
        cMontaTxt += "Valor Atual      ;" 
        cMontaTxt += "Qtda Atual       ;" 
        cMontaTxt += "Valor Anterior   ;"
        cMontaTxt += "Qtda Anterior    ;"
        cMontaTxt += "VCMH             ;"        
     	  cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
          
          cMontaTxt := 'Col. CempIesarial'+ ";"
          cMontaTxt += '  '+ ";"
          cMontaTxt += '  '+ ";"
          cMontaTxt += Transform(nVlrAtuE,'@E  99,999,999,999.99')+ ";"
          cMontaTxt += Transform(nQtdAtuE,'@E  99,999,999')+ ";"
          cMontaTxt += Transform(nVlrAntE,'@E  99,999,999,999.99')+ ";"
          cMontaTxt += Transform(nQtdAntE,'@E  99,999,999')+ ";" 
          cMontaTxt += Transform(nVcmhEmp,'@E  999.99999')+ ";"  
      	 cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
	   FWrite(nHandle,cMontaTxt)

          cMontaTxt := 'Col. Adesão'+ ";"
          cMontaTxt += '  '+ ";"
          cMontaTxt += '  '+ ";"
          cMontaTxt += Transform(nVlrAtuA,'@E  99,999,999,999.99')+ ";"
          cMontaTxt += Transform(nQtdAtuA,'@E  99,999,999')+ ";"
          cMontaTxt += Transform(nVlrAntA,'@E  99,999,999,999.99')+ ";"
          cMontaTxt += Transform(nQtdAntA,'@E  99,999,999')+ ";" 
          cMontaTxt += Transform(nVcmhAds,'@E  999.99999')+ ";"  
      	 cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
	   FWrite(nHandle,cMontaTxt)

          cMontaTxt := 'Col. Total'+ ";"
          cMontaTxt += '  '+ ";"
          cMontaTxt += '  '+ ";"
          cMontaTxt += Transform(nVlrAtuT,'@E  99,999,999,999.99')+ ";"
          cMontaTxt += Transform(nQtdAtuT,'@E  99,999,999')+ ";"
          cMontaTxt += Transform(nVlrAntT,'@E  99,999,999,999.99')+ ";"
          cMontaTxt += Transform(nQtdAntT,'@E  99,999,999')+ ";" 
          cMontaTxt += Transform(nVcmhTot,'@E  999.99999')+ ";"  
      	 cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)

//////////////////////
      cMontaTxt := " " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := " " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := "Por Plano  " + CRLF
      FWrite(nHandle,cMontaTxt)

ASort(aDadosPL , , , {|x,y|x[1]+x[2] < y[1]+y[2]})

      For nCount:=1 to len(aDadosPL)
      
          cMontaTxt := trim(aDadosPL[nCount][1]) + ";"		
          cMontaTxt += '  '+ ";" 
          cMontaTxt += trim(aDadosPL[nCount][2]) + ";"	
          cMontaTxt += Transform(aDadosPL[nCount][5],'@E  99,999,999,999.99')+ ";"  
          cMontaTxt += Transform(aDadosPL[nCount][6],'@E  999,999,999')+ ";"
          cMontaTxt += Transform(aDadosPL[nCount][3],'@E  99,999,999,999.99')+ ";" 		
          cMontaTxt += Transform(aDadosPL[nCount][4],'@E  999,999,999')+ ";"  	
          cMontaTxt += Transform( ( ( ( (aDadosPL[nCount][5]/aDadosPL[nCount][6]) / (aDadosPL[nCount][3]/aDadosPL[nCount][4]) )-1 )*100) ,'@E  99999.99999') + ";"
       	 cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

////////////////////// CempIesa /////
      cMontaTxt := " " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := " " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := "Por CempIesa  " + CRLF
      FWrite(nHandle,cMontaTxt)

ASort(aDadosEmp , , , {|x,y|x[1]+x[2] < y[1]+y[2]})


      For nCount:=1 to len(aDadosEmp)
      
          cMontaTxt := trim(aDadosEmp[nCount][1]) + ";"		
          cMontaTxt += trim(aDadosEmp[nCount][2]) + ";"	 
          cMontaTxt += ' '  + ";"	
          cMontaTxt += Transform(aDadosEmp[nCount][6],'@E  99,999,999,999.99')+ ";"  
          cMontaTxt += Transform(aDadosEmp[nCount][7],'@E  999,999,999')+ ";"
          cMontaTxt += Transform(aDadosEmp[nCount][4],'@E  99,999,999,999.99')+ ";" 		
          cMontaTxt += Transform(aDadosEmp[nCount][5],'@E  999,999,999')+ ";"  	
          cMontaTxt += Transform( ( ( ( (aDadosEmp[nCount][6]/aDadosEmp[nCount][7]) / (aDadosEmp[nCount][4]/aDadosEmp[nCount][5]) )-1 )*100) ,'@E  9999.9999999') + ";"
       	 cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

		// encerra gravação no arquivo?
	FClose(nHandle)
		//cNomeArq+= cNomeArq + CRLF
 	    //MsgAlert("Relatorio salvo em: "+cNomeArq)
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq)
        
Return ()    
//////////////////////      
Static Function FGrvPlan5()    

   LOCAL nCount:= 1
   
   //cNomDadCab:= 'Dados da Reserva'
   //cComp     :=  cCompte
   //cNomPla   := 'Dados da Reserva'            

   	cNomeArq := "G:\DICOM\GEREM\NÚCLEO GERENCIAL 2\NÚCLEO DE MONITORAMENTO E CONTROLE\Base Power BI\meta\Meta de Vendas  -"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)

      cMontaTxt := "Periodo de "+ cCompte1+'31' + " a "+ cCompte2+'31' +" " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt += "CempIesa de "+cEmpI+" a "+ cEmpF +" " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := " " + CRLF
      FWrite(nHandle,cMontaTxt)
      cMontaTxt := " " + CRLF      
      cMontaTxt := "Meta de Vendas " + CRLF
      FWrite(nHandle,cMontaTxt)

        cMontaTxt := "Cod da CempIesa  ;"
        cMontaTxt += "Nome CempIesa    ;"        
        cMontaTxt += "Tipo de Plano   ;" 
        cMontaTxt += "Tipo Contrato   ;" 
        cMontaTxt += "Estoque         ;" 
        cMontaTxt += "Inclusao        ;"
        cMontaTxt += "Exclusao        ;"
     	  cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

      For nCount:=1 to len(aDadosMV)
      
         cMontaTxt := trim(aDadosMV[nCount][1]) + ";"		
         cMontaTxt += trim(aDadosMV[nCount][2]) + ";"	
         cMontaTxt += trim(aDadosMV[nCount][3]) + ";"
         cMontaTxt += trim(aDadosMV[nCount][4]) + ";"	
         cMontaTxt += Transform(aDadosMV[nCount][5],'@E  999,999,999')+ ";"
         cMontaTxt += Transform(aDadosMV[nCount][6],'@E  999,999,999')+ ";"  	
         cMontaTxt += Transform(aDadosMV[nCount][7],'@E  999,999,999')+ ";"  	         
         cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

//////////////////////

		// encerra gravação no arquivo?
	FClose(nHandle)
		//cNomeArq+= cNomeArq + CRLF
 	    //MsgAlert("Relatorio salvo em: "+cNomeArq)
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq)
        
Return ()    

Static Function Processa2()  

local cQuery    := ' ' 
// local CodEmpAux := ' ' 
// local cComptaux := ' '
// local nqtdaaux  := 0
// local nqtdabaux := 0
local i := 0

fazcompt(cCompte0)

/*
--------------------------------------------------------
---- medio 
*/
cQuery :=       "select Custo1.codemp codemp ,"
cQuery += CRLF +" to_char(custo1.refer,'YYYYMMDD') Refer , " 
//cQuery += CRLF +" custo1.refer Refer , " 
cQuery += CRLF +"custo1.qtdavidas QtdaVida ," 
cQuery += CRLF +"custo1.custotot Custotot ," 
cQuery += CRLF +"custo1.custo CustoBase , "
          
cQuery += CRLF +"case when custo1.custo < desvios.primeiro_desvio then custo1.custo else desvios.primeiro_desvio end as CustoMen1 , "
cQuery += CRLF +"case when custo1.custo < desvios.segundo_desvio  then custo1.custo else desvios.segundo_desvio  end as CustoMen2 , "
cQuery += CRLF +"case when custo1.custo < desvios.treceiro_desvio then custo1.custo else desvios.treceiro_desvio end as CustoMen3 , "
          
cQuery += CRLF +"case when custo1.custo > desvios.inf_desvio1 then custo1.custo else desvios.inf_desvio1 end as CustoMai1 , "
cQuery += CRLF +"case when custo1.custo > desvios.inf_desvio2 then custo1.custo else desvios.inf_desvio2 end as CustoMai2 , "
cQuery += CRLF +"case when custo1.custo > desvios.inf_desvio3 then custo1.custo else desvios.inf_desvio3 end as CustoMai3 , "
          
cQuery += CRLF +"desvios.primeiro_desvio DesvMai1 , "
cQuery += CRLF +"desvios.segundo_desvio  DesvMai2 , " 
cQuery += CRLF +"desvios.Treceiro_desvio DesvMai3 , " 
cQuery += CRLF +"desvios.inf_desvio1 DesvMen1 , " 
cQuery += CRLF +"desvios.inf_desvio2 DesvMen2 , "
cQuery += CRLF +"desvios.inf_desvio3 DesvMen3   "
     
cQuery += CRLF +"From(Select MCusto.CODEMP codemp , MCusto.mes_ano_ref refer, VidComp.QtdaVida qtdavidas , MCusto.custo custoTot , "

If cDesvP == 1
   cQuery += CRLF +" trunc((MCusto.custo / VidComp.QtdaVida),2) custo "
Else 
   cQuery += CRLF +" MCusto.custo custo "
EndIf            

cQuery += CRLF +"From (SELECT CODEMP codemp , mes_ano_ref , sum(aprovado)custo "  
cQuery += CRLF +"From cob_sinistralidade_ms_int "    
cQuery += CRLF +"WHERE mes_ano_ref BETWEEN to_date('"+cCompte1+"01','YYYYMMDD') AND to_date('"+cCompte12+"01','YYYYMMDD') " 
cQuery += CRLF +"AND CODEMP >= '"+CEmpI+"' AND CODEMP <= '"+CEmpF+"'"
cQuery += CRLF +"GROUP BY codemp  , mes_ano_ref ) MCusto , "

cQuery += CRLF +"         (Select to_date('"+cCompte1+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte1+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte1+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte2+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte2+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte2+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte3+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte3+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte3+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte4+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte4+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte4+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "    
cQuery += CRLF +"Union All Select to_date('"+cCompte5+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte5+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte5+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte6+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte6+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte6+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte7+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte7+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte7+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "        
cQuery += CRLF +"Union All Select to_date('"+cCompte8+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte8+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte8+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  " 
cQuery += CRLF +"Union All Select to_date('"+cCompte9+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte9+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte9+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte10+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte10+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte10+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "    
cQuery += CRLF +"Union All Select to_date('"+cCompte11+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte11+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte11+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte12+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte12+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte12+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte13+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte13+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte13+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  ) VidComp "        

cQuery += CRLF +"where MCusto.codemp = VidComp.codemp "
cQuery += CRLF +"and MCusto.mes_ano_ref = VidComp.Compte) custo1 , "          
cQuery += CRLF +"(select media1.CODEMP codemp , trunc(SQRT((sum(desv)/12)),2) raiz, media1.media , " 
cQuery += CRLF +"(trunc(SQRT((sum(desv)/12)),2) + media1.media) primeiro_desvio , "
cQuery += CRLF +"((trunc(SQRT((sum(desv)/12)),2)*2) + media1.media) segundo_desvio , "
cQuery += CRLF +"((trunc(SQRT((sum(desv)/12)),2)*3) + media1.media) treceiro_desvio  , "
cQuery += CRLF +"case when(media1.media - trunc(SQRT(sum(desv)/12),2)) < 0.00 then 0 else (media1.media - trunc(SQRT(sum(desv)/12),2) ) end inf_desvio1 , "
cQuery += CRLF +"case when(media1.media - trunc(SQRT(sum((desv)/12)*2),2)) < 0.00 then 0 else (media1.media - trunc(SQRT((sum(desv)/12)*2),2)) end inf_desvio2 , " 
cQuery += CRLF +"case when(media1.media - trunc(SQRT(sum((desv)/12)*3),2)) < 0.00 then 0 else (media1.media - trunc(SQRT((sum(desv)/12)*3),2)) end inf_desvio3 "
cQuery += CRLF +"From (SELECT MMedia.CODEMP codemp , trunc((sum(MMedia.custo)/12),2) media "
cQuery += CRLF +"FROM (Select MCusto.CODEMP codemp , MCusto.mes_ano_ref refer,

If cDesvP == 1
   cQuery += CRLF +" trunc((MCusto.custo / VidComp.QtdaVida),2) custo "
Else 
   cQuery += CRLF +" MCusto.custo custo "
EndIf            
       
cQuery += CRLF +"From (SELECT CODEMP codemp , mes_ano_ref , sum(aprovado)custo "  
cQuery += CRLF +"FROM cob_sinistralidade_ms_int "   
cQuery += CRLF +"WHERE mes_ano_ref BETWEEN to_date('"+cCompte1+"01','YYYYMMDD') AND to_date('"+cCompte12+"01','YYYYMMDD')" 
cQuery += CRLF +"AND CODEMP >= '"+CEmpI+"' AND CODEMP <= '"+CEmpF+"'"
cQuery += CRLF +"GROUP BY codemp  , mes_ano_ref ) MCusto ,"

cQuery += CRLF +"         (Select to_date('"+cCompte1+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte1+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte1+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte2+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte2+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte2+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   " 
cQuery += CRLF +"Union All Select to_date('"+cCompte3+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte3+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte3+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte4+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte4+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte4+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "    
cQuery += CRLF +"Union All Select to_date('"+cCompte5+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte5+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte5+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte6+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte6+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte6+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte7+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte7+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte7+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "        
cQuery += CRLF +"Union All Select to_date('"+cCompte8+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte8+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte8+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   " 
cQuery += CRLF +"Union All Select to_date('"+cCompte9+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte9+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte9+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte10+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte10+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte10+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "    
cQuery += CRLF +"Union All Select to_date('"+cCompte11+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte11+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte11+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte12+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte12+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte12+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte13+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte13+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte13+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp ) VidComp "

cQuery += CRLF +"where MCusto.codemp = VidComp.codemp "
cQuery += CRLF +"and MCusto.mes_ano_ref = VidComp.Compte) MMedia "           
cQuery += CRLF +"WHERE MMedia.CODEMP >= '"+CEmpI+"' AND MMedia.CODEMP <= '"+CEmpF+"' "
cQuery += CRLF +"GROUP BY MMedia.CODEMP)Media1 , "  
  
cQuery += CRLF +"(select custoM.codemp  codemp , custoM.refer , trunc((sum((custoM.custo - mediaM.media) * (custoM.custo - mediaM.media))),2) desv "
cQuery += CRLF +"from (Select MCusto.CODEMP codemp , MCusto.mes_ano_ref  refer , "

If cDesvP == 1
   cQuery += CRLF +" trunc((MCusto.custo / VidComp.QtdaVida),2) custo "
Else 
   cQuery += CRLF +" MCusto.custo custo "
EndIf            

cQuery += CRLF +"From (SELECT CODEMP codemp , mes_ano_ref , sum(aprovado)custo "  
cQuery += CRLF +"FROM cob_sinistralidade_ms_int "   
cQuery += CRLF +"WHERE mes_ano_ref BETWEEN to_date('"+cCompte1+"01','YYYYMMDD') AND to_date('"+cCompte12+"01','YYYYMMDD') " 
cQuery += CRLF +"AND CODEMP >= '"+CEmpI+"' AND CODEMP <= '"+CEmpF+"' "
cQuery += CRLF +"GROUP BY codemp  , mes_ano_ref ) MCusto , "

cQuery += CRLF +"         (Select to_date('"+cCompte1+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte1+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte1+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte2+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte2+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte2+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   " 
cQuery += CRLF +"Union All Select to_date('"+cCompte3+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte3+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte3+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte4+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte4+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte4+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "    
cQuery += CRLF +"Union All Select to_date('"+cCompte5+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte5+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte5+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte6+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte6+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte6+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte7+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte7+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte7+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "        
cQuery += CRLF +"Union All Select to_date('"+cCompte8+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte8+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte8+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   " 
cQuery += CRLF +"Union All Select to_date('"+cCompte9+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte9+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte9+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte10+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte10+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte10+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "    
cQuery += CRLF +"Union All Select to_date('"+cCompte11+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte11+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte11+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte12+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte12+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte12+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte13+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte13+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte13+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp ) VidComp "

cQuery += CRLF +"where MCusto.codemp = VidComp.codemp "
cQuery += CRLF +"and MCusto.mes_ano_ref = VidComp.Compte) CustoM , "
 
cQuery += CRLF +"(SELECT MMedia.CODEMP codemp , trunc((sum(MMedia.custo)/12),2) media "
cQuery += CRLF +"FROM (Select MCusto.CODEMP codemp , MCusto.mes_ano_ref  refer,"

If cDesvP == 1
   cQuery += CRLF +" trunc((MCusto.custo / VidComp.QtdaVida),2) custo "
Else 
   cQuery += CRLF +" MCusto.custo custo "
EndIf            

cQuery += CRLF +"From (SELECT CODEMP codemp , mes_ano_ref , sum(aprovado)custo "  
cQuery += CRLF +"FROM cob_sinistralidade_ms_int "   
cQuery += CRLF +"WHERE mes_ano_ref BETWEEN to_date('"+cCompte1+"01','YYYYMMDD') AND to_date('"+cCompte12+"01','YYYYMMDD') " 
cQuery += CRLF +"AND CODEMP >= '"+CEmpI+"' AND CODEMP <= '"+CEmpF+"' "
cQuery += CRLF +"GROUP BY codemp  , mes_ano_ref ) MCusto , "

cQuery += CRLF +"         (Select to_date('"+cCompte1+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte1+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte1+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte2+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte2+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte2+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   " 
cQuery += CRLF +"Union All Select to_date('"+cCompte3+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte3+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte3+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte4+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte4+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte4+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "    
cQuery += CRLF +"Union All Select to_date('"+cCompte5+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte5+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte5+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte6+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte6+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte6+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte7+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte7+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte7+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "        
cQuery += CRLF +"Union All Select to_date('"+cCompte8+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte8+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte8+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   " 
cQuery += CRLF +"Union All Select to_date('"+cCompte9+"01','YYYYMMDD') Compte ,  ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte9+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte9+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp   "
cQuery += CRLF +"Union All Select to_date('"+cCompte10+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte10+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte10+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "    
cQuery += CRLF +"Union All Select to_date('"+cCompte11+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte11+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte11+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte12+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte12+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte12+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp  "
cQuery += CRLF +"Union All Select to_date('"+cCompte13+"01','YYYYMMDD') Compte , ba1_codemp codemp , Count(*) QtdaVida From Ba1020 Ba1  Where Ba1_Filial = ' ' And D_E_L_E_T_ = ' ' And (Ba1_Datblo >= '"+cCompte13+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc  <= '"+cCompte13+"31' And Ba1_Codemp >= '"+CEmpI+"' And Ba1_Codemp <= '"+CEmpF+"' Group By ba1_codemp ) VidComp "

cQuery += CRLF +"where MCusto.codemp = VidComp.codemp "
cQuery += CRLF +"and MCusto.mes_ano_ref = VidComp.Compte) MMedia "           
cQuery += CRLF +"WHERE MMedia.CODEMP >= '"+CEmpI+"' AND MMedia.CODEMP <= '"+CEmpF+"' "
cQuery += CRLF +"GROUP BY MMedia.CODEMP)MediaM "       
cQuery += CRLF +"group by custoM.codemp , custoM.refer) desv1 "
cQuery += CRLF +"where  media1.codemp = desv1.codemp "          
cQuery += CRLF +"group by media1.media, media1.CODEMP)desvios " 

//--------------------------------------------------------

If Select((cAliastmp)) <> 0 
    (cAliastmp)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   

(cAliastmp)->(dbGoTop()) 
  
While (cAliastmp)->(!EOF())

If (cAliastmp)->CustoBase == (cAliastmp)->custoMen1 .and. (cAliastmp)->CustoBase == (cAliastmp)->custoMai1
    nDesv1 := (cAliastmp)->CustoBase
ElseIf (cAliastmp)->CustoBase !=(cAliastmp)->custoMen1
    nDesv1 := (cAliastmp)->custoMen1
ElseIf (cAliastmp)->CustoBase !=(cAliastmp)->custoMai1
    nDesv1 := (cAliastmp)->custoMai1
EndIf     

If (cAliastmp)->CustoBase ==(cAliastmp)->custoMen2 .and. (cAliastmp)->CustoBase == (cAliastmp)->custoMai2
    nDesv2 := (cAliastmp)->CustoBase
ElseIf (cAliastmp)->CustoBase !=(cAliastmp)->custoMen2
    nDesv2 := (cAliastmp)->custoMen2
ElseIf (cAliastmp)->CustoBase !=(cAliastmp)->custoMai2
    nDesv2 := (cAliastmp)->custoMai2
EndIf     

If (cAliastmp)->CustoBase ==(cAliastmp)->custoMen3 .and. (cAliastmp)->CustoBase == (cAliastmp)->custoMai3
    nDesv3 := (cAliastmp)->CustoBase
ElseIf (cAliastmp)->CustoBase !=(cAliastmp)->custoMen3
    nDesv3 := (cAliastmp)->custoMen3
ElseIf (cAliastmp)->CustoBase !=(cAliastmp)->custoMai3
    nDesv3 := (cAliastmp)->custoMai3
EndIf    

		Aadd(aDadosc,{ (cAliastmp)->codemp    ,;
			            (cAliastmp)->refer     ,;
                     (cAliastmp)->QtdaVida  ,;
                     (cAliastmp)->custotot  ,;
                     (cAliastmp)->custobase ,;
                     nDesv1                 ,;
                     nDesv2                 ,;
                     nDesv3                 })

          nDesv0T := nDesv0T + (cAliastmp)->custobase
 	       nDesv1T := nDesv1T + nDesv1  
          nDesv2T := nDesv2T + nDesv2
          nDesv3T := nDesv3T + nDesv3
          nDesv4T := nDesv4T + (cAliastmp)->custotot 
          
          nqtdavid:= nqtdavid + (cAliastmp)->QtdaVida
            
      (cAliastmp)->(DbSkip())                   
    
EndDo

for i=13 to 24
      
      fFazregr(i)

		Aadd(aDadosc,{CEmpI                        ,;
			           fazCmpInd(I)                 ,;
                    fFazRegr(I)                  ,;
                   (nDesv4T/12)                  ,;
                   (nDesv0T/12)                  ,;  
                   (nDesv1T/12)                  ,;
                   (nDesv2T/12)                  ,;
                   (nDesv3T/12)                  })
                   
/*
          nDesv0T := ((nDesv0T - (aDadosc[i-12][5])) + (nDesv0T/12))
          nDesv1T := ((nDesv1T - (aDadosc[i-12][6])) + (nDesv1T/12))  
          nDesv2T := ((nDesv2T - (aDadosc[i-12][7])) + (nDesv2T/12))
          nDesv3T := ((nDesv3T - (aDadosc[i-12][8])) + (nDesv3T/12))
          nDesv4T := ((nDesv4T - (aDadosc[i-12][4])) + (nDesv4T/12))  
*/
          nDesv0T := ((nDesv0T - (aDadosc[(i-12)+nCont][5])) + (nDesv0T/12))
          nDesv1T := ((nDesv1T - (aDadosc[(i-12)+nCont][6])) + (nDesv1T/12))  
          nDesv2T := ((nDesv2T - (aDadosc[(i-12)+nCont][7])) + (nDesv2T/12))
          nDesv3T := ((nDesv3T - (aDadosc[(i-12)+nCont][8])) + (nDesv3T/12))
          nDesv4T := ((nDesv4T - (aDadosc[(i-12)+nCont][4])) + (nDesv4T/12))  

Next 

nCont := nCont + 24

A:='B'

FGrvPlan2()  

Return()

static function fFazRegr(I)

local nX2        := 12*((1*1)+(2*2)+(3*3)+(4*4)+(5*5)+(6*6)+(7*7)+(8*8)+(9*9)+(10*10)+(11*11)+(12*12)) // somatorio dos quadrados das parcelas 
local nSomaX1    := (1+2+3+4+5+6+7+8+9+010+11+12) // somatori das parcelas 
local nXElv2     := nSomaX1 * nSomaX1 // somatori das parcelas 
local nX2_nXElv2 := (nX2 - nXElv2)

Local nTotQtda12 := (aDadosc[(I-12),3] + aDadosc[(I-11),3] + aDadosc[(I-10),3] + aDadosc[(I-9),3] + aDadosc[(I-8),3] + aDadosc[(I-7),3] + aDadosc[(I-6),3] + aDadosc[(I-5),3] + aDadosc[(I-4),3] + aDadosc[(I-3),3] + aDadosc[(I-2),3] + aDadosc[(I-1),3])

Local nExy       := 12*((aDadosc[(I-12),3]*1) + (aDadosc[(I-11),3]*2) + (aDadosc[(I-10),3]*3) + (aDadosc[(I-9),3]*4) + (aDadosc[(I-8),3]*5) + (aDadosc[(I-7),3]*6) + (aDadosc[(I-6),3]*7) + (aDadosc[(I-5),3]*8) + (aDadosc[(I-4),3]*9) + (aDadosc[(I-3),3]*10) + (aDadosc[(I-2),3]*11) + (aDadosc[(I-1),3])*12)

local nExEY      := nSomaX1*nTotQtda12 

local nSXY_SXxSY := nExy - nExEY

local nB         := nSXY_SXxSY / nX2_nXElv2 

local X_         := nSomaX1 / 12

local Y_         := nTotQtda12 / 12

Local A          := Y_ - (nB*X_) 

Local Y          := A + (nB*I)

a:='b'

Return(Y)

/*
6 meses
///////////////////////////////////////

static function fFazRegr(I)

local nX2        := 6*((7*7)+(8*8)+(9*9)+(10*10)+(11*11)+(12*12)) // somatorio dos quadrados das parcelas 
local nSomaX1    := (7+8+9+010+11+12) // somatori das parcelas 
local nXElv2     := nSomaX1 * nSomaX1 // somatori das parcelas 
local nX2_nXElv2 := (nX2 - nXElv2)

Local nTotQtda12 := ( aDadosc[(I-6),3] + aDadosc[(I-5),3] + aDadosc[(I-4),3] + aDadosc[(I-3),3] + aDadosc[(I-2),3] + aDadosc[(I-1),3])

Local nExy       := 6*((aDadosc[(I-6),3]*7) + (aDadosc[(I-5),3]*8) + (aDadosc[(I-4),3]*9) + (aDadosc[(I-3),3]*10) + (aDadosc[(I-2),3]*11) + (aDadosc[(I-1),3])*12)

local nExEY      := nSomaX1*nTotQtda12 

local nSXY_SXxSY := nExy - nExEY

local nB         := nSXY_SXxSY / nX2_nXElv2 

local X_         := nSomaX1 / 6

local Y_         := nTotQtda12 / 6

Local A          := Y_ - (nB*X_) 

Local Y          := A + (nB*I)

a:='b'

Return(Y)
*/
//////////////////////////////////////

Static Function FGrvPlan2()    

   LOCAL nCount:= 1
   // local dDatNom   := stod(' ')
   //cNomDadCab:= 'Dados da Reserva'
   //cComp     :=  cCompte
   //cNomPla   := 'Dados da Reserva'            

   	cNomeArq := "C:\TEMP\DesvioP-"+CEmpI+' - '+ SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)
     
        cMontaTxt := "Codemp     ;" 
        cMontaTxt += "Referencia ;" 
        cMontaTxt += "Qtda Vidas ;" 
        cMontaTxt += "CustoTotal ;"
        cMontaTxt += "CustoBase  ;"
        cMontaTxt += "1Desvio    ;"
        cMontaTxt += "2Desvio    ;"
        cMontaTxt += "3Desvio    ;"
     		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosc)
      
          cMontaTxt := aDadosc[nCount][1] + ";"		 
          cMontaTxt += (aDadosc[nCount][2]) + ";"		
          cMontaTxt += Transform((aDadosc[nCount][3]) ,'@E  999,999,999') + ";"		
          cMontaTxt += Transform((aDadosc[nCount][4]) ,'@E  999,999,999.99') + ";"   
          cMontaTxt += Transform((aDadosc[nCount][5]) ,'@E  999,999,999.99') + ";"  
          cMontaTxt += Transform((aDadosc[nCount][6]) ,'@E  999,999,999.99') + ";"  
          cMontaTxt += Transform((aDadosc[nCount][7]) ,'@E  999,999,999.99') + ";"
          cMontaTxt += Transform((aDadosc[nCount][8]) ,'@E  999,999,999.99') + ";"
      	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra gravação no arquivo?
		FClose(nHandle)
		//cNomeArq+= cNomeArq + CRLF
 	    //MsgAlert("Relatorio salvo em: "+cNomeArq)
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq)

	EndIf                                 
	           
Return ()    
//////////////////////
static function fazcompt(cCompte0)

// comptencia 1 
cCompte1    := cCompte0

// comptencia 2
 cAno        := Substr(cCompte1,1,4)
 cMes        := Substr(cCompte1,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte2    :=cAno+cMes

// comptencia 3
 cAno        := Substr(cCompte2,1,4)
 cMes        := Substr(cCompte2,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte3    :=cAno+cMes

// comptencia 4
 cAno        := Substr(cCompte3,1,4)
 cMes        := Substr(cCompte3,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte4    :=cAno+cMes

// comptencia 5
 cAno        := Substr(cCompte4,1,4)
 cMes        := Substr(cCompte4,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte5    :=cAno+cMes

// comptencia 6
 cAno        := Substr(cCompte5,1,4)
 cMes        := Substr(cCompte5,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte6    :=cAno+cMes

// comptencia 7
 cAno        := Substr(cCompte6,1,4)
 cMes        := Substr(cCompte6,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte7    :=cAno+cMes

// comptencia 8
 cAno        := Substr(cCompte7,1,4)
 cMes        := Substr(cCompte7,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte8    :=cAno+cMes

// comptencia 9
 cAno        := Substr(cCompte8,1,4)
 cMes        := Substr(cCompte8,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte9    :=cAno+cMes

// comptencia 10
 cAno        := Substr(cCompte9,1,4)
 cMes        := Substr(cCompte9,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte10    :=cAno+cMes

// comptencia 11
 cAno        := Substr(cCompte10,1,4)
 cMes        := Substr(cCompte10,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte11    :=cAno+cMes

// comptencia 12
 cAno        := Substr(cCompte11,1,4)
 cMes        := Substr(cCompte11,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte12    :=cAno+cMes

// comptencia 13
 cAno        := Substr(cCompte12,1,4)
 cMes        := Substr(cCompte12,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte13    :=cAno+cMes

// comptencia 14
 cAno        := Substr(cCompte13,1,4)
 cMes        := Substr(cCompte13,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte14    :=cAno+cMes

// comptencia 15
 cAno        := Substr(cCompte14,1,4)
 cMes        := Substr(cCompte14,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte15    :=cAno+cMes

// comptencia 16
 cAno        := Substr(cCompte15,1,4)
 cMes        := Substr(cCompte15,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte16    :=cAno+cMes

// comptencia 17
 cAno        := Substr(cCompte16,1,4)
 cMes        := Substr(cCompte16,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte17    :=cAno+cMes

// comptencia 18
 cAno        := Substr(cCompte17,1,4)
 cMes        := Substr(cCompte17,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte18    :=cAno+cMes

// comptencia 19
 cAno        := Substr(cCompte18,1,4)
 cMes        := Substr(cCompte18,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte19    :=cAno+cMes

// comptencia 20
 cAno        := Substr(cCompte19,1,4)
 cMes        := Substr(cCompte19,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte20    :=cAno+cMes

// comptencia 21
 cAno        := Substr(cCompte20,1,4)
 cMes        := Substr(cCompte20,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte21    :=cAno+cMes

// comptencia 22
 cAno        := Substr(cCompte21,1,4)
 cMes        := Substr(cCompte21,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte22    :=cAno+cMes

// comptencia 23
 cAno        := Substr(cCompte22,1,4)
 cMes        := Substr(cCompte22,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte23    :=cAno+cMes

// comptencia 24
 cAno        := Substr(cCompte23,1,4)
 cMes        := Substr(cCompte23,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cCompte24    :=cAno+cMes

Return()

////////////////////////////

static function fazCmpInd(ind)

local Ret := ' '

   If Ind = 13
      Ret:= cCompte13+'01'
   ElseIf Ind = 14
      Ret:= cCompte14+'01' 
   ElseIf Ind = 15
      Ret:= cCompte15+'01' 
   ElseIf Ind = 16
      Ret:= cCompte16+'01' 
   ElseIf Ind = 17
      Ret:= cCompte17+'01' 
   ElseIf Ind = 18
      Ret:= cCompte18+'01' 
   ElseIf Ind = 19
      Ret:= cCompte19+'01' 
   ElseIf Ind = 20
      Ret:= cCompte20+'01' 
   ElseIf Ind = 21
      Ret:= cCompte21+'01' 
   ElseIf Ind = 22
      Ret:= cCompte22+'01' 
   ElseIf Ind = 23
      Ret:= cCompte23+'01' 
   ElseIf Ind = 24
      Ret:= cCompte24+'01'
   EndIF        
return (Ret)

////////////

static Function VCMH() 

local cQuery    := ' ' 
local cQuery1   := ' ' 
local I         := 0

fazcompt(cCompte0)

/*
--------------------------------------------------------
---- Qtda Vidas atual anterior  
*/
//--------------------------------------------------------

cQuery :=       "select * from ( "
cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte1+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte1+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte2+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte2+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte3+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte3+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte4+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte4+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte5+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte5+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte6+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte6+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte7+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte7+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte8+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte8+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte9+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte9+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte10+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte10+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte11+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte11+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Anterior' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte12+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte12+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte13+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte13+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo ,  ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte14+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte14+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte15+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte15+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo ,  ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte16+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte16+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte17+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte17+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte18+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte18+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte19+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte19+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte20+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte20+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte21+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte21+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte22+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte22+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte23+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte23+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" union all "

cQuery += CRLF +"Select 'Atual' Periodo , ba1_codemp codemp ,  bi3_codigo plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Count(*) QtdaVida "  
cQuery += CRLF +"  From Ba1020 Ba1 , BI3020 BI3 "
cQuery += CRLF +" Where Ba1_Filial = ' ' And ba1.D_E_L_E_T_ = ' '  and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   And (Ba1_Datblo >= '"+cCompte24+"01' Or Ba1_Datblo = ' ') And Ba1_Datinc <= '"+cCompte24+"31' "
cQuery += CRLF +"   And Ba1_Codemp >= '"+cEmpI+"' And Ba1_Codemp <= '"+cEmpF+"' and bi3_codigo = ba1_codpla "
cQuery += CRLF +" group by ba1_codemp , bi3_codigo , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery += CRLF +" )  totqtda "
cQuery += CRLF +" where totqtda.seg <> 'Dental' and totqtda.codemp not in ('0402')"

/////////////////////custo 

cQuery1:=       "select * from ( "
cQuery1+= CRLF +"SELECT  'Anterior' Periodo , codemp codemp , cod_plano plano , trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont ,Sum(APROVADO) CustoANO , Sum(GLOSADO) Glosa , sum(PART) Copart 
cQuery1+= CRLF +"  FROM COB_SINISTRALIDADE_MS_INT , BI3020 BI3 
cQuery1+= CRLF +" where MES_ANO_REF between TO_DATE('"+cCompte1+"01' ,'YYYYMMDD')AND TO_DATE('"+cCompte12+"31' ,'YYYYMMDD')
cQuery1+= CRLF +"   And Codemp >= '"+cEmpI+"' And Codemp <= '"+cEmpF+"'  "
cQuery1+= CRLF +"   and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' 
cQuery1+= CRLF +"   and bi3_codigo = cod_plano
cQuery1+= CRLF +" group by codemp , cod_plano , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "

cQuery1+= CRLF +" union all

cQuery1+= CRLF +"SELECT  'Atual' Periodo , codemp codemp , cod_plano plano,trim(decode(bi3_codseg,'004', 'Dental', 'Saúde')) seg , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , Sum(APROVADO) CustoANO , Sum(GLOSADO) Glosa , sum(PART) Copart 
cQuery1+= CRLF +"  FROM COB_SINISTRALIDADE_MS_INT , BI3020 BI3 
cQuery1+= CRLF +" where MES_ANO_REF between TO_DATE('"+cCompte13+"01' ,'YYYYMMDD')AND TO_DATE('"+cCompte24+"31' ,'YYYYMMDD')
cQuery1+= CRLF +"   And Codemp >= '"+cEmpI+"' And Codemp <= '"+cEmpF+"'  "
cQuery1+= CRLF +"   and Bi3_Filial = ' ' And bi3.D_E_L_E_T_ = ' ' 
cQuery1+= CRLF +"   and bi3_codigo = cod_plano
cQuery1+= CRLF +" group by codemp , cod_plano , decode(bi3_codseg,'004', 'Dental', 'Saúde') , decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros') "
cQuery1+= CRLF +" )  totcusto "
cQuery1+= CRLF +" where totcusto.seg <> 'Dental' and totcusto.codemp not in ('0402')"

//--------------------------------------------------------
//cAliasVcC   Custo 
//cAliasVcV   vidas 
//--------------------------------------------------------

If Select((cAliasVcV)) <> 0 
    (cAliasVcV)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliasVcV)   

(cAliasVcV)->(dbGoTop()) 
  
While (cAliasVcV)->(!EOF())     
	                  
   If (nAscan:=Ascan(aDadosTC , {|e| e[1]+e[2] == (cAliasVcV)->Periodo + (cAliasVcV)->TPCONT})) == 0           
             aaDD(aDadosTC,{(cAliasVcV)->Periodo ,;
                            (cAliasVcV)->TPCONT  ,;
                                          0.00   ,;
                            (cAliasVcV)->QTDAVIDA})                                         
   Else 
    	             aDadosTC[nAscan,4]+= (cAliasVcV)->QTDAVIDA 
   EndIf  

 ///////////////////////////////////  

//////////////////////// plano ///
If (cAliasVcV)->Periodo == 'Anterior'
    QtVidAnt := (cAliasVcV)->QTDAVIDA
Else 
    QtVidAtu := (cAliasVcV)->QTDAVIDA
EndIf 

   If (nAscan:=Ascan(aDadosPL , {|e| e[1]+e[2] ==  trim((cAliasVcV)->TPCONT) + trim((cAliasVcV)->plano)})) == 0           
               aaDD(aDadosPL , {trim((cAliasVcV)->TPCONT),;
                                trim((cAliasVcV)->plano) ,;
                                                   0.00  ,;
                                                 QtVidAnt,;
                                                   0.00  ,;
                                                 QtVidAtu,;
                                                  0.000  })                                         
   Else 
    	             aDadosPL[nAscan,4]+= QtVidAnt
                   aDadosPL[nAscan,6]+= QtVidAtU 
   EndIf
      QtVidAnt:= 0
      QtVidAtU:= 0   
////////////////////////
//////////////////////// CempIesa  ///
If (cAliasVcV)->Periodo == 'Anterior'
    QtVidAnt := (cAliasVcV)->QTDAVIDA
Else 
    QtVidAtu := (cAliasVcV)->QTDAVIDA
EndIf 

 If (nAscan:=Ascan(aDadosEmp , {|e| e[1]+e[2] ==  trim((cAliasVcV)->TPCONT) + trim((cAliasVcV)->CodEmp)})) == 0           
              aaDD(aDadosEmp , {trim((cAliasVcV)->TPCONT),;
                                trim((cAliasVcV)->CodEmp),;
                                ' ' ,;
                                                   0.00  ,;
                                                 QtVidAnt,;
                                                   0.00  ,;
                                                 QtVidAtu,;
                                                  0.000  })                                         
   Else 
    	             aDadosEmp[nAscan,5]+= QtVidAnt
                   aDadosEmp[nAscan,7]+= QtVidAtU 
   EndIf
      QtVidAnt:= 0
      QtVidAtU:= 0   
////////////////////////

//////////////////////// CempIesa plano ///
If (cAliasVcV)->Periodo == 'Anterior'
    QtVidAnt := (cAliasVcV)->QTDAVIDA
Else 
    QtVidAtu := (cAliasVcV)->QTDAVIDA
EndIf 

 If (nAscan:=Ascan(aDadosEPL , {|e| e[1]+e[2]+e[3] ==  trim((cAliasVcV)->TPCONT) + trim((cAliasVcV)->CodEmp)+trim((cAliasVcV)->plano)})) == 0           
              aaDD(aDadosEPL , {trim((cAliasVcV)->TPCONT),;
                                trim((cAliasVcV)->CodEmp),;
                                trim((cAliasVcV)->plano) ,;
                                                   0.00  ,;
                                                 QtVidAnt,;
                                                   0.00  ,;
                                                 QtVidAtu,;
                                                  0.000  })                                         
   Else 
    	             aDadosEPL[nAscan,5]+= QtVidAnt
                   aDadosEPL[nAscan,7]+= QtVidAtU 
   EndIf
      QtVidAnt:= 0
      QtVidAtU:= 0   
////////////////////////

   (cAliasVcV)->(DbSkip())                   
    
EndDo

If Select((cAliasVcC)) <> 0 
    (cAliasVcC)->(DbCloseArea())  
Endif 
        
TCQuery cQuery1  New Alias (cAliasVcC)   

(cAliasVcC)->(dbGoTop()) 
  
While (cAliasVcC)->(!EOF())     

   If (nAscan:=Ascan(aDadosTC , {|e| e[1]+e[2] == (cAliasVcC)->Periodo + (cAliasVcC)->TPCONT})) == 0           
              aaDD(aDadosTC,{(cAliasVcC)->Periodo ,;
                             (cAliasVcC)->TPCONT  ,;
                             (cAliasVcC)->CUSTOANO,;
                              0                   })                                         
   Else 
    	             aDadosTC[nAscan,3]+= (cAliasVcC)->CUSTOANO  
   EndIf  

//////////////////////////////////plano////////////////
   If (cAliasVcC)->Periodo == 'Anterior'
      CustoAnt := (cAliasVcC)->CUSTOANO
   Else 
      CustoAtu              := (cAliasVcC)->CUSTOANO
   EndIf 

   If (nAscan:=Ascan(aDadosPL , {|e| e[1]+e[2] ==  trim((cAliasVcC)->TPCONT) + trim((cAliasVcC)->plano) })) == 0           
              aaDD(aDadosPL , {trim((cAliasVcC)->TPCONT)  ,;
                               trim((cAliasVcC)->plano)   ,;
                                           CustoAnt ,;
                                             0      ,;
                                           CustoAtu ,;
                                             0      ,;
                                             0.000  })                                         
   Else 
    	             aDadosPL[nAscan,3]+= CustoAnt
    	             aDadosPL[nAscan,5]+= CustoAtu                               
   EndIf

      CustoAnt:= 0.00
      CustoAtu:= 0.00                    
/////////////////////////////////

//////////////////////////////////CempIesa ////////////////
   If (cAliasVcC)->Periodo == 'Anterior'
      CustoAnt := (cAliasVcC)->CUSTOANO
   Else 
      CustoAtu := (cAliasVcC)->CUSTOANO
   EndIf 

   If (nAscan:=Ascan(aDadosEmp , {|e| e[1]+e[2] ==  trim((cAliasVcC)->TPCONT) + trim((cAliasVcC)->codemp )})) == 0           
                aaDD(aDadosEmp , {trim((cAliasVcC)->TPCONT)  ,;
                               trim((cAliasVcC)->codemp)   ,;
                               ' '                         ,;
                                           CustoAnt        ,;
                                             0             ,;
                                           CustoAtu        ,;
                                             0             ,;
                                             0.000         })                                         
   Else 
    	             aDadosEmp[nAscan,4]+= CustoAnt
    	             aDadosEmp[nAscan,6]+= CustoAtu                               
   EndIf

      CustoAnt:= 0.00
      CustoAtu:= 0.00                    
/////////////////////////////////

//////////////////////////////////CempIesa / plano////////////////
   If (cAliasVcC)->Periodo == 'Anterior'
      CustoAnt := (cAliasVcC)->CUSTOANO
   Else 
      CustoAtu := (cAliasVcC)->CUSTOANO
   EndIf 

   If (nAscan:=Ascan(aDadosEPL , {|e| e[1]+e[2]+e[3] ==  trim((cAliasVcC)->TPCONT) + trim((cAliasVcC)->codemp )+ trim((cAliasVcC)->plano) })) == 0           
              aaDD(aDadosEPL , {trim((cAliasVcC)->TPCONT)  ,;
                               trim((cAliasVcC)->codemp)  ,;
                               trim((cAliasVcC)->plano)   ,;
                                           CustoAnt ,;
                                             0      ,;
                                           CustoAtu ,;
                                             0      ,;
                                             0.000  })                                         
   Else 
    	             aDadosEPL[nAscan,4]+= CustoAnt
    	             aDadosEPL[nAscan,6]+= CustoAtu                               
   EndIf

      CustoAnt:= 0.00
      CustoAtu:= 0.00                    
/////////////////////////////////

   (cAliasVcC)->(DbSkip())                   
    
EndDo

for I:=1 to len(aDadosTC)

   If  trim(aDadosTC[I,1]) == 'Anterior'

       nVlrAntT+= aDadosTC[I,3]
       nQtdAntT+= aDadosTC[I,4]

       If  trim(aDadosTC[I,2]) == 'Col. CempIesarial'

           nQtdAntE+= aDadosTC[I,4]
           nVlrAntE+= aDadosTC[I,3]

       Else  

           nQtdAntA+= aDadosTC[I,4]
           nVlrAntA+= aDadosTC[I,3]

       EndIf   

   Else 

       nQtdAtuT+= aDadosTC[I,4]
       nVlrAtuT+= aDadosTC[I,3]

       If  trim(aDadosTC[I,2]) == 'Col. CempIesarial'

           nQtdAtuE+= aDadosTC[I,4]
           nVlrAtuE+= aDadosTC[I,3]

       Else  

           nQtdAtuA+= aDadosTC[I,4]
           nVlrAtuA+= aDadosTC[I,3]

       EndIf

   EndIF      

Next   
 
 nVcmhEmp := (((nVlrAtuE/nQtdAtuE) / (nVlrAntE/nQtdAntE) ) -1)*100

 nVcmhAds:=  (((nVlrAtuA/nQtdAtuA) / (nVlrAntA/nQtdAntA) ) -1)*100

 nVcmhTot:=  (((nVlrAtuT/nQtdAtuT) / (nVlrAntT/nQtdAntT) ) -1)*100


FGrvPlan4()

return()

////////////Meta de Vneda 
static Function MetaVenda() 

local cQuery    := ' ' 

fazcompt(cCompte0)
a:='b'

cQuery :=       "select distinct  est.codemp ,est.NomEmp  , est.TpPlano ,est.tpCont, est.qtdatot  estoque , " 
cQuery += CRLF +"       nvl(inc.qtdatot,0) inc ,  nvl(Bloq.qtdatot,0) Bloq "
cQuery += CRLF +"  from "
cQuery += CRLF +"       (SELECT BA1_CODEMP CODEMP , trim(bg9_descri) NomEmp , decode(bi3_codseg,'004', 'Odontologico' , 'Saude') TpPlano ,trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , COUNT(*) QTDATOT "    
cQuery += CRLF +"          FROM BA1020  BA1 , bi3020 bi3 , bg9020 bg9 "
cQuery += CRLF +"         where BA1_filial = ' ' AND BA1.D_e_l_e_t_ = ' ' "  
cQuery += CRLF +"           and bi3_filial = ' ' and bi3.d_E_L_E_T_ = ' ' "
cQuery += CRLF +"           and bg9_filial = ' ' and bg9.d_E_L_E_T_ = ' ' "
cQuery += CRLF +"           and (ba1_datblo = ' ' or ba1_datblo > '"+cCompte1+"31') and ba1_datinc <= '"+cCompte1+"31'" 
cQuery += CRLF +"           AND ba1_codemp >= '"+cEmpI+"' AND ba1_codemp <= '"+cEmpF+"'     
cQuery += CRLF +"           and bi3_codigo  =  ba1_CODPLA "
cQuery += CRLF +"           and bg9_codigo  = ba1_codemp " 
cQuery += CRLF +"         GROUP BY BA1_CODEMP , bi3_codseg , bi3_tipcon, bg9_descri ) est , " 
cQuery += CRLF +"       (SELECT BA1_CODEMP CODEMP , decode(bi3_codseg,'004', 'Odontologico' , 'Saude') TpPlano ,trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , COUNT(*) QTDATOT "   
cQuery += CRLF +"          FROM BA1020  BA1 , bi3020 bi3 "  
cQuery += CRLF +"         where BA1_filial =' ' AND BA1.D_e_l_e_t_ = ' ' "  
cQuery += CRLF +"           and ba1_datinc > '"+cCompte1+"31+' and ba1_datinc <= '"+cCompte2+"31'" 
cQuery += CRLF +"           AND ba1_codemp >= '"+cEmpI+"' AND ba1_codemp <= '"+cEmpF+"'    
cQuery += CRLF +"           and bi3_filial = ' ' and bi3.d_E_L_E_T_ = ' ' " 
cQuery += CRLF +"           and bi3_codigo =  ba1_CODPLA "
cQuery += CRLF +"         GROUP BY BA1_CODEMP , bi3_codseg , bi3_tipcon) inc , " 
cQuery += CRLF +"       (SELECT BA1_CODEMP CODEMP ,decode(bi3_codseg,'004', 'Odontologico' , 'Saude') TpPlano , trim(decode(trim(bi3_tipcon),'1','Individual','2','Familiar' ,'3','Col. Adesão', '4', 'Col. CempIesarial' , 'outros')) tpCont , COUNT(*) QTDATOT "    
cQuery += CRLF +"          FROM BA1020  BA1 , bi3020 bi3 "  
cQuery += CRLF +"         where BA1_filial =' ' AND BA1.D_e_l_e_t_ = ' ' "   
cQuery += CRLF +"           and ba1_datblo > '"+cCompte1+"31' and ba1_datblo <= '"+cCompte2+"31'" 
cQuery += CRLF +"           AND ba1_codemp >= '"+cEmpI+"' AND ba1_codemp <= '"+cEmpF+"'
cQuery += CRLF +"           and bi3_filial = ' ' and bi3.d_E_L_E_T_ = ' ' "
cQuery += CRLF +"           and bi3_codigo =  ba1_CODPLA "
cQuery += CRLF +"         GROUP BY BA1_CODEMP , bi3_codseg , bi3_tipcon) bloq " 
cQuery += CRLF +" where  est.codemp = inc.codemp(+)     "
cQuery += CRLF +"   and  est.codemp = bloq.codemp(+)    "  
cQuery += CRLF +"   and  est.TpPlano   = inc.TpPlano(+) "   
cQuery += CRLF +"   and  est.TpPlano   = bloq.TpPlano(+) "  
cQuery += CRLF +" order by 1,3 "


If Select((cAliasMV)) <> 0 
    (cAliasMV)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliasMV)   

(cAliasMV)->(dbGoTop()) 
  
While (cAliasMV)->(!EOF())     
	                  
   aaDD(aDadosMV,{(cAliasMV)->CODEMP  ,;
                  (cAliasMV)->NOMEMP  ,;
                  (cAliasMV)->TPPLANO ,;
                  (cAliasMV)->TPCONT  ,;
                  (cAliasMV)->ESTOQUE ,;
                  (cAliasMV)->INC     ,;
                  (cAliasMV)->BLOQ    })                                         

   (cAliasMV)->(DbSkip())                   

ENDDO

   FGrvPlan5()

Return()

//////////////////////

Static Function AjustaSX1(cPerg)

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe a Compte Inicial")
U_CABASX1(cPerg , "01" , "Compte Inicial(AAAAMM)","","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe CempIesa Inicial")
U_CABASX1(cPerg , "02" , "CempIesa Inicial" ,"","","mv_ch2","C",4,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe CempIesa Final")
U_CABASX1(cPerg , "03" , "CempIesa Final" ,"","","mv_ch3","C",4,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Desvio ")
U_CABASX1(cPerg,"04", "Tp Desvio "        ,"","","mv_ch4","N",1,0,1,"C","","","","","mv_par04","Custo Per capto","","","","Custo Medio ","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "CempIesa ")
U_CABASX1(cPerg,"05", "Status Da CempIesa "        ,"","","mv_ch5","N",1,0,1,"C","","","","","mv_par04","Ativas","","","","Todas ","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Programa ")
U_CABASX1(cPerg,"06", "Tp De Saida "   ,"","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Safra","","","","Desvio Pdrao ","","","VCMH","","","","","","","","",aHelp,aHelp,aHelp)
/*
aAdd(aHelp, "Com Lote de de Faturamento ")
U_CABASX1(cPerg,"07","Lote Faturamento "   ,"","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Com Lote Fat","","","","Sem Lote Fat","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Lançamento de Faturamento Inicial ")
U_CABASX1(cPerg , "08" , "Lot Fatur. inicial " ,"","","mv_ch8","C",12,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Lançamento de Faturamento Final ")
U_CABASX1(cPerg , "09" , "Lot Fatur. Final" ,"","","mv_ch9","C",12,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , seleção da janela")
U_CABASX1(cPerg , "10" , "Dt do Processamento De " ,"","","mv_ch10","D",08,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , seleção da janela")
U_CABASX1(cPerg , "11" , "Dt do Processamento Ate" ,"","","mv_ch11","D",08,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Matricula completa 16 caracteres , sem o digito , Inicial ")
U_CABASX1(cPerg , "12" , "Matricula Inicial (S/digito)" ,"","","mv_ch12","C",16,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Matricula completa 16 caracteres , sem o digito , Final ")
U_CABASX1(cPerg , "13" , "Matricula Final (S/digito) " ,"","","mv_ch13","C",16,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
*/
Return()

static function fcompt(cCompte)

 cAno        := Substr(cCompte,1,4)
 cMes        := Substr(cCompte,5,2)

If val(cMes)+1 == 13 
   cAno := strzero((val(cAno)+1),4)
   cMes := '01'
Else 
   cMes:=strzero((val(cMes)+1),2)
EndIF 

cComptblo:= cAno + cMes 

Return(cComptblo)
