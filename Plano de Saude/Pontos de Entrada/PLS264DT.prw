#Define CRLF Chr(13)+Chr(10)
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS264DT  ºAutor  ³ Gedilson Rangel    º Data ³  28/08/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Alterar a data de validade do cartao de identificacao caso º±±
±±º          ³ a familia/usuario tenha data limite preechida.             º±±
±±º          ³ Se a data limite for maior que a data de validade calculadaº±±
±±º          ³ esta prevalecerá.                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlterado  ³Luzio Tavares - 20/10/2008                                  º±±
±±º          ³Inserido controle de data validade do cartao, obedencendo a º±±
±±º          ³quantidade de tempo pre-fixado no cadastro de contratos     º±±
±±º          ³mantendo as regras padrao do sistema.                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                            

User Function PLS264DT

Local nPeRePF 	:= GetNewPar("MV_PLSPRPF",12)
Local nDiaVen  	:= 0
Local dValidade	:= PARAMIXB[1]
Local aArea		:= GetArea()
Local aAreaBA1	:= BA1->(GetArea())
Local aAreaBA3	:= BA3->(GetArea())
   
U_ValPLS264(dValidade)//Leonardo Portella - 12/09/12

BA1->(RestArea(aAreaBA1))
BA3->(RestArea(aAreaBA3))
RestArea(aArea)

Return(dValidade)
               
********************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 17/09/12                                  ³
//³Transformei o codigo dentro do PE PLS264DT em funcao para     ³
//³que esta funcao possa ser utilizada em outros programas com a ³
//³mesma logica e reduzindo a manutencao.                        ³
//³Considera ponteirado na BA1 e BA3.                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function ValPLS264(dValidade)

/*
//*****************************************************************************************************************
//Trecho de codigo incluido por Luzio em 20/10/2008 para que a validade de todos cartoes obedeça promeiramente a
//quantidade de meses informado no cadastro do sub-contrato.
If BA3->BA3_TIPOUS == "1"
	nPerRen := nPeRePF  //Para contratos pessoa fisica, obedece a quantidade de meses de validade do parametro especifico.
Else
	If BQC->BQC_NPERRN > 0
		nPerRen := BQC->BQC_NPERRN //Para contratos juridicos, obedece a quantidade de meses de validade do referido campo.
	Else
		nPerRen := nPeRePF
	EndIf
Endif

nDiaVen := substr(DtoS(BQC->BQC_NPERRN-1),7,2)

If Empty(dValidade)
	If Empty(BA1->BA1_EMICAR) .and. BA1->BA1_VIACAR = 0
		dValidade := BA1->BA1_DATINC
	Else
		dValidade := BA1->BA1_DTVLCR
	EndIf
	While nPerRen > 12
		dValidade := stod(strzero((val(substr(dtos(dValidade),1,4))+1),4)+substr(dtos(dValidade),5,4))
		nPerRen := nPerRen-12
	EndDo
	dValidade := stod(substr(dtos(stod(substr(dtos(dValidade),1,6)+"15")+(nPerRen*30)),1,6)+substr(dtos(dValidade),7,2))
Else
	If BA1->BA1_VIACAR <> 0 .and. !Empty(BA1->BA1_DTVLCR)
		If dValidade > stod(substr(dtos(stod(substr(dtos(BA1->BA1_DTVLCR),1,6)+"15")+(nPerRen*30)),1,6)+substr(dtos(BA1->BA1_DTVLCR),7,2))
			If substr(dtos(BA1->BA1_DTVLCR),1,4) = substr(Dtos(dDataBase),1,4)
				dValidade := stod(substr(dtos(stod(substr(dtos(BA1->BA1_DTVLCR),1,6)+"15")+(nPerRen*30)),1,6)+substr(dtos(BA1->BA1_DTVLCR),7,2))
			Else  //Caso a via ja tenha sido renovada e esta sendo solicitado uma via avulsa
				dValidade := BA1->BA1_DTVLCR   //mantem a data de vencimento atual.
			EndIf
		EndIf
	EndIf
Endif
// Fim do trecho incluido por Luzio
//*****************************************************************************************************************
*/

//*****************************************************************************************************************
//Alexandre em 04/12/2009: A validade dos cartoes deve obedecer primeiramente a
//data de bloqueio, e onde a mesma não existir será mantida a regra da data limite.
  
Local cSQL		:= " "

If !EMPTY(BA1->BA1_DATBLO) .AND. dValidade > (BA1->BA1_DATBLO)
	dValidade:= BA1->BA1_DATBLO
ElseIf !EMPTY(BA3->BA3_DATBLO) .AND. dValidade > (BA3->BA3_DATBLO)
	dValidade:= BA3->BA3_DATBLO
Else
	If !EMPTY(BA1->BA1_YDTLIM) .AND. dValidade > (BA1->BA1_YDTLIM)
		dValidade:= BA1->BA1_YDTLIM
	ElseIf !EMPTY(BA3->BA3_LIMITE) .AND. dValidade > (BA3->BA3_LIMITE)
		dValidade:= BA3->BA3_LIMITE
	End
End
/* 
//BACALHAU - CARTEIRAS MATER RENOVACAO
cSQL	:= " SELECT VALIDADE  "+CRLF
cSQL	+= "   FROM (         "+CRLF
cSQL	+= "           select lpad(matricula_,17,'0') MATRICULA "+CRLF
cSQL	+= "                , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE "+CRLF
cSQL	+= "             from adimp_nego "+CRLF
cSQL	+= "            WHERE NOVA_DATA IS NOT NULL "+CRLF
cSQL	+= "           union "+CRLF
cSQL	+= "           select lpad(matricula,17,'0') MATRICULA "+CRLF
cSQL	+= "                , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE "+CRLF
cSQL	+= "             from adimp_parc "+CRLF
cSQL	+= "            WHERE NOVA_DATA IS NOT NULL "+CRLF
cSQL	+= "           union "+CRLF
cSQL	+= "           select lpad(matricula,17,'0') MATRICULA "+CRLF
cSQL	+= "                , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE "+CRLF
cSQL	+= "             from adimplentes "+CRLF
cSQL	+= "            WHERE NOVA_DATA IS NOT NULL "+CRLF
cSQL	+= "           union " +CRLF
cSQL	+= "           select lpad(matricula,17,'0') MATRICULA "+CRLF
cSQL	+= "                , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE " +CRLF
cSQL	+= "             from inadimp_3060 "+CRLF
cSQL	+= "            WHERE NOVA_DATA IS NOT NULL "+CRLF
cSQL	+= "           union "+CRLF
cSQL	+= "           select lpad(matricula,17,'0') MATRICULA "+CRLF
cSQL	+= "                , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE "+CRLF
cSQL	+= "             from inadimp_30 "+CRLF
cSQL	+= "            WHERE NOVA_DATA IS NOT NULL "+CRLF
cSQL	+= "        ) "+CRLF
cSQL	+= "    WHERE MATRICULA = '"+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"'" +CRLF  

cSQL	:= " SELECT VALIDADE  "+CRLF
cSQL	+= "   FROM (         "+CRLF
cSQL	+= "           select lpad(matricula,17,'0') MATRICULA "+CRLF
cSQL	+= "                , substr(NOVA_DATA,7,4)||substr(NOVA_DATA,4,2)||substr(NOVA_DATA,1,2) VALIDADE "+CRLF
cSQL	+= "             from mater_dep "+CRLF
cSQL	+= "            WHERE NOVA_DATA IS NOT NULL "+CRLF
cSQL	+= "        ) "+CRLF
cSQL	+= "    WHERE MATRICULA = '"+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+"'" +CRLF  


TcQuery cSQL New Alias c_Alias

If !Empty(c_Alias->VALIDADE)
	dValidade := STOD(c_Alias->VALIDADE)
Endif	

c_Alias->(DbCloseArea())
*/

Return dValidade  