#Include "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"         
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*------------------------------------------------------------------------
| Funcao    | CABA116  | Otavio Pinto                  | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | Protocolo de Atendimento                                    |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/
user function CABA116()

private nFim    := 2 
private nFim1   := 2  
PRIVATE  I      := 0
private cQuery  := ' '    
private cAgente := ' ' //'1120'  
PRIVATE cMattel := space(17)
 
PRIVATE cNomUtel:= space(TAMSX3("ZX_NOMUSR"	)[1])
private dDtNasc := space(TAMSX3("ZX_YDTNASC")[1])
private dDtInc  := space(TAMSX3("ZX_YDTINC"	)[1])
private cDescpl := space(TAMSX3("ZX_YPLANO"	)[1])
PRIVATE cEmail  := space(TAMSX3("ZX_EMAIL"	)[1])       

private cProtant:= ' '                 
private nInc    := 0 

PRIVATE nSucesso := 0     
private cProtPa  := ' ' 
     
private lUra    := .T. 
private cUser   := ' ' 

cEmpAnt == '02'

cUser   := ALLTRIM(UsrRetName(__cUserId))


      cQuery :="  select nvl(TRIM(PCO_AGENTE), ' ' ) AGENTE "
      cQuery +="    from "+RetSqlName("PCO")+" PCO "                                        
      cQuery +="   where PCO_FILIAL = '" + xFilial("PCO") + "' AND D_e_l_e_t_ = ' ' AND PCO_USUARI = '"+__CUSERID +"'"


      If Select("TMP4") <> 0
         DbSelectArea("TMP4")
	     DbCloseArea()
      Endif


      TCQuery cQuery Alias "TMP4" New
     
      dbSelectArea("TMP4")
     
      TMP4->( dbGoTop() ) 
      
      cAgente :=TMP4->AGENTE      
      
//      cAgente :='3239'                

// chamada para "zerar" cache de chamadas (chamada1) , caso fique alguma chamada sem encerar pelo sistema.       
  
        cQuery := " UPDATE chamada1 "
		cQuery += " SET encurso  = 'F' "
        cQuery += " WHERE trim(accountcode) = '"+trim(cagente)+"'" // and encurso  = 'T'" 
		
		nSucesso += TcSqlExec(cQuery)                
 
/// roda uma vez so  ao iniciar 


//Inicio - Angelo Henrique - Data:31/05/2016

If lUra
   while nFim != 1
   
      sleep(1000)                 
     
      cQuery :=" select calldate dtcha , uniqueid prot, accountcode agente ,src num_ch , encurso enc , telcamado telch "
      cQuery +="   from chamada1 ch1  "                                   
      cQuery +="  where trim(accountcode) = '"+trim(cagente)+"' "                           


      If Select("TMP1") <> 0
         DbSelectArea("TMP1")
	     DbCloseArea()
      Endif


      TCQuery cQuery Alias "TMP1" New
     
      dbSelectArea("TMP1")
     
      TMP1->( dbGoTop() )

      if trim(TMP1->prot) = 'X'
                  
         cQuery :="  update chamada1 set uniqueid ='99' where trim(accountcode) = '"+cagente+"' "                           
   	     
   	     nSucesso += TcSqlExec(cQuery)
         nFim := 1  
         Return 
         
      EndIf    
     
      If TMP1->enc == 'T' .and. cProtant != TMP1->prot   ;
        .and. (( cEmpAnt == '01' .and.( trim(TMP1->TELCH)=='8855' .or. trim(TMP1->TELCH)=='8850')) .OR. ( cEmpAnt == '02' .and. trim(TMP1->TELCH)=='8888'))
      
         fCUsr(TMP1->dtcha , TMP1->prot, TMP1->num_ch)                     
     
         cProtant := TMP1->prot    
         
         
        cQuery := " UPDATE chamada1 "
		cQuery += " SET encurso  = 'F' "
        cQuery += " WHERE trim(accountcode) = '"+trim(cagente)+"' and encurso  = 'T'" 
		
		nSucesso += TcSqlExec(cQuery)                                       
             
 
 ////// chamada programa de PA passando matricula -- Altamiro 29/05/2017

       cProtPa := U_CABA069(cMattel , "2" ) 

/////// fim chamada programa  
    
     
        If cProtPa == nil   
           cProtPa := ' ' 
        EndIf
        
        Alert("numero do protocolo  "+ cProtPa + " de retorno ")   
        
        cQuery := " UPDATE chamada2 "
		cQuery += " SET userfield  = '"+cProtPa+"' "
        cQuery += " WHERE trim(uniqueid) = '"+trim(cProtant)+"' and dst = '"+trim(cagente)+"' " 
		
		nSucesso += TcSqlExec(cQuery)
        
      Else    
                    
         fTAvs(Tmp1->dtcha ,Tmp1->prot, Tmp1->num_ch , cagente)

      EndIf           
      
  Enddo
EndIf 

Static Function fTAvs(dtcha , prot, num_ch, cagente ) //Timer()

Local nSegundos  := 1 // Disparo serÃ¡ de 1 em 1 segundo  
Local cTexto     := "TESTE"   
Local lHide      := .T.

Local nMaxInc    := 45
Local cCaractInc := "*"

//oDlg1      := MSDialog():New( 227,292,347,618,"Status do ultamo Atendimento ",,,.F.,,,,,,.T.,,,.T. )
//oMGet1     := TMultiGet():New( 000,000,{|u| If(PCount()>0,cHistRet:=u,cHistRet)},oDlg1,324,136,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,  )

cTexto  := "             Atenção  !!!"                   
cTexto1 := " Data do Ultimo Atendimento "+ SUBSTR(dtcha,9,2)+'/'+ SUBSTR(dtcha,6,2)+'/'+SUBSTR(dtcha,1,4)+" "
cTexto11:= " Usuario :"+__CUSERID +"  Agente : "+cAgente +" " 
cTexto2 := " Protocolo Num. : "+ prot +" " 
cTexto3 := " Do Numero do Telefonico é : "+ num_ch + " "   

//cTexto4 := " Data : " + dtos(date()) + " , Hora : " + time()  


DEFINE DIALOG oDlg TITLE "Status do ultimo Atendimento" FROM 0,0 TO 150,220 PIXEL
   
   oSay1   := TSay():New(05,05,,oDlg,,,,,,.T.,CLR_HRED,,200,90)
   oSay1:SetText(cTexto)   
   oSay11   := TSay():New(35,05,,oDlg,,,,,,.T.,CLR_HRED,,200,90)
   oSay11:SetText(cTexto1)    
   oSay112   := TSay():New(45,05,,oDlg,,,,,,.T.,CLR_HRED,,200,90)
   oSay11:SetText(cTexto11)   
   oSay12   := TSay():New(55,05,,oDlg,,,,,,.T.,CLR_HRED,,200,90)
   oSay12:SetText(cTexto2)  
   oSay13   := TSay():New(65,05,,oDlg,,,,,,.T.,CLR_HRED,,200,90)
   oSay13:SetText(cTexto3)  
   
   oSay2   := TSay():New(15,05,,oDlg,,,,,,.T.,CLR_HGREEN,,40,90)
   oSay2:SetText(time()) 
   
   oSay3   := TSay():New(25,05,,oDlg,,,,,,.T.,CLR_HBLUE,,200,90)
   oSay3:SetText(Replicate(cCaractInc,nInc))   
    
   oTimer := TTimer():New(nSegundos,, oDlg )  
   
   oTimer:bAction := {|| If(Fvcha(cagente), oDlg:End(),),;
                         If(lHide, oSay1:Hide(), oSay1:Show()),;
                         lHide := !lHide,;
                         oSay2:SetText(time()),;
                         If(++nInc > nMaxInc, nInc := 0,),;
                         oSay3:SetText(Replicate(cCaractInc,nInc))}   
                       
                                                                
   oTimer:lActive := .t.
   oTimer:Activate()
 
ACTIVATE DIALOG oDlg CENTERED 

Return()


 
Static Function Fvcha(cagente)  
 
local ret :=.F.

      cQuery :=" select calldate dtcha , uniqueid prot, accountcode agente ,src num_ch , encurso enc "
      cQuery +="   from chamada1 ch1  "                                        
      cQuery +="  where trim(accountcode) = '"+cagente+"' "                           


      If Select("TMP1") <> 0
         DbSelectArea("TMP1")
	     DbCloseArea()
      Endif


      TCQuery cQuery Alias "TMP1" New
     
      dbSelectArea("TMP1")
     
      TMP1->( dbGoTop() ) 
      
      if TMP1->enc =='F'
         ret :=.F.
      Else           
         ret :=.T.
      EndIf
         
      TMP1->( dbclosearea() )
      
return (ret)


Static Function fCUsr(dtcha , prot, num_ch)

local MATRIC:= ' '           
 if substr(trim(num_ch),4,1)== '9' 
    ctel:=  substr(trim(num_ch),len(trim(num_ch))-8,9)
 else 
    ctel:=  substr(trim(num_ch),len(trim(num_ch))-7,8)
 EndIf               
               
cQuery      := "SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC ,BI3_CODIGO||'-'||BI3_DESCRI PLDES, ba1_email email ,"
cQuery      += " BA1_NOMUSR nomusr , " //BA1_DATINC DTINC , BA1_DATNAS DTNASC , "
cQuery      += " SUBSTR(BA1_DATINC,7,2)||'/'||SUBSTR(BA1_DATINC,5,2)||'/'||SUBSTR(BA1_DATINC,1,4) DTINC ,"
cQuery      += " SUBSTR(BA1_DATNAS,7,2)||'/'||SUBSTR(BA1_DATNAS,5,2)||'/'||SUBSTR(BA1_DATNAS,1,4) DTNASC   " 
cQuery      += " FROM "+RetSqlName("BA1")+" BA1 ," + RetSqlName("BI3")+" BI3 "
cQuery      += " WHERE  BA1_FILIAL = '" + xFilial("BA1") + "' and  BA1.D_E_L_E_T_ = ' ' and BI3_FILIAL = '" + xFilial("BI3") + "' and  BI3.D_E_L_E_T_ = ' ' "
cQuery      += " AND BI3_CODINT = BA1_CODINT AND  BI3_CODIGO = BA1_CODPLA AND BI3_VERSAO = BA1_VERSAO and ba1_image = 'ENABLE' "         
/// TRATA SÓ MATER 
//cQuery      += " AND BA1_CODEMP = '0001' "         
/// FIM                            
cQuery      += " AND (TRIM(BA1_TELEFO) LIKE '%"+ctel+"%' OR TRIM(BA1_YTEL2) LIKE '%"+ctel+"%' OR TRIM(BA1_YCEL) LIKE '%"+ctel+"%' )              

TCQuery cQuery Alias "TMP3" New
     
dbSelectArea("TMP3")
     
TMP3->( dbGoTop() ) 

cMattel := TMP3->MATRIC
cNomUtel:= TMP3->nomusr
dDtNasc := TMP3->DTNASC  
dDtInc  := TMP3->DTINC  
cDescpl := TMP3->PLDES      
cEmail  := TMP3->email


TMP3->( dbclosearea() )      

Return ( ) 


// Fim do programa CABA069.PRW