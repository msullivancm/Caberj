#Include "PROTHEUS.CH"
#Include "RWMAKE.CH"

/*/
----------------------------------------------------------------------------
Programa  MT103SE2()º Autor ³ MMT      º Data ³  07/07/2022   
----------------------------------------------------------------------------
Descricao  inclui campo na folder de duplicatas MATA103
----------------------------------------------------------------------------
//
//
//
/*/

User Function MT103SE2()

	Local nI := 1
	Local aCampos := { "E2_CODBAR" , "E2_LINDIG" }
	Local aVet := {}

	FOR nI := 1 TO Len(aCampos)

//	If SX3->(MsSeek("E2_CODBAR"))

	If SX3->(MsSeek(aCampos[nI]))

		AADD(aVet  ,{TRIM(x3titulo()),;
			SX3->X3_CAMPO,;
			SX3->X3_PICTURE,;
			SX3->X3_TAMANHO,;
			SX3->X3_DECIMAL,;
			"",;
			SX3->X3_USADO,;
			SX3->X3_TIPO,;
			SX3->X3_F3,;
			SX3->X3_CONTEXT,;
			SX3->X3_CBOX,;
			SX3->X3_RELACAO,;
			".T."})
	EndIf

	Next nI

Return(aVet)

