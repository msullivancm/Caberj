
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

User Function CABA163

Local cMsg			:= ""      
Local nCont			:= 0
Private cDpj        := 'Nใo'   
private cImp        := 'Nใo'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABA163"
Private cTitulo     := "Pagramento PGD - CENTRO MEDICOS - MATURIDADE"
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

Private  aDados     := {}
Private  aDadoCons  := {}
private cDiaFim     :='30'

private cAno        := 0
private cMes        := 0
private cCompte     :=' '

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

private 	cCodEmp := ' ' 


 fAchaComp() 
 
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
cQuery :=       " SELECT COMPTE , "
cQuery += CRLF +"        OPER , "
cQuery += CRLF +"        MATRIC , "
cQuery += CRLF +"        SUBSTR(MATRIC,5,4) CODEMP2 , " 
cQuery += CRLF +"        CODLAN , "
cQuery += CRLF +"        CODLINT , "
cQuery += CRLF +"        CODPLA , "
cQuery += CRLF +"        DATAREAL , "
cQuery += CRLF +"        IDPROF , "
cQuery += CRLF +"        CODRDA ,"
cQuery += CRLF +"        PROJET "
cQuery += CRLF +"   FROM MOVIW "
cQuery += CRLF +"  WHERE COMPTE = '"+ cCompte +"' "

*/  
   
cQuery += CRLF +"SELECT   PE8_COMPTE  COMPTE   ,"   
cQuery += CRLF +"         PE8_OPER    OPER     ,"
cQuery += CRLF +"         PE8_MATRIC  MATRIC   ,"
cQuery += CRLF +"         SUBSTR(PE8_MATRIC,5,4) CODEMP2 , " 
cQuery += CRLF +"         PE8_CODLAN  CODLAN   ,"
cQuery += CRLF +"         PE8_CODLIN  CODLINT  ,"
cQuery += CRLF +"         PE8_CODPLA  CODPLA   ,"
cQuery += CRLF +"         PE8_DTREAL  datareal ," 
cQuery += CRLF +"         PE8_IDPROF  idprof   ,"
cQuery += CRLF +"         PE8_CODRDA  CODRDA   ,"
cQuery += CRLF +"         PE8_PROJET  PROJET   ,"
cQuery += CRLF +"         PE8_CODTAB  CODTAB   ,"
cQuery += CRLF +"         PE8_CODPRO  CODPRO   ,"
cQuery += CRLF +"         PE8_DTPRE   DATAPRE  ,"
cQuery += CRLF +"         PE8_LANCAB  LANCAB    "
cQuery += CRLF +"    FROM PE8010 "
cQuery += CRLF +"  WHERE PE8_COMPTE = '"+ cCompte +"' "



   If Select((cAliastmp)) <> 0 
    (cAliastmp)->(DbCloseArea())  
  Endif 
        
  TCQuery cQuery  New Alias (cAliastmp)   

  (cAliastmp)->(dbGoTop()) 
  
  While (cAliastmp)->(!EOF())         

		cCodEmp := Iif(trim((cAliastmp)->OPER)=='CABERJ', substr((cAliastmp)->matric,5,4),'0009')
		
		If (nAscan:=Ascan(aDados , {|e| e[1]+e[2]+e[3]+e[4]+e[5]+e[6]+e[7]+e[8] == trim((cAliastmp)->COMPTE)      + ;
			  											    	         cCodEmp                        + ;
																         trim((cAliastmp)->CODPLA)      + ;
																         trim((cAliastmp)->CODRDA)      + ;
																         Trim((cAliastmp)->CODLAN)      + ;
																         Trim((cAliastmp)->CODLINT)     + ;
																         Trim((cAliastmp)->PROJET)      + ;
																         trim((cAliastmp)->CODEMP2)})) == 0  
   
   			Aadd(aDados,{ trim((cAliastmp)->COMPTE)    , ;
   						  cCodEmp                      , ;
   						  trim((cAliastmp)->CODPLA)    , ;
						     trim((cAliastmp)->CODRDA)    , ;
						     trim((cAliastmp)->CODLAN)    , ; 
					    	  Trim((cAliastmp)->CODLINT)   , ;
					   	  Trim((cAliastmp)->PROJET)    , ;
						     trim((cAliastmp)->CODEMP2)   , ;
						     0 ,;  
				           1} )
				         
	 	Else 

	 	    aDados[nAscan,10]+= 1
	 
	 	EndIf   
	 	
	    If (nAscan:=Ascan(aDadoCons , {|e| e[1]+e[2] == trim((cAliastmp)->COMPTE) +;
												        Trim((cAliastmp)->CODRDA) })) == 0  
   
   			Aadd(aDadoCons,{Trim((cAliastmp)->COMPTE) ,;
							Trim((cAliastmp)->CODRDA) ,;
							 0 ,;
							 0 ,;  
			              1})
				         
	 	Else 

	 	    aDadoCons[nAscan,5]+= 1
	 
	 	EndIf   
		
 	   (cAliastmp)->(DbSkip())
  EndDo 

  fCalcUni()

  FGrvPlan()

 If  msgyesno("Deseja fazer os lan็amentos de Creditos para os RDA's listados ? ")

      FGrvBGQ() 

      fAcertaDC()  

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
 
     	cNomeArq := "C:\TEMP\"+cCompte+" - "+cEmpresa+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 
     	
		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)        		 
        cMontaTxt := 'Competencia :'+  cCompte
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	
        
     
        cMontaTxt := "Compte     ;" 
        cMontaTxt += "Empresa    ;" 
        cMontaTxt += "Emp.Cont   ;" 
        cMontaTxt += "Cod Plano  ;" 
		  cMontaTxt += "Codrda     ;"      
		  cMontaTxt += "Cod D/C    ;" 
				
		  cMontaTxt += "Cod D/C Int ;" 
		   
		  cMontaTxt += "Tp Projeto ;"    
	     cMontaTxt += "Valor      ;"    
		  cMontaTxt += "Qtda       ;"  
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDados)
      
          If trim(aDados[nCount][7])=='1' 
            cTpProj := 'C.Medico'
          ElseIf trim(aDados[nCount][7])=='2' 
            cTpProj := 'P.G.D'
          ElseIf trim(aDados[nCount][7])=='3' 
            cTpProj := 'Maturidade'  
          Else 
            cTpProj := 'Paliare' 
          EndIF    
      
          cMontaTxt := trim(aDados[nCount][1]) + ";"		 
          cMontaTxt += trim(aDados[nCount][2]) + ";"		
          cMontaTxt += trim(aDados[nCount][8]) + ";"		
          cMontaTxt += trim(aDados[nCount][3]) + ";"		 
          cMontaTxt += trim(aDados[nCount][4]) + ";"
          cMontaTxt += trim(aDados[nCount][5]) + ";"
          cMontaTxt += trim(aDados[nCount][6]) + ";"
          cMontaTxt += cTpProj                 + ";"	
          cMontaTxt += Transform(aDados[nCount][9],'@E  999,999.99')+ ";"            	          		          
		    cMontaTxt += Transform(aDados[nCount][10],'@E  99,999')+ ";"   
     
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
		
   cNomDadCab:= ' 2 - Resumo da Conferencia '
   cComp     :=  cCompte
   cNomPla   := ' BASE sintetica '                   
 
       cNomeArq := "C:\TEMP\"+cCompte+" - "+cEmpresa+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv" 

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : '+cComp 
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	 

        cMontaTxt := "Comptecia ;"
        cMontaTxt += "Cod Rda   ;" 
        cMontaTxt += "Valor Total;" 
        cMontaTxt += "Valor Unitario ;" 
        cMontaTxt += "Qtda      ;"   
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadoCons)
		                                    
   		  cMontaTxt := aDadoCons[nCount][1] + ";"  
           cMontaTxt += aDadoCons[nCount][2] + ";"  
           cMontaTxt += Transform(aDadoCons[nCount][3],'@E  999,999.99')+ ";"  
           cMontaTxt += Transform(aDadoCons[nCount][4],'@E  99,999.99')+ ";"   	
		     cMontaTxt += Transform(aDadoCons[nCount][5],'@E  99,999')+ ";"   
		
		     cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		//cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
	    
             
Return ()    
///////

//////

Static Function FGrvBGQ()  

LOCAL cRDAAud := ' '  
LOCAL c_Nivel := "2" 
LOCAL cCodBD  := ' ' 

local ctpproj := ' ' 
  
   For nCount:=1 to len(aDados)     
         
        ctpproj := Iif(aDados[nCount][7]=='1','C.Medico',Iif(aDados[nCount][7]=='2','P.G.D',Iif(aDados[nCount][7]=='3','Maturidade','Paliare'))) 	 

        cRDAAud := aDados[nCount][4] 

        cCodBD :=' '  	    
/////////////////////////////////////////////        
//////Registra lan็amento de Debito na caberj

		   PDM->(Reclock("PDM",.T.))	
		
			  	PDM->PDM_FILIAL := xFilial("BGQ") 
			  	PDM->PDM_COMPTE := cCompteP //aDados[nCount][1] 
			  	PDM->PDM_CODEMP := aDados[nCount][2] 
		   	PDM->PDM_CODPLA := aDados[nCount][3] 
		   	PDM->PDM_CODRDA := cRDAAud 
		   	PDM->PDM_CODLAN := aDados[nCount][5] 
		   	PDM->PDM_TPPROJ := aDados[nCount][7] 
		   	PDM->PDM_VALOR  := aDados[nCount][9]  
		   	PDM->PDM_QTDA   := aDados[nCount][10]  
			   PDM->PDM_ALIAS  := 'BGQ' 
			   PDM->PDM_SEQDB  := cCodBD 
			   PDM->PDM_CABINT := '1'
			   PDM->PDM_LOTPAG := ' '
			   PDM->PDM_FEITO  := '2' 
			    
			   PDM->PDM_CEMPR  := aDados[nCount][8]
		      PDM->PDM_CRDAR  := aDados[nCount][4]
			    		
	      PDM->(MsUnlock())
	    
      If aDados[nCount][2] == '0009'
//////////////////////////////////////////////
//////Registra lan็amento de credito na caberj
         PDM->(Reclock("PDM",.T.))	
		
			   PDM->PDM_FILIAL := xFilial("BSQ") 
         	PDM->PDM_COMPTE := cComptePP //aDados[nCount][1] ///cCompteP
			   PDM->PDM_CODEMP := aDados[nCount][2] 
			   PDM->PDM_CODPLA := aDados[nCount][3] 
			   PDM->PDM_CODRDA := '999997'
			   PDM->PDM_CODLAN := '99A' //aDados[nCount][5] 
			   PDM->PDM_TPPROJ := aDados[nCount][7] 
			   PDM->PDM_VALOR  := aDados[nCount][9]  
			   PDM->PDM_QTDA   := aDados[nCount][10]  
			   PDM->PDM_ALIAS  := 'BSQ' 
			   PDM->PDM_SEQDB  := cCodBD 
			   PDM->PDM_CABINT := '1'
			   PDM->PDM_LOTPAG := ' '
			   PDM->PDM_FEITO  := '2' 

			   PDM->PDM_CEMPR  := aDados[nCount][8]
			   PDM->PDM_CRDAR  := aDados[nCount][4]
			  
		   PDM->(MsUnlock())
			
///////////////////////////////////////////////////
//////Registra lan็amento de debito para a integral
		
           PDM->(Reclock("PDM",.T.))	
		
			   	PDM->PDM_FILIAL := xFilial("BGQ") 
			   	PDM->PDM_COMPTE := cComptePP ///aDados[nCount][1] /// cCompteP
			   	PDM->PDM_CODEMP := aDados[nCount][8] 
			   	PDM->PDM_CODPLA := aDados[nCount][3] 
			   	PDM->PDM_CODRDA := '999997'
			   	PDM->PDM_CODLAN := aDados[nCount][6] 
			   	PDM->PDM_TPPROJ := aDados[nCount][7] 
			   	PDM->PDM_VALOR  := aDados[nCount][9]  
			   	PDM->PDM_QTDA   := aDados[nCount][10]  
			   	PDM->PDM_ALIAS  := 'BGQ' 
			   	PDM->PDM_SEQDB  := cCodBD 
			   	PDM->PDM_CABINT := '2'
   			   PDM->PDM_LOTPAG := ' ' 
    			   PDM->PDM_FEITO  := '2'

			      PDM->PDM_CEMPR  := aDados[nCount][8]
			      PDM->PDM_CRDAR  := aDados[nCount][4]
			  
		   PDM->(MsUnlock())			
      
	  EndIf      
	  
 Next 


 	 			
return()   

Static Function fAcertaDC()

cQuery := CRLF +" SELECT codrda , (vlrcmp - totpdm) Diferenca , REC FROM "
cQuery += CRLF +" (SELECT PDM_CODRDA codrda , PDJ.PDJ_VLRCMP vlrcmp ,SUM(PDM_VALOR)totPdm, max(pdm.R_E_C_N_O_) REC "
cQuery += CRLF +"   FROM "+ RetSqlName("PDM") +" PDM , "+ RetSqlName("PDJ") +" PDJ "
cQuery += CRLF +"  WHERE pdm_filial ='"+xFilial("PDM")+"' AND PDM.D_e_l_e_t_ = ' ' " 
cQuery += CRLF +"    AND pdJ_filial ='"+xFilial("PDJ")+"' AND PDJ.D_e_l_e_t_ = ' ' "
cQuery += CRLF +"    AND pdm_compte = '"+cCompteP+"'  AND PDM_Cabint ='1' "
cQuery += CRLF +"    AND PDJ_COMPTE = '"+cCompte+"' AND PDM_ALIAS = 'BGQ' " 
cQuery += CRLF +"    AND PDJ_CODRDA = PDM_CODRDA "
 
cQuery += CRLF +"  GROUP BY PDM_CODRDA , PDJ.PDJ_VLRCMP " 
cQuery += CRLF +" HAVING PDJ_VLRCMP <> SUM(PDM_VALOR)) "
cQuery += CRLF +"  ORDER BY 1 "

   If Select((cAliasADB)) <> 0 

    (cAliasADB)->(DbCloseArea())  

  Endif 
        
  TCQuery cQuery  New Alias (cAliasADB)   

  (cAliasADB)->(dbGoTop()) 
  
   DbSelectArea("PDM") 
  
  While (cAliasADB)->(!EOF())         
   
		 	DbGoto((cAliasADB)->REC)
		 	
		 	RecLock("PDM",.F.)
		 	     PDM->PDM_VALOR:= PDM->PDM_VALOR + ((cAliasADB)->Diferenca)
		 	MsUnlock()
		 	
		   (cAliasADB)->(DbSkip())
  EndDo
  
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
*/
Static Function fAchaComp()                              

local cQuery := ' ' 

cQuery := CRLF + "    SELECT MAX(PDJ_COMPTE) COMPTE " 
cQuery += CRLF + "      FROM "+ RetSqlName("PDJ") +" PDJ ," 
cQuery += CRLF + "           "+ RetSqlName("PDM") +" PDM " 
cQuery += CRLF + "     WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
cQuery += CRLF + "       AND PDM_FILIAL = '" + xFilial("PDM") + "'" 
cQuery += CRLF + "       AND PDJ.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "       AND PDM.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "       AND PDM_COMPTE = PDJ_COMPTE " 
cQuery += CRLF + "       AND PDJ_QTDPRC > 0 "
   
   
   If Select((cAliasCmp)) <> 0 
   
   (cAliasCmp)->(DbCloseArea())  
  
   Endif 
        
   TCQuery cQuery  New Alias (cAliasCmp)   

   (cAliasCmp)->(dbGoTop()) 
  
  
 If (cAliasCmp)->(!EOF()) .and. (cAliasCmp)->COMPTE <> '0'  
 
     cano := val(substr((cAliasCmp)->COMPTE,1,4))
     cmes := val(substr((cAliasCmp)->COMPTE,5,2))
   //    cano:=2019
   //    cmes:= 09
     //rever
     If cmes < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf 
     
     cCompte := strzero(cano,4)+strzero(cmes,2)
     
      cmesP:= cmes 
      cAnoP:= cAno
     
     If cmes < 12
        cmesP:= cmes + 1
        cAnoP:= cAno
     Else     
        canoP++
        cmesP:= 01
     EndIf 
     
      cmesPP  := cmesP 
      cAnoPP  := cAnoP

     cCompteP := strzero(canoP,4)+strzero(cmesP,2)  // comptencia da movimenta็ใo IW
     
     If cmesPP < 12
        cmesPP:= cmesP + 1
        cAnoPP:= cAnoP
     Else     
        canoPP++
        cmesPP:= 01
     EndIf 
     
     cComptePP := strzero(canoPP,4)+strzero(cmesPP,2) // comptencia do custo de pagamento ao prestador 
     
        cmesPPP:= cmesPP 
        cAnoPPP:= cAnoPP
     
     If cmesPPP < 12
        cmesPPP:= cmesPP + 1
        cAnoPPP:= cAnoPP
     Else     
        canoPPP++
        cmesPPP:= 01
     EndIf 
     
     cComptePPP := strzero(canoPPP,4)+strzero(cmesPPP,2) // comptencia de cobran็a da caberj a integral
             
 Else 

     MsgAlert("A Ultima Comptencia Nao esta Fechada , Aguarde Fechamento ","Atencao!")  
   
     //     Return
  
     //   cano:= 2019
     //   cmes:= 08
       
     //EndIf    
     
   
//   dDiaFim := LastDate(stod(cCompte+'01'))
   //- o ๚ltimo dia do m๊s:
  //   dDiaFim := u_retdiames(ddatabase,2) // obt้m o ๚ltimo dia do m๊s (tipo date)
  //   cDiaFim := dtos(dDiaFim) // coloca no formato 'yyyymmdd' (tipo string)
 EndIf     
return 


static function fCalcUni()

 For nCount:=1 to len(aDadoCons)
     
    If PDJ->(MsSeek(aDadoCons[nCount][2]+aDadoCons[nCount][1] ))
       
       PDJ->(Reclock("PDJ",.F.))

             PDJ->PDJ_VLRUNI := (PDJ->PDJ_VLRCMP / aDadoCons[nCount][5])
             PDJ->PDJ_QTDPRC := aDadoCons[nCount][5]         
	      
             aDadoCons[nCount][3]:= PDJ->PDJ_VLRCMP 
             aDadoCons[nCount][4]:= (PDJ->PDJ_VLRCMP / aDadoCons[nCount][5]) 

      PDJ->(MsUnlock())    
	
	EndIf    
	
 Next 
      
      
         For nCount:=1 to len(aDadoCons)
      
         	 For nCount1:=1 to len(aDados)     
         	 
         	     If aDadoCons[nCount][1]== aDados[nCount1][1]
         	        If aDadoCons[nCount][2]== aDados[nCount1][4]
         	 
	                   aDados[nCount1][9]:= (aDados[nCount1][10] * aDadoCons[nCount][4]) 
             
                    EndIF           
            
	             EndIf    
	         Next
         Next 
      
return() 






