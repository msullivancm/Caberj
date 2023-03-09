#include "PROTHEUS.CH"
#include "PLSMGER.CH"
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
User Function PM260CLS(  )      
local crec_:= val(PARAMIXB[1])
B5A->(DbGoTo(crec_))
 //alert ("M260GRV") 
/*
/// trata cpf
if b5a_cpftit = " "                                                 
       delete (recno_)
Elseif b5a_cpfdep <> ' ' .and. calc_idade (ddatabase , b5a_datnas)  < 18  //MV_menida    				
       b5a_cpfdep := ' '                                                                               
Elseif b5a_cpfdep := ' ' .and. calc_idade (ddatabase , b5a_datnas)  > 18  //MV_menida    				       
       delete (recno_)
ElseIf  Validacpf(b5a_CODINT || B5a_CODEMP|| B5A_MATRIC )  == .T.
     delete (recno_) 
EndIF                     
*/
 cNomusr := ConsNome(b5a->b5a_nomusr)
 cNomrda := ConsNome(b5a->b5a_nomrda)

if b5a_nomusr != cNomusr .or. b5a->b5a_nomrda != b5a->b5a_nomrda 

   b5a->(reclock("B5A",.F.))
   B5A->b5a_nomusr := cNomusr 
   B5A->b5a_nomrda := cNomrda
   b5a->(msunlock())

 EndIf  

///TESTA_CPF      
/*
Static Function Val_cpf( cFamilia )  

Local l_Ret := .F.   

cQuery :=" SELECT B1.BA1_CODINT|| B1.BA1_CODEMP|| B1.BA1_MATRIC || B1.BA1_TIPREG MATRICULA1 "
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
cQuery +="    AND B1.BA1_CPFUSR<>' ' AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009')  "
cQuery +="  ORDER BY  2,1"

If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New

TMP->( dbGoTop() )

If TMP->( EOF() )
     
	l_Ret := .T.

EndIf              

TMP->( dbCloseArea() )         

Return l_Ret
   */
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




2 - M260GRV


c - CPFs invแlidos de profissionais de sa๚de.      
*/