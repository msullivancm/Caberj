
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR085   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Este programa ira fazer listagem de assitidos que iram      º±±
±±º          ³ completar 18 anos na data                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR130

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR130"

Private cAliastmp 	:= GetNextAlias()  

Private cAliastmp1	:= GetNextAlias()        

Private cAliastmp2	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem de assitidos que iram completar 18 anos na data " + CRLF
cMsg += " Passada por paramentro " + CRLF

***************************************************************************    
 
Private aDados1    := {}       
Private acabec1    := {"Matricula","Nome Usuario", "Data Nasc." , "Cpf usuario ","Nome Mãe ","Telefone ","Celilar ","Cod. Plano","Nome Plano","Municipio", "E_mail" , "Cont. Empresa" , "Versao" ,"Sub Contrat","Versao" , "Usua. Titular" , "Descrição"  ,  }

Private aDados2    := {}       
Private acabec2    := {"Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","<<<----->>> ",;
                        "Usuario2","Nivel Cobr2", "Data Nasc.2","Idade2" , "Cpf usuario2 ","Bloq2","Matr. Vida2"}               
                        
Private acabec3    := {"Nome Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","Tp Usuario "}   
Private aDados3    := {}  

private Descric     := ' '                                                                                                         
 	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cMesAniv    := mv_par01
cAnoAniv	:= mv_par02  
cGeraEx	    := mv_par03   
cSo18ano    := mv_par04    
cCpfDupl    := mv_par05        
cCpfMI16    := mv_par06 
cCpfBranco  := mv_par07        
dDtAtu      := dtos(dDataBase)  
dDtAtud     := dtos(dDataBase)  
dDtAtub     := substr(dDtAtud,1,4) 
nAnosXX     := str(mv_par08)

cEmpresa    := Iif(cEmpAnt == '01','C','I') 

Private cTitulo     := "Lista de Emacipados na data , completando "+ nAnosXX +" ano na data  "        
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1    
   If cCpfMI16  == 1 
      DlgToExcel({{"ARRAY","Listagem maior"+ nAnosXX+" anos sem CPF" ,aCabec1,aDados1}})   
   EndIF
   If cCpfDupl == 1 
      DlgToExcel({{"ARRAY","Listagem CPF em Duplicidade" ,aCabec2,aDados2}})   
   EndIf                                                                                 
    If cCpfBranco == 1 
      DlgToExcel({{"ARRAY","Listagem CPF Em Branco " ,aCabec3,aDados3}})   
   EndIf        
EndIF 
If cCpfMI16  == 1 
   fGeraRel2()    
EndIf    
If cCpfDupl == 1 
   fGeraRe22()    
EndIf    
If cCpfBranco == 1 
   fGeraRe33()    
EndIf   
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

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
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
////////////////////////////////////
If cCpfMI16  == 1 
   cquery := CRLF+" SELECT BA1.BA1_CODINT || BA1.BA1_CODEMP || BA1.BA1_MATRIC || BA1.BA1_TIPREG  MATRIC ,  BA1.BA1_NOMUSR NOMUSR ," 
   cquery += CRLF+"        BA1.BA1_DATNAS DATNAS , BA1.BA1_CPFUSR CPFUSR , BA1.BA1_MAE MAE , BA1.BA1_TELEFO TELEFO , BA1.BA1_YCEL YCEL ," 
   cquery += CRLF+"        BA1.BA1_MUNICI MUNICI , BI3_CODIGO CODIGO , BI3_DESCRI DESCRI , BTS_EMAIL EMAIL , ba1.ba1_conemp conemp ,"
   cquery += CRLF+"        ba1.ba1_vercon vercon , ba1.ba1_subcon subcon , BA1.BA1_VERSUB VERSUB ,BQC.BQC_DESCRI DESCRIc , BA12.BA1_NOMUSR NOMUSRT "
   cquery += CRLF+"   FROM " + RetSqlName("BA1") + " Ba1 ," + RetSqlName("BA1") + " Ba12 ," + RetSqlName("BI3") + " BI3 , "+ RetSqlName('BTS') + " BTS , " + RetSqlName('BQC') + " BQC "
   cquery += CRLF+"  WHERE ba1.BA1_FILIAL  = '" + xFilial('BA1') + "' AND Ba1.D_E_L_E_T_ = ' ' "
   cquery += CRLF+"    AND ba12.BA1_FILIAL = '" + xFilial('BA1') + "' AND Ba12.D_E_L_E_T_= ' ' "
   cquery += CRLF+"    AND BI3_FILIAL = '" + xFilial('BI3') + "' AND BI3.D_E_L_E_T_ = ' ' "                              
   cquery += CRLF+"    AND BTS_FILIAL = '" + xFilial('BTS') + "' AND BTS.D_E_L_E_T_ = ' ' "  
   cquery += CRLF+"    AND BQC_FILIAL = '" + xFilial('BQC') + "' AND BQC.D_E_L_E_T_ = ' ' "  
   cquery += CRLF+"    AND ba1.BA1_MATVID  = BTS_MATVID  " 
      
   If cSo18ano == 1     
      cquery += CRLF+" AND (IDADE_S(TRIM(Ba1.BA1_DATNAS),'"+ dtos(Lastday(Ctod('01'+'/'+cMesAniv+'/'+cAnoAniv)))+"')  = "+ nAnosXX + " ) "
   Else
      cquery += CRLF+" AND (IDADE_S(TRIM(Ba1.BA1_DATNAS),'"+ dtos(Lastday(Ctod('01'+'/'+cMesAniv+'/'+cAnoAniv)))+"') >= "+ nAnosXX +" ) "      
   EndIf   
   cquery += CRLF+"    AND BI3_CODIGO     = ba1.BA1_CODPLA "
   cquery += CRLF+"    AND BA1.BA1_CPFUSR = ' ' " 
   cquery += CRLF+"    AND BA1.BA1_IMAGE = 'ENABLE' "
   cquery += CRLF+"    AND BA1.BA1_CODINT = BA12.BA1_CODINT "
   cquery += CRLF+"    AND BA1.BA1_CODEMP = BA12.BA1_CODEMP "
   cquery += CRLF+"    AND BA1.BA1_MATRIC = BA12.BA1_MATRIC "
   cquery += CRLF+"    AND ba12.ba1_tipusu = 'T' "  

   cquery += CRLF+"    AND BA1.BA1_CODINT = BQC.BQC_CODINT "
   cquery += CRLF+"    AND BA1.BA1_CONEMP = BQC.BQC_NUMCON "
   cquery += CRLF+"    AND BA1.BA1_VERCON = BQC.BQC_VERCON "
   cquery += CRLF+"    AND BA1.BA1_SUBCON = BQC.BQC_SUBCON "  
   cquery += CRLF+"    AND BA1.BA1_VERSUB = BQC.BQC_VERSUB "
   cquery += CRLF+"    AND BA1.BA1_CODEMP = BQC.BQC_CODEMP "

   if cEmpresa  == 'C'
      cquery += CRLF+" AND Ba1.BA1_CODEMP NOT IN ('0004','0006','0010','0009') "  
   EndIf 
   cquery += CRLF+"  ORDER BY 8, 1 "
EndIf
if cCpfDupl == 1
   cquery1 := CRLF+"  SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC ||B1.BA1_tipreg  MATRIC1 ,  b1.ba1_nomusr nomusr1 ,"
   cquery1 += CRLF+"         decode (b3.ba3_cobniv,'1','cob. Familia' , decode (b1.ba1_cobniv,'1','cob. Benefic' ), 'cob. emp')  niv_cobraca1, "
   cquery1 += CRLF+"         B1.BA1_CPFUSR CPF1 , IDADE_S(trim(B1.BA1_DATNAS),'"+dDtAtu+"') IDADE1, "
   cquery1 += CRLF+"         B1.BA1_DATNAS DATNAS1, b1.ba1_datblo bloq1 , b1.BA1_MATVID MATVID1, "
        
   cquery1 += CRLF+"         B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  MATRIC11 , b11.ba1_nomusr nomusr11 ,"
   cquery1 += CRLF+"         decode (b31.ba3_cobniv,'1','cob. Familia' , decode (b11.ba1_cobniv,'1','cob. Benefic'), 'cob. emp')  niv_cobraca11, "
   cquery1 += CRLF+"         B11.BA1_CPFUSR CPF11 , IDADE_S(trim(B11.BA1_DATNAS),'"+dDtAtu+"') IDADE11 , "
   cquery1 += CRLF+"         B11.BA1_DATNAS DATNAS11, b11.ba1_datblo bloq11 , b11.BA1_MATVID MATVID11"
        
   cquery1 += CRLF+"    FROM " + RetSqlName("BA1") + " B11 , " + RetSqlName("BA1") + " B1 , " + RetSqlName("BA3") + " b3 , " + RetSqlName("BA3") + " b31 "
   cquery1 += CRLF+"   WHERE B11.BA1_FILIAL ='" + xFilial('BA1') + "' AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= '" + xFilial('BA1') + "' AND B1.D_E_L_E_T_= ' ' "     
   cquery1 += CRLF+"     and B31.BA3_FILIAL ='" + xFilial('BA3') + "' AND B31.D_E_L_E_T_=' '  AND B3.BA3_FILIAL= '" + xFilial('BA3') + "' AND B3.D_E_L_E_T_= ' ' " 

   cquery1 += CRLF+"     AND ((IDADE_S(TRIM(B11.BA1_DATNAS),'"+dDtAtu+"') >= "+ nAnosXX +" ) or (IDADE_S(TRIM(B11.BA1_DATNAS),'"+dDtAtu+"') < "+ nAnosXX +" and b11.ba1_tipusu = 'T')) "  
   cquery1 += CRLF+"     AND ((IDADE_S(TRIM(B1.BA1_DATNAS),'"+dDtAtu+"')  >= "+ nAnosXX +" ) or (IDADE_S(trim(B1.BA1_DATNAS),'"+dDtAtu+"')  < "+ nAnosXX +" and b1.ba1_tipusu  = 'T')) "
   cquery1 += CRLF+"     AND b11.BA1_MATVID <> b1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR  and b1.ba1_cpfusr <> ' ' "
   cquery1 += CRLF+"     AND (b1.ba1_datblo = ' ' or  substr(b1.ba1_datblo,1,4) >= '"+dDtAtub+"') and (b11.ba1_datblo = ' ' or  substr(b11.ba1_datblo,1,4) >= '"+dDtAtub+"') "

   cquery1 += CRLF+"     AND (B1.BA1_CODINT <> B11.BA1_CODINT "
   cquery1 += CRLF+"       OR B1.BA1_CODEMP <> B11.BA1_CODEMP "
   cquery1 += CRLF+"       OR B1.BA1_MATRIC <> B11.BA1_MATRIC "
   cquery1 += CRLF+"       OR B1.BA1_tipreg <> B11.BA1_tipreg) " 
   cquery1 += CRLF+"     AND B1.BA1_CODINT =  B3.BA3_CODINT "
   cquery1 += CRLF+"     and B1.BA1_CODEMP =  B3.BA3_CODEMP "
   cquery1 += CRLF+"     and B1.BA1_MATRIC =  b3.BA3_MATRIC "
   cquery1 += CRLF+"     AND B11.BA1_CODINT = B31.BA3_CODINT "
   cquery1 += CRLF+"     and B11.BA1_CODEMP = B31.BA3_CODEMP "
   cquery1 += CRLF+"     and B11.BA1_MATRIC = B31.BA3_MATRIC "

   cquery1 += CRLF+"     AND B1.BA1_CODEMP   <> '0004' AND B11.BA1_CODEMP <> '0004' "
   cquery1 += CRLF+"     AND (b3.ba3_cobniv = '1' or b1.ba1_cobniv = '1' ) and (b31.ba3_cobniv = '1' or b11.ba1_cobniv = '1') "
   cquery1 += CRLF+"     ORDER BY 4 "             
endIf                                          
If cCpfBranco == 1 
   cquery2 := CRLF+"  SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC ||B1.BA1_tipreg  MATRIC1 ,  b1.ba1_nomusr nomusr1 ,"
   cquery2 += CRLF+"         decode (b3.ba3_cobniv,'1','cob. Familia' , decode (b1.ba1_cobniv,'1','cob. Benefic' ), 'cob. emp')  niv_cobraca1, "
   cquery2 += CRLF+"         B1.BA1_CPFUSR CPF1 , IDADE_S(trim(B1.BA1_DATNAS),'"+dDtAtu+"') IDADE1, "
   cquery2 += CRLF+"         B1.BA1_DATNAS DATNAS1, b1.ba1_datblo bloq1 , b1.BA1_MATVID MATVID1,  b1.ba1_tipusu Tpusuario "
        
   cquery2 += CRLF+"    FROM  " + RetSqlName("BA1") + " B1 , " + RetSqlName("BA3") + " b3 "
   cquery2 += CRLF+"   WHERE B1.BA1_FILIAL= '" + xFilial('BA1') + "' AND B1.D_E_L_E_T_= ' ' "     
   cquery2 += CRLF+"     and B3.BA3_FILIAL= '" + xFilial('BA3') + "' AND B3.D_E_L_E_T_= ' ' " 

   cquery2 += CRLF+"     AND ((IDADE_S(TRIM(B1.BA1_DATNAS),'"+dDtAtu+"')  >= "+ nAnosXX +" ) or (IDADE_S(trim(B1.BA1_DATNAS),'"+dDtAtu+"')  < "+ nAnosXX +" and b1.ba1_tipusu  = 'T')) "
   cquery2 += CRLF+"     AND b1.ba1_cpfusr = ' ' "
   cquery2 += CRLF+"     AND (b1.ba1_datblo = ' ' or  substr(b1.ba1_datblo,1,4) > '"+dDtAtub+"') "

   cquery2 += CRLF+"     AND B1.BA1_CODINT =  B3.BA3_CODINT "
   cquery2 += CRLF+"     and B1.BA1_CODEMP =  B3.BA3_CODEMP "
   cquery2 += CRLF+"     and B1.BA1_MATRIC =  b3.BA3_MATRIC "

   cquery2 += CRLF+"     AND B1.BA1_CODEMP   <> '0004' "
   cquery2 += CRLF+"     AND (b3.ba3_cobniv = '1' or b1.ba1_cobniv = '1' ) "
   cquery2 += CRLF+"     ORDER BY 4 "             
endIf                                          
/////////////////////////////////////////*
If cCpfMI16  == 1 	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())    

     
       aaDD(aDados1,{(cAliastmp)->MATRIC       ,;
                     (cAliastmp)->NOMUSR       ,;
	                 stod((cAliastmp)->DATNAS)  ,; 
	                 (cAliastmp)->CPFUSR        ,;
	                 (cAliastmp)->MAE           ,; 
	                 (cAliastmp)->TELEFO        ,;
	                 (cAliastmp)->YCEL          ,;
	                 (cAliastmp)->codigo        ,;  
	   	             (cAliastmp)->descri        ,;
	   	             (cAliastmp)->munici        ,;
	   	             (cAliastmp)->email         ,;
	   	             (cAliastmp)->conemp        ,;
	                 (cAliastmp)->vercon        ,;  
	   	             (cAliastmp)->subcon        ,;
	   	             (cAliastmp)->VERSUB        ,;
	   	             (cAliastmp)->NOMUSRT       ,;
	   	             (cAliastmp)->DESCRIc        })                

       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
EndIf                                          
/////////////////////////////////////////*
if cCpfDupl == 1                         
    If Select((cAliastmp1)) <> 0 
       (cAliastmp1)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery1 New Alias (cAliastmp1)  
    
    dbSelectArea(cAliastmp1)
   
    (cAliastmp1)->(dbGoTop())   
     
    While (cAliastmp1)->(!Eof())      
     
       aaDD(aDados2,{(cAliastmp1)->MATRIC1 +' - '+ (cAliastmp1)->NOMUSR1        ,;
                     (cAliastmp1)->niv_cobraca1   ,;
	                 stod((cAliastmp1)->DATNAS1)  ,; 
	                 (cAliastmp1)->IDADE1         ,;
	                 (cAliastmp1)->CPF1           ,;
	                 stod((cAliastmp1)->bloq1 )   ,; 
	                 (cAliastmp1)->MATVID1        ,;
                      "<<<----->>>"               ,;
                     (cAliastmp1)->MATRIC11 +' - '+ (cAliastmp1)->NOMUSR11        ,;
                     (cAliastmp1)->niv_cobraca11  ,;
	                 stod((cAliastmp1)->DATNAS11) ,; 
	                 (cAliastmp1)->IDADE11        ,;
	                 (cAliastmp1)->CPF11          ,;
	                 stod((cAliastmp1)->bloq11)  ,; 
	                 (cAliastmp1)->MATVID11       })                

       (cAliastmp1)->(dbSkip()) 	   
     EndDo	                   

EndIf 
/////////////////////////////////////////*   
If cCpfBranco == 1                        
    If Select((cAliastmp2)) <> 0 
       (cAliastmp2)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery2 New Alias (cAliastmp2)  
    
    dbSelectArea(cAliastmp2)
   
    (cAliastmp2)->(dbGoTop())   
     
    While (cAliastmp2)->(!Eof())      
     
       aaDD(aDados3,{(cAliastmp2)->MATRIC1 +' - '+ (cAliastmp2)->NOMUSR1        ,;
                     (cAliastmp2)->niv_cobraca1   ,;
	                 stod((cAliastmp2)->DATNAS1)  ,; 
	                 (cAliastmp2)->IDADE1         ,;
	                 (cAliastmp2)->CPF1           ,;
	                 stod((cAliastmp2)->bloq1 )   ,; 
	                 (cAliastmp2)->MATVID1        ,;  
	                 (cAliastmp2)->Tpusuario      })                

       (cAliastmp2)->(dbSkip()) 	   
     EndDo	                   

EndIf

Return    
                
*************************************************************************************************************   
//16  anos ou maior  sem cpf
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR130"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************
//cpf em duplicidade 
Static Function fGeraRe22

Local oReport 
Private cPerg		:= "CABR130"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef3()
oReport:PrintDialog()

Return    
*************************************************************************************************************
//cpf em branco  
Static Function fGeraRe33

Local oReport 
Private cPerg		:= "CABR130"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef4()
oReport:PrintDialog()

Return
/********************************************************************************************************************************
/*
16  anos ou maior  sem cpf
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function ReportDef2()

Local oReport 
Local oDPJ    
oReport	:= TReport():New("CABR130","Relação de Aniversariantes de "+ nAnosXX +" anos sem CPF ",, {|oReport| ReportPrt(oReport)},"Relação de Aniversariantes de "+ nAnosXX +" anos sem CPF  ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Relação de Aniversariantes de 18 anos  ",,aOrdem)             

If cEmpresa  == 'C'
   TRCell():New(oDPJ ,'MATRIC'	    		,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'NOMUSR'	     		,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,50				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DTNASC'		        ,/*TABELA*/	,'Dta Nascim'      ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'EMAIL'	      	    ,/*TABELA*/	,'Email Usuario '   ,/*Picture*/ 	    ,35			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'NOMMAE'	      	    ,/*TABELA*/	,'Nome da Mae '    ,/*Picture*/ 	    ,50			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'MUNICI'		    	,/*TABELA*/	,'Municipio '      ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'TELFIX'		    	,/*TABELA*/	,'Telefone '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'TELCEL'		    	,/*TABELA*/	,'Telef Cel'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'CPLANO'		    	,/*TABELA*/	,'Cod Plano '      ,/*Picture*/ 	    ,06			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DPLANO'	     		,/*TABELA*/	,'Desc Plano'	   ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
Else 
   TRCell():New(oDPJ ,'MATRIC'	    		,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'NOMUSR'	     		,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DTNASC'		        ,/*TABELA*/	,'Dta Nascim'      ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'NOMMAE'	      	    ,/*TABELA*/	,'Nome da Mae '    ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'MUNICI'		    	,/*TABELA*/	,'Municipio '      ,/*Picture*/ 	    ,20			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'TELFIX'		    	,/*TABELA*/	,'Telefone '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'TELCEL'		    	,/*TABELA*/	,'Telef Cel'       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'CPLANO'		    	,/*TABELA*/	,'Cod Plano '      ,/*Picture*/ 	    ,06			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DPLANO'	     		,/*TABELA*/	,'Desc Plano'	   ,/*Picture*/ 	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'DESCRI'	      	    ,/*TABELA*/	,'Contrato  '      ,/*Picture*/ 	    ,40			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'NOMUSRT'	      	    ,/*TABELA*/	,'Nome Tit.'       ,/*Picture*/ 	    ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  

EndIf 
 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("MUNICI"),"Total por Municipio "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
   TRFunction():New(oDPJ:Cell("MUNICI")    	    ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)

/********************************************************************************************************************************
/* 16  anos ou maior  sem cpf
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrt(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados1)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf      
	
    If cEmpresa  == 'C'
       oDPJ:Cell('MATRIC'	 		):SetValue((aDados1[i][1]))     
       oDPJ:Cell('NOMUSR'	 		):SetValue((aDados1[i][2]))    
       oDPJ:Cell('DTNASC'	  		):SetValue((aDados1[i][3]))       
       oDPJ:Cell('EMAIL'   	    	):SetValue((aDados1[i][11]))   
       oDPJ:Cell('NOMMAE'  	        ):SetValue((aDados1[i][5]))
       oDPJ:Cell('TELFIX'	 		):SetValue((aDados1[i][6]))     
       oDPJ:Cell('TELCEL'	 		):SetValue((aDados1[i][7]))     	  
       oDPJ:Cell('CPLANO'	 		):SetValue((aDados1[i][8]))          
       oDPJ:Cell('DPLANO'	 		):SetValue((aDados1[i][9]))           
       oDPJ:Cell('MUNICI'	 		):SetValue((aDados1[i][10]))          
    Else                                                                   
       oDPJ:Cell('MATRIC'	 		):SetValue((aDados1[i][1]))     
       oDPJ:Cell('NOMUSR'	 		):SetValue((aDados1[i][2]))    
       oDPJ:Cell('DTNASC'	  		):SetValue((aDados1[i][3]))       
       oDPJ:Cell('NOMMAE'  	        ):SetValue((aDados1[i][5]))
       oDPJ:Cell('TELFIX'	 		):SetValue((aDados1[i][6]))     
       oDPJ:Cell('TELCEL'	 		):SetValue((aDados1[i][7]))     	  
       oDPJ:Cell('CPLANO'	 		):SetValue((aDados1[i][8]))          
       oDPJ:Cell('DPLANO'	 		):SetValue((aDados1[i][9]))           
       oDPJ:Cell('MUNICI'	 		):SetValue((aDados1[i][10]))      
       
       oDPJ:Cell('DESCRI' 	    	):SetValue((aDados1[i][17]))       

       oDPJ:Cell('NOMUSRT' 	    	):SetValue((aDados1[i][16]))       
    EndIf                 
    
   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   
/********************************************************************************************************************************                                                                                           
/*
cpf em dudplicidade 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function ReportDef3()

Local oReport 
Local oDPJ1    
oReport	:= TReport():New("CABR130","Relação de CPF em Duplicidade ",, {|oReport| ReportPrt2(oReport)},"Relação de CPF em Duplicidade  ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ1 := TRSection():New(oReport,"Relação de CPF em Duplicidade   ",,aOrdem)             
       
 //  TRCell():New(oDPJ1 ,'MATRIC1'	    	,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NOMUSR1'	     	,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NCOBRA1'           ,/*TABELA*/	,'nivel cobraca1'  ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'DATNAS1'	      	,/*TABELA*/	,'Dt. Nasc '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'IDADE1'	      	    ,/*TABELA*/	,'Idade  '         ,/*Picture*/ 	    ,02			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'CPF1'		    	,/*TABELA*/	,'CPF '            ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'bloq1'		    	,/*TABELA*/	,'bloq '           ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'MATVID1'		   	,/*TABELA*/	,'MatVida '        ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'<<<----->>>'	   	,/*TABELA*/	,'<<<----->>>'      ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 //  TRCell():New(oDPJ1 ,'MATRIC2'	    	,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NOMUSR2'	     	,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NCOBRA2'           ,/*TABELA*/	,'nivel cobraca1'  ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'DATNAS2'	      	,/*TABELA*/	,'Dt. Nasc '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'IDADE2'	      	    ,/*TABELA*/	,'Idade  '         ,/*Picture*/ 	    ,02			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'CPF2'		    	,/*TABELA*/	,'CPF '            ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'bloq2'		    	,/*TABELA*/	,'bloq '           ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'MATVID2'		   	,/*TABELA*/	,'MatVida '        ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
 
oBreak01 		:= TRBreak():New(oDPJ1,oDPJ1:Cell("CPF1"),"Total  "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                    
   TRFunction():New(oDPJ1:Cell("CPF1")         ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)


/******************************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrt2(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ1 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados2)

//Se nao tiver esta linha, nao imprime os dados
oDPJ1:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados2)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf  
		
       oDPJ1:Cell('NOMUSR1'	 		):SetValue((aDados2[i][1]))        
       oDPJ1:Cell('NCOBRA1'  	  	):SetValue((aDados2[i][2]))   
       oDPJ1:Cell('DATNAS1'	 		):SetValue((aDados2[i][3]))   
	   oDPJ1:Cell('IDADE1'	 		):SetValue((aDados2[i][4]))         
	   oDPJ1:Cell('CPF1'	 	    ):SetValue((aDados2[i][5]))           
	   oDPJ1:Cell('bloq1'	 		):SetValue((aDados2[i][6]))           
	   oDPJ1:Cell('MATVID1'	 		):SetValue((aDados2[i][7]))        
       oDPJ1:Cell('<<<----->>>'		):SetValue((aDados2[i][8]))               
       oDPJ1:Cell('NOMUSR2'	 		):SetValue((aDados2[i][9]))       
       oDPJ1:Cell('NCOBRA2'	        ):SetValue((aDados2[i][10])) 
	   oDPJ1:Cell('DATNAS2'	 		):SetValue((aDados2[i][11])) 
	   oDPJ1:Cell('IDADE2'	 		):SetValue((aDados2[i][12]))        
	   oDPJ1:Cell('CPF2'	 		):SetValue((aDados2[i][13]))          
	   oDPJ1:Cell('bloq2'	 		):SetValue((aDados2[i][14])) 
	   oDPJ1:Cell('MATVID2'	 		):SetValue((aDados2[i][15]))      
	
   oDPJ1:PrintLine()
   
Next i

oDPJ1:Finish()

Return   

/********************************************************************************************************************************                                                                                           
/*
cpf em branco  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function ReportDef4()

Local oReport 
Local oDPJ2  
oReport	:= TReport():New("CABR130","Relação de CPF em Branco  ",, {|oReport| ReportPrt4(oReport)},"Relação de CPF em Branco   ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ2 := TRSection():New(oReport,"Relação de CPF CPF em diuplicidade   ",,aOrdem)             
       
   TRCell():New(oDPJ2 ,'NOMUSR1'	     	,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ2 ,'NCOBRA1'           ,/*TABELA*/	,'Nivel Cobraca'   ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ2 ,'DATNAS1'	      	,/*TABELA*/	,'Dt. Nasc '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ2 ,'IDADE1'	      	    ,/*TABELA*/	,'Idade  '         ,/*Picture*/ 	    ,02			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ2 ,'CPF1'		    	,/*TABELA*/	,'CPF '            ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ2 ,'bloq1'		    	,/*TABELA*/	,'bloq '           ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ2 ,'MATVID1'		   	,/*TABELA*/	,'MatVida '        ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ2 ,'TPUSR'	        	,/*TABELA*/	,'TPUSR'           ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 
oBreak01 		:= TRBreak():New(oDPJ2,oDPJ2:Cell("CPF1"),"Total  "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                    
   TRFunction():New(oDPJ2:Cell("CPF1")         ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)   
/******************************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrt4(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ2 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados3)

//Se nao tiver esta linha, nao imprime os dados
oDPJ2:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados3)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf  
		
       oDPJ2:Cell('NOMUSR1'	 		):SetValue((aDados3[i][1]))        
       oDPJ2:Cell('NCOBRA1'  	  	):SetValue((aDados3[i][2]))   
       oDPJ2:Cell('DATNAS1'	 		):SetValue((aDados3[i][3]))   
	   oDPJ2:Cell('IDADE1'	 		):SetValue((aDados3[i][4]))         
	   oDPJ2:Cell('CPF1'	 	    ):SetValue((aDados3[i][5]))           
	   oDPJ2:Cell('bloq1'	 		):SetValue((aDados3[i][6]))           
	   oDPJ2:Cell('MATVID1'	 		):SetValue((aDados3[i][7]))        
       oDPJ2:Cell('TPUSR'	    	):SetValue((aDados3[i][8]))               
           
	
   oDPJ2:PrintLine()
   
Next i

oDPJ2:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Mes Aniversario ") 		,"","","mv_ch1","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano Aniversario ") 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"03",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"04",OemToAnsi("So XX anos  ") 	        ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Conf. Duplicidade CPF ") 	,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Conf. CPF XX Anos")    	,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"07",OemToAnsi("Conf. CPF Em branco >XX Anos")   	,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"08",OemToAnsi("Idade Para validar(XX) ") 		,"","","mv_ch8","N",02,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","","",{},{})

Pergunte(cPerg,.F.)

Return

