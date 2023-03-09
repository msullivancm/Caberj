#INCLUDE "PROTHEUS.CH"

USER FUNCTION PL660FC()
Local _nPosIn := Ascan(aRotina,{|x| AllTrim(x[1]) == "Incluir"          })
Local _nPosAl := Ascan(aRotina,{|x| AllTrim(x[1]) == "Alterar"          })
Local _nPosEx := Ascan(aRotina,{|x| AllTrim(x[1]) == "Excluir"          })
Local _nPosVl := Ascan(aRotina,{|x| AllTrim(x[1]) == "Valor Cobrança"   })
Local _nPosPr := Ascan(aRotina,{|x| AllTrim(x[1]) == "Par.Reajustes"     })
		
IF Alltrim(FunName()) $ "CABA233" 
        
    If _nPosIn > 0 .OR. _nPosAl > 0 .OR. _nPosEx > 0 .OR. _nPosVl > 0 .OR. _nPosPr > 0 
        aRotina[_nPosIn][2] := "U_CABA233A()"
        aRotina[_nPosAl][2] := "U_CABA233A()"
        aRotina[_nPosEx][2] := "U_CABA233A()"
        aRotina[_nPosVl][2] := "U_CABA233A()"
        aRotina[_nPosPr][2] := "U_CABA233A()"
    EndIF
EndIF



Return
