#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#Include "TOPCONN.CH"
#Include "TBICONN.CH"
#INCLUDE "ap5mail.ch"
#Include "TbiCode.ch"

#DEFINE _cEol  CHR(13)+CHR(10)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³caba119   ºAutor  ³Marcela Coimbra     º Data ³  09/18/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ROTINA PARA Replicar valor a Pagar RDA's Iw                º±±
±±º          ³ e Carga da Tabela de Movimentação de Atendimento - MOVIW   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          

User Function CABA162(cContr)       

private cScript   := " "
private cQuery    := ' ' 

Private cAliastmp := GetNextAlias()  
Private cAliasconf:= GetNextAlias()
Private cAliasIBBB:= GetNextAlias()
Private cAliasCBBB:= GetNextAlias()

Private cAliasIw  := GetNextAlias()  
Private cNCompte  := ' ' 
private cano      := ' ' 
private cmes      := ' ' 

private 	cCompte  := '201912'	

private cControle := cContr

PRIVATE cFaltRda  := ' '
//PRIVATE nFazCar   := nFazCar1           


cQuery := CRLF + " SELECT PDJ_CODRDA CODRDA , "
cQuery += CRLF + "        PDJ_COMPTE COMPTE , "
cQuery += CRLF + "        PDJ_NOMRDA NOMRDA , "
cQuery += CRLF + "        PDJ_QTDPRC QTDAPC , "
cQuery += CRLF + "        PDJ_VLRCMP VLRCMP , "
cQuery += CRLF + "        PDJ_VLRUNI VLRUNI   "
cQuery += CRLF + "   FROM "+ RetSqlName("PDJ") +" PDJ " 
cQuery += CRLF + "  WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
cQuery += CRLF + "    AND D_E_L_E_T_ = ' ' "
cQuery += CRLF + "    AND PDJ_QTDPRC > 0 "
cQuery += CRLF + "    AND PDJ_COMPTE = (SELECT MAX(PDJ_COMPTE) " 
cQuery += CRLF + "                        FROM "+ RetSqlName("PDJ") +" PDJ ,"+ RetSqlName("PDM") +" PDM "  
cQuery += CRLF + "                       WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
cQuery += CRLF + "                         AND PDM_FILIAL = '" + xFilial("PDM") + "'" 
cQuery += CRLF + "                         AND PDJ.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "                         AND PDM.D_E_L_E_T_ = ' ' "
cQuery += CRLF + "                         AND PDM_COMPTE = PDJ_COMPTE " 
cQuery += CRLF + "                         AND  PDJ_QTDPRC > 0) "
    
   
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
        
TCQuery cQuery  New Alias (cAliastmp)   

(cAliastmp)->(dbGoTop()) 
    
If (cAliastmp)->(!EOF())    

   cano := val(substr((cAliastmp)->COMPTE,1,4))
   cmes := val(substr((cAliastmp)->COMPTE,5,2))
     
   If cmes < 12
      cmes++
   Else     
      cano++
      cmes:= 01
   EndIf 
     
   cCompte := strzero(cano,4)+strzero(cmes,2)
     
   If !ValComp(cCompte) 
    
      MsgAlert("A Comptencia "+cCompte+" Já esta replicada e ainda nao esta Fechada , Favor Processar o Repasse ","Atencao!") 
    
      Return
     
   EndIf 
     
Else 
 
   MsgAlert("A Ultima Comptencia Nao esta Fechada , Aguarde Fechamento ","Atencao!")  
   
   Return
  
EndIf  
 
If cControle == 1

 	For nI := 1 to 5
		IncProc('Duplicanco Aarquivo...')
	Next  

   		 While (cAliastmp)->(!EOF())                                 
		
		   	RecLock("PDJ", .T.)
					
			    PDJ->PDJ_CODRDA := (cAliastmp)->CODRDA  
		       PDJ->PDJ_COMPTE :=  cCompte 
		       PDJ->PDJ_NOMRDA := (cAliastmp)->NOMRDA 
		       PDJ->PDJ_QTDPRC := 0 
		       PDJ->PDJ_VLRCMP :=  (cAliastmp)->VLRCMP 
		       PDJ->PDJ_VLRUNI :=  0  
		   		       
		   	PDJ->(MsUnLock())
		   			
		      (cAliastmp)->( dbSkip() )     
				
		    EndDo
  
        MsgStop("SUCESSO !!! Replica da Tabela de REMUNERAÇÃO  Concluida .... ")       

EndIf	

If cControle == 2

   If ValCargaIw(cCompte)   

      If msgyesno("Deseja Carregar o Movimento do IW da Compte "+cCompte+" ? ")
        
    	   u_fCarg_MovIw(cCompte)
   
      EndIf 

   Else  

	   MsgAlert("Os RDA's listados abaixa "+CRLF +" FALTA valor de FAT ou NÃO Estão no IW " + CRLF + cFaltRda + CRLF + CRLF +"Carga do IW NÃO foi Realizada ","Atencao!")  
   
   EndIf	
	
EndIf 

Return()  


user Function fCarg_MovIw(cCompte)



private dDatFim := LastDate(stod(cCompte+'01'))

private cDatInc := '01/'+substr (cCompte,5,2)+'/'+substr (cCompte,1,4)
private cDatFim := substr (dtos(dDatFim),7,2)+'/'+ substr (cCompte,5,2)+'/'+substr (cCompte,1,4)

private dDatFim := stod(cCompte+'28')
   
 //  MsgAlert("Atualizado Tabela de Movimentação do IW , na Competencia : " +cCompte + " não Localizado","Atencao!")

//	ProcRegua(0)

	For nI := 1 to 5
		IncProc('Atualização Tabela de Movimentação do IW  ...'+CRLF+' Iniciando Carga da Tabela MOVIW ')
	Next
	
	
//	cQuery := CRLF + "SELECT * FROM MOVIW1  "     
    
//If Select((cAliastmp)) <> 0 
//  (cAliastmp)->(DbCloseArea())  
//Endif 
        
//TCQuery cQuery  New Alias (cAliastmp)   

//(cAliastmp)->(dbGoTop()) 
    
//---CRIAÇÃO E ALIMENTAÇÃO DA TABELA DO IW 
//--DROP TABLE MOVIW1
//-- select * from MOVIW where COMPTE = '201908'
//--delete MOVIW where COMPTE = '201908'

 
//   cScript := CRLF +" CREATE TABLE MOVIW1 AS ( "
//   cScript := CRLF +" INSERT INTO MOVIW1 AS ( "
 
 //cScript := CRLF +" INSERT INTO MOVIW  ( " 

// ver com a raque columas , DATAPRE ,  LANCAB  

cScript\ := CRLF +"SELECT COMPTE , OPER , MATRIC ,  CODLAN , CODLINT ,  CODPLA , DATAREAL , IDPROF , CODRDA , PROJET ,  CodTab , CodPro , '01/01/21' DATAPRE , ' ' LANCAB  "
cScript += CRLF + " FROM ( "
//cScript += CRLF + " SELECT '20'||SUBSTR( H.STARTDATE,7,2)||SUBSTR( H.STARTDATE,4,2) COMPTE, "
cScript += CRLF + " SELECT to_char(TRUNC(H.STARTDATE),'YYYYMM') COMPTE, "
cScript += CRLF + "  DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL') OPER , "
cScript += CRLF + "  A.CAREPLANREGISTER MATRIC ,  "
cScript += CRLF + "  DECODE(IDCONTRACT,77,RETORNA_COD_LANC ('1',RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER),PDI_PROJET),decode(PDI_PROJET,'1','245','2','246','3','247','4','248')) CODLAN , " 
cScript += CRLF + "  DECODE(IDCONTRACT,77,' ',RETORNA_COD_LANC ('2',RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER),PDI_PROJET)) CODLINT , "  
cScript += CRLF + "  DECODE(IDCONTRACT,77,RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER), RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER)) CODPLA , "
cScript += CRLF + "  H.STARTDATE AS DATAREAL , "
cScript += CRLF + "  G.IDPROFESSIONAL AS IDPROF , " 
cScript += CRLF + "  NVL(trim(PDI_CODRDA),'Sem Rda') codrda ,PDI_PROJET PROJET , "
cScript += CRLF + "  '16' CodTab , '10101012' CodPro "
cScript += CRLF + "  FROM CAPADMISSION@PROTHEUSIW A , "
cScript += CRLF + "  GLBPERSON@PROTHEUSIW B , "
cScript += CRLF + "  CAPCONSULT@PROTHEUSIW C , "
cScript += CRLF + "  SCCCODE@PROTHEUSIW D , "
cScript += CRLF + "  GLBPATIENT@PROTHEUSIW E , "
cScript += CRLF + "  GLBENTERPRISE@PROTHEUSIW F , "
cScript += CRLF + "  CAPPROFAGENDA@PROTHEUSIW G , "
cScript += CRLF + "  CAPEVOLUTION@PROTHEUSIW H , " 
cScript += CRLF + "  GLBPERSON@PROTHEUSIW I , "
cScript += CRLF + "  GLBPROFESSIONAL@PROTHEUSIW J , " 
cScript += CRLF + "  PDI010 PDI "
cScript += CRLF + "  WHERE C.IDADMISSION = A.ID " 
cScript += CRLF + "  AND A.IDPATIENT = E.ID "
cScript += CRLF + "  AND E.IDPERSON = B.ID "
cScript += CRLF + "  AND C.SCSPECIALITY = D.ID "
cScript += CRLF + "  AND C.IDPROFAGENDA = G.ID "  
cScript += CRLF + "  AND C.REALIZED = 1 "

cScript += CRLF + "  AND A.CAREPLANREGISTER NOT IN ('00010004068547002') "
//cScript += CRLF + "   AND A.CAREPLANREGISTER NOT IN ('00010004068547002','00010369000473007','00010369000446000','00010369000209008') "

cScript += CRLF + "  AND H.ID (+)= C.IDEVOLUTION " 
cScript += CRLF + "  AND A.IDENTERPRISE = F.ID "
cScript += CRLF + "  AND G.IDPROFESSIONAL = I.ID "
cScript += CRLF + "  AND G.IDPROFESSIONAL = J.IDPERSON "
cScript += CRLF + "  AND PDI_FILIAL = ' ' AND PDI.D_e_l_e_t_ = ' ' AND PDI_CODIW = G.IDPROFESSIONAL "
//cScript += CRLF + " AND TRUNC(G.AGENDAENDDATE) BETWEEN '"+cValToChar(dDatInc)+"' AND '"+cValToChar(dDatFim)+"'  ) )"
//cScript += CRLF + " AND ('20'||substr(TRUNC(G.AGENDAENDDATE),7,2)||substr(TRUNC(G.AGENDAENDDATE),4,2)) ='"+ cCompte +"') )"
//cScript += CRLF + "  AND ('20'||substr(trunc(H.STARTDATE),7,2)||substr(trunc(H.STARTDATE),4,2)) ='"+ cCompte +"' ) )"

cScript += CRLF + "  AND to_char(TRUNC(H.STARTDATE),'YYYYMM') ='"+ cCompte +"' )"
 

//////////////////////////////

If Select((cAliasIw)) <> 0 
   (cAliasIw)->(DbCloseArea())  
Endif 
        
TCQuery cScript  New Alias (cAliasIw)   

(cAliasIw)->(dbGoTop())

Do while !(cAliasIw)->(eof()) 
	//
  
   RECLOCK("PE8", .T. )

      PE8_FILIAL   :=  xFilial('PE8')   
      PE8_COMPTE   := (cAliasIw)->COMPTE   
      PE8_OPER     := (cAliasIw)->OPER  
      PE8_MATRIC   := (cAliasIw)->MATRIC 
      PE8_CODLAN   := (cAliasIw)->CODLAN  
      PE8_CODLIN   := (cAliasIw)->CODLINT  
      PE8_CODPLA   := (cAliasIw)->CODPLA   
      PE8_DTREAL   := (cAliasIw)->datareal  
      PE8_IDPROF   := (cAliasIw)->idprof   
      PE8_CODRDA   := (cAliasIw)->CODRDA   
      PE8_PROJET   := (cAliasIw)->PROJET   
      PE8_CODTAB   := (cAliasIw)->CODTAB   
      PE8_CODPRO   := (cAliasIw)->CODPRO 
      PE8_DTPRE    :=  dDatFim // (cAliasIw)->DATAPRE  
      PE8_LANCAB   := (cAliasIw)->LANCAB  

   (MSUNLOCK())

   (cAliasIw)->(DbSkip())
 
EndDo


//nSucesso:= tcsqlexec(cScript)
	
//If nSucesso == 0
	 
   MsgStop("SUCESSO !!! Carga da Tabela MOVIW Concluida .... ")
	   	
//Else 		                                          
	
//   MsgAlert("FALHA !!! Falha ao Cargar da Tabela MOVIW  .... ","Atencao!")
	
//EndIf	 
	
RETURN()


static function ValComp(cVcompte)

      cQuery := CRLF + " SELECT PDJ_CODRDA CODRDA , "
      cQuery += CRLF + "        PDJ_COMPTE COMPTE , "
      cQuery += CRLF + "        PDJ_NOMRDA NOMRDA , "
      cQuery += CRLF + "        PDJ_QTDPRC QTDAPC , "
      cQuery += CRLF + "        PDJ_VLRCMP VLRCMP , "
      cQuery += CRLF + "        PDJ_VLRUNI VLRUNI   "
      cQuery += CRLF + "   FROM "+ RetSqlName("PDJ") +" PDJ " 
      cQuery += CRLF + "  WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
      cQuery += CRLF + "    AND D_E_L_E_T_ = ' ' "
      cQuery += CRLF + "    AND PDJ_QTDPRC > 0 AND PDJ_VLRUNI > 0"
      cQuery += CRLF + "    AND PDJ_COMPTE = '"+cVcompte+"'"
         
      If Select((cAliasconf)) <> 0 
         (cAliasconf)->(DbCloseArea())  
      Endif 
            
      TCQuery cQuery  New Alias (cAliasconf)   

      (cAliasconf)->(dbGoTop()) 
    
Return( (cAliasconf)->(EOF()))
   

static Function ValCargaIw(cVCompte)

    local lRet := .T.
    local EmpCI:= ' '

    cQuery := CRLF + " SELECT CODRDA , 'IW' DESCRICAO FROM ( "

      cQuery += CRLF + " (SELECT PDJ_CODRDA CODRDA "
      cQuery += CRLF + "   FROM "+ RetSqlName("PDJ") +" PDJ " 
      cQuery += CRLF + "  WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
      cQuery += CRLF + "    AND D_E_L_E_T_ = ' ' and PDJ_VLRCMP > 0"
      cQuery += CRLF + "    AND PDJ_COMPTE = '"+cVcompte+"'"

      cQuery += CRLF + " Minus "   

      cQuery += CRLF + " SELECT  CODRDA "
      cQuery += CRLF + " FROM ( "
      cQuery += CRLF + " SELECT to_char(TRUNC(H.STARTDATE),'YYYYMM') COMPTE, "
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL') OPER , "
      cQuery += CRLF + "  A.CAREPLANREGISTER MATRIC ,  "
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,RETORNA_COD_LANC ('1',RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER),PDI_PROJET),decode(PDI_PROJET,'1','245','2','247','3','246','4','248')) CODLAN , " 
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,' ',RETORNA_COD_LANC ('2',RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER),PDI_PROJET)) CODLINT , "  
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER), RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER)) CODPLA , "
      cQuery += CRLF + "  H.STARTDATE AS DATAREAL , "
      cQuery += CRLF + "  G.IDPROFESSIONAL AS IDPROF , " 
      cQuery += CRLF + "  NVL(trim(PDI_CODRDA),'Sem Rda') codrda ,PDI_PROJET PROJET , "
      cQuery += CRLF + "  '16' CodTab , '10101012' CodPro "
      cQuery += CRLF + "  FROM CAPADMISSION@PROTHEUSIW A , "
      cQuery += CRLF + "  GLBPERSON@PROTHEUSIW B , "
      cQuery += CRLF + "  CAPCONSULT@PROTHEUSIW C , "
      cQuery += CRLF + "  SCCCODE@PROTHEUSIW D , "
      cQuery += CRLF + "  GLBPATIENT@PROTHEUSIW E , "
      cQuery += CRLF + "  GLBENTERPRISE@PROTHEUSIW F , "
      cQuery += CRLF + "  CAPPROFAGENDA@PROTHEUSIW G , "
      cQuery += CRLF + "  CAPEVOLUTION@PROTHEUSIW H , " 
      cQuery += CRLF + "  GLBPERSON@PROTHEUSIW I , "
      cQuery += CRLF + "  GLBPROFESSIONAL@PROTHEUSIW J , " 
      cQuery += CRLF + "  PDI010 PDI "
      cQuery += CRLF + "  WHERE C.IDADMISSION = A.ID " 
      cQuery += CRLF + "  AND A.IDPATIENT = E.ID "
      cQuery += CRLF + "  AND E.IDPERSON = B.ID "
      cQuery += CRLF + "  AND C.SCSPECIALITY = D.ID "
      cQuery += CRLF + "  AND C.IDPROFAGENDA = G.ID "
      cQuery += CRLF + "  AND C.REALIZED = 1 "
      
      cQuery += CRLF + "  AND A.CAREPLANREGISTER NOT IN ('00010004068547002') "
      //cQuery += CRLF + "   AND A.CAREPLANREGISTER NOT IN ('00010004068547002','00010369000473007','00010369000446000','00010369000209008') "
      
      cQuery += CRLF + "  AND H.ID (+)= C.IDEVOLUTION " 
      cQuery += CRLF + "  AND A.IDENTERPRISE = F.ID "
      cQuery += CRLF + "  AND G.IDPROFESSIONAL = I.ID "
      cQuery += CRLF + "  AND G.IDPROFESSIONAL = J.IDPERSON "
      cQuery += CRLF + "  AND PDI_FILIAL = ' ' AND PDI.D_e_l_e_t_ = ' ' AND PDI_CODIW = G.IDPROFESSIONAL "
      cQuery += CRLF + "  AND to_char(TRUNC(H.STARTDATE),'YYYYMM') ='"+ cVCompte +"' ) ))"

      cQuery += CRLF + " Union all "

       cQuery += CRLF + " SELECT CODRDA CODRDA , 'FAT' DESCRICAO FROM ( "

      cQuery += CRLF +"(SELECT CODRDA "
      cQuery += CRLF + "  FROM ( "
      cQuery += CRLF + " SELECT to_char(TRUNC(H.STARTDATE),'YYYYMM') COMPTE, "
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL') OPER , "
      cQuery += CRLF + "  A.CAREPLANREGISTER MATRIC ,  "
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,RETORNA_COD_LANC ('1',RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER),PDI_PROJET),decode(PDI_PROJET,'1','245','2','246','3','247','4','248')) CODLAN , " 
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,' ',RETORNA_COD_LANC ('2',RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER),PDI_PROJET)) CODLINT , "  
      cQuery += CRLF + "  DECODE(IDCONTRACT,77,RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER), RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER)) CODPLA , "
      cQuery += CRLF + "  H.STARTDATE AS DATAREAL , "
      cQuery += CRLF + "  G.IDPROFESSIONAL AS IDPROF , " 
      cQuery += CRLF + "  NVL(trim(PDI_CODRDA),'Sem Rda') codrda ,PDI_PROJET PROJET , "
      cQuery += CRLF + "  '16' CodTab , '10101012' CodPro "
      cQuery += CRLF + "  FROM CAPADMISSION@PROTHEUSIW A , "
      cQuery += CRLF + "  GLBPERSON@PROTHEUSIW B , "
      cQuery += CRLF + "  CAPCONSULT@PROTHEUSIW C , "
      cQuery += CRLF + "  SCCCODE@PROTHEUSIW D , "
      cQuery += CRLF + "  GLBPATIENT@PROTHEUSIW E , "
      cQuery += CRLF + "  GLBENTERPRISE@PROTHEUSIW F , "
      cQuery += CRLF + "  CAPPROFAGENDA@PROTHEUSIW G , "
      cQuery += CRLF + "  CAPEVOLUTION@PROTHEUSIW H , " 
      cQuery += CRLF + "  GLBPERSON@PROTHEUSIW I , "
      cQuery += CRLF + "  GLBPROFESSIONAL@PROTHEUSIW J , " 
      cQuery += CRLF + "  PDI010 PDI "
      cQuery += CRLF + "  WHERE C.IDADMISSION = A.ID " 
      cQuery += CRLF + "  AND A.IDPATIENT = E.ID "
      cQuery += CRLF + "  AND E.IDPERSON = B.ID "
      cQuery += CRLF + "  AND C.SCSPECIALITY = D.ID "
      cQuery += CRLF + "  AND C.IDPROFAGENDA = G.ID "
      cQuery += CRLF + "  AND C.REALIZED = 1 "
      
      cQuery += CRLF + "  AND A.CAREPLANREGISTER NOT IN ('00010004068547002') "
            
      cQuery += CRLF + "  AND H.ID (+)= C.IDEVOLUTION " 
      cQuery += CRLF + "  AND A.IDENTERPRISE = F.ID "
      cQuery += CRLF + "  AND G.IDPROFESSIONAL = I.ID "
      cQuery += CRLF + "  AND G.IDPROFESSIONAL = J.IDPERSON "
      cQuery += CRLF + "  AND PDI_FILIAL = ' ' AND PDI.D_e_l_e_t_ = ' ' AND PDI_CODIW = G.IDPROFESSIONAL "
      cQuery += CRLF + "  AND to_char(TRUNC(H.STARTDATE),'YYYYMM') ='"+ cVCompte +"' ) "

      cQuery += CRLF + " Minus "   

      cQuery += CRLF + " SELECT PDJ_CODRDA  CODRDA  "
      cQuery += CRLF + "   FROM "+ RetSqlName("PDJ") +" PDJ " 
      cQuery += CRLF + "  WHERE PDJ_FILIAL = '" + xFilial("PDJ") + "'" 
      cQuery += CRLF + "    AND D_E_L_E_T_ = ' ' and PDJ_VLRCMP > 0" 
      cQuery += CRLF + "    AND PDJ_COMPTE = '"+cVcompte+"' ) )"

      If Select((cAliasconf)) <> 0 
         (cAliasconf)->(DbCloseArea())  
      Endif 
            
      TCQuery cQuery  New Alias (cAliasconf)   
 
      (cAliasconf)->(dbGoTop())
      
      While (cAliasconf)->(!EOF())                                       

         cFaltRda += CRLF +(cAliasconf)->CODRDA + ' - '+(cAliasconf)->DESCRICAO           

         (cAliasconf)->( dbSkip() )
         lRet := .F.
      EndDo   

      (cAliasconf)->(DbCloseArea()) 
   //   (cAliasconf)->(dbGoTop())

 
cQuery := CRLF + "SELECT  OPER , MATRIC , nvl(CODLAN,'Null')CODLAN , nvl(CODLINT,'Null') CODLINT ,  CODPLA , IDPROF , CODRDA , PROJET , 'Divergencia / Falhas' DESCRICAO "
cQuery += CRLF + "  FROM ( "
cQuery += CRLF + "  SELECT to_char(TRUNC(H.STARTDATE),'YYYYMM') COMPTE, "
cQuery += CRLF + "   DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL') OPER , "
cQuery += CRLF + "   A.CAREPLANREGISTER MATRIC ,  "
cQuery += CRLF + "   DECODE(IDCONTRACT,77,RETORNA_COD_LANC ('1',RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER),PDI_PROJET),decode(PDI_PROJET,'1','245','2','246','3','247','4','248')) CODLAN , " 
cQuery += CRLF + "   DECODE(IDCONTRACT,77,' ',RETORNA_COD_LANC ('2',RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER),PDI_PROJET)) CODLINT , "
cQuery += CRLF + "   DECODE(IDCONTRACT,77,RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER), RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER)) CODPLA , "
cQuery += CRLF + "   H.STARTDATE AS DATAREAL , "
cQuery += CRLF + "   G.IDPROFESSIONAL AS IDPROF , "
cQuery += CRLF + "   NVL(trim(PDI_CODRDA),'Sem Rda') codrda ,PDI_PROJET PROJET , "
cQuery += CRLF + "   '16' CodTab , '10101012' CodPro "
cQuery += CRLF + "   FROM CAPADMISSION@PROTHEUSIW A , "
cQuery += CRLF + "   GLBPERSON@PROTHEUSIW B , "
cQuery += CRLF + "   CAPCONSULT@PROTHEUSIW C , "
cQuery += CRLF + "   SCCCODE@PROTHEUSIW D , "
cQuery += CRLF + "   GLBPATIENT@PROTHEUSIW E , " 
cQuery += CRLF + "   GLBENTERPRISE@PROTHEUSIW F , "
cQuery += CRLF + "   CAPPROFAGENDA@PROTHEUSIW G , "
cQuery += CRLF + "   CAPEVOLUTION@PROTHEUSIW H , "
cQuery += CRLF + "   GLBPERSON@PROTHEUSIW I , "
cQuery += CRLF + "   GLBPROFESSIONAL@PROTHEUSIW J ," 
cQuery += CRLF + "   PDI010 PDI "
cQuery += CRLF + "   WHERE C.IDADMISSION = A.ID " 
cQuery += CRLF + "   AND A.IDPATIENT = E.ID "
cQuery += CRLF + "   AND E.IDPERSON = B.ID "
cQuery += CRLF + "   AND C.SCSPECIALITY = D.ID "
cQuery += CRLF + "   AND C.IDPROFAGENDA = G.ID "
cQuery += CRLF + "   AND C.REALIZED = 1 "

cQuery += CRLF + "  AND A.CAREPLANREGISTER NOT IN ('00010004068547002') "
//cQuery += CRLF + "   AND A.CAREPLANREGISTER NOT IN ('00010004068547002','00010369000473007','00010369000446000','00010369000209008') "

cQuery += CRLF + "   AND H.ID (+)= C.IDEVOLUTION " 
cQuery += CRLF + "   AND A.IDENTERPRISE = F.ID "
cQuery += CRLF + "   AND G.IDPROFESSIONAL = I.ID "
cQuery += CRLF + "   AND G.IDPROFESSIONAL = J.IDPERSON "
cQuery += CRLF + "   AND PDI_FILIAL = ' ' AND PDI.D_e_l_e_t_ = ' ' AND PDI_CODIW = G.IDPROFESSIONAL " 
/*  
cQuery += CRLF + "   and (((DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL')= 'INTEGRAL' ) "
cQuery += CRLF + "          AND (DECODE(IDCONTRACT,77,' ',RETORNA_COD_LANC ('2',RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER),PDI_PROJET))) is null ) "
cQuery += CRLF + "    OR (DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL')= 'CABERJ' "
cQuery += CRLF + "          AND DECODE(IDCONTRACT,77,RETORNA_COD_LANC ('1',RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER),PDI_PROJET),decode(PDI_PROJET,'1','245','2','246','3','247','4','248')) is null ) "
cQuery += CRLF + "    OR ((DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL')= 'INTEGRAL' ) "
cQuery += CRLF + "          AND (DECODE(IDCONTRACT,77,' ',RETORNA_COD_LANC ('2',RETORNA_CODPLA_USU_MS_FIN ('I',A.CAREPLANREGISTER),PDI_PROJET))) is null ) "
cQuery += CRLF + "    OR (DECODE(IDCONTRACT,77,'CABERJ','78','INTEGRAL')= 'CABERJ' "
cQuery += CRLF + "          AND DECODE(IDCONTRACT,77,RETORNA_COD_LANC ('1',RETORNA_CODPLA_USU_MS_FIN ('C',A.CAREPLANREGISTER),PDI_PROJET),decode(PDI_PROJET,'1','245','2','246','3','247','4','248')) is null )) "
*/
cQuery += CRLF + "   AND to_char(TRUNC(H.STARTDATE),'YYYYMM')  ='"+ cVCompte +"' ) " 

//  AND to_char(TRUNC(H.STARTDATE),'YYYYMMDD') >='20200801' 
//  AND to_char(TRUNC(H.STARTDATE),'YYYYMMDD') <='20200821'
      If Select((cAliasconf)) <> 0 
         (cAliasconf)->(DbCloseArea())  
      Endif 
            
      TCQuery cQuery  New Alias (cAliasconf)   
 
      (cAliasconf)->(dbGoTop())
       cFaltRda +=  '----------------------------------------------' + CRLF

      While (cAliasconf)->(!EOF())                                       

         If (cAliasconf)->CODLAN == 'Null' .or.  (cAliasconf)->CODLINT == 'Null'
            cFaltRda += CRLF +(cAliasconf)->DESCRICAO + CRLF + ;
            ' - Operadora - ' + (cAliasconf)->OPER + CRLF + ;
            ' - Matricula - ' + (cAliasconf)->MATRIC + CRLF + ;
            ' - Cod. Lanc. Caberj  - ' + (cAliasconf)->CODLAN + CRLF + ;
            ' - Cod. Lanc. Integral - ' +  (cAliasconf)->CODLINT + CRLF + ;
            ' - Cod. Plano  - ' + (cAliasconf)->CODPLA + CRLF + ;
            ' - Prof .IW - ' + (cAliasconf)->IDPROF + CRLF + ;
            ' - Cod. RDA - ' + (cAliasconf)->CODRDA + CRLF + ;
            ' - Cod. Projeto - '+ (cAliasconf)->PROJET + CRLF + ;      
            '----------------------------------------------' + CRLF
            lRet := .F.
/*            If CODLAN == null 
               EmpCI := 'C'
               fGravaBBB(CODPLA, CODLAN , projet, EmpCI)
            EndIf
            If CODLINT == null 
               EmpCI := 'I'
               fGravaBBB(CODPLA, CODLAN , projet, EmpCI)
            
            EndIf
*/         
         EndIf 

           (cAliasconf)->( dbSkip() )

      EndDo   

         (cAliasconf)->(dbGoTop())

   Return( lRet )


/*
Static Function fGravaBBB(CODPLA, CODLAN , projet , cEMPCI)

local cQueryBBB := ' ' 
local cQueryMAX := ' ' 
local cQueryBI3 := ' ' 

local BbbMax := 0

Private cAliasBBB := GetNextAlias()
Private cAliasBI3 := GetNextAlias()
Private cAliasBBBX:= GetNextAlias()

cQueryBBB := CRLF +"select * "
cQueryBBB := CRLF +"  from " + RetSqlName("BBB") +" BBB " 
cQueryBBB := CRLF +" where BBB_FILIAL = '"+xFilial('BBB')+ "' AND D_e_l_e_t_ = ' '"

If cEMPCI == 'I'
   cQueryBBB := CRLF +"   AND BBB_YCODPL = '0141' AND BBB_CODPLA = '0141' "
Else 
   cQueryBBB := CRLF +"   AND BBB_YCODPL = '0142' AND BBB_CODPLA = '0142' "
EndIf   

   If Select((cAliasBBB)) <> 0 

      (cAliasBBB)->(DbCloseArea())  

   Endif 
        
  TCQuery cQueryBBB  New Alias (cAliasBBB)   

  (cAliasBBB)->(dbGoTop()) 


   cQueryMax := CRLF +"select MAX(BBB_CODSER)+1 qtd from " + RetSqlName("BBB") +" BBB "  where BBB_FILIAL = '"+xFilial('BBB')+ "' AND D_e_l_e_t_ = ' ' "

   If Select((cAliasBBBX)) <> 0 

      (cAliasBBBX)->(DbCloseArea())  

   Endif 
        
  TCQuery cQueryMax  New Alias (cAliasBBBX)   

  (cAliasBBBX)->(dbGoTop()) 

   BbbMax:= (cAliasBBBX)->qtd  


cQueryBI3 := CRLF +" select * "
cQueryBI3 += CRLF +"from  " + RetSqlName("BI3") +" BI3 "  
cQueryBI3 += CRLF +" where bi3_filial = '"+xFilial('BI3')+ "' and d_E_L_E_T_ = ' '" 
cQueryBI3 += CRLF +" bi3_codigo = '"+CODPL+'"

   If Select((cAliasBI3)) <> 0 

      (cAliasBI3)->(DbCloseArea())  

   Endif 
        
  TCQuery cQueryBI3  New Alias (cAliasBI3)   

  (cAliasBI3)->(dbGoTop())    
   
  While (cAliasBBB)->(!EOF())  

        cDescr:= substr((cAliasBBB)->BBB_DESCRI,1,14) + (cAliasBI3)->BI3_DESCRI,1,25)       
   
		RecLock("BBB",.T.)

         BBB_FILIAL := xFilial('BBB') 
         BBB_CODSER := BbbMax 
         BBB_DESCRI := cDescr
         BBB_VLRSER := (cAliasBBB)->BBB_VLRSER
         BBB_QTDCH  := (cAliasBBB)->BBB_QTDCH 
         BBB_TIPSER := (cAliasBBB)->BBB_TIPSER
         BBB_TIPOCT := (cAliasBBB)->BBB_TIPOCT
         BBB_INCIR  := (cAliasBBB)->BBB_INCIR
         BBB_INCPLS := (cAliasBBB)->BBB_INCPLS
         BBB_INCINS := (cAliasBBB)->BBB_INCINS
         BBB_INCPIS := (cAliasBBB)->BBB_INCPIS
         BBB_IMPRES := (cAliasBBB)->BBB_IMPRES
         BBB_INCCOF := (cAliasBBB)->BBB_INCCOF
         BBB_INCCSL := (cAliasBBB)->BBB_INCCSL
         BBB_VERBA  := (cAliasBBB)->BBB_VERBA
         BBB_CODANT := (cAliasBBB)->BBB_CODANT
         BBB_CONTA  := (cAliasBBB)->BBB_CONTA
         BBB_HISTC  := (cAliasBBB)->BBB_HISTC
         BBB_CONMFT := (cAliasBBB)->BBB_CONMFT
         BBB_CODPRO := (cAliasBBB)->BBB_CODPRO
         BBB_DIRF   := (cAliasBBB)->BBB_DIRF
         BBB_COPCRE := (cAliasBBB)->BBB_COPCRE
         BBB_TIPPE  := (cAliasBBB)->BBB_TIPPE
         BBB_YEVENT := (cAliasBBB)->BBB_YEVENT
         BBB_YEVCAB := (cAliasBBB)->BBB_YEVCAB
         BBB_YCODPL := CODPLA
         BBB_YNEVEN := (cAliasBBB)->BBB_YNEVEN
         BBB_YCODEM := (cAliasBBB)->BBB_YCODEM
         BBB_TIPBEN := (cAliasBBB)->BBB_TIPBEN
         BBB_TIPCTR := (cAliasBBB)->BBB_TIPCTR
         BBB_NATURE := (cAliasBBB)->BBB_NATURE
         BBB_INCISS := (cAliasBBB)->BBB_INCISS
         BBB_CLASIP := (cAliasBBB)->BBB_CLASIP
         BBB_TES    := (cAliasBBB)->BBB_TES
         BBB_CODPLA := CODPLA

      BbbMax++         
		MsUnlock()
		 	
		(cAliasBBB)->(DbSkip())
  EndDo

return()
*/