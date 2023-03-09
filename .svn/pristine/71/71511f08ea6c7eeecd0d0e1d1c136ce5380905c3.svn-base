#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 18/06/01

/*
+-------------------------------------------------------------------------------------+
| Programa   | ConLdig   | Autor | Fabio Sergio                   | Data | 11.07.2002 |
|------------+-----------+-------+--------------------------------+------+------------|
| Descricao  | Informar a linha digitavel do codigo de barras                         |
|            |                                                                        |
|------------+------------------------------------------------------------------------|
| Uso        | Contas a Pagar - Financeiro - CABERJ                                   |
|------------+------------------------------------------------------------------------|
|                  ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   |
|-------------+------------+----------------------------------------------------------|
| Programador | Data       | Motivo da Alteracao                                      |
|-------------+------------+----------------------------------------------------------|
|             |            |                                                          |
+-------------------------------------------------------------------------------------+
*/
User Function ConLdig()        

If M->E2_Tpcodba != "S"
   Return .t.
Endif 

// Define o path do arquivo texto
Private Dlg1 
Private V_Lin1      := Space(05) 
Private V_Lin2      := Space(05)
Private V_Lin3      := Space(05)
Private V_Lin4      := Space(06)
Private V_Lin5      := Space(05)
Private V_Lin6      := Space(06)
Private V_Lin7      := Space(01)
Private V_Lin8      := Space(14)

@ 000,000 to 130,420 DIALOG Dlg1 Title "Linha Digitavel"
@ 005,006 Say OEMTOANSI("Digite a representacao numerica do codigo de barras")
@ 010,003 TO 040,210
@ 020,006 Get V_Lin1  Picture "99999"            Size 07,07 
@ 020,030 Get V_Lin2  Picture "99999"            Size 07,07
@ 020,054 Get V_Lin3  Picture "99999"            Size 07,07
@ 020,078 Get V_Lin4  Picture "999999"           Size 08,08
@ 020,102 Get V_Lin5  Picture "99999"            Size 07,07
@ 020,126 Get V_Lin6  Picture "999999"           Size 08,08
@ 020,150 Get V_Lin7  Picture "9"                Size 03,03
@ 020,155 Get V_Lin8  Picture "99999999999999"   Size 50,50

@ 045,085 BMPBUTTON TYPE 1 ACTION FVerLinDig()
//@ 095,115 BMPBUTTON TYPE 2 ACTION Close(Dlg1)

ACTIVATE DIALOG Dlg1 Center

Return()

****************************
Static Function FVerLinDig()
****************************
 // xxxx9.xxxx9.xxxx9.xxxxx9.xxxx9.xxxxx9.x.xxxxxxxxxxxxx

V_RetBco :=  StrZero(Val(Substr(V_Lin1,1,3)),3)                // Banco
V_RetMoe :=  StrZero(Val(Substr(V_Lin1,4,1)),1)                // Moeda
V_RetDac :=  StrZero(Val(V_Lin7),1)                            // DAC
V_RetVal :=  Strzero(Val(Substr(V_Lin8,01,14)),14)             // Retorna o Fator de Vencimento e Valor
                  

// Retorna o campo livre sem digito verificador.// Tamanho de 25 
V_RetCpo :=  Strzero(Val(Substr(V_Lin1,05,01)),1)          + ; 
             Strzero(Val(Substr(V_Lin2,01,04)),4)          + ;
             Strzero(Val(Substr(V_Lin3,01,05)),5)          + ; 
             Strzero(Val(Substr(V_Lin4,01,05)),5)          + ;
             Strzero(Val(Substr(V_Lin5,01,05)),5)          + ;
             Strzero(Val(Substr(V_Lin6,01,05)),5)          

M->E2_CodBar := V_RetBco + V_RetMoe + V_RetDac + V_RetVal + V_RetCpo

If Val(M->E2_CodBar) = 0 
   M->E2_CodBar := Space(44)
Endif

Close(Dlg1)

Return .t.

/*
+-------------------------------------------------------------------------------------+
| Programa   | FCODBARVL | Autor | GIOVANI CAPUCHO                | Data | 07.03.2002 |
|------------+-----------+-------+--------------------------------+------+------------|
| Descricao  | Calculo do modulo 11 sugerido pelo ITAU. Esta funcao somente e utili-  |
|            | zada como validacao do campo E2_CODBAR.                                |
|            |                                                                        |
|            | Esta rotina tambem tranforma o codigo digitado em codigo de barras se  |
|            | necessario                                                             |
|            |                                                                        |
|------------+------------------------------------------------------------------------|
| Obs.       | Este Validacao de Usuario esta associada ao campo E2_CODBAR da tabela  |
|            | Contas a Pagar.                                                        |
|------------+------------------------------------------------------------------------|
| Uso        | Contas a Pagar - Financeiro - Concremat                                |
|------------+------------------------------------------------------------------------|
|                  ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL                   |
|-------------+------------+----------------------------------------------------------|
| Programador | Data       | Motivo da Alteracao                                      |
|-------------+------------+----------------------------------------------------------|
|             |            |                                                          |
+-------------------------------------------------------------------------------------+
*/
User Function FCODBARVL()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LRET := .F.

If ValType(M->E2_CODBAR) == NIL
   Return(.t.)
Endif

cStr    := M->E2_CODBAR
i		:= 0
nMult	:= 2
nModulo := 0
cChar	:= SPACE(1)
cDigito	:= SPACE(1)

If len(AllTrim(cStr)) < 44
   
   cDV1    := SUBSTR(cStr,10, 1) 
   cDV2    := SUBSTR(cStr,21, 1) 
   cDV3    := SUBSTR(cStr,32, 1) 
   
   cCampo1 := SUBSTR(cStr, 1, 9)
   cCampo2 := SUBSTR(cStr,11,10)
   cCampo3 := SUBSTR(cStr,22,10)

   //+---------------------------------------------------------------------------------+
   //| Calculo do modulo 10 sugerido pelo ITAU. Esta funcao somente e utilizada como   |
   //| validacao do campo E2_CODBAR. Verifica a digitacao do codigo de barras          |
   //+---------------------------------------------------------------------------------+

   //+---------------------------------------------------------------------------------+
   //| Calcula DV1                                                                     |
   //+---------------------------------------------------------------------------------+

   nMult	:= 2
   nModulo	:= 0
   nVal		:= 0
   
   For i := Len(cCampo1) to 1 Step -1
    
       cChar := Substr(cCampo1,i,1)
      
       If isAlpha(cChar)
	      Help(" ", 1, "ONLYNUM")
          Return(.f.)
       Endif
		
	   nModulo := Val(cChar)*nMult
		
	   If nModulo >= 10
	      nVal := NVAL + 1
		  nVal := nVal + (nModulo-10)
	   Else
	      nVal := nVal + nModulo	
       EndIf	

       nMult:= if(nMult==2,1,2)

   Next        

   nCalc_DV1 := 10 - (nVal % 10)

   //+---------------------------------------------------------------------------------+
   //| Calcula DV2                                                                     |
   //+---------------------------------------------------------------------------------+

   nMult	:= 2
   nModulo	:= 0
   nVal		:= 0
   
   For i := Len(cCampo2) to 1 Step -1
       
       cChar := Substr(cCampo2,i,1)
       
       If isAlpha(cChar)
          Help(" ", 1, "ONLYNUM")
          Return(.f.)
       Endif        
       
       nModulo := Val(cChar)*nMult
       
       If nModulo >= 10
          nVal := nVal + 1
          nVal := nVal + (nModulo-10)
       Else
          nVal := nVal + nModulo	
       EndIf	
       
       nMult:= if(nMult==2,1,2)

   Next        
   
   nCalc_DV2 := 10 - (nVal % 10)

   //+---------------------------------------------------------------------------------+
   //| Calcula DV3                                                                     |
   //+---------------------------------------------------------------------------------+

   nMult	:= 2
   nModulo	:= 0
   nVal		:= 0
   
   For i := Len(cCampo3) to 1 Step -1
       
       cChar := Substr(cCampo3,i,1)
       
       If isAlpha(cChar)
          Help(" ", 1, "ONLYNUM")
          Return(.f.)
       Endif        
       
       nModulo := Val(cChar)*nMult
       
       If nModulo >= 10
          nVal := nVal + 1
          nVal := nVal + (nModulo-10)
       Else
          nVal := nVal + nModulo	
       EndIf	

       nMult:= If(nMult==2,1,2)

   Next        
   
   nCalc_DV3 := 10 - (nVal % 10)

   If !(nCalc_DV1 == Val(cDV1) .and. nCalc_DV2 == Val(cDV2) .and. nCalc_DV3 == Val(cDV3) )
      Help(" ",1,"INVALCODBAR")
      lRet := .f.
   Else         
      lRet := .t.
   endif                
   
Else

   cDigito := SUBSTR(cStr,5, 1)
   cStr    := SUBSTR(cStr,1, 4)+ ;
              SUBSTR(cStr,6,39)

   //+---------------------------------------------------------------------------------+
   //| Calculo do modulo 11 sugerido pelo ITAU. Esta funcao somente e utilizada como   |
   //| validacao do campo E2_CODBAR.Verifica o codigo de barras grafico (Atraves  de   |
   //| leitor)                                                                         |
   //+---------------------------------------------------------------------------------+

   cStr := AllTrim(cStr)

   If Len(cStr) < 43
      Help(" ", 1, "FALTADG")
      Return(.f.)
   Endif

   For i := Len(cStr) to 1 Step -1
   
       cChar := Substr(cStr,i,1)
   
       If isAlpha(cChar)
          Help(" ", 1, "ONLYNUM")
          Return(.f.)
       Endif        
   
        nModulo := nModulo + Val(cChar)*nMult
        nMult   := if(nMult==9,2,nMult+1)
   
   Next        

   nRest := 11 - (nModulo % 11)
   nRest := if(nRest==10 .or. nRest==11,1,nRest)  

   If nRest <> Val(cDigito)
      Help(" ",1,"DgSISPAG")
      lRet := .f.
   Else         
      lRet := .t.
   Endif                

Endif

Return(lRet)
