#Include 'Protheus.ch'              

/*
PONTO DE ENTRANDA USADO PELO MOBILE PARA LIMPAR A INFORMACAO
DE SUBCONTRATO DA CARTEIRA VIRTUAL       
AUTOR - EQUIPE MOBILESAUDE
*/

User Function MSLOGFIM()
LOCAL obj := Paramixb[1]
LOCAL nI  := Paramixb[2]
LOCAL cSql := ""

If 	BA1->BA1_CODEMP == "0001" .or.;
	BA1->BA1_CODEMP == "0002" .or.;
	BA1->BA1_CODEMP == "0003" .or.;
	BA1->BA1_CODEMP == "0005"

	obj:retorno_dados[nI]:empresa_nome	:= ""
Endif

Return(obj)

