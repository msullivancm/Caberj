User Function LP53201H

PRIVATE cHist:=" "
IF TRIM(SE2->E2_ORIGEM)=="PLSMPAG" 
   IF TRIM(SE2->e2_TIPO) $  "TX|INS|ISS"  
      IF TRIM(SE2->E2_NATUREZ) = 'ISS' 
         cHist  :="ISS PGT MEDICO NA DATA - BORD "+SE5->E5_DOCUMEN 
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'INSS' 
         cHist  :="INSS PGT MEDICO NA DATA - BORD "+SE5->E5_DOCUMEN   
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'COFINS' 
         cHist  :="COFINS PGT MEDICO NA DATA - BORD "+SE5->E5_DOCUMEN                                                    
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'PIS' 
         cHist  :="PIS PGT MEDICO NA DATA - BORD "+SE5->E5_DOCUMEN   
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'CSLL' 
         cHist  :="CSLL PGT MEDICO NA DATA - BORD "+SE5->E5_DOCUMEN   
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'IRF' 
         cHist  :="IRRF PGT MEDICO NA DATA - CRET "+SE2->E2_CODRET+ " - BORD "+SE5->E5_DOCUMEN             
      EndIf
   ELSE       
    cHist  :="PAGTO MEDICO NA DATA - BORD "+SE5->E5_DOCUMEN 
   EndIf                                                    
ELSEIF TRIM(SE2->E2_ORIGEM)=="PLSM152"                         
   IF TRIM(SE2->e2_TIPO) $  "TX|INS|ISS"  
      IF TRIM(SE2->E2_NATUREZ) = 'ISS' 
         cHist  :="ISS PGT DE COMISSÕES  - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN 
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'INSS' 
         cHist  :="INSS PGT DE COMISSÕES  - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN  
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'COFINS' 
         cHist  :="COFINS PGT DE COMISSÕES  - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN                                                  
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'PIS' 
         cHist  :="PIS PGT DE COMISSÕES  - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN  
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'CSLL' 
         cHist  :="CSLL PGT DE COMISSÕES  - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN    
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'IRF'     
         cHist  :="IRRF PGT DE COMISSÕES  - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN            
      EndIf
   ELSE     
    cHist  :="PAGT TIT DE COMISSÕES - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN   
   EndIf 
ELSEIF TRIM(SE2->E2_ORIGEM)=="CAB007"
    cHist  :="PAGTO REEMBOLSO - BORD "+SE5->E5_DOCUMEN 
ELSE      
   IF TRIM(SE2->e2_TIPO) $  "TX|INS|ISS"  
      IF TRIM(SE2->E2_NATUREZ) = 'ISS' 
         cHist  :="ISS PGT FINAN. NA DATA - BORD "+SE5->E5_DOCUMEN 
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'INSS' 
         cHist  :="INSS PGT FINAN. NA DATA - BORD "+SE5->E5_DOCUMEN   
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'COFINS' 
         cHist  :="COFINS PGT FINAN. NA DATA - BORD "+SE5->E5_DOCUMEN                                                    
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'PIS' 
         cHist  :="PIS PGT FINAN. NA DATA - BORD "+SE5->E5_DOCUMEN   
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'CSLL' 
         cHist  :="CSLL PGT FINAN. NA DATA - BORD "+SE5->E5_DOCUMEN  
      ELSEIF TRIM(SE2->E2_NATUREZ) = 'IRF' 
         cHist  :="IRRF PGT FINAN. NA DATA - CRET "+SE2->E2_CODRET+ " - BORD "+SE5->E5_DOCUMEN              
      EndIf 
   Else   
	cHist  :="PAGT TIT - "+SE2->E2_NUM+"-"+"FORN:"+AllTrim(SE2->E2_NOMFOR)+"-"+AllTrim(SE2->E2_HIST)+"- BORD "+SE5->E5_DOCUMEN                                                                                       
ENDIF
ENDIF
Return cHist       

                                                                                                           
