#include "PROTHEUS.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} function PLRDBXCR
 description
  Ponto de entrada PLRDBXCR criado para alterar a query que verifica 
  os títulos a ser compensados com o NCC.
 @author  Angelo Henrique
 @since   26/08/2020
 @version P12 RELEASE 27
/*/
//-------------------------------------------------------------------

User Function PLRDBXCR()

    Local cQuery := PARAMIXB[1] //Query padrão 

    // Manipulação da query
    cQuery := STRTRAN(cQuery, "<=", "=")  
    cQuery += " AND E1_NUM = '" + SE1->E1_NUM  + "' " 

Return cQuery