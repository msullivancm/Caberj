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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR189   บ Autor ณAltamiro              บ Data ณ 18/05/2018บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para atualizar tabela de controle de Debito/Credito บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABA168()

Local cMsg			:= ""      
Local nCont			:= 0
Private cDpj        := 'Nใo'   
private cImp        := 'Nใo' 
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABA168"
Private cTitulo     := "sele็ใo para pagamento da solutiom  "
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .T.
private lDesfaz     := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         
PRIVATE cEmpresa    :=  Iif(cempant == '01','Caberj','Integral')  
Private cAliastmp   := GetNextAlias()
Private cAliasCmp   := GetNextAlias()

Private cAliasADB   := GetNextAlias()

Private aDados      := {}
Private aDadoCons   := {}
private cDiaFim     :='30'

private cAno        := 0
private cMes        := 0
private cCompte     :='202003'

private cAnoP       := 0
private cMesP       := 0
private cCompteP    :=' '

private cAnoPP      := 0
private cMesPP      := 0
private cComptePP   :=' '

private cAnoPPP     := 0
private cMesPPP     := 0
private cComptePPP  :=' '

private cdate       := ' '

private 	cCodEmp    := ' ' 

private  ctpproj := ' ' 

// fAchaComp()
 
 Processa({||Processa()}, cTitulo, "", .T.) 

//Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Processa()  

local cQuery := ' ' 


/*
cQuery :=       " select ba1_codint codint , "
cQuery += CRLF +"        ba1_codemp codemp , "
cQuery += CRLF +"        ba1_matric matric , "
cQuery += CRLF +"        ba1_tipreg tipreg , "
cQuery += CRLF +"        ba1_digito digito , "
cQuery += CRLF +"        ba1_nomusr nomusr , "
cQuery += CRLF +"        ba1_datinc datinc , "
cQuery += CRLF +"        ba1_datblo datblo , "
cQuery += CRLF +"        ba1_motblo motblo , "
cQuery += CRLF +"        ba1_consid consid , "
cQuery += CRLF +"        ba1_codpla codpla , "
cQuery += CRLF +"        '1'        tppgto , "
cQuery += CRLF +"        24.40      vlrpgo   "
cQuery += CRLF +"   from "+ RetSqlName("BA1") +" BA1 "
cQuery += CRLF +"  where ba1_filial = '"+xFilial("BA1")+"'"
cQuery += CRLF +"    and d_E_L_E_T_ = ' ' "
cQuery += CRLF +"    and ba1_datinc <= '"+cCompte+"31' "
cQuery += CRLF +"    and (ba1_datblo > '"+cCompte+"31'  or ba1_datblo = ' ' )"
cQuery += CRLF +"    and ba1_codpla in ('0094','0095','0096','0106','0111','0112','0113','0115') " 

cQuery += CRLF +"union all "

cQuery += CRLF +" select ba1_codint codint , "
cQuery += CRLF +"        ba1_codemp codemp , "
cQuery += CRLF +"        ba1_matric matric , "
cQuery += CRLF +"        ba1_tipreg tipreg , "
cQuery += CRLF +"        ba1_digito digito , "
cQuery += CRLF +"        ba1_nomusr nomusr , "
cQuery += CRLF +"        ba1_datinc datinc , "
cQuery += CRLF +"        ba1_datblo datblo , "
cQuery += CRLF +"        ba1_motblo motblo , "
cQuery += CRLF +"        ba1_consid consid , "
cQuery += CRLF +"        ba1_codpla codpla , "
cQuery += CRLF +"        '2'        tppgto , "
cQuery += CRLF +"        10.40      vlrpgo   "
cQuery += CRLF +"   from "+ RetSqlName("BA1") +" BA1 "
cQuery += CRLF +"  where ba1_filial = '"+xFilial("BA1")+"'"
cQuery += CRLF +"    and d_E_L_E_T_ = ' ' "
cQuery += CRLF +"    and ba1_datinc <= '"+cCompte+"31' "
cQuery += CRLF +"    and (ba1_datblo > '"+cCompte+"31'  or ba1_datblo = ' ' )"
cQuery += CRLF +" and ba1_codpla in ('0094','0095','0096','0106','0111','0112','0113','0115') " 



select
       BA1_CODPLA
       PDR_TPPGTO  , 
       PDR_VLRPGT  , COUNT(*) QTDA 
       
  from BA1020  BA1 , SIGA.PDR020 PDR
 where BA1_filial = ' ' and BA1.d_E_L_E_T_ = ' ' 
   AND PDR_filial = ' ' and PDR.d_E_L_E_T_ = ' '
   and ba1_datinc <= '20200331' 
   and (ba1_datblo > '20200331'  or ba1_datblo = ' ' )
   AND PDR_COMPTI<= '202003' AND (PDR_COMPTF>= '202003' OR PDR_COMPTF = ' ')
   and ba1_codpla in PDR_CODPLA
   GROUP BY  BA1_CODPLA , PDR_TPPGTO , PDR_VLRPGT   
   ORDER BY BA1_CODPLA , PDR_TPPGTO , PDR_VLRPGT
 ;*/



CQuery :="        select distinct ba1_codint codint , 
CQuery += CRLF +"        ba1_codemp codemp , 
CQuery += CRLF +"        ba1_matric matric , 
CQuery += CRLF +"        ba1_tipreg tipreg , 
CQuery += CRLF +"        ba1_digito digito , 
CQuery += CRLF +"        ba1_nomusr nomusr , 
CQuery += CRLF +"        ba1_datinc datinc , 
CQuery += CRLF +"        ba1_datblo datblo , 
CQuery += CRLF +"        ba1_motblo motblo , 
CQuery += CRLF +"        ba1_consid consid , 
CQuery += CRLF +"        ba1_codpla codpla , 
CQuery += CRLF +"        PDR_TPPGTO tppgto , 
CQuery += CRLF +"        PDR_VLRPGT vlrpgo ,  
CQuery += CRLF +"        PDR_CODDB  CODDB   

CQuery += CRLF +"   from "+ RetSqlName("BA1") +" BA1 ,"+ RetSqlName("PDR") +" PDR "
cQuery += CRLF +"  where ba1_filial = '"+xFilial("BA1")+"' and BA1.d_E_L_E_T_ = ' ' "
cQuery += CRLF +"    and PDR_filial = '"+xFilial("PDR")+"' and PDR.d_E_L_E_T_ = ' ' "

cQuery += CRLF +"    and ba1_datinc <= '"+cCompte+"31' "
cQuery += CRLF +"    and (ba1_datblo > '"+cCompte+"01'  or ba1_datblo = ' ' )"

cQuery += CRLF +"    and PDR_COMPTI<= '"+cCompte+"' AND (PDR_COMPTF>= '"+cCompte+"' OR PDR_COMPTF = ' ') "
//cQuery += CRLF +"  and ( ba1_codpla = PDR_CODPLA or  ba1_codemp = PDR_CODemp "
   
cQuery += CRLF +" And ((Pdr_Codpla <> ' ' And Pdr_Codpla = Ba1_Codpla And Pdr_Codemp <> ' ' And Ba1_Codemp = Pdr_Codemp) "   
cQuery += CRLF +"  Or  (Pdr_Codpla <> ' ' And Pdr_codpla  = Ba1_Codpla And Pdr_Codemp = ' ' )     "
cQuery += CRLF +"  Or  (Pdr_Codpla  = ' ' And Pdr_Codemp <> ' '       And Ba1_Codemp = Pdr_Codemp)) "   
cQuery += CRLF +"  order by ba1_codemp , ba1_matric , ba1_tipreg ,  pdr_coddb "
   
   If Select((cAliastmp)) <> 0 
    (cAliastmp)->(DbCloseArea())  
   Endif         
 
   TCQuery cQuery  New Alias (cAliastmp)   

  (cAliastmp)->(dbGoTop()) 
  
   While (cAliastmp)->(!EOF())         

   		Aadd(aDados,{ trim(cCompte)                , ;
                       trim((cAliastmp)->codint)    , ;
   	    				  trim((cAliastmp)->CodEmp)    , ;
   			    		  trim((cAliastmp)->Matric)    , ;
					        trim((cAliastmp)->TipReg)    , ;
					        trim((cAliastmp)->Digito)    , ; 
    				        Trim((cAliastmp)->nomusr)    , ;
	   				     Trim((cAliastmp)->Datinc)    , ;
                       Trim((cAliastmp)->Datblo)    , ;
		   			     Trim((cAliastmp)->motblo)    , ;
                       Trim((cAliastmp)->consid)    , ;
		   			     Trim((cAliastmp)->codpla)    , ;
                       Trim((cAliastmp)->tppgto)    , ;
                            (cAliastmp)->vlrpgo     , ;
                            (cAliastmp)->coddb      } )
	   
         (cAliastmp)->(DbSkip())
   EndDo 

ASort(aDados , , , {|x,y|x[1]+x[3]+x[4]+x[5]+x[12]+x[13] < y[1]+y[3]+y[4]+y[5]+y[12]+y[13]})    

   FGrvPlan()

   FGrvPDQ() 

   If  msgyesno("Deseja fazer os lan็amentos de Creditos para os RDA's listados ? ")

       MsgAlert("Rotina Em Constru็ใo!!!","Aten็ใo!")
    //   FGrvBGQ() 

   EndIf
 
RETURN 



Static Function AjustaSX1(cPerg)

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Data De  : ","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" })
aAdd(aRegs,{cPerg,"02","Data Ate : ","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" })
aadd(aRegs,{cPerg,"03","Quebra Por escritorio ?","","","mv_ch3","N", 1,0,0,"C","","mv_par03","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)

Static Function FGrvPlan()    

   cNomDadCab:=  '1 - Dados Analisados  '
   cComp     :=   cCompte
   cNomPla   := 'Base Analisada '                   
 
     	cNomeArq := "C:\TEMP\"+cCompte+" - solution - "+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)
      
      cMontaTxt := cNomDadCab
      cMontaTxt += CRLF
      
      FWrite(nHandle,cMontaTxt)        		 
      
      cMontaTxt := 'Competencia :'+  cCompte
      cMontaTxt += CRLF
      
      FWrite(nHandle,cMontaTxt)		 
      
      cMontaTxt := 'Planilha : Solution'  
      cMontaTxt += CRLF
      
      FWrite(nHandle,cMontaTxt)	
        
      cMontaTxt := "Competencia ;" 
      cMontaTxt += "Matricula  ;" 
      cMontaTxt += "Nome Usuario ;" 
      cMontaTxt += "Cod Plano  ;" 
		cMontaTxt += "Data Inclusao;"      
   	cMontaTxt += "Data bloqueio;" 
	   cMontaTxt += "Tp Atendimento ;"    
		cMontaTxt += "Valor      ;"    
      cMontaTxt += "Cod Deb/Cre ;"    
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDados)
      
         If aDados[nCount,13] == '01'    
            cTpProj := 'Consulta'  
         ElseIf aDados[nCount,13] == '02'  
            cTpProj := 'HM' 
         Else    
            cTpProj := 'Nใo Cadastrado' 
         EndIF    
      
         cMontaTxt := trim(aDados[nCount][1])+ ";"		 
         cMontaTxt += trim(aDados[nCount][2])+'.'+trim(aDados[nCount][3])+'.'+trim(aDados[nCount][4])+'.'+trim(aDados[nCount][5])+'-'+trim(aDados[nCount][6])+ ";"		
         cMontaTxt += trim(aDados[nCount][7])  + ";"		
         cMontaTxt += trim(aDados[nCount][12]) + ";"		 
         cMontaTxt += substr(aDados[nCount][8],7,2) +'/'+substr(aDados[nCount][8],5,2) +'/'+substr(aDados[nCount][8],1,4) + ";"
         cMontaTxt += substr(aDados[nCount][9],7,2) +'/'+substr(aDados[nCount][9],5,2) +'/'+substr(aDados[nCount][9],1,4) + ";" 
         cMontaTxt += cTpProj  +";"           	
         cMontaTxt += Transform(aDados[nCount][14],'@E  999,999.99')+ ";"            	          		          
		   cMontaTxt += trim(aDados[nCount][15])  + ";"
    	   cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		   FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		//cNomeArq+= cNomeArq + CRLF
 	    //MsgAlert("Relatorio salvo em: "+cNomeArq)
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq)

	EndIf                                 
		
Return ()    
///////

//////

Static Function FGrvPDQ()  

LOCAL cRDAAud := ' '  
LOCAL c_Nivel := "2" 
LOCAL cCodBD  := ' ' 



   For nCount:=1 to len(aDados)     

        cCodBD :=' '  	    
/////////////////////////////////////////////        
//////Registra lan็amento Para base de pagto solution

		   PDQ->(Reclock("PDQ",.T.))	
		
			   PDQ->PDQ_FILIAL := xFilial("PDQ")
               PDQ->PDQ_CODINT := aDados[nCount][2] 
               PDQ->PDQ_CODEMP := aDados[nCount][3] 
               PDQ->PDQ_MATRIC := aDados[nCount][4] 
               PDQ->PDQ_TIPREG := aDados[nCount][5] 
               PDQ->PDQ_DIGITO := aDados[nCount][6] 
               PDQ->PDQ_NOMUSR := aDados[nCount][7] 
               PDQ->PDQ_DATINC := STOD(aDados[nCount][8]) 
               PDQ->PDQ_DATBLO := STOD(aDados[nCount][9])  
               PDQ->PDQ_MOTBLO := aDados[nCount][10] 
               PDQ->PDQ_REFBLO := aDados[nCount][11] 
               PDQ->PDQ_TPPGTO := aDados[nCount][13] 
               PDQ->PDQ_VLRPGT := aDados[nCount][14] 
               PDQ->PDQ_COMPTE := aDados[nCount][1]
               PDQ->PDQ_CLNCDB := aDados[nCount][15] 
               PDQ->PDQ_NUMLOT := ' '  
               PDQ->PDQ_CODDC  := ' ' 
               PDQ->PDQ_CODPLA := aDados[nCount][12]
               
	      PDQ->(MsUnlock())
	    
 Next 
 	 			
return()   

Static Function fVerfBgq() 

   cQuery := "      Select BGQ_CODIGO , BGQ_ANO , BGQ_MES , BGQ_numlot FROM " + RetSqlName("BGQ") +  " BGQ" 
   cQuery += CRLF +" WHERE BGQ_FILIAL = '" + xFilial("BGQ") +"' AND D_E_L_E_T_ = ' '  "
   cQuery += CRLF +"   AND BGQ_CODIGO = '145246' "
   cQuery += CRLF +"   AND BGQ_ANO	  = '"+cCompAno+"' "
   cQuery += CRLF +"   AND BGQ_MES	  = '"+cCompMes+"' "
                     
If Select(("TMP")) <> 0 

   ("TMP")->(DbCloseArea()) 

Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
If !EMPTY(tmp->BGQ_CODIGO) 
    lRet := .T.
    If  EMPTY(tmp->BGQ_numlot)
        lFaturado := .F.
    Else               
        lFaturado := .T.
    EndIf    
Else          
    lRet := .F.
EndIf      

return(lRet)                                        
/// 

Static Function fLimpbgq()                              

   cQuery :=       " DELETE " + RetSqlName("BGQ") +  " BGQ" 
   cQuery += CRLF +" WHERE BGQ_FILIAL = '" + xFilial("BGQ") +"' AND D_E_L_E_T_ = ' '  "
   cQuery += CRLF +"   AND BGQ_CODIGO = '145246' "
   cQuery += CRLF +"   AND BGQ_ANO	  = '"+cCompAno+"' "
   cQuery += CRLF +"   AND BGQ_MES	  = '"+cCompMes+"' " 
   cQuery += CRLF +"   AND Trim(BGQ_numlot) is null  "
   
    nSucesso += TcSqlExec(cQuery)	
    
return(lRet)                                        

Static Function fAchaComp()                              

local cQuery := ' ' 

cQuery := CRLF + "    SELECT NVL(MAX(PDQ_COMPTE),' ') COMPTE " 
cQuery += CRLF + "      FROM "+ RetSqlName("PDQ") +" PDQ " 

cQuery += CRLF + "     WHERE PDQ_FILIAL = '" + xFilial("PDQ") + "'" 
cQuery += CRLF + "       AND PDQ.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "       AND PDQ_CODDC <> ' ' "
   
   
   If Select((cAliasCmp)) <> 0 
   
   (cAliasCmp)->(DbCloseArea())  
  
   Endif 
        
   TCQuery cQuery  New Alias (cAliasCmp)   

   (cAliasCmp)->(dbGoTop()) 
  
  
 If (cAliasCmp)->(!EOF()) .and. (cAliasCmp)->COMPTE <> ' '  
 
     cano := val(substr((cAliasCmp)->COMPTE,1,4))
     cmes := val(substr((cAliasCmp)->COMPTE,5,2))
  
     //rever
     If cmes < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf 
     
     cCompte := strzero(cano,4)+strzero(cmes,2)
     
 Else 

     MsgAlert("A Ultima Comptencia Nao esta Fechada , Aguarde Fechamento ","Atencao!")  
   
  EndIf     

   cCompte :='202003'

return() 

//////

Static Function fGrvBGQ()  

LOCAL cRDAAud := ' '  
LOCAL c_Nivel := "2" 
LOCAL cCodBD  := ' ' 
local cQuery  := ' ' 


cQuery := CRLF +" SELECT PDQ_COMPTE COMPTE , PDQ_CODEMP codemp , PDQ_CODPLA codpla , PDQ_TPPGTO tppgto, PDQ_CLNCDB CLNCDB, COUNT(*) QTDA,  SUM(PDQ_VALOR) VALOR "
cQuery += CRLF +"   from "+ RetSqlName("PDQ") +" PDQ "
cQuery += CRLF +"  where ba1_filial = '"+xFilial("PDQ")+"'"
cQuery += CRLF +"    and d_E_L_E_T_ = ' ' "
 Query += CRLF +"    AND PDQ_CODDC  = ' '  "
cQuery += CRLF +"  GROUP BY PDQ_COMPTE , PDQ_CODEMP , PDQ_CODPLA , PDQ_TPPGTO , PDQ_CLNCDB"
cQuery += CRLF +"  ORDER BY PDQ_COMPTE , PDQ_CODEMP , PDQ_CODPLA , PDQ_TPPGTO , PDQ_CLNCDB"

   If Select((cAliastmp)) <> 0 

    (cAliastmp)->(DbCloseArea())  

   Endif 
        
   TCQuery cQuery  New Alias (cAliastmp)   

   (cAliastmp)->(dbGoTop()) 
    
   While (cAliastmp)->(!EOF()) 
           
      cTpPgto := Iif((cAliastmp)->TPPGTO =='1','Consulta',Iif((cAliastmp)->TPPGTO=='2','H.M','Nใo Determinado')) 	 

      cCodLan := PDQ_CLNCDB
		
      BBB->(MsSeek(xFilial("BBB")+ (cAliastmp)->cCodlan))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Necessario truncar casas decimais, lancando centavo no ultimo adic. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู					
	 	BGQ->(Reclock("BGQ",.T.))	
		
      	BGQ->BGQ_FILIAL	   := xFilial("BGQ") 
			BGQ->BGQ_CODSEQ	   := GETSX8NUM("BGQ","BGQ_CODSEQ")
			BGQ->BGQ_CODIGO	   := 'SOLUTI' 
			BGQ->BGQ_NOME	      := 'solution ' // --Posicione("BAU",1,xFilial("BAU")+(cAliastmp)->PDM_CODRDA,"BAU_NOME")
			BGQ->BGQ_ANO	      := substr((cAliastmp)->compte,1,4) 
			BGQ->BGQ_MES	      := substr((cAliastmp)->compte,5,2)
			BGQ->BGQ_CODLAN	   := (cAliastmp)->CLNCDB
			BGQ->BGQ_VALOR	      := (cAliastmp)->VALOR
			BGQ->BGQ_QTDCH	      := 0
			BGQ->BGQ_TIPO	      := "2" //Credito
			BGQ->BGQ_TIPOCT	   := "2" //PJ
			BGQ->BGQ_INCIR	      := BBB->BBB_INCIR
			BGQ->BGQ_INCINS	   := BBB->BBB_INCINS
			BGQ->BGQ_INCPIS	   := BBB->BBB_INCPIS
			BGQ->BGQ_INCCOF	   := BBB->BBB_INCCOF
			BGQ->BGQ_INCCSL	   := BBB->BBB_INCCSL
			BGQ->BGQ_VERBA	      := BBB->BBB_VERBA
			BGQ->BGQ_CODOPE	   := '0001'
			BGQ->BGQ_CONMFT	   := "0" //Nao
   	   BGQ->BGQ_ATIVO       := '1'
			BGQ->BGQ_OBS	      := "PGTO SOLUTION - Ref: "+(cAliastmp)->COMPTE+" - "+cTppgto +" - " +(cAliastmp)->CODEMP 
			BGQ->BGQ_USMES	      := 0
			BGQ->BGQ_LANAUT	   := "0" //Nao   
			
			BGQ->BGQ_ITECTA      := (cAliastmp)->CODPLA   
	      BGQ->BGQ_CLVL        := (cAliastmp)->CODEMP
         BGQ->BGQ_CODEMP      := (cAliastmp)->CODEMP

	    	BGQ->BGQ_YLTAUD	   :=' '  
		
		   cCodBD               := BGQ->BGQ_CODSEQ 
		
		BGQ->(MsUnlock()) 
   	    ConfirmSx8() 		

//////Registra NUMERO DO SEQUENCIA DO lan็amento de Debito na caberj/integral
    	
      cQueryPdq := " UPDATE SIGA.PDQ010 SET PDQ_CODDB = '"+cCodBD+"'"
      cQueryPdq += "  WHERE PDQ_COMPTE = "+ (cAliastmp)->COMPTE +"'"
      cQueryPdq += "    AND PDQ_CODEMP = "+ (cAliastmp)->CODEMP +"'"
      cQueryPdq += "    AND PDQ_CODPLA = "+ (cAliastmp)->CODPLA +"'"
      cQueryPdq += "    AND PDQ_TPPGTO = "+ (cAliastmp)->TPPGTO +"'"
      cQueryPdq += "    AND PDQ_CLNCDB = "+ (cAliastmp)->CLNCDB +"'"
              
      TcSqlExec(cQueryPdq) 	
   
   EndDo 

Return()

