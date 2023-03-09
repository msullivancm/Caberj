#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR163   บ Autor ณAltamiro              บ Data ณ 30/03/15  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณEste programa ira fazer listagem da Critica do SIB          บฑฑ
ฑฑบ          ณ conforme parametros                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABR163A

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR163"
Private cTitulo     := "Listagem da Critica do SIB "        

Private cAliastmp 	:= GetNextAlias()  

Private cAliastmp1	:= GetNextAlias()        

Private cAliastmp2	:= GetNextAlias()       

Private lCritica    :=.F.
Private x           := 0  
private a           := ' '   
private dDtBase     := dtos(dDataBase)

                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem da Critica do SIB conforme parametros" 

***************************************************************************    
 
Private aDados1    := {}       
Private acabec1    := {"cod Emp" , "Contrato", "Vers. Contrato","Sub Contrato", "Vers Sub ","Matricula",;
                                                  "Nome Usuario", "Motivo","Critica F/T" ,;
                                                  "Data Nasc." ,"Conteudo ","Motivo","Critica F/T" ,;
                                                  "Cpf usuario ","Conteudo ","Motivo","Critica F/T" ,;
                                                 "SEXO"         ,"Conteudo ","Motivo","Critica F/T" ,;
                                                 "Nome Mใe "    ,"Conteudo ","Motivo","Critica F/T" ,;
                                                 "Pispasep "    ,"Conteudo ","Motivo","Critica F/T" ,; 
                                                 "Decl.N. Vivo" ,"Conteudo ","Motivo","Critica F/T" ,; 
                                                 "num. Cartao saude" ,"Conteudo ","Motivo","Critica F/T" ,;
                                                 "End residencial "  ,"Conteudo ","Motivo","Critica F/T" ,;
                                                  "Logradouro" ,"Conteudo ","Motivo","Critica F/T" ,;       
                                                  "Bairro"     ,"Conteudo ","Motivo","Critica F/T" ,;    
                                                  "Cod. Munic" ,"Conteudo ","Motivo","Critica F/T" ,;
                                                  "cod. Cep"   ,"Conteudo ","Motivo","Critica F/T" ,;
                                                  "Plano Repase" ,"Conteudo ","Motivo","Critica F/T" ,;
                                                  "Data Bloqueio " ,"Conteudo ","Motivo","Critica F/T" ,;
                                                  "Familia sem titular" ,"Conteudo ","Motivo","Critica F/T" ,"critica sib"}



 

Private aDados2    := {}       
Private acabec2    := {"Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","<<<----->>> ",;
                        "Usuario2","Nivel Cobr2", "Data Nasc.2","Idade2" , "Cpf usuario2 ","Bloq2","Matr. Vida2"}               
                        
Private acabec3    := {"Nome Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","Tp Usuario "}   
Private aDados3    := {}  

private Descric     := ' '   
private ctraco      := replicate("_",220)     

private lCritica1 := .F.                                                
private a1        := ' '                                                                                                         
private lCritica2 := .F.                                                
private a2        := ' '                                                                                                        
private lCritica3 := .F.                                                
private a3        := ' '                                                                                                        
private lCritica4 := .F.                                                
private a4        := ' '                                                                                                        
private lCritica5 := .F.                                                
private a5        := ' '                                                                                                        
private lCritica6 := .F.                                                
private a6        := ' '                                                                                                        
private lCritica7 := .F.                                                
private a7        := ' '                                                                                                        
private lCritica8 := .F.                                                
private a8        := ' '                                                                                                        
private lCritica9 := .F.                                                
private a9        := ' '                                                                                                        
private lCritica10:= .F.                                                
private a10       := ' '                                                                                                        
private lCritica11:= .F.                                                
private a11       := ' '                                                                                                        
private lCritica12:= .F.                                                
private a12       := ' '                                                                                                        
private lCritica13:= .F.                                                
private a13       := ' '     
private lCritica14:= .F.                                                
private a14       := ' '     

private cMens1 := ' '                                                                                                   
private cMens2 := ' '
private cMens3 := ' ' 
private cMens4 := ' '  
private cCpf   := ' '                                                                                                                                                                                                  

 	
  	  
AjustaSX1(cPerg)

//Pergunte(cPerg,.T.) 

cDtIniSib      := dtos(mv_par01)
cDtFimSib  	   := dtos(mv_par02)   
cInclSib       := mv_par03 
cAltSib        := mv_par04
cExcSib        := mv_par05 
cListSCri      := mv_par06  
cEmpDe         := mv_par07  
cEmpAte        := mv_par08  

cGeraprod  	   := mv_par09   
cusuario       := mv_par10

cGeraEx  	   := mv_par11  

dDatRef  := dtos(mv_par02)

cCpfMI16       := 1 
cCpfDupl       := 0     
cCpfBranco     := 0 
Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
   
// faz ecxel   
if len(aDados1) > 0 
   if cGeraEx == 1    
      If cInclSib  == 1 .or. cAltSib  == 1 
         DlgToExcel({{"ARRAY","Listagem Criticas da prefeitura " ,acabec1 ,aDados1}})   
      EndIf        
    EndIF 
EndIf
      
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
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
////////////////////////////////////   
cquery := CRLF+" SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO,"
cquery += CRLF+"        BA1_NOMUSR, BA1_OPEORI, BA1_INFANS, BA1_ATUSIB, BA1_LOCSIB, BA1_MATANT,BA1_MATUSB, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB,"
cquery += CRLF+"        BA1_INFSIB, BA1_CODPLA, BA1_VERSAO, BA1_DATBLO, BA1_DATNAS, BA1_SEXO, BA1_CPFUSR, BA1_MAE, BA1_TIPUSU, BA1_ENDERE, BA1_CEPUSR, BA1_TRADES, BA1_TRAORI,"
cquery += CRLF+"        BA1_MUNICI, BA1_ESTADO, BA1_DATINC, BA1_DATTRA, BA1_CODCLI, BA1_LOJA, BA1_COBNIV, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_CODMUN,"
cquery += CRLF+"        BA1_GRAUPA, BA1_MATVID, BA1_CPFMAE, BA1_CPFPRE, BA1_CODCCO, BTS_DRGUSR, BTS_ORGEM, BTS_RGEST,BTS_PISPAS, BTS_NRCRNA, BTS_DENAVI,"
cquery += CRLF+"        BA3_TIPOUS, BA3_PLPOR, BA3_CODPLA, BA3_VERSAO, BA3_CODCLI, BA3_LOJA, BA3_COBNIV  " 

cquery += CRLF+"   FROM "+ RetSqlName("BA1") + " BA1 , " + RetSqlName("BTS") + " BTS , " + RetSqlName("BA3")+" BA3  "
cquery += CRLF+"  WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND BA1.D_E_L_E_T_ = ' '"
cquery += CRLF+"    AND BTS_FILIAL = '" + xFilial("BTS") + "' AND BTS.D_E_L_E_T_ = ' '"
cquery += CRLF+"    AND BA3_FILIAL = '" + xFilial("BA3") + "' AND BA3.D_E_L_E_T_ = ' '"  
cquery += CRLF+"    AND BA1_MATVID = BTS_MATVID AND BA1_CODINT = BA3_CODINT AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC"

cquery += CRLF+" AND BA1_CODEMP >= '" + cEmpDe + "' AND BA1_CODEMP <= '" + cEmpAte + "' and ba1_image = 'ENABLE'"
  
cquery += CRLF+"        ORDER BY BA1_FILIAL, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, CASE WHEN BA1_TIPUSU = 'T' THEN '1' ELSE '2' END, BA1_TIPREG, BA1_DIGITO"
       
//////
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
 TCQuery cQuery New Alias (cAliastmp)  
    
 dbSelectArea(cAliastmp)
   
 (cAliastmp)->(dbGoTop())   
 

While (cAliastmp)->(!Eof())                     
/***********************/
lCritica:=.F.     
                         PI_NomUsr() 
                         PI_DtNUsr()  
                         PI_Cpf()      
                         PI_sexo()    
                         PI_NomMae()                            
                         PI_Pispas()  
                         PI_NasViv()   
                         PI_cns()     
                         PI_END1()    
                         PI_END2()    
                         PI_END3()    
                         PI_END4()    
                         PI_END5()    
                       //  PI_PlOrg()   
                         PI_DtCanc()   
                         PI_FamTit()  


 aaDD(aDados1,{   (cAliastmp)->BA1_CODEMP , (cAliastmp)->BA1_CONEMP, (cAliastmp)->BA1_VERCON, (cAliastmp)->BA1_SUBCON, (cAliastmp)->BA1_VERSUB,;
                      "Matricula : " + (cAliastmp)->BA1_CODINT+'.'+(cAliastmp)->BA1_CODEMP+'.'+(cAliastmp)->BA1_MATRIC+'.'+(cAliastmp)->BA1_tipreg+'.'+(cAliastmp)->BA1_digito ,;
             (cAliastmp)->BA1_NOMUSR               ,a14 , lcritica14 ,;    
                     "Data Nascimento " ,SubStr((cAliastmp)->BA1_DATNAS,7,2) +"/" + SubStr((cAliastmp)->BA1_DATNAS,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATNAS,1,4) ,a1 , lCritica1    ,;
                     cMens1             ,cCpf                                                                                                                            ,a2  , lCritica2    ,;  
                     "Sexo do usuario "                    , Iif((cAliastmp)->BA1_SEXO == "1","1-Masculino","3-Feminino")                                               ,'nao critica','nao critica' ,; 
                     "Nome da Mใe"                         , AllTrim(SubStr((cAliastmp)->BA1_MAE+Space(70),1,70))                                                       ,a4 , lcritica4 ,;
                     "Numero do PisPasep"                  , AllTrim((cAliastmp)->BTS_PISPAS)                                                                            ,a5 , lcritica5 ,;         
                     "Declaracao de Nascido Vivo"          , AllTrim((cAliastmp)->BTS_DENAVI)                                                                            ,a6 , lcritica6 ,;
                     "Numero do Cartao Nacional de SaudE " , AllTrim((cAliastmp)->BTS_NRCRNA)                                                                            ,'nao critica','nao critica' ,;
                     "Endereco residencial"                , ((cAliastmp)->BA1_ENDERE)                                                                                   ,a7  , lcritica7 ,;
                     "logradouro "                         , ((cAliastmp)->BA1_COMEND)                                                                                   ,a8  , 'nao critica' ,;
                     "Bairro "                             , ((cAliastmp)->BA1_BAIRRO)                                                                                   ,a9  , lcritica9 ,;
                     "Codigo do municipio"                 , ((cAliastmp)->BA1_CODMUN)                                                                                   ,a10 , lcritica10 ,;
                     "Codigo do CEP"                       , ((cAliastmp)->BA1_CEPUSR)                                                                                   ,a11 , lcritica11 ,;
                     "Plano repase"                        , cMens2                                                                                                       ,'nao critica','nao critica' ,;
                     "Data Bloqueio "                      , cMens3                                                                                                       ,a12 , lcritica12 ,;
                     "Familia sem Titular "                , cMens4                                                                                                       ,a13 , lcritica13 ,;
                     lCritica })
         (cAliastmp)->(dbSkip()) 	   
EndDo	                   
                                          
/////////////////////////////////////////*        

Return    
                
******************************************************************************************
Static Function PI_sexo() 
// Sexo do beneficiario                                                   
private cMens := ' ' 
     	cMens := "Sexo do usuario , cadastro Usuario --> "+ Iif((cAliastmp)->BA1_SEXO == "1","1-Masculino","3-Feminino")
     	
return(Cmens)                                                             
                       
/*********************                                                        
// CPF - Cadastro de Pessoas Fisicas - do beneficiario
*********************/
Static Function PI_Cpf()   
private cMens := ' '   
                                    
lCritica2:= .F.   
a2:= " " 
If !Empty((cAliastmp)->BA1_CPFUSR)
	cMens := "Cpf Preenchido , Valido , Cadastro Usuario --> "+(cAliastmp)->BA1_CPFUSR 
	 cCpf :=((cAliastmp)->BA1_CPFUSR)
Else
	If Calc_Idade(Ctod(dDatRef),Ctod((cAliastmp)->BA1_DATNAS)) < 18 .And. (cAliastmp)->BA1_TIPUSU <> 'T'
	   cMens := "Cpf em Branco , Valido , Cadastro Usuario --> "+(cAliastmp)->BA1_CPFUSR
	   cCpf  := (cAliastmp)->BA1_CPFUSR
	Else
		If !Empty((cAliastmp)->BA1_CPFMAE)               
   		   cMens := "Cpf da Mใe , Valido , Cadastro Usuario --> "+(cAliastmp)->BA1_CPFMAE
   		   cCpf  := (cAliastmp)->BA1_CPFMAE
		Else
			If !Empty((cAliastmp)->BA1_CPFPRE)
			   cMens := "Cpf do Preposto , Valido , Cadastro Usuario --> "+ (cAliastmp)->BA1_CPFPRE
			   cCpf  := (cAliastmp)->BA1_CPFPRE
			Else
			   cMens := "Cpf Em Branco , InValido , Cadastro Usuario , T "   
			   lCritica := .T.    
			   lCritica2:= .T. 
			   a2:= 'CPF EM BRANCO' 
			   cCpf  := (cAliastmp)->BA1_CPFMAE
			EndIf
		EndIf
	EndIf
EndIf  
cmens1:=Cmens 
return(Cmens) 
                                                                   
/*********************                                                        
// Numero do PIS/PASEP do beneficiario ou Numero de Identificacao do Trabalhador - NIT
*********************/
Static Function PI_Pispas()
private cMens := ' '                                                       
         a := ' '
        a5 := ' '
 lcritica5 := .F. 
    If Empty((cAliastmp)->BTS_PISPAS) .and. Empty((cAliastmp)->BA1_MAE)  
       a:= 'Pis em Branco e Nome da Mใe em Branco, T '
       lcritica := .T.   
       lcritica5 := .T.    
    EndIf   
        cMens:= 'Numero do PisPasep --> '+ AllTrim((cAliastmp)->BTS_PISPAS) + ' - ' + a 
        a5 := a        
return(Cmens)                                                                    

/*********************                                                        
// Nome da mae do beneficiario                                                
*********************/
Static Function PI_NomMae()   
private         x:= 1  
private         a:=''  
private cMens := ' ' 

a4:= ' ' 
lcritica4 :=.F.

while x <= len((cAliastmp)->BA1_MAE)    
        if (X+3) <= len((cAliastmp)->BA1_MAE) .and. (substr((cAliastmp)->BA1_MAE ,x , 1)) = ' ' .and. (substr((cAliastmp)->BA1_MAE ,x+1 , 2)) != ' ' .and. (substr((cAliastmp)->BA1_MAE ,x+2 , 3)) = ' ' 
            a:= 'Abrevia็ใo identificadas , T ' 
            lCritica:= .T.                      
            a4:= a
            lcritica4 :=.T. 
        EndIf    
        if (substr((cAliastmp)->BA1_MAE ,x , 1)) $ ".|-|_|/|'|=|:"  
            a :='Caracter Especial   ,T ' 
            lCritica:= .T.       
            a4:= a
            lcritica4 :=.T.  
        elseif (substr((cAliastmp)->BA1_MAE ,x , 1)) $ "0|1|2|3|4|5|6|7|8|9"  
            a:= 'Numero  Identificado  , T  '
            lCritica:= .T.   
            a4:= a
            lcritica4 :=.T.
       endIf       
     x++
enddo                                  
if empty ((cAliastmp)->BA1_MAE)      
   a:='Em Branco , T ' 
   lCritica:= .T.   
   a4:= a
   lcritica4 :=.T.
EndIf     
        cMens := "Nome da Mใe,  Cadastro Usuario --> " + AllTrim(SubStr((cAliastmp)->BA1_MAE+Space(70),1,70)) +  ' - ' + a   
return(Cmens)

/*********************    
// Numero da Declaracao de Nascido Vivo
*********************/
Static Function PI_NasViv()   
private cMens := ' ' 
a6:=' '
 lCritica6:= .F. 
       
if (cAliastmp)->BA1_DATNAS >= "20100101"
    If empty(trim(BTS->BTS_DENAVI)) 
       cMens := "Numero da Declaracao de Nascido Vivo , Nascidos apartir de 01/01/2010 --> Em Branco , T " 
       lCritica:= .T.          
       lCritica6:= .T.
    else     	
       cMens := "Numero da Declaracao de Nascido Vivo , Nascidos apartir de 01/01/2010 --> " + AllTrim((cAliastmp)->BTS_DENAVI)     
    EndIf    
Else
	cMens := "Numero da Declara็ใoo de Nascido Vivo, Nascidos antes 01/01/2010  , em branco "
EndIf          
a6:= cMens
return(Cmens)
                          
/*********************    
// Numero do Cartao Nacional de Saude
*********************/
Static Function PI_cns
private cMens := ' ' 
     	cMens := "Numero do Cartao Nacional de Saude --> " + AllTrim((cAliastmp)->BTS_NRCRNA)
return(Cmens)                                                             

/*********************    
// Codigo de identificacao do beneficiario titular na operadora para beneficiarios informados como dependentes
*********************/
Static Function PI_MatTD
private cMens := ' ' 
If (cAliastmp)->BA1_TIPUSU <> 'T'
   cMens := "Matricula atual do Dependente  , Cadastro Usuario --> " + (cAliastmp)->BA1_CODINT+'.'+(cAliastmp)->BA1_CODEMP+'.'+(cAliastmp)->BA1_MATRIC+'.'+(cAliastmp)->BA1_tipreg+'.'+(cAliastmp)->BA1_digito 
   if !Empty((cAliastmp)->BA1_MATANT)
      cMens := "Matricula Anterior do Dependente , Cadastro Usuario --> " + (cAliastmp)->BA1_MATANT
   EndIf  
   If (cAliastmp)->BA1_tipreg == '00'
      a:= " - Tipreg igual 00 - T "
      lCritica:= .T.  
   EndIf   
ElseIf (cAliastmp)->BA1_TIPUSU == 'T'
   cMens := "Matricula atual do titular , Cadastro Usuario --> " + (cAliastmp)->BA1_CODINT+'.'+(cAliastmp)->BA1_CODEMP+'.'+(cAliastmp)->BA1_MATRIC+'.'+(cAliastmp)->BA1_tipreg+'.'+(cAliastmp)->BA1_digito 
   if !Empty((cAliastmp)->BA1_MATANT)
	  cMens := "Matricula Anterior do Titular , Cadastro Usuario --> " + (cAliastmp)->BA1_MATANT
   EndIf   
   If (cAliastmp)->BA1_tipreg != '00'
      a:= " - Tipreg diferente de  00 - T "
      lCritica:= .T.  
   EndIf      
EndIf    
return(Cmens+a)

/*********************    
/* IDENTIFICACAO DE ENDERECO 
*********************/

Static Function PI_END1
// Indicacao de endereco residencial ou profissional 2,1
//aRegInc[nRegInc,11] := "2"
// Logradouro do beneficiario
private cMens := 'endereco residencial , Cadastro Usuario --> '     
a:= ' '     
a7       :=' ' 
lCritica7:= .F.  
if empty ((cAliastmp)->BA1_ENDERE)      
   a:='Em Branco , T ' 
   lCritica:= .T.  
   lCritica7:= .T.  
EndIf              

cMens += AllTrim(SubStr((cAliastmp)->BA1_ENDERE + Space(50),1,50))+AllTrim(SubStr((cAliastmp)->BA1_NR_END + Space(05),1,05)) +' - '+ a     
a7:= a         
return(Cmens)

/**********************************/
Static Function PI_END2
// Numero do logradouro
private cMens := 'logradouro , Cadastro Usuario --> '    
a:= ' '   
a8:= ' ' 
if empty((cAliastmp)->BA1_COMEND)      
     a:='Em Branco '    
EndIf              
  cMens += AllTrim(SubStr((cAliastmp)->BA1_COMEND + Space(15),1,15)) +' - '+ a 
  a8:= a
return(Cmens)   

/***********************/
Static Function PI_END3
// Bairro do logradouro do beneficiario           
private cMens := 'Bairro  , Cadastro Usuario --> '     
 a:=' ' 
 a9:= ' ' 
 lCritica9:= .F. 
if empty(TRIM((cAliastmp)->BA1_BAIRRO))      
   a:='Em Branco  , T ' 
   lCritica:= .T.
   a9:= a 
   lCritica9:= .T. 
EndIf   
   cMens += AllTrim(SubStr((cAliastmp)->BA1_BAIRRO + Space(30),1,30))+' - '+ a
        
return(Cmens)   
        
/**********************************/
Static Function PI_END4
// Codigo do municipio do logradouro indicado     
private cMens := 'Codigo do municipio , Cadastro Usuario --> ' 
 a:=' '    
 a10 := ' '      
 lCritica10:= .F.
 
if empty((cAliastmp)->BA1_CODMUN)      
   a:='Em Branco , T ' 
   a10:=a
   lCritica:= .T. 
   lCritica10:= .T.
EndIf  
   cMens += AllTrim((cAliastmp)->BA1_CODMUN)+' - '+ a
return(Cmens)                     

/**********************************/
Static Function PI_END5
// CEP                              
/**********************************/                       
private cMens := 'Codigo do CEP  , Cadastro Usuario --> ' 
a11:= ' '           
lCritica11:= .F.   

if empty((cAliastmp)->BA1_CEPUSR)      
   a:='Em Branco , T ' 
   lCritica:= .T.   
   lCritica11:= .T.      
   a11:=a
EndIf  
   cMens += AllTrim((cAliastmp)->BA1_CEPUSR)+' - '+ a
return(Cmens)                                            
 
/**********************************/                       


/**********************************/                       
Static Function PI_PlOrg
// Numero do plano origem RPS (portabilidade)
private cMens := 'Numero do plano origem RPS , Cadastro Usuario --> '     

cMens +=  AllTrim(If( !Empty((cAliastmp)->BA3_PLPOR) .Or. !Empty((cAliastmp)->BA1_PLPOR),;
                  If(!Empty((cAliastmp)->BA1_PLPOR),(cAliastmp)->BA1_PLPOR,(cAliastmp)->BA3_PLPOR),''))  
                  
cmens2:=Cmens                        
return(Cmens)  

/**********************************/                        
Static Function PI_DtIPl
// Data de contratacao do plano
private cMens := 'Data de contratacao do plano , cadastro Usuario --> '   
a:= ' '  
If dDtBase <(cAliastmp)->BA1_DATINC
   a := " - Data Incluใo maior que data de atual , T "  
    lCritica:= .T.  
EndIf
cMens += SubStr((cAliastmp)->BA1_DATINC,7,2) + "/" + SubStr((cAliastmp)->BA1_DATINC,5,2) + "/" + SubStr((cAliastmp)->BA1_DATINC,1,4) + a
return(Cmens)  

/**********************************/                        
Static Function PI_NomUsr                                              
// Nome do Beneficiario                                                
private cMens := 'Nome Beneficiario  , cadastro Usuario --> '   
 a14:= ' '  
 x:= 1                      
 lCritica14:= .F.  
while x <= len((cAliastmp)->BA1_NOMUSR)  
               
        if (X+3) <= len((cAliastmp)->BA1_NOMUSR) .and. (substr((cAliastmp)->BA1_NOMUSR ,x , 1)) = ' ' .and. (substr((cAliastmp)->BA1_NOMUSR ,x+1 , 2)) != ' ' .and. (substr((cAliastmp)->BA1_NOMUSR ,x+2 , 3)) = ' ' 
            a14:= 'Abrevia็ใo identificadas , T  ' 
            lCritica:= .T.                       
            lCritica14:= .T.
        EndIf    
        If (substr((cAliastmp)->BA1_NOMUSR ,x , 1)) $ ".|-|_|/|'|=|:"  
            a14:= 'Caracter Especial  , T ' 
            lCritica:= .T.
            lCritica14:= .T.   
        elseif (substr((cAliastmp)->BA1_NOMUSR ,x , 1)) $ "0|1|2|3|4|5|6|7|8|9"  
            a14:= 'Numero  Identificado  , T  '
            lCritica:= .T.   
            lCritica14:= .T.   
        endIf     
      x++
enddo    
                              
if empty ((cAliastmp)->BA1_NOMUSR)      
   a14:='Em Branco , T ' 
   lCritica:= .T. 
   lCritica14:= .T.     
EndIf     

cMens += AllTrim(SubStr((cAliastmp)->BA1_NOMUSR + Space(70),1,70)) +' - '+ a14   
return(Cmens) 
                                                                        
/**********************************/                        
Static Function PI_DtNUsr                                              
// Data de nascimento do beneficiario                        
private cMens := 'Data Nascimento do Beneficiario  , cadastro Usuario --> '      
// SOLITADO PELA LUCIA A INCLUวรO DA CRITICA  DE MES ANO , SENDO IGNORADO O DIA DO NACISMENTO 
a:= ' '   
a1:=' ' 
lCritica1:= .F. 
lCritica:= .F.     
if SUBSTR((cAliastmp)->BA1_DATNAS,1,6) > SUBSTR((cAliastmp)->BA1_DATINC,1,6)
  a:= ' Mes/Ano de nascimento maior que o mes/ano de inclussao -- '+ SUBSTR((cAliastmp)->BA1_DATNAS,1,6) + ' > ' + SUBSTR((cAliastmp)->BA1_DATINC,1,6) +', T '
  lCritica:= .T.  
  lCritica1:= .T.                                                  
  a1:= ' Mes/Ano de nascimento maior que o mes/ano de inclussao -- '+ SUBSTR((cAliastmp)->BA1_DATNAS,1,6) + ' > ' + SUBSTR((cAliastmp)->BA1_DATINC,1,6) +', T '
else  
  a:= ' '                                                          
  lCritica1:= .F.                                                
  a1:= ' '                                                            
    
EndIf     
  cMens +=  SubStr((cAliastmp)->BA1_DATNAS,7,2) +"/" + SubStr((cAliastmp)->BA1_DATNAS,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATNAS,1,4) + a      

return(Cmens) 
             
/**********************************/                        
Static Function PI_DtCanc                                              
// Data de nascimento do beneficiario                        
private cMens := 'Data Bloqueio do Beneficiario  , cadastro Usuario --> '      
// SOLITADO PELA LUCIA A INCLUวรO DA CRITICA  DE MES ANO , SENDO IGNORADO O DIA DO NACISMENTO 
a:= ' ' 
a12:= ' ' 
lCritica12:= .F. 
if !empty((cAliastmp)->BA1_DATBLO)  .and.(cAliastmp)->BA1_DATBLO < (cAliastmp)->BA1_DATINC
  a:= ' Data do B็loqueio menor que a de Inclussao , T '
  lCritica:= .T. 
  lCritica13:= .T. 
else 
  a:= ' ' 
EndIf   
cMens +=  "Dt do Inclussใo " +SubStr((cAliastmp)->BA1_DATINC,7,2) +"/" + SubStr((cAliastmp)->BA1_DATINC,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATINC,1,4)  
cMens +=  "Dt do Bloquido " +SubStr((cAliastmp)->BA1_DATBLO,7,2) +"/" + SubStr((cAliastmp)->BA1_DATBLO,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATBLO,1,4) + a     
  a13 := a    
  cmens3:=Cmens 
return(Cmens) 



/**********************************/                        
Static Function PI_FamTit                                                       

private cMens := 'Familia Com Titular  , cadastro Usuario --> '+(cAliastmp)->BA1_CODINT+"'-'"+(cAliastmp)->BA1_CODEMP+"'-'"+(cAliastmp)->BA1_MATRIC+"'"                                                                   
private cSQL  := ' '      
  a13 =  ' ' 
  lCritica13:= .F. 

                          
cSQL += "   SELECT Count(R_E_C_N_O_) QTDA "
cSQL += "     FROM "+ RetSqlName("BA1") + " BA1
//cSQL += "   FROM BA1010 "
cSQL += "   WHERE BA1_FILIAL = '" + xFilial("BA1") + "' "
//cSQL += "   WHERE BA1_FILIAL = '  ' "
cSQL += "   AND BA1_CODINT = '"+(cAliastmp)->BA1_CODINT+"'" 
cSQL += "   AND BA1_CODEMP = '"+(cAliastmp)->BA1_CODEMP+"'"
cSQL += "   AND BA1_MATRIC = '"+(cAliastmp)->BA1_MATRIC+"'"  
cSQL += "   AND BA1_TIPREG = '00' " 
cSQL += "   AND BA1_TIPUSU = 'T'  "
                                   
If Select((cAliastmp1)) <> 0 
  (cAliastmp1)->(DbCloseArea()) 
Endif
  
 TCQuery cSQL New Alias (cAliastmp1)  
    
 dbSelectArea(cAliastmp1)
   
 If (cAliastmp1)->QTDA == 0   
    a:= ' - Familia sem Titular - T ' 
    lCritica:= .T.     
     lCritica13:= .T.
 Else                                 
    a:= ' '
 EndIf    
a13:=a              
cmens4:=Cmens 
return(Cmens + a ) 


/**********************************/                        
/*
// Indicacao de cobertura parcial temporaria
private cMens := 
aRegInc[nRegInc,24] := PLSIBCPT(dDatRef,TRBSIB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

// Indicacao de itens de procedimentos excluidos da cobertura
aRegInc[nRegInc,25] := "0"
                        
 /**********************************                        
Static Function PI_CNPJC
// Numero do CNPJ da pessoa juridica contratante do plano coletivo
private cMens :='Numero do CNPJ da pessoa juridica contratante do plano coletivo '
If (cAliastmp)->BA3_TIPOUS <> "1" //Beneficiario PJ
	If !Empty(BQC->BQC_CNPJ)
		aRegInc[nRegInc,26] := BQC->BQC_CNPJ
	Else
		If SA1->(dbSeek(xFilial("SA1")+BQC->(BQC_CODCLI+BQC_LOJA)))
			aRegInc[nRegInc,26] := SA1->A1_CGC
		Else
			aRetCli := PLSRETNCB(TRBSIB->BA1_CODINT,TRBSIB->BA1_CODEMP,TRBSIB->BA1_MATRIC,TRBSIB->BA1_OPEORI)
			If aRetCli[1]
				If SA1->(msSeek(xFilial("SA1")+TRBSIB->(BA3_CODCLI+BA3_LOJA)))
					aRegInc[nRegInc,26] := SA1->A1_CGC
				EndIf
			EndIf
		EndIf
	EndIf
Else
	aRegInc[nRegInc,26] := ""
EndIf

// Numero do CEI do contratante do plano coletivo
If aRetPla[3] $ "3,4" .And. Empty(BQC->BQC_CNPJ) .And. !Empty(SA1->A1_CEINSS)
	aRegInc[nRegInc,26] := "" // Vou informar o CEI e nao o CNPJ
	aRegInc[nRegInc,27] := AllTrim(SA1->A1_CEINSS)
Else
	aRegInc[nRegInc,27] := ""
EndIf

// Relacao de dependencia
nPos := aScan(aGraPar,{|x| x[1] == TRBSIB->BA1_GRAUPA})
If nPos > 0
	aRegInc[nRegInc,28] := aGraPar[nPos,2]
Else
	aRegInc[nRegInc,28] := "10"
EndIf

aRegInc[nRegInc,29] := .T. //Indica que o registro sera escrito no arquivo SBX

If lCriaLog
	PlsLogFil(Transform(TRBSIB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),MATRIPLS) +"  "+ ;
	SubStr(AllTrim(TRBSIB->BA1_NOMUSR)+Space(30),1,30)+ " - Inclusใo ",cArqLog)
EndIf
*/
Return .T.
******************************************************************************************

Static Function AjustaSX1(cPerg)         

Local aHelpPor := {} 

PutSx1(cPerg,"01",OemToAnsi("Data Inicio SIB   ") 		,"","","mv_ch1","D",10,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Data Fim SIB      ") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Critica Inclusao  ")    	,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Nใo","","","","","","","","","","","",{},{},{})   
PutSx1(cPerg,"04",OemToAnsi("Critica Altera็๕a ")   	,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"05",OemToAnsi("Critica Exclussใo ")       ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Nใo","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"06",OemToAnsi("Listar S๓ Criticados ? ")	,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Nใo","","","","","","","","","","","",{},{},{})   

PutSx1(cPerg,"07",OemToAnsi("Empresa de   ") 		    ,"","","mv_ch7","C",04,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"08",OemToAnsi("Empresa Ate  ") 		    ,"","","mv_ch8","C",04,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"09",OemToAnsi("Produtividade ")          ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Sim","","","","Nใo","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"10",OemToAnsi("Usuaria Prod. ") 		    ,"","","mv_ch10","C",20,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"11",OemToAnsi("Gerar Excel       ") 	    ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim","","","","Nใo","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.T.)

Return


