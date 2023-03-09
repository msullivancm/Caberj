
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"                                                           
#include "SIGAWIN.CH"
#INCLUDE 'FONT.CH'                                                                                                                   
#INCLUDE 'COLORS.CH'
#INCLUDE 'TOPCONN.CH'    
#Include "Ap5Mail.Ch"                                                                                                      

                                                                                                                      
/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR189   บ Autor ณAltamiro              บ Data ณ 18/05/2018บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para Pagamento a METLIFE                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABA165

Local cMsg			:= ""      
Local nCont			:= 0    
Private cDpj        := 'Nใo'     
private cImp        := 'Nใo'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABA165"
Private cTitulo     := "Pagramento PGD - CENTRO MEDICOS -P.G.D- MATURIDADE"
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

private cAno        := 0
private cMes        := 0
private cDiaFim     :='30'
private cCompte     :=' '

private cdate       := ' '

private 	cCodEmp := ' ' 

private   cQueryPdm := " "



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

    If  msgyesno("Deseja fazer os lan็amentos de Creditos para os RDA's listados ? ")

        FGrvBGQ() 

    EndIf
 
RETURN 

//////////////////////////////////////////////////////////// 

Static Function fGrvBGQ()  

LOCAL cRDAAud := ' '  
LOCAL c_Nivel := "2" 
LOCAL cCodBD  := ' ' 
local cQuery  := ' ' 
local ctpproj := ' ' 

cQuery := CRLF +" SELECT *  "
//cQuery += CRLF +"   FROM "+ RetSqlName("PDM") +" PDM "
cQuery += CRLF +"   FROM PDM010 PDM "
cQuery += CRLF +"  WHERE pdm_filial ='"+xFilial("PDM")+"' AND PDM.D_e_l_e_t_ = ' ' " 
//If cEmpAnt == '01' 
   cQuery += CRLF +"    AND pdm_compte= '"+cCompte+"'
//endIf      
cQuery += CRLF +"    AND PDM_FEITO ='2' and pdm_seqdb = ' ' "

//Query += CRLF +" and pdm_codemp = '0009' and pdm_codpla = '0064' and pdm_valor = 55.05 "   


//cQuery += CRLF +"    AND PDM_ALIAS ='BGQ' "
If cEmpAnt == '01' 
   cQuery += CRLF +"    AND PDM_CABINT ='1' "
Else 
   cQuery += CRLF +"    AND PDM_CABINT ='2' "
EndIf 
cQuery += CRLF +"  ORDER BY 1 "


   If Select((cAliastmp)) <> 0 

    (cAliastmp)->(DbCloseArea())  

  Endif 
        
  TCQuery cQuery  New Alias (cAliastmp)   

 (cAliastmp)->(dbGoTop()) 
    
  While (cAliastmp)->(!EOF()) 
           
        ctpproj := Iif((cAliastmp)->PDM_TPPROJ=='1','C.Medico',Iif((cAliastmp)->PDM_TPPROJ=='2','P.G.D',Iif((cAliastmp)->PDM_TPPROJ=='3','Maturidade','Paliare')) ) 	 
   If (cAliastmp)->PDM_ALIAS ='BGQ'    
    
		BBB->(MsSeek(xFilial("BBB")+ (cAliastmp)->PDM_CODLAN ))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Necessario truncar casas decimais, lancando centavo no ultimo adic. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู					
		BGQ->(Reclock("BGQ",.T.))	
			BGQ->BGQ_FILIAL	:= xFilial("BGQ") 
			BGQ->BGQ_CODSEQ	:= GETSX8NUM("BGQ","BGQ_CODSEQ")
			BGQ->BGQ_CODIGO	:= (cAliastmp)->PDM_CODRDA
			BGQ->BGQ_NOME	:= Posicione("BAU",1,xFilial("BAU")+(cAliastmp)->PDM_CODRDA,"BAU_NOME")
			BGQ->BGQ_ANO	:= substr((cAliastmp)->PDM_compte,1,4) 
			BGQ->BGQ_MES	:= substr((cAliastmp)->PDM_compte,5,2)
			BGQ->BGQ_CODLAN	:= (cAliastmp)->PDM_CODLAN
			BGQ->BGQ_VALOR	:= (cAliastmp)->PDM_VALOR
			BGQ->BGQ_QTDCH	:= 0
			BGQ->BGQ_TIPO	:= "2" //Credito
			BGQ->BGQ_TIPOCT	:= "2" //PJ
			BGQ->BGQ_INCIR	:= BBB->BBB_INCIR
			BGQ->BGQ_INCINS	:= BBB->BBB_INCINS
			BGQ->BGQ_INCPIS	:= BBB->BBB_INCPIS
			BGQ->BGQ_INCCOF	:= BBB->BBB_INCCOF
			BGQ->BGQ_INCCSL	:= BBB->BBB_INCCSL
			BGQ->BGQ_INCISS := '0'
			BGQ->BGQ_VERBA	:= BBB->BBB_VERBA
			BGQ->BGQ_CODOPE	:= '0001'
			BGQ->BGQ_CONMFT	:= "0" //Nao
		    BGQ->BGQ_ATIVO  := '1'
			BGQ->BGQ_OBS	:= "LANCTO PGTO IW - Ref: "+(cAliastmp)->PDM_COMPTE+" - "+ctpproj 
			BGQ->BGQ_USMES	:= 0
			BGQ->BGQ_LANAUT	:= "0" //Nao   
			
			BGQ->BGQ_ITECTA := (cAliastmp)->PDM_CODPLA   
	        BGQ->BGQ_CLVL   := (cAliastmp)->PDM_CODEMP
	        BGQ->BGQ_CODEMP := (cAliastmp)->PDM_CODEMP

	    	BGQ->BGQ_YLTAUD	:=' '  
		
		    cCodBD := BGQ->BGQ_CODSEQ 
		
		BGQ->(MsUnlock()) 
   	    ConfirmSx8() 		

//////Registra NUMERO DO SEQUENCIA DO lan็amento de Debito na caberj/integral
    	
    	cRecpdm:=((cAliastmp)->R_E_C_N_O_)
    	
    	cQueryPdm := " UPDATE SIGA.PDM010 SET PDM_SEQDB = '"+cCodBD+"' , PDM_FEITO = '1' WHERE r_e_c_n_o_  = " + cValToChar(cRecpdm) //STRTRAN(((cAliastmp)->R_E_C_N_O_)) 
    
        TcSqlExec(cQueryPdm) 	
    
		
		//fGrvPdmDB()
		 
   ElseIf  (cAliastmp)->PDM_CODEMP  == '0009' .and. cempant == '01'
		
		   BSQ->(Reclock("BSQ",.T.))
				BSQ->BSQ_FILIAL	:= xFilial("BSQ")
				BSQ->BSQ_CODSEQ	:= PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," ")
				BSQ->BSQ_CODINT := '0001'
				BSQ->BSQ_CODEMP	:= '0009'
				BSQ->BSQ_MATRIC	:= ''
				BSQ->BSQ_CONEMP	:= '000000000002'
				BSQ->BSQ_VERCON	:= '001'
			    //BSQ->BSQ_SUBCON	:= '000000001'
			    BSQ->BSQ_SUBCON	:= ' '
				//BSQ->BSQ_VERSUB	:= '001'
			    BSQ->BSQ_VERSUB	:= ' '
				BSQ->BSQ_COBNIV := c_Nivel
								
				BSQ->BSQ_ANO	:= substr((cAliastmp)->PDM_compte,1,4)
				BSQ->BSQ_MES	:= substr((cAliastmp)->PDM_compte,5,2)
	
				BSQ->BSQ_CODLAN	:= '99A' // para teste 
	
				BSQ->BSQ_VALOR	:= (cAliastmp)->PDM_VALOR
				BSQ->BSQ_NPARCE	:= "1"
						
				BSQ->BSQ_OBS	:= "Cobran็a Do Custo dos Programas - "+ ctpproj	
				
				BSQ->BSQ_AUTOMA	:= "1"
				BSQ->BSQ_TIPO	:= "1"
				BSQ->BSQ_TIPEMP	:= "2"
				BSQ->BSQ_ATOCOO	:= "1"
			
			   cCodBD := BSQ->BSQ_CODSEQ
			
		   BSQ->(MsUnlock())
		   
//////////////////////////////
		//////Registra lan็amento de credito na caberj
		
        cRecpdm:=((cAliastmp)->R_E_C_N_O_)
    	
    	cQueryPdm := " UPDATE SIGA.PDM010 SET PDM_SEQDB = '"+cCodBD+"' , PDM_FEITO = '1' WHERE r_e_c_n_o_  = " + cValToChar(cRecpdm) //STRTRAN(((cAliastmp)->R_E_C_N_O_)) 
    
        TcSqlExec(cQueryPdm) 	
    		
	
	//	fGrvPdmDB()  
   
     EndIf      

	(cAliastmp)->(DbSkip())
 
 EndDo

	 			
return()   

Static Function fGrvPdmDB()
    
    cQueryPdm := " UPDATE SIGA.PDM010 SET PDM_SEQDB = '"+cCodBD+"' , PDM_FEITO = '1' WHERE r_e_c_n_o_  = " + cValToChar((cAliastmp)->R_E_C_N_O_) //STRTRAN(((cAliastmp)->R_E_C_N_O_)) 
    
    TcSqlExec(cQueryPdm) 	
    
return()   

static Function fAchaComp()                              

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
If cempant == '01'
   cQuery += CRLF + "       AND PDM_CABINT = '1' AND PDM_FEITO = '1'"
Else 
   cQuery += CRLF + "       AND PDM_CABINT = '2' AND PDM_FEITO = '1'"
EndIf 
   
   If Select((cAliasCmp)) <> 0 
   
   (cAliasCmp)->(DbCloseArea())  
  
   Endif 
        
   TCQuery cQuery  New Alias (cAliasCmp)   

   (cAliasCmp)->(dbGoTop()) 
  
    
 If (cAliasCmp)->(!EOF()) .and. trim((cAliasCmp)->COMPTE) <> '0'  
 
     cano := val(substr((cAliasCmp)->COMPTE,1,4))
     cmes := val(substr((cAliasCmp)->COMPTE,5,2))
     
     If cmes < 12
        cmes++
     Else     
        cano++
        cmes:= 01
     EndIf 
     
     cCompte := strzero(cano,4)+strzero(cmes,2)
     //cCompte :='202004'    
 Else 
 
     MsgAlert("A Ultima Comptencia Nao esta Fechada , Aguarde Fechamento" ,"Atencao!")  
   
        Return
  
      //  cano:= 2019
      //  cmes:= 10
     
      //    cCompte := strzero(cano,4)+strzero(cmes,2)
  
 EndIf    
     
 
  
   // o ๚ltimo dia do m๊s:
   //  dDiaFim := u_retdiames(ddatabase,2) // obt้m o ๚ltimo dia do m๊s (tipo date)
   //  cDiaFim := dtos(dDiaFim) // coloca no formato 'yyyymmdd' (tipo string)
     
return ()


