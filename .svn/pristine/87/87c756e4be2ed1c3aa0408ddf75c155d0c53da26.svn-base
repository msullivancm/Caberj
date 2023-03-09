
#include "rwmake.ch"
#include "protheus.ch"
User Function autexecrle()
Private lMsErroAuto := .F.  

dbSelectArea("SE2")
SE2->(dbSetOrder(1))
SE2->(dbGoTop())       



//If SE2->(dbSeek(xFilial("SE2") + "RLE" + "011946814" + ""+ "REM" + "135223" + "01"))       
If SE2->(dbSeek(xFilial("SE2") + "RLE" + "011946814" ))
If SE2->E2_SALDO > 0
cHistBaixa := "Exemplo BX. Pagar"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³Monta array com os dados da baixa a pagar do título³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ 
aBaixa := {}                                                
/*
AADD(aBaixa, {"E2_FILIAL" , SE2->E2_FILIAL , Nil})
AADD(aBaixa, {"E2_PREFIXO" , "RLE" , Nil})
AADD(aBaixa, {"E2_NUM" , "011946814", Nil})
AADD(aBaixa, {"E2_PARCELA" ," ", Nil})
AADD(aBaixa, {"E2_TIPO" , "REM" , Nil})
AADD(aBaixa, {"E2_FORNECE" , "135223" , Nil})
AADD(aBaixa, {"E2_LOJA" , "01" , Nil}) 
AADD(aBaixa, {"AUTMOTBX" , "BNC" , Nil})
AADD(aBaixa, {"AUTBANCO" , "001" , Nil})
AADD(aBaixa, {"AUTAGENCIA" , "00001" , Nil})
AADD(aBaixa, {"AUTCONTA" , "000001 " , Nil})
AADD(aBaixa, {"AUTDTBAIXA" , "20170727" , Nil}) 
AADD(aBaixa, {"AUTDTCREDITO", "20170727"  , Nil})
AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
AADD(aBaixa, {"AUTVLRPG" , 25.20, Nil})
*/
AADD(aBaixa, {"E2_FILIAL" , SE2->E2_FILIAL , Nil})
AADD(aBaixa, {"E2_PREFIXO" , SE2->E2_prefixo  , Nil})
AADD(aBaixa, {"E2_NUM" , SE2->E2_NUM , Nil})
AADD(aBaixa, {"E2_PARCELA" ,SE2->E2_PARCELA, Nil})
AADD(aBaixa, {"E2_TIPO" , SE2->E2_TIPO , Nil})
AADD(aBaixa, {"E2_FORNECE" , SE2->E2_FORNECE  , Nil})
AADD(aBaixa, {"E2_LOJA" , SE2->E2_LOJA  , Nil}) 
AADD(aBaixa, {"AUTMOTBX" , 'REE'  , Nil})
AADD(aBaixa, {"AUTBANCO" , ' ' , Nil})
AADD(aBaixa, {"AUTAGENCIA" , '' , Nil})
AADD(aBaixa, {"AUTCONTA" , '' , Nil})
AADD(aBaixa, {"AUTDTBAIXA"  , dDatabase , Nil}) 
AADD(aBaixa, {"AUTDTCREDITO", DDATABASE  , Nil})
AADD(aBaixa, {"AUTHIST" , cHistBaixa , Nil})
AADD(aBaixa, {"AUTVLRPG" , SE2->E2_SALDO , Nil})
ACESSAPERG("FIN080", .F.)
MSEXECAUTO({|x,y| FINA080(x,y)}, aBaixa, 3)
If lMsErroAuto
MOSTRAERRO() 
Return .F.
Else
Alert("Baixa realizada, verifique a SE5")
EndIf 
Else
Alert("O título não possui saldo a pagar em aberto")
EndIf 
Else
Alert("O título a pagar não foi localizado")
EndIf
Return