#Include "PROTHEUS.CH"

User Function RDMPAO()

AxCadastro("PAO", "Controle Emissão Rel's NUPRE's", , , , , , , {||U_LOGPAO()}, , , , , )  

Return(.T.)       

User Function LOGPAO()

Local cHistPd := " "

If INCLUI
  cHistPd := " "
Else
  If ALTERA
    cHistPd := "ALTERA " + "STATUS " + M->PAO_STATUS + " DATA " + DTOS(M->PAO_DTABER)
  Else
    cHistPd := "EXCLUI " + "STATUS " + M->PAO_STATUS + " DATA " + DTOS(M->PAO_DTABER)
  Endif
Endif
          
If cHistPd != " "
  DbSelectArea("PAP")
  RecLock("PAP", .T.)
  PAP->PAP_FILIAL := xFilial("PAP")   
  PAP->PAP_NUPRE  := M->PAO_NUPRE 
  PAP->PAP_COMPET  := M->PAO_COMPET 
  PAP->PAP_DTOCOR := DDATABASE
  PAP->PAP_HISTPD := cHistPd
  PAP->( MsUnlock() )
Endif  

Return(.T.)