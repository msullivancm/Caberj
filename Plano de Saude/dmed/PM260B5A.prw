#include "PROTHEUS.CH"
#include "PLSMGER.CH"    
#INCLUDE "rwmake.ch"
#include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณM260SQRE ณ Autor ณ Altamiro Affonso       ณ Data ณ 09.01.13  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Ponto de entrada para tratar :                              ณฑฑ 
ฑฑณDescricao ณ a - Reembolso que nใo caracterizam custo m้dico;     	   ณฑฑ
ฑฑณDescricao ณ b - cr้dito concedido ao assistido como auxํlio funeral.	   ณฑฑ    
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Advanced Protheus                                           ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
*/
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define nome da funcao                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
User Function PM260B5A()       
LOCAL cIdreg := PARAMIXB[01] 
LOCAL cmatric:= PARAMIXB[02]
LOCAL cCpftit:= PARAMIXB[03] 
local lret:=.T.

		

if  cIdreg = '3' .and. empty (trbd->b5a_cpfdep) .and. calc_idade (ddatabase , trbd->b5a_datnas)  > 18  //MV_menida    				       
    lret := .F.
EndIf           
        
     
if lret 
   lret:= Val_cpf(substr(cmatric,1,14)) 
EndIf 
                         
      
 return (lret)
///TESTA_CPF       

Static Function Val_cpf( cFamilia )  

Local l_Ret := .T.   

/*cQuery :=" SELECT B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC || B1.BA1_TIPREG MATRICULA1 "
cQuery +="      , B1.BA1_CPFUSR CPF "
cQuery +="      , B1.BA1_DATNAS  "
cQuery +="   from  ba1010 b1  ,bts010  b2   , ba3010 b3 , sa1010 sa1 "
cQuery +="  WHERE B1.BA1_FILIAL=' ' "
cQuery +="    AND B3.BA3_FILIAL = ' '" 
cQuery +="    AND BTS_FILIAL=' ' "
cQuery +="    AND A1_FILIAL = ' ' "  
cQuery +="    AND B1.D_E_L_E_T_=' '" 
cQuery +="    AND B2.D_E_L_E_T_=' ' "
cQuery +="    AND B3.D_E_L_E_T_=' ' "
cQuery +="    AND SA1.D_E_L_E_T_=' ' "   
cQuery +="    AND B1.BA1_DATNAS < '19940101' "
cQuery +="    AND B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC = '" + cFamilia + "'" // &PARAM
cQuery +="    AND BA1_MATVID=BTS_MATVID AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO> TO_CHAR (SYSDATE,'yyyymmdd'))  "
cQuery +="    AND B1.BA1_CODINT = B3.BA3_CODINT AND B1.BA1_CODEMP = B3.BA3_CODEMP AND B1.BA1_MATRIC = B3.BA3_MATRIC AND BA3_CODCLI = A1_COD  "
cQuery +="    AND B1.BA1_CPFUSR IN (SELECT BA1_CPFUSR FROM  BA1010 B1 WHERE B1.BA1_FILIAL=' ' AND B1.D_E_L_E_T_=' '  "
cQuery +="    AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO > TO_CHAR (SYSDATE,'yyyymmdd')) AND B1.BA1_CPFUSR<>' ' " 
cQuery +="    AND B1.BA1_DATNAS < '19940101' "
cQuery +="    AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009') GROUP BY BA1_CPFUSR HAVING COUNT(*)>1 )  "
cQuery +="    AND B1.BA1_CPFUSR<> ' ' AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009')  "
cQuery +="  ORDER BY  2,1*/  

 cQuery :=" SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC ||B1.BA1_tipreg  MATRIC  ,B1.BA1_CPFUSR , b1.ba1_imAge  "
 cQuery +=" , B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  MATRIC  ,B11.BA1_CPFUSR , b11.ba1_imAge " 
 cQuery +="  FROM  BA1010 B11 ,  BA1010 B1                                                                                "
 cQuery +="  WHERE B11.BA1_FILIAL =' ' AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= ' ' AND B1.D_E_L_E_T_= ' '              "
 cQuery +="   AND ((B11.BA1_DATNAS < '19950101') or (B11.BA1_DATNAS >= '19950101'  and b11.ba1_tipusu = 'T'))            "
 cQuery +="   AND ((B1.BA1_DATNAS < '19950101')  or (B1.BA1_DATNAS >= '19950101'   and b1.ba1_tipusu = 'T'))             "
 cQuery +="   and b11.BA1_MATVID <> b1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR  and b1.ba1_cpfusr <> ' '           "
 cQuery +="   and b1.r_e_c_n_o_ <> b11.r_e_c_n_o_                                                                        "
 cQuery +="   AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC||B1.BA1_tipreg <> B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  "
 cQuery +="   AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC  = '" + cFamilia + "'"  
 cQuery +="   and b1.ba1_imAge = 'ENABLE' AND b11.ba1_imAge = 'ENABLE'   "


If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New

TMP->( dbGoTop() )

If TMP->( EOF() )
     
	l_Ret := .T.   

Else       
     
l_Ret := .F.
	

EndIf              

TMP->( dbCloseArea() )         

Return l_Ret

////FIM_TESTA_CPF  
/////limpa caracteres especias dos nomes (titular , dependente , executantes)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSM260   บAutor  ณaltamiro	         บ Data ณ  31/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณremove carracteres invalidos do nomes                       บฑฑ
ฑฑบ          |                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณdmed                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION ConsNome(cReeNom)
PRIVATE lverde := .T.
PRIVATE nnumro := 0
PRIVATE x  := 1   
//private num := "0123456789ABXCDEFGHIJLMNOPQRSTUVXZabcdefghiflmnopqrstuvxz*"
x:= 1  
a:=''  
while x <= len(cReeNom)    
        if (substr(cReeNom ,x , 1)) $ ".|-|_|/|'|=|:"  
            a+=' '
        elseif (substr(cReeNom ,x , 1)) $ "0"  
            a+='O'
        else 
            a+= substr(cReeNom ,x , 1) 
        endIf    
     x++
enddo
Return(a) 
/*




a - CPFs invแlidos de beneficiแrios;
b - Nomes invแlidos de beneficiแrios;
c - CPFs invแlidos de profissionais de sa๚de.    
*/