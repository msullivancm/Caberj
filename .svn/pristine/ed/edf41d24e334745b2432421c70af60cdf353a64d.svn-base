*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | FLOGBOL  | Autor | Edilson Leal  (Korus Consultoria)       |*
*+------------+------------------------------------------------------------+*
*|Data        | 24.01.2008                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Grava Log na Impressão do Boleto. Utilizada nas rotinas    |*
*|            | BOL_ITAU e CABBOLFT.                                       |*
*+------------+------------------------------------------------------------+*
*|Arquivos    | SE1                                                        |*
*+------------+------------------------------------------------------------+*
*|Alteracoes  | 														                  |*
*+-------------------------------------------------------------------------+*
*****************************************************************************

#Include "Rwmake.ch"
#Include "Topconn.ch"

************************
User Function fLogBol()   
************************

Local cArq  := "LOG_IMP_BOLETO"
Local cTrb  := CriaTrab(,.F.)
Local aArea := GetArea()

If !TcCanOpen(cArq)

   aArq := {{"EMPRESA", "C", 02, 0},;
            {"FILIAL" , "C", 02, 0},;
            {"CODUSU" , "C", 05, 0},;   
            {"USUARIO", "C", 30, 0},;
            {"HDATA"  , "D", 08, 0},;                              
            {"HORA"   , "C", 08, 0},;               
            {"PREFIXO", "C", 03, 0},;
            {"NUM"    , "C", 09, 0},;            
            {"PARCELA", "C", 01, 0},;
            {"TIPO"   , "C", 03, 0},;    
            {"CLIENTE", "C", 06, 0},;                
            {"LOJA"   , "C", 02, 0},;
            {"VENCTO" , "D", 08, 0},;          
            {"VENCREA", "D", 08, 0},;            
            {"VALOR"  , "N", 17, 2},;            
            {"NUMBCO" , "N", 15, 2},;            
            {"YTPEXP" , "C", 01, 0}}
                        
   DbCreate(cArq, aArq, "TOPCONN")
   
EndIf

DbUseArea(.T., "TOPCONN", cArq, cTrb, .F., .F.)                                 

(cTrb)->(RecLock((cTrb),.T.))

	(cTrb)->EMPRESA := cEmpAnt
	(cTrb)->FILIAL  := SE1->E1_FILIAL
	(cTrb)->CODUSU  := RetCodUsr()           
	(cTrb)->USUARIO := UsrRetName(RetCodUsr())
	(cTrb)->HDATA   := Date()
	(cTrb)->HORA    := Time()
	(cTrb)->PREFIXO := SE1->E1_PREFIXO
	(cTrb)->NUM     := SE1->E1_NUM
	(cTrb)->PARCELA := SE1->E1_PARCELA
	(cTrb)->TIPO    := SE1->E1_TIPO
	(cTrb)->CLIENTE := SE1->E1_CLIENTE
	(cTrb)->LOJA    := SE1->E1_LOJA
	(cTrb)->VENCTO  := SE1->E1_VENCTO
	(cTrb)->VENCREA := SE1->E1_VENCREA
	(cTrb)->VALOR   := SE1->E1_VALOR
	(cTrb)->YTPEXP  := SE1->E1_YTPEXP   

	**'Marcela Coimbra - Data: 03/07/2013     '** 
	**'Marcela Coimbra - Grava Numero do Banco'** 

	(cTrb)->NUMBCO  := SE1->E1_NUMBCO

	**'Marcela Coimbra - FIM'** 	 

(cTrb)->(MsUnlock())

(cTrb)->(DbCloseArea())

RestArea(aArea)
Return