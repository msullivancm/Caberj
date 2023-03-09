#INCLUDE "rwmake.ch"
     
/*/
----------------------------------------------------------------------------
Programa  F460VER()º Autor ³ ERIKA SCHMITZ         º Data ³  11/03/04   
----------------------------------------------------------------------------
Descricao  Ponto de entrada para impressão de verso de cheque.
----------------------------------------------------------------------------
/*/

User Function FINR460()


Private V_Alias,V_Recno,VHist1,V_Hist2,V_Hist3,V_Hist4,V_Hist5,V_Hist6

V_Hist1 := Space(100)
V_Hist2 := Space(100)
V_Hist3 := Space(100)
V_Hist4 := Space(100)
V_Hist5 := Space(100)
V_Hist6 := Space(100)

_nHdll := PARAMIXB
_nHdll :=0 
_aTitulos :=()

V_Alias := Alias()
V_Recno := Recno()

IF MsgYesNo("Imprime Verso do Cheque ? ")

   @ 190,001 TO 450,470 DIALOG _oDlg1 TITLE "Historico do Cheque : " 
   @ 005,005 TO 250,220
   @ 015,010 Say OEMTOANSI("Historico 1 : ")
   @ 015,060 Get V_Hist1 Picture "@!" Size 130,130
   @ 035,010 Say OEMTOANSI("Historico 2 : ")
   @ 035,060 Get V_Hist2 Picture "@!" Size 130,130 
   @ 050,010 Say OEMTOANSI("Historico 3 : ")
   @ 050,060 Get V_Hist3 Picture "@!" Size 130,130
   @ 065,010 Say OEMTOANSI("Historico 4 : ")
   @ 065,060 Get V_Hist4 Picture "@!" Size 130,130
   @ 080,010 Say OEMTOANSI("Historico 5 : ")
   @ 080,060 Get V_Hist5 Picture "@!" Size 130,130
   @ 095,010 Say OEMTOANSI("Historico 6 : ")
   @ 095,060 Get V_Hist6 Picture "@!" Size 130,130
   @ 118,090 BMPBUTTON TYPE 01 ACTION CLOSE(_ODLG1)
   Activate Dialog _oDlg1 centered
       
   cVerso    := ""
  
   cArqVerso := "C:\CHRONOS\Verso.TXT" 
  
   
   // Para as Versao Protheus (5.07...), deve ser anexado ao Nome   
   // do arquivo o Drive + Diret¢rio Default do Agente de Impressao 
   //(Default C:\AGENTE32\). Exemplo :                              
                                                               
   	    
   cVerso := cVerso + "               "+Replic(chr(13)+chr(10),1)
   cVerso := cVerso + "               "+Alltrim(V_Hist1)+chr(13)+chr(10)
   cVerso := cVerso + "               "+Space(60)+chr(13)+chr(10)
   cVerso := cVerso + "               "+alltrim(V_Hist2)+chr(13)+chr(10)
   cVerso := cVerso + "               "+Space(60)+chr(13)+chr(10)
   cVerso := cVerso + "               "+alltrim(V_Hist3)+chr(13)+chr(10)
   cVerso := cVerso + "               "+Space(60)+chr(13)+chr(10)
   cVerso := cVerso + "               "+alltrim(V_Hist4)+chr(13)+chr(10)
   cVerso := cVerso + "               "+Space(60)+chr(13)+chr(10)
   cVerso := cVerso + "               "+alltrim(V_Hist5)+chr(13)+chr(10)
   cVerso := cVerso + "               "+Space(60)+chr(13)+chr(10)
   cVerso := cVerso + "               "+alltrim(V_Hist6)+chr(13)+chr(10)
   
   
    
            
 If Memowrit(cArqVerso,cVerso)
	  
	  // Caso gravou com sucesso o Texto no Arquivo                     
	  // Retorna "*" + Nome do Arquivo                                  
	  
	   cRetVerso := "*" + cArqVerso
   
 Else
	    // Mas se nao for possivel gravar o arquivo, retorna uma string   
		// em branco, para indicar que o verso nao sera  impresso          
		
		Alert("Nao foi possivel gravar arquivo "+cArqVerso)
		cRetVerso := "*" + cArqVerso
 Endif

Else

   cVerso    := ""
   //cArqVerso := "C:\Bematech\DP20Plus\Verso.TXT"  
   cArqVerso := "C:\CHRONOS\Verso.TXT" 
  
   Memowrit(cArqVerso,cVerso)
   cRetVerso := ""  

Endif

 
DbSelectArea(V_Alias)
DbGoto(V_Recno)

MsWrite(_nHdll,"                    "+Replic(CHR(10)+CHR(13),5))
MsWrite(_nHdll,"                    "+cVerso+CHR(10)+CHR(13))
MsWrite(_nHdll,CHR(12)+CHR(26))

//Return(cRetVerso)
Return(.T.)
