#Include "Protheus.ch"
User Function PLS305BOT()  

Local aBotoes := {}    

AAdd(aBotoes,{'RELATORIO',{|| U_PLS305RECE()} , "Receita Medica","Receita"}) 
AAdd(aBotoes,{'RELATORIO',{|| U_PLS305C24()} , "Guia TISS","Guia"})//verificar esta chamada 

Return (aBotoes)    


User Function PLS305RECE()

If !Empty(M->BTH_CODATE)
  U_CHRECEIT(M->BTH_CODATE)
Else
  Alert("Finalize o Atendimento para a impressão da Receita")
Endif  

Return   

User Function PLS305C24()

If !Empty(M->BTH_CODATE)
  U_CABR024({"1",.F.})
Else
  Alert("Finalize o Atendimento para a impressão da Guia")
Endif  

Return