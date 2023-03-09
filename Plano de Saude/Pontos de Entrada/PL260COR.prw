#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |PL260COR  ºAutor  ³Leonardo Portella   º Data ³  21/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Atualizacao das cores do cadastro de Familia/Usuario.       º±±
±±º          ³Os PE PLSMCORF3 e PLSBUTDV utilizam o retorno deste PE, de  º±±
±±º          ³modo a manter os filtros para as legendas consistentes entreº±±
±±º          ³o cadastro Familia/Usuario e as rotinas de busca padrao do  º±±
±±º          ³PLS.                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß  
± em 27/3/17 incluir legenda para inclusao futura - cinza                   ± 
± em 04/5/17 incluir legenda para exclusao futura - amarela                 ±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
User Function PL260COR

	Local aArea		:= GetArea()
	Local cCodPla	:= ""
	Local cQry		:= ""

	/*
	cQry := CRLF + " SELECT LISTAGG(BI3_CODIGO, '|') WITHIN GROUP (ORDER BY BI3_CODIGO) AS LISTA"
    cQry += CRLF + " FROM " + RetSqlName("BI3") + " BI3"
	cQry += CRLF + " WHERE BI3_FILIAL = '  '"
    cQry += CRLF +	 " AND BI3_GRUPO  = '001'"
    cQry += CRLF +	 " AND BI3_CODSEG = '004'"
    cQry += CRLF +	 " AND D_E_L_E_T_ = ' '"
	*/
	
	// Retirada query anterior pq na release 33 o retorno do listagg estava vindo vazio (mesmo tendo itens nesta condição no banco)
	cQry := " SELECT BI3_CODIGO AS LISTA"
	cQry += " FROM " + RetSqlName("BI3")
	cQry += " WHERE BI3_FILIAL = '" + xFilial("BI3") + "' AND BI3_GRUPO = '001' AND BI3_CODSEG = '004' AND D_E_L_E_T_ = ' '"

    TCQuery cQry New Alias "QRYSBM" 

    QRYSBM->(DbGoTop())
	while !QRYSBM->(EOF())
		cCodPla += QRYSBM->LISTA + "|"
		QRYSBM->(DbSkip())
	end
    QRYSBM->(DbCloseArea())

	aCores		:= {{ "(BA1->BA1_MOTBLO <> Space(03) .AND. BA1->BA1_DATBLO <= dDataBase)"		, 'BR_VERMELHO'	},;
					{ "(BA1->BA1_MOTBLO <> Space(03) .AND. BA1->BA1_DATBLO > dDataBase)"		, 'BR_AMARELO'	},;
					{ "(Empty(BA1->BA1_DATBLO) .AND. BA1->BA1_DATINC > dDataBase)"				, 'BR_CINZA'	},;
					{ "(BA1->BA1_XTPBEN == 'RECIPR')"											, 'BR_LARANJA'	},;
					{ "( (BA1->BA1_CODPLA $ '"+cCodPla+"') .OR. (BA1->BA1_XTPBEN == 'ODONTO') )", 'BR_BRANCO'	},;
					{ "(BA1->BA1_MOTBLO == Space(03))"											, 'BR_VERDE'	}}
	
	aCdCores	:= {{ 'BR_VERDE'	, 'Usuario ativo'						},;
					{ 'BR_CINZA'	, 'Usuario ativo, inclusao futura'		},;
					{ 'BR_AMARELO'	, 'Usuario Bloqueado, bloqueio futuro'	},;
					{ 'BR_VERMELHO'	, 'Usuario Bloqueado'					},;
					{ 'BR_LARANJA'	, 'Matricula Reciprocidade'				},;
					{ 'BR_BRANCO'	, 'Matricula Odontologica'				}}
	
	RestArea(aArea)

return {aCores, aCdCores}
