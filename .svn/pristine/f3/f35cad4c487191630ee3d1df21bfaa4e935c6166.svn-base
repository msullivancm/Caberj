#include "Protheus.ch"
#IFDEF lLinux
	#define CRLF Chr(13) + Chr(10)
#ELSE
	#define CRLF Chr(10)
#ENDIF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³M260SQRE ³ Autor ³ Marcela Coimbra       ³ Data ³ 09.01.13  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Ponto de entrada para tratar :                              ³±± 
±±³Descricao ³ a - Filtrar títulos baixados por fatura para os casos de    ³±±
±±³Descricao ³ parcelamento.                                        	   ³±±    
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Advanced Protheus                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


User Function PLM260CMP()

Local c_Qry    := "" // Query passada pela rotina padrao
Local c_Prefix := "" // Prefixo do titulo que esta sendo analisado - E5_PREFIXO
Local c_Numero := "" // Numero do titulo que esta sendo tratado - E5_NUMERO
Local c_Parcel := " " // Parcela do titulo que esta sendo tratado - E5_PARCELA
Local c_Tipo   := "" // Tipo do titulo que esta sendo tratado - E5_TIPO
Local lDesTit  := .F.// Indica se o titulo que esta sendo tratado devera ser descartado. Inicialmente nao (.F.) sera descartado

If paramixb[2] == "GEP" //Chamada do ponto de entrada no processamento da folha. Tenho apenas dois parametros {Sql,"GPE"}.

	c_Qry := paramixb[1] //Inicialmente nao tenho regra especifica para custo medico com desconto em folha. Retorno a query padrao.

ElseIf paramixb[2] == "FIN" //Chamada do ponto de entrada no processamento do financeiro. Tenho seis parametros {Sql,"FIN",Prefixo,Numero,Parcela,Tipo}.

	If !Empty(paramixb[1])
		c_Qry := paramixb[1]
	Else
		MsgInfo("PLM260CMP - " + paramixb[2] + ": Query não foi passada para o ponto de entrada pela rotina padrão!")
		Return paramixb[1]
	EndIf

	If !Empty(paramixb[3])
		c_Prefix := paramixb[3]
	Else
		MsgInfo("PLM260CMP - " + paramixb[2] + ": Título sem prefixo!" + CRLF + "Número / tipo" + paramixb[4] + " / " + paramixb[6])
		Return c_Qry
	EndIf

	If !Empty(paramixb[4])
		c_Numero := paramixb[4]
	Else
		MsgInfo("PLM260CMP - " + paramixb[2] + ": Título sem número!" + CRLF + "Prefixo / tipo" + paramixb[3] + " / " + paramixb[6])
		Return c_Qry
	EndIf

	If !Empty(paramixb[5])
		c_Parcel := paramixb[5]
	EndIf

	If !Empty(paramixb[6])
		c_Tipo := paramixb[6]
	Else
		MsgInfo("PLM260CMP - " + paramixb[2] + ": Título sem tipo!" + CRLF + "Prefixo / número" + paramixb[3] + " / " + paramixb[4])
		Return c_Qry
	EndIf

	//Feita todas as validacoes dos parametros, a partir daqui sera tratado a regra especifica
	
	dbSelectArea("SZH")
	dbSetOrder(4)
	If dbSeek( xFilial("SZH") + c_Prefix + c_Numero + c_Parcel + c_Tipo )
              
		lDesTit := .T.              
              
	EndIf   	
	
	If lDesTit //Vou descartar o titulo que esta sendo tratado

		c_Qry += " AND 0 = 1 "     

	EndIf

Else //Retorna a query do padrao

	c_Qry := paramixb[1]
	
EndIf

Return c_Qry
