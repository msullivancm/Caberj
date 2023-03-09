#INCLUDE "PLSTISS.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'FILEIO.CH'
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

#define	 cPicCNES	PesqPict("BB8","BB8_CNES")

/*
****************************************************************************************
****************************************************************************************
****************************************************************************************
****************************************************************************************
*******Funcao   * CABR234    * Leonardo Portella                 *Data *10/02/17 *******
****************************************************************************************
*******Descricao - Impressao de guias TISS                                       *******
****************************************************************************************
*******CONSULTA   - R234CON  - Baseado na função padrão PLSTISS1                 *******
*******SADT       - R234SADT - Baseado na função padrão PLSTISS2                 *******
*******INTERNACAO - R234INT  - Baseado na função padrão PLSTISSX                 *******
*******HONORARIOS - R234HON  - Baseado na função padrão PLSTISS5                 *******
****************************************************************************************
****************************************************************************************
*/

User Function CABR234

	Local aGuias	:= {}
	Local aDados
	Local aArea 	:= GetArea()
	Local aAreaBA0 	:= BA0->(GetArea())
	Local aAreaBCL 	:= BCL->(GetArea())
	Local aAreaBA1 	:= BA1->(GetArea())
	Local aAreaBTS 	:= BTS->(GetArea())
	Local aAreaBAU 	:= BAU->(GetArea())
	Local aAreaBID 	:= BID->(GetArea())
	Local aAreaBD6 	:= BD6->(GetArea())
	Local aAreaBR8 	:= BR8->(GetArea())
	Local aAreaBB0 	:= BB0->(GetArea())
	Local aAreaBD7 	:= BD7->(GetArea())
	Local aAreaBWT 	:= BWT->(GetArea())
	Local c_Alias

	BCL->(DbSetOrder(1))
	BCL->(DbSeek(xFilial('BCL') + BCI->(BCI_CODOPE + BCI_TIPGUI)))

	If BCL->(EOF()) .or. !( BCL->BCL_ALIAS $ 'BD5|BE4' )
		MsgStop('Alias Nºo implementado!',AllTrim(SM0->M0_NOMECOM))
		Return
	Else
		c_Alias := BCL->BCL_ALIAS
	EndIf

	BA0->(DbSetOrder(1))
	BA0->(DbSeek(xFilial('BA0') + &(c_Alias + "->" + c_Alias + "_CODOPE") ))

	BA1->(DbSetOrder(2))
	BA1->(DbSeek(xFilial('BA1') + &(c_Alias + "->(" + c_Alias + "_CODOPE + " + c_Alias + "_CODEMP + " + c_Alias + "_MATRIC + " + c_Alias + "_TIPREG + " + c_Alias + "_DIGITO )") ))

	BTS->(DbSetOrder(1))
	BTS->(DbSeek(xFilial('BTS') + BA1->BA1_MATVID ))

	BAU->(DbSetOrder(1))
	BAU->(DbSeek(xFilial('BAU') + &(c_Alias + "->" + c_Alias + "_CODRDA") ))

	BD6->(DbSetOrder(1))
	BD6->(DbSeek(xFilial('BD6') + &(c_Alias + "->(" + c_Alias + "_CODOPE + " + c_Alias + "_CODLDP + " + c_Alias + "_CODPEG + " + c_Alias + "_NUMERO )") ))

	Do Case

		Case BCI->BCI_TIPGUI == '01' //Consulta

		aDados 	:= Array(39)

		aDados[1]  := BA0->BA0_SUSEP //Registro ANS
		aDados[2]  := Left(BD5->BD5_NUMIMP,20) //Num guia
		aDados[3]  := BD5->BD5_DATPRO //Emissao guia (Solicitado Sï¿½rgio)
		aDados[4]  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //Carteira
		aDados[5]  := Left(Posicione('BI3',1,xFilial('BI3') + BA1->(BA1_CODINT + BA1_CODPLA),'BI3_NREDUZ'),40)//Plano
		aDados[6]  := BA1->BA1_DTVLCR //Validade carteira
		aDados[7]  := Left(BA1->BA1_NOMUSR,70) //Nome
		aDados[8]  := BTS->BTS_NRCRNA //CNS
		aDados[9]  := BAU->BAU_CPFCGC //CNPJ na Operadora
		aDados[10] := Left(BAU->BAU_NOME,70) //Nome contratado
		aDados[11] := BAU->BAU_CNES //CNES
		aDados[12] := BAU->BAU_TIPLOG //Tipo de logradouro
		aDados[13] := Left(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),40) //Logr. - Endereï¿½o - Compl
		aDados[14] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),41,5) //Logr. - Endereï¿½o - Compl
		aDados[15] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),46,15) //Logr. - Endereï¿½o - Compl
		aDados[16] := Left(Posicione('BID',1,xFilial('BID') + BAU->BAU_MUN,'BID_DESCRI'),40) //Municipio
		aDados[17] := BAU->BAU_EST //UF
		aDados[18] := BAU->BAU_MUN //Codigo IBGE
		aDados[19] := BAU->BAU_CEP //CEP
		aDados[20] := Posicione("BB0",4,xFilial("BB0") + BD5->(BD5_ESTEXE + BD5_REGEXE + BD5_SIGEXE),"BB0_NOME") //Nome executante
		aDados[21] := BD5->BD5_SIGEXE //Conselho executante
		aDados[22] := BD5->BD5_REGEXE
		aDados[23] := BD5->BD5_ESTEXE //UF Executante
		aDados[24] := BD5->BD5_CBOS //CBOS
		aDados[25] := BD5->BD5_TIPDOE //Tipo de doeNºa
		aDados[26] := { BD5->BD5_TPODOE,BD5->BD5_UTPDOE } //Tempo de doeNºa
		aDados[27] := If(BD5->BD5_INDACI $ '0|1|2', BD5->BD5_INDACI, '2') //Indicaï¿½ï¿½o acidente
		aDados[28] := BD5->BD5_CID //CID
		aDados[29] := BD5->BD5_CIDSEC //CID2
		aDados[30] := BD5->BD5_CID3 //CID3
		aDados[31] := BD5->BD5_CID4 //CID4
		aDados[32] := BD5->BD5_DATPRO //Data do atendimento
		aDados[33] := BD6->BD6_CODPAD //Código tabela
		aDados[34] := BD6->BD6_CODPRO //Código procedimento
		aDados[35] := BD5->BD5_TIPCON //Tipo de consulta
		aDados[36] := BD5->BD5_TIPSAI //Tipo de Saída
		aDados[37] := 'Guia: ' + BD5->(BD5_CODLDP + '.' + BD5_CODPEG + '.' + BD5_NUMERO) + ' - Impresso em: ' + DtoC(Date()) + ' [ ' + Time() + ' ]'//Observaï¿½ï¿½o
		aDados[38] := BD5->BD5_DATPRO //Data profissional
		aDados[39] := BD5->BD5_DATPRO //Data Beneficiário

		aAdd(aGuias, aDados)

		R234CON(aGuias, .T., 2)

		Case BCI->BCI_TIPGUI == '02' //SADT

		aDados 	:= Array(89)

		aDados[1]  := BA0->BA0_SUSEP //Registro ANS
		aDados[2]  := Left(BD5->BD5_NUMIMP,20) //Numero
		aDados[3]  := Left(BD5->BD5_NUMIMP,20) //"12345678901234567892" //Num guia principal
		aDados[4]  := BD5->BD5_DATPRO //CtoD("01/01/07"),;//Data da autorizacao
		aDados[5]  := If(!empty(BD5->BD5_VALSEN),BD5->BD5_SENHA,'') //"12345678901234567892",;//Senha
		aDados[6]  := BD5->BD5_VALSEN //CtoD("01/01/07"),;//Data validade da senha
		aDados[7]  := BD5->BD5_DATPRO //Data emissao guia (Solicitado Sï¿½rgio)
		aDados[8]  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //"12345678901234567892",;//Numero da carteira
		aDados[9]  := Left(Posicione('BI3',1,xFilial('BI3') + BA1->(BA1_CODINT + BA1_CODPLA),'BI3_NREDUZ'),20) //Replicate("M",20),;//Plano
		aDados[10] := BA1->BA1_DTVLCR //Validade da carteira
		aDados[11] := Left(BA1->BA1_NOMUSR,70) //Replicate("M",70),;//Nome
		aDados[12] := BTS->BTS_NRCRNA //"123456789102345",;//Numero CNS
		aDados[13] := BAU->BAU_CPFCGC //"14.141.114/00001-35",;//CNPJ na Operadora
		aDados[14] := Left(BAU->BAU_NOME,70) //Replicate("M",70),;//Nome contratado
		aDados[15] := BAU->BAU_CNES //"1234567",;//CNES
		aDados[16] := Left(BD5->BD5_NOMSOL,70) //Replicate("M",70),;//Nome profissional solicitante
		aDados[17] := BD5->BD5_SIGLA //"1234567",;//Conselho solicitante
		aDados[18] := BD5->BD5_REGSOL //"123456789102345",;//Numero solicitante
		aDados[19] := BD5->BD5_ESTSOL //"ES",;//UF solicitante
		aDados[20] := BD5->BD5_CBOS //"12345",;//CBOS Solicitante
		aDados[21] := { BD5->BD5_DATPRO, BD5->BD5_HORPRO } //Data hora solicitacao
		aDados[22] := If(BD5->BD5_TIPATO == '4','U','E') //"E",;//Carater solicitacao
		aDados[23] := BD5->BD5_CID //"12345",;//CID 10
		aDados[24] := Left(BD5->BD5_INDCLI,70) //Replicate("M",70),;//Indicacao clinica

		cChvGuia   := BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)

		aDados[25] := {} //Tabela
		aDados[26] := {} //Procedimento
		aDados[27] := {} //Descricao
		aDados[28] := {} //Qtd solicitada
		aDados[29] := {} //Qtd autorizada

		//Realizados
		aDados[51] := {} //Data
		aDados[52] := {} // Hora inicial
		aDados[53] := {} //Hora final
		aDados[54] := {} //Tabela
		aDados[55] := {} //Codigo procedimento
		aDados[56] := {} //Descrição
		aDados[57] := {} //Quantidade
		aDados[58] := {} //Via
		aDados[59] := {} //Tecnica
		aDados[60] := {} //%Red acrescimo
		aDados[61] := {} //Valor unitï¿½rio
		aDados[62] := {} //Valor total

		aDados[63] := {} //Data procedimentos em sï¿½rie

		//OPME Solicitados
		aDados[72] := {} //Tabela
		aDados[73] := {} //Cod do OPM
		aDados[74] := {} //Descr. OPM
		aDados[75] := {} //Qtde
		aDados[76] := {} //Fabricante
		aDados[77] := {} //Valor unitï¿½rio

		//OPME utilizados
		aDados[78] := {} //Tabela
		aDados[79] := {} //Cod do OPM
		aDados[80] := {} //Descr. OPM
		aDados[81] := {} //Qtde
		aDados[82] := {} //Fabricante
		aDados[83] := {} //Valor unitï¿½rio
		aDados[84] := {} //Valor total

		nTotOPME 		:= 0
		nProcedimento 	:= 0 //1
		nMaterial 		:= 0 //2
		nMedicamento 	:= 0 //3
		nTaxas 			:= 0 //4
		nDiarias 		:= 0 //6
		nPacote 		:= 0 //7
		nGasesMed 		:= 0 //8
		nAlugueis 		:= 0 //9

		While !BD6->(EOF()) .and. ( cChvGuia == BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) )

			cTpProc := Posicione('BR8',1,xFilial('BR8') + BD6->(BD6_CODPAD + BD6_CODPRO),'BR8_TPPROC')

			If ( BD6->BD6_CODLDP == '0013' ) .or. ( cTpProc == '5' ) //5 - Ortese/Protese

				//OPME Solicitados
				aAdd(aDados[72], BD6->BD6_CODPAD) //Tabela
				aAdd(aDados[73], BD6->BD6_CODPRO) //Cod do OPM
				aAdd(aDados[74], BD6->BD6_DESPRO) //Descr. OPM
				//aAdd(aDados[75], BD6->BD6_QTDAPR) //Qtde
				aAdd(aDados[75], BD6->BD6_QTDPRO) //Qtde
				aAdd(aDados[76], "") //Fabricante
				aAdd(aDados[77], Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) //Valor unitï¿½rio

				//OPME utilizados
				aAdd(aDados[78], BD6->BD6_CODPAD) //Tabela
				aAdd(aDados[79], BD6->BD6_CODPRO) //Cod do OPM
				aAdd(aDados[80], BD6->BD6_DESPRO) //Descr. OPM
				//aAdd(aDados[81], BD6->BD6_QTDAPR) //Qtde
				aAdd(aDados[81], BD6->BD6_QTDPRO) //Qtde
				aAdd(aDados[82], "") //Fabricante
				aAdd(aDados[83], Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) //Valor unitï¿½rio
				aAdd(aDados[84], BD6->BD6_VLRAPR) //Valor total

				nTotOPME += BD6->BD6_VLRAPR

			Else

				aAdd(aDados[25], BD6->BD6_CODPAD)
				aAdd(aDados[26], BD6->BD6_CODPRO)
				aAdd(aDados[27], BD6->BD6_DESPRO)
				//aAdd(aDados[28], BD6->BD6_QTDAPR)  //DESCONTINUADO P12
				aAdd(aDados[28], BD6->BD6_QTDPRO)    //ACRESCENTADO REPETIDO PARA NAO ARRISCAR DAR ERRO DE ARRAY
				aAdd(aDados[29], BD6->BD6_QTDPRO)

				aAdd(aDados[51], BD6->BD6_DATPRO) //Data
				aAdd(aDados[52], BD6->BD6_HORPRO) //Hora inicial
				aAdd(aDados[53], BD6->BD6_HORPRO) //Hora final
				aAdd(aDados[54], BD6->BD6_CODPAD) //Tabela
				aAdd(aDados[55], BD6->BD6_CODPRO) //Codigo procedimento
				aAdd(aDados[56], Left(BD6->BD6_DESPRO, 60)) //Descrição
				aAdd(aDados[57], BD6->BD6_QTDPRO) //Quantidade
				aAdd(aDados[58], BD6->BD6_VIA) //Via
				aAdd(aDados[59], "") //Tecnica
				aAdd(aDados[60], BD6->BD6_PERVIA) //%Red acrescimo
				aAdd(aDados[61], Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) //Valor unitï¿½rio
				aAdd(aDados[62], BD6->BD6_VLRAPR) //Valor total

				aAdd(aDados[63], CtoD("//")) //Data procedimentos em sï¿½rie

				Do Case

					Case cTpProc $ '1|7'
					nProcedimento 	+= BD6->BD6_VLRAPR

					Case cTpProc == '2'
					nMaterial 		+= BD6->BD6_VLRAPR

					Case cTpProc == '3'
					nMedicamento 	+= BD6->BD6_VLRAPR

					Case cTpProc == '4'
					nTaxas 			+= BD6->BD6_VLRAPR

					Case cTpProc == '6'
					nDiarias 		+= BD6->BD6_VLRAPR

					Case cTpProc == '8'
					nGasesMed 		+= BD6->BD6_VLRAPR

					Case cTpProc == '9'
					nAlugueis 		+= BD6->BD6_VLRAPR

					Otherwise
					nProcedimento 	+= BD6->BD6_VLRAPR

				EndCase

			EndIf

			BD6->(DbSkip())

		EndDo

		//Totais da guia
		aDados[65] := {nProcedimento}
		aDados[66] := {nTaxas + nAlugueis}
		aDados[67] := {nMaterial}
		aDados[68] := {nMedicamento}
		aDados[69] := {nDiarias}
		aDados[70] := {nGasesMed}
		aDados[71] := {nProcedimento + nTaxas + nAlugueis + nMaterial + nMedicamento + nDiarias + nGasesMed}

		aDados[85] := {nTotOPME} //Total OPME

		aDados[30] := BAU->BAU_CPFCGC //"14.141.114/00001-35",;//CNPJ na operadora
		aDados[31] := Left(BAU->BAU_NOME,70) //Nome contratado
		aDados[32] := BAU->BAU_TIPLOG //Tipo de logradouro
		aDados[33] := Left(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),40) //Logr. - Endereï¿½o - Compl
		aDados[34] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),41,5) //Logr. - Endereï¿½o - Compl
		aDados[35] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),46,15) //Logr. - Endereï¿½o - Compl
		aDados[36] := Left(Posicione('BID',1,xFilial('BID') + BAU->BAU_MUN,'BID_DESCRI'),40) //Municipio
		aDados[37] := BAU->BAU_EST //UF
		aDados[38] := BAU->BAU_MUN //Codigo IBGE
		aDados[39] := BAU->BAU_CEP //CEP
		aDados[40] := { "", "" } //Exec complementar
		aDados[41] := "" //Replicate("M",70),; //Nome Exec complementar
		aDados[42] := "" //"1234567",; //Conselho Exec complementar
		aDados[43] := "" //"123456789102345",;//Numero Exec complementar
		aDados[44] := "" //"MM",;//UF Exec complementar
		aDados[45] := { "", "" }//CBOS e grau part Exec complementar
		aDados[46] := BD5->BD5_TIPATE //"01",;//Tipo atendimento
		aDados[47] := BD5->BD5_INDACI //"1",;//Tipo de acidente
		aDados[48] := BD5->BD5_TIPSAI //Tipo de Saída
		aDados[49] := BD5->BD5_TIPDOE //Tipo de doeNºa
		aDados[50] := { BD5->BD5_TPODOE,BD5->BD5_UTPDOE } //Tempo de doeNºa

		aDados[64] := 'Guia: ' + BD5->(BD5_CODLDP + '.' + BD5_CODPEG + '.' + BD5_NUMERO) + ' - Impresso em: ' + DtoC(Date()) + ' [ ' + Time() + ' ]'//Observaï¿½ï¿½o

		aDados[86] := BD5->BD5_DATPRO //Data assinatura solicitante
		aDados[87] := BD5->BD5_DATPRO //Data assinatura resp aut
		aDados[88] := BD5->BD5_DATPRO //Data assinatura benef
		aDados[89] := BD5->BD5_DATPRO //Data assinatura prestador exec

		aAdd(aGuias, aDados)

		R234SADT(aGuias, .T., 2)

		Case BCI->BCI_TIPGUI == '05' //GRI

		aDados 	:= Array(83)

		aDados[1]  := BA0->BA0_SUSEP //Registro ANS//"123456"
		aDados[2]  := Left(BE4->BE4_NUMIMP,20) //Numero//"12345678901234567892"
		aDados[3]  := Left(BE4->BE4_NUMIMP,20) //"12345678901234567892" //Num guia solicitacao//"12345678901234567892"
		aDados[4]  := BE4->BE4_DATPRO //CtoD("01/01/07"),;//Data da autorizacao
		aDados[5]  := BE4->BE4_SENHA //"12345678901234567892",;//Senha
		aDados[6]  := BE4->BE4_DATVAL //CtoD("01/01/07"),;//Data validade da senha
		aDados[7]  := BE4->BE4_DATPRO //Data emissao guia (Solicitado Sï¿½rgio)
		aDados[8]  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //"12345678901234567892",;//Numero da carteira
		aDados[9]  := Left(Posicione('BI3',1,xFilial('BI3') + BA1->(BA1_CODINT + BA1_CODPLA),'BI3_NREDUZ'),40) //Replicate("M",40),;//Plano
		aDados[10] := BA1->BA1_DTVLCR //Validade da carteira
		aDados[11] := Left(BA1->BA1_NOMUSR,70) //Replicate("M",70),;//Nome
		aDados[12] := BTS->BTS_NRCRNA //"123456789102345",;//Numero CNS
		aDados[13] := BAU->BAU_CPFCGC //"14.141.114/00001-35",;//CNPJ na Operadora
		aDados[14] := Left(BAU->BAU_NOME,70) //Replicate("M",70),;//Nome contratado
		aDados[15] := BAU->BAU_CNES //"1234567",;//CNES
		aDados[16] := BAU->BAU_TIPLOG //Tipo de logradouro
		aDados[17] := Left(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),40) //Logr. - Endereï¿½o - Compl
		aDados[18] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),41,5) //Logr. - Endereï¿½o - Compl
		aDados[19] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),46,15) //Logr. - Endereï¿½o - Compl
		aDados[20] := Left(Posicione('BID',1,xFilial('BID') + BAU->BAU_MUN,'BID_DESCRI'),40) //Municipio
		aDados[21] := BAU->BAU_EST //UF
		aDados[22] := BAU->BAU_MUN //Codigo IBGE
		aDados[23] := BAU->BAU_CEP //CEP
		aDados[24] := If(BE4->BE4_TIPCON $ '2|6','U','E')//"E"--1=Normal;2=Emergencia;3=Reconsulta;4=Pre-Natal;5=Referencia;6=Urgencia
		aDados[25] := { 'Acomodação ',If(BE4->BE4_PADINT == '1',' Individual',' Coletivo')} //Tipo acomodacao
		aDados[26] := {BE4->BE4_DATPRO,BE4->BE4_HORPRO } //Data hora internacao
		aDados[27] := {BE4->BE4_DTALTA,BE4->BE4_HRALTA } //Data hora saida internacao
		aDados[28] := BE4->BE4_GRPINT//Tipo internacao--1=Internacao Clinica;2=Internacao Cirurgica;3=Internacao Obstetrica;4=Internacao Pediatrica;5=Internacao Psiquiatrica
		aDados[29] := BE4->BE4_REGINT//Regime internacao--1=Hospitalar;2=Hospital-Dia;3=Domiciliar

		aDados[30] := {;
		If(BE4->BE4_EMGEST == '1','X',''),;//Em gestacao
		If(BE4->BE4_ABORTO == '1',"X",''),;//Aborto
		If(BE4->BE4_TRAGRA == '1',"X",''),;//Transtorno materno na gravidez
		If(BE4->BE4_COMURP == '1',"X",''),;//Complicacao no puerperio
		If(BE4->BE4_ATESPA == '1',"X",''),;//Atendimento recem nascido na sala do parto
		If(BE4->BE4_COMNAL == '1',"X",''),;//Complicacao pre-natal
		If(BE4->BE4_BAIPES == '1',"X",''),;//Baixo peso < 2.5 kg
		If(BE4->BE4_PARCES == '1',"X",''),;//Parto cesareo
		If(BE4->BE4_PATNOR == '1',"X",'') ;//Parto normal
		}

		aDados[31] := BE4->BE4_OBTMUL//Obito mulher - 1=Gravida;2=ate 42 dias apos termino gestacao;3=de 43 dias a 12 meses apos gestacao

		aDados[32] := {;
		BE4->BE4_OBTPRE,;//Obito neonatal precoce
		BE4->BE4_OBTTAR ;//Obito neonatal tardio
		}

		aDados[33] := BE4->BE4_NRDCNV//Declaraï¿½ï¿½o nascido vivo
		aDados[34] := BE4->BE4_NASVIV//Qtd nascido vivo
		aDados[35] := BE4->BE4_NASMOR//Qtd nascido morto
		aDados[36] := BE4->BE4_NASVPR//Qtd nascido prematuro
		aDados[37] := BE4->BE4_CID//CID
		aDados[38] := BE4->BE4_CIDSEC//CID2
		aDados[39] := BE4->BE4_CID3//CID3
		aDados[40] := BE4->BE4_CID4//CID4
		aDados[41] := If(BE4->BE4_INDACI == '9','2',BE4->BE4_INDACI)//Indicaï¿½ï¿½o acidente - 0=Relacionado ao trabalho;1=Acidente de Transito;2=Outros Acidente;9=Nao Acidente
		aDados[42] := Posicione('BIY',1,xFilial('BIY') + BE4->(BE4_CODOPE + BE4_TIPALT),'BIY_DESCRI')//Tipo saida
		aDados[43] := BE4->BE4_CIDOBT//CID Obito
		aDados[44] := BE4->BE4_NRDCOB//Numero declaracao obito

		cChvGuia   := BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)

		aDados[45] := {}
		aDados[46] := {}
		aDados[47] := {}
		aDados[48] := {}
		aDados[49] := {}
		aDados[50] := {}
		aDados[51] := {}
		aDados[52] := {}
		aDados[53] := {}
		aDados[54] := {}
		aDados[55] := {}
		aDados[56] := {}

		//OPME
		aDados[65] := {}
		aDados[66] := {}
		aDados[67] := {}
		aDados[68] := {}
		aDados[69] := {}
		aDados[70] := {}
		aDados[71] := {}
		aDados[72] := 0

		nTotOPME 		:= 0
		nProcedimento 	:= 0 //1
		nMaterial 		:= 0 //2
		nMedicamento 	:= 0 //3
		nTaxas 			:= 0 //4
		nDiarias 		:= 0 //6
		nPacote 		:= 0 //7
		nGasesMed 		:= 0 //8
		nAlugueis 		:= 0 //9

		While !BD6->(EOF()) .and. ( cChvGuia == BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) )

			cTpProc := Posicione('BR8',1,xFilial('BR8') + BD6->(BD6_CODPAD + BD6_CODPRO),'BR8_TPPROC')

			If ( BD6->BD6_CODLDP == '0013' ) .or. ( cTpProc == '5' ) //5 - Ortese/Protese

				//OPME utilizados
				aAdd(aDados[65], BD6->BD6_CODPAD) //Tabela
				aAdd(aDados[66], BD6->BD6_CODPRO) //Cod do OPM
				aAdd(aDados[67], BD6->BD6_DESPRO) //Descr. OPM
				//aAdd(aDados[68], BD6->BD6_QTDAPR) //Qtde
				aAdd(aDados[68], BD6->BD6_QTDPRO) //Qtde
				aAdd(aDados[69], "") //Codigo barras
				aAdd(aDados[70], Round(BD6->BD6_VLRAPR ,2)) //Valor unitï¿½rio
				aAdd(aDados[71], Round(BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,2) ) //Valor total

				nTotOPME += BD6->BD6_VLRAPR

			Else

				aAdd(aDados[45], BD6->BD6_DATPRO) //Data
				aAdd(aDados[46], BD6->BD6_HORPRO) //Hora inicial
				aAdd(aDados[47], BD6->BD6_HORPRO) //Hora final
				aAdd(aDados[48], BD6->BD6_CODPAD) //Tabela
				aAdd(aDados[49], BD6->BD6_CODPRO) //Codigo procedimento
				aAdd(aDados[50], Left(BD6->BD6_DESPRO, 60)) //Descrição
				aAdd(aDados[51], BD6->BD6_QTDPRO) //Quantidade
				aAdd(aDados[52], BD6->BD6_VIA) //Via
				aAdd(aDados[53], "") //Tecnica
				aAdd(aDados[54], BD6->BD6_PERVIA) //%Red acrescimo
				aAdd(aDados[55], Round(BD6->BD6_VLRAPR ,2)) //Valor unitï¿½rio
				aAdd(aDados[56], Round(BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,2) /* BD6->BD6_VLRAPR*/) //Valor total

				Do Case

					Case cTpProc $ '1|7'
					nProcedimento 	+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Case cTpProc == '2'
					nMaterial 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Case cTpProc == '3'
					nMedicamento 	+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Case cTpProc == '4'
					nTaxas 			+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Case cTpProc == '6'
					nDiarias 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Case cTpProc == '8'
					nGasesMed 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Case cTpProc == '9'
					nAlugueis 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

					Otherwise
					nProcedimento 	+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

				EndCase

			EndIf

			BD6->(DbSkip())

		EndDo

		//Equipe
		aDados[57] := { Posicione('BD7',1,xFilial('BD7') + BE4->(BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_ORIMOV),'BD7_SEQUEN') }//Seq ref
		aDados[58] := { If(empty(BE4->BE4_CDPFRE),' ',Posicione('BWT',1,xFilial('BWT') + BD7->(BD7_CODOPE + BD7_CODTPA),'BWT_CODEDI')) }//Grau participacao
		aDados[59] := { BE4->BE4_CDPFRE }//Codigo na operadora/CPF
		aDados[60] := { BE4->BE4_NOMEXE }//Nome profissional
		aDados[61] := { Posicione('BB0',1,xFilial('BB0') + BE4->BE4_CDPFRE,'BB0_CODSIG') }//Conselho profissional
		aDados[62] := { BE4->BE4_REGEXE }//Numero conselho
		aDados[63] := { BE4->BE4_ESTEXE }//UF
		aDados[64] := { Posicione('BB0',1,xFilial('BB0') + BE4->BE4_CDPFRE,'BB0_CGC') }//CPF

		aDados[72] := nTotOPME

		aDados[73] := { ;
		If(BE4->BE4_TIPFAT = 'T',"X",' '),; //Total
		If(BE4->BE4_TIPFAT = 'P',"X",' ') ; //Parcial
		}//Tipo faturamento

		aDados[74] := nProcedimento//Total procedimentos
		aDados[75] := nDiarias//Total diarias
		aDados[76] := nTaxas + nAlugueis//Total taxas + alugueis
		aDados[77] := nMaterial//Total materiais
		aDados[78] := nMedicamento//Total medicamentos
		aDados[79] := nGasesMed//Total gases medicinais
		aDados[80] := nProcedimento + nDiarias + nTaxas + nAlugueis + nMaterial + nMedicamento + nGasesMed//Total geral

		aDados[81] := 'Guia: ' + BE4->(BE4_CODLDP + '.' + BE4_CODPEG + '.' + BE4_NUMERO) + ' - Impresso em: ' + DtoC(Date()) + ' [ ' + Time() + ' ]'//Observaï¿½ï¿½o

		aDados[82] := BE4->BE4_DATPRO//Data assinatura contratado
		aDados[83] := BE4->BE4_DATPRO//Data assinatura auditores operadora

		aAdd(aGuias, aDados)

		R234RINT(aGuias, .T., 2)

		Case BCI->BCI_TIPGUI == '06' //Honorarios individual

		aDados := {}

		// Cabecalho
		aAdd(aDados, BA0->BA0_SUSEP) //1 Registro ANS
		aAdd(aDados, Left(BD5->BD5_NUMIMP,20) ) //2 - Numero
		aAdd(aDados, BD5->BD5_GUIINT ) //3 Nr Guia Solicitacao
		aAdd(aDados, If(!empty(BD5->BD5_VALSEN),BD5->BD5_SENHA,'') )  //4 Senha
		aAdd(aDados, BD5->BD5_CODOPE+BD5->BD5_CODLDP+BD5->BD5_CODPEG+BD5->BD5_NUMERO  )  //5

		// Dados do Beneficiario
		aAdd(aDados, BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) )//"12345678901234567892",;//Numero da carteira) //6
		aAdd(aDados, Left(BA1->BA1_NOMUSR,70)	)//7  Nome Beneficiário
		aAdd(aDados, 'N'						) //8 - Atendimento a RN

		//**********************************************
		//    Posiciona Rede de Atendimento            *
		//**********************************************
		BAU->(dbSetOrder(1))
		BAU->(dbSeek(xFilial("BAU")+BD5->BD5_CODRDA))

		// Dados do Contratado (onde foi executado o procedimento)
		aAdd(aDados, BD5->BD5_CODRDA	   ) //9  - Código da Operadora
		aAdd(aDados, Left(BAU->BAU_NOME,70)) //10 - Nome do Hospital
		aAdd(aDados, Transform(BTS->BTS_NRCRNA, cPicCNES) 	   ) //11 - Código CNES

		// Dados do Contratado Executante
		aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 12 - Código na operadora CPF/CNPJ
		aAdd(aDados, Left(BAU->BAU_NOME,70)) //13 - Nome do Hospital
		aAdd(aDados, Transform(BTS->BTS_NRCRNA, cPicCNES)	   ) //14 - Código CNES

		// Dados da Internação
		aAdd(aDados, BD5->BD5_DATPRO		) //15 - Data Início do Faturamento
		aAdd(aDados, BD5->BD5_DATPRO	    ) //16 - Data do Fim do Faturamento

		// Procedimentos Realizados
		/*			aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99")))
		aAdd(aDados, B0D->B0D_NOMCON) //10
		aAdd(aDados, Transform(B0D->B0D_CNES, cPicCNES)) // 11 - CNES

		BWT->(DbSetORder(1))
		BWT->(MsSeek(xFilial("BWT")+PlsIntPAd()+B0D->B0D_GRAPAR))
		aAdd(aDados, BWT->BWT_CODEDI) //GRAU DE PARTICIPACAO DO PROFISSIONAL NA EQUIPE  17

		aAdd(aDados, B0D->B0D_NOMEXE)//18
		aAdd(aDados, B0D->B0D_SICONS)//22
		*/
		// Dados do Procedimento
		aCpo17 := {}
		aCpo18 := {}
		aCpo19 := {}
		aCpo20 := {}
		aCpo21 := {}
		aCpo22 := {}
		aCpo23 := {}
		aCpo24 := {}
		aCpo25 := {}
		aCpo26 := {}
		aCpo27 := {}
		aCpo28 := {}
		aCpo29 := {}
		aCpo30 := {}
		aCpo31 := {}
		aCpo32 := {}
		aCpo33 := {}
		aCpo34 := {}
		aCpo35 := {}
		aCpo36 := {}


		nVrTot := 0



		BD6->(dbSetOrder(8))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
		cChave   := BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)
		BD6->(dbSeek(cChave))

		While !BD6->(EOF()) .and. ( cChave == BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) )

			IF BD6->BD6_SITUAC == '1' .and. BD6->BD6_STATUS == '1'

				cTpProc := Posicione('BR8',1,xFilial('BR8') + BD6->(BD6_FILIAL+ BD6_CODPRO),'BR8_TPPROC')

				aAdd(aCpo17, BD6->BD6_DATPRO) 		// Data
				aAdd(aCpo18, BD6->BD6_HORPRO)		// Hora Inicial
				aAdd(aCpo19, BD6->BD6_HORPRO)		// Hora
				aAdd(aCpo20, BD6->BD6_CODPAD)		// Tabela
				aAdd(aCpo21, BD6->BD6_CODPRO)		// Código de Procedimento
				aAdd(aCpo22, BD6->BD6_DESPRO)		//Descrição
				aAdd(aCpo23, val(cvaltochar(BD6->BD6_QTDPRO ) ) )		//Quantidade
				aAdd(aCpo24, val(cvaltochar(BD6->BD6_VIA)))		// Via
				aAdd(aCpo25, ""				)		// Tecnica
				aAdd(aCpo26, BD6->BD6_PERVIA)		// Red Acrescimo
				aAdd(aCpo27, Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) // Valor Unitário
				aAdd(aCpo28, Round(BD6->BD6_VLRAPR, 2)) // Valor Total

				nVrTot += BD6->BD6_VLRAPR

			Endif

			BD6->(DbSkip())

		EndDo

		aAdd(aDados, aCpo17)
		aAdd(aDados, aCpo18)
		aAdd(aDados, aCpo19)
		aAdd(aDados, aCpo20)
		aAdd(aDados, aCpo21)
		aAdd(aDados, aCpo22)
		aAdd(aDados, aCpo23)
		aAdd(aDados, aCpo24)
		aAdd(aDados, aCpo25)
		aAdd(aDados, aCpo26)
		aAdd(aDados, aCpo27)
		aAdd(aDados, aCpo28)

		// Identificação do(s) profissional (is) Executantes

		BD7->(dbSetOrder(6))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
		//cChave   := BD6->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO)
		BD7->(dbSeek(cChave))

		While !BD7->(EOF()) .and. ( cChave == BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) )

			IF BD7->BD7_SITUAC == '1'// .and. BD7->BD7_STATUS == '1'

				cTpProc := Posicione('BR8',1,xFilial('BR8') + BD7->(BD7_FILIAL+ BD7_CODPRO),'BR8_TPPROC')

				aAdd(aCpo29, BD7->BD7_SEQUEN ) // Seq Ref
				aAdd(aCpo30, If(empty(BE4->BE4_CDPFRE),' ',Posicione('BWT',1,xFilial('BWT') + BD7->(BD7_CODOPE + BD7_CODTPA),'BWT_CODEDI')))	//Grau participacao
				aAdd(aCpo31, BE4->BE4_CDPFRE )//Codigo na operadora/CPF
				aAdd(aCpo32, BE4->BE4_NOMEXE)		// Nome do profissional
				aAdd(aCpo33, GetAdvFVal('BB0','BB0_CODSIG',xFilial('BB0') + BE4->BE4_CDPFRE,1) )//Conselho profissional
				aAdd(aCpo34, BE4->BE4_REGEXE )		//Numero do Conselho
				aAdd(aCpo35, BE4->BE4_ESTEXE)		//UF
				aAdd(aCpo36, GetAdvFVal('BD5','BD5_CBOS',BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_FASE+BD7_SITUAC),2))		// CBOS



			Endif

			BD7->(DbSkip())

		EndDo




		aAdd(aDados, aCpo29)
		aAdd(aDados, aCpo30)
		aAdd(aDados, aCpo31)
		aAdd(aDados, aCpo32)
		aAdd(aDados, aCpo33)
		aAdd(aDados, aCpo34)
		aAdd(aDados, aCpo35)
		aAdd(aDados, aCpo36)
		// Identificação do(s) profissional (is) Executantes

		aAdd(aDados, B0D->B0D_OBSERV)
		aAdd(aDados, cvaltochar(nVrTot)) // Valor final do Honorario Medico considerando o somatorio do campo valor total
		aAdd(aDados, dDataBase)
		aAdd(aDados, ''			)


		aAdd(aGuias, aDados)

		R234HON(aGuias, .T., 2)

		Otherwise

		MsgStop('- CABR234:' + CRLF + ' Tipo de guia [ ' + BCI->BCI_TIPGUI + ' - ' + AllTrim(BCL->BCL_DESCRI) + ' ] Alias [ ' + BCL->BCL_ALIAS + ' ] Nºo implementado.', AllTrim(SM0->M0_NOMECOM))

	End Case

	BA0->(RestArea(aAreaBA0))
	BCL->(RestArea(aAreaBCL))
	BA1->(RestArea(aAreaBA1))
	BTS->(RestArea(aAreaBTS))
	BAU->(RestArea(aAreaBAU))
	BID->(RestArea(aAreaBID))
	BD6->(RestArea(aAreaBD6))
	BR8->(RestArea(aAreaBR8))
	BR8->(RestArea(aAreaBB0))
	BD7->(RestArea(aAreaBD7))
	BWT->(RestArea(aAreaBWT))
	RestArea(aArea)

	Return

	***************************************************************************************************

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½CONSULTA  - R234CON  - Baseado na função padrão PLSTISS1                ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Parametros aDados - Array com as informações do relatório              ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ lGerTXT - Define se imprime direto sem passar pela tela 	   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½			 de configuracao/preview do relatorio 		       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ nLayout - Define o formato de papï¿½l para impressao:         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½           1 - Formato Ofï¿½cio II (216x330mm)                 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½           2 - Formato A4 (210x297mm)                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½  		 3 - Formato Carta (216x279mm)     			       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function R234CON(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0      // Para implementar layout A4
	Local nLinA4    :=  0      // Para implementar layout A4
	Local cFileLogo
	Local nLin
	Local nI, nX
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local oPrint    := Nil
	LOCAL cFileName	:= ""
	LOCAL cRel      := "guicons"
	LOCAL cPathSrvJ := GETMV("MV_RELT")
	LOCAL nAL		:= 0.25
	LOCAL nAC		:= 0.24

	DEFAULT lGerTXT 	:= .F.
	DEFAULT nLayout 	:= 2
	DEFAULT cLogoGH 	:= ""
	DEFAULT lWeb		:= .F.
	DEFAULT cPathRelW 	:= ""
	DEFAULT aDados := { {;
	"123456",;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	Replicate("M",40),;
	CtoD("12/12/07"),;
	Replicate("M",70),;
	"123456789102345",;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"1234567",;
	"123",;
	Replicate("M",40),;
	"12345",;
	Replicate("M",15),;
	Replicate("M",40),;
	"ES",;
	"1234567",;
	"29800-000",;
	Replicate("M",70),;
	"MMMMMMM",;
	"123456789102345",;
	"ES",;
	"12345",;
	"M",;
	{ 12,"M" },;
	"0",;
	"12345",;
	"23456",;
	"34567",;
	"45678",;
	CtoD("12/12/06"),;
	"12",;
	"1234567890",;
	"1",;
	"1",;
	Replicate("M", 240),;
	CtoD("12/12/12"),;
	CtoD("12/12/12") } }

	oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½ Nao permite acionar a impressao quando for na web.
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
	If !lWeb
		oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	Else
		oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
		If lSrvUnix
			AjusPath(@oPrint)
		EndIf
	EndIf
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Tratamento para impressao via job
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	oPrint:lServer := lWeb

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½ Caminho do arquivo
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	oPrint:cPathPDF := cPathSrvJ

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Modo retrato
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	oPrint:SetPortrait()

	If nLayout ==2
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Papï¿½l A4
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:SetPaperSize(9)
	ElseIf nLayout ==3
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Papï¿½l Carta
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:SetPaperSize(1)
	Else
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:SetPaperSize(14)
	Endif

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Device
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If lWeb
		oPrint:setDevice(IMP_PDF)
		//oPrint:lPDFAsPNG := .T.
	EndIf
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Verifica se existe alguma impressora configurada para Impressao Grafica
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If  !lWeb
		oPrint:Setup()
		If !(oPrint:nModalResult == 1)
			Return
		Endif
	EndIf

	If oPrint:nPaperSize  == 9 // Papï¿½l A4
		nLinMax	:= 1754
		nColMax	:= 2335
		nLayout 	:= 2
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	Elseif oPrint:nPaperSize == 1 // Papel Carta
		nLinMax	:= 1545
		nColMax	:= 2400
		nLayout 	:= 3
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		nLinMax	:= 1764
		nColMax	:= 2400
		nLayout 	:= 1
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
		oFont04	:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	Endif

	For nX := 1 To Len(aDados)

		If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
			Loop
		EndIf

		If oPrint:Cprinter == "PDF" .OR. lWeb
			nLinIni	:= 150
		Else
			nLinIni := 000
		Endif
		nColIni := 000
		nLinA4  := 000
		nColA4  := 000

		oPrint:StartPage()		// Inicia uma nova pagina
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½Box Principal                                                 ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
		//ï¿½Carrega e Imprime Logotipo da Empresa                         ï¿½
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		fLogoEmp(@cFileLogo,, cLogoGH)

		If File(cFilelogo)
			oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) // Tem que estar abaixo do RootPath
		EndIf

		if nLayout == 2 // Papï¿½l A4
			nColA4:= -0065
			nLinA4:= 0
		Endif

		oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1000 + nColA4)*nAC, STR0001, oFont02n,,,, 2) //"GUIA DE CONSULTA"
		oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1700 + nColA4)*nAC, "2 - "+OemToAnsi(STR0002), oFont01) //"Nº"
		oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1801 + nColA4)*nAC, aDados[nX, 02], oFont03n)

		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0249)*nAL + nLinA4, (nColIni + 0415)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, "1 - "+STR0003, oFont01) //"Registro ANS"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
		oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0420)*nAC, (nLinIni + 0249)*nAL + nLinA4, (nColIni + 0830)*nAC)
		oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0430)*nAC, "3 - "+OemToAnsi(STR0004), oFont01) //"Data de Emissão da Guia"
		oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0440)*nAC, DtoC(aDados[nX, 03]), oFont04)

		oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010)*nAC, OemToAnsi(STR0005), oFont01) //"Dados do Beneficiário"
		oPrint:Box((nLinIni + 0280)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 0585)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020)*nAC, "4 - "+OemToAnsi(STR0006), oFont01) //"Número da Carteira"
		oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 04], oFont04)
		oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 0590)*nAC, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 2112 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0600)*nAC, "5 - "+STR0007, oFont01) //"Plano"
		oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 0610)*nAC, aDados[nX, 05], oFont04)
		oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 2117)*nAC + nColA4, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 2127 + nColA4)*nAC, "6 - "+STR0008, oFont01) //"Validade da Carteira"
		oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 2137 + nColA4)*nAC, DtoC(aDados[nX, 06]), oFont04)

		oPrint:Box((nLinIni + 0383)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0477)*nAL + (3*nLinA4), (nColIni + 1965 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0408 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "7 - "+STR0009, oFont01) //"Nome"
		oPrint:Say((nLinIni + 0448 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 07], oFont04)
		oPrint:Box((nLinIni + 0383)*nAL + (2*nLinA4), (nColIni + 1970 + nColA4)*nAC, (nLinIni + 0477)*nAL + (3*nLinA4), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0408 + (2*nLinA4))*nAL, (nColIni + 1980 + nColA4)*nAC, "8 - "+STR0010, oFont01) //"Número do Cartão Nacional de Saúde"
		oPrint:Say((nLinIni + 0448 + (2*nLinA4))*nAL, (nColIni + 1990 + nColA4)*nAC, aDados[nX, 08], oFont04)

		oPrint:Say((nLinIni + 0502 + (3*nLinA4))*nAL, (nColIni + 0010)*nAC, STR0011, oFont01) //"Dados do Contratado"
		oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 0020)*nAC, "9 - "+STR0012, oFont01) //"Código na Operadora / CNPJ / CPF"
		oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 09], oFont04)
		oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 0431)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 2165 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 0441)*nAC, "10 - "+STR0013, oFont01) //"Nome do Contratado"
		oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 10], 1, 65), oFont04)
		oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "11 - "+STR0014, oFont01) //"Código CNES"
		oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 11], oFont04)

		oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 0132)*nAC)
		oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC, "12 - "+STR0015, oFont01) //"T.L."
		oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 12], oFont04)
		oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 0137)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1050 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 0147)*nAC, "13-14-15 - "+STR0016, oFont01) //"Logradouro - Número - Complemento"
		oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 0157)*nAC, SubStr(AllTrim(aDados[nX, 13]) + IIf(!Empty(aDados[nX, 14]), ", ","") + AllTrim(aDados[nX, 14]) + IIf(!Empty(aDados[nX, 15]), " - ","") + AllTrim(aDados[nX, 15]), 1, 34), oFont04)
		oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1055 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1830 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1065 + nColA4)*nAC, "16 - "+STR0017, oFont01) //"Município"
		oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1075 + nColA4)*nAC, SubStr(aDados[nX, 16], 1, 29), oFont04)
		oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1835 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1940 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1845 + nColA4)*nAC, "17 - "+STR0018, oFont01) //"UF"
		oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1860 + nColA4)*nAC, aDados[nX, 17], oFont04)
		oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1945 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 2165 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1955 + nColA4)*nAC, "18 - "+STR0019, oFont01) //"Código IBGE"
		oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1965 + nColA4)*nAC, aDados[nX, 18], oFont04)
		oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "19 - "+STR0020, oFont01) //"CEP"
		oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 19], oFont04)

		oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 1455 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 0020)*nAC, "20 - "+STR0021, oFont01) //"Nome do Profissional Executante"
		oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 20], 1, 54), oFont04)
		oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 1460 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 1735 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 1470 + nColA4)*nAC, "21 - "+STR0022, oFont01) //"Conselho Profissional"
		oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 1480 + nColA4)*nAC, aDados[nX, 21], oFont04)
		oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 1740 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2065 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 1750 + nColA4)*nAC, "22 - "+STR0023, oFont01) //"Número no Conselho"
		oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 1760 + nColA4)*nAC, aDados[nX, 22], oFont04)
		oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 2070 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2165 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 2080 + nColA4)*nAC, "23 - "+STR0018, oFont01) //"UF"
		oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 2090 + nColA4)*nAC, aDados[nX, 23], oFont04)
		oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "24 - "+STR0024, oFont01) //"Código CBO S"
		oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 24], oFont04)

		oPrint:Say((nLinIni  + 0829 + (6*nLinA4))*nAL, (nColIni + 0010)*nAC, STR0025, oFont01) //"Hipï¿½teses DiagNºsticas"
		oPrint:Box((nLinIni  + 0839)*nAL + (6*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 0315)*nAC)
		oPrint:Say((nLinIni  + 0864 + (6*nLinA4))*nAL, (nColIni + 0020)*nAC, "25 - "+STR0026, oFont01) //"Tipo de DoeNºa"
		oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0077)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0043)*nAC, aDados[nX, 25], oFont04)
		oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0090)*nAC, STR0027+"    "+STR0028, oFont01)  //"A-Aguda"###"C-Crï¿½nica"
		oPrint:Box((nLinIni  + 0839)*nAL + (6*nLinA4), (nColIni + 0320)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 0765)*nAC)
		oPrint:Say((nLinIni  + 0864 + (6*nLinA4))*nAL, (nColIni + 0330)*nAC, "26 - "+STR0029, oFont01) //"Tempo de DoeNºa"
		oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0340)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0340)*nAC)
		oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0340)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0426)*nAC)
		oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0426)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0426)*nAC)
		oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 26,1], 2, 0))=="00","",(StrZero(aDados[nX, 26,1], 2, 0))), oFont04)
		oPrint:Say((nLinIni  + 0899 + (6*nLinA4))*nAL, (nColIni + 0434)*nAC, "-", oFont01)
		oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0447)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0447)*nAC)
		oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0447)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0494)*nAC)
		oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0494)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0494)*nAC)
		oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0457)*nAC, aDados[nX, 26,2], oFont04)
		oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0510)*nAC, STR0030+"  "+STR0031+"  "+STR0032, oFont01) //"A-Anos"###"M-Meses"###"D-Dias"
		oPrint:Box((nLinIni + 0839)*nAL  + (6*nLinA4), (nColIni + 0770)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 1807)*nAC)
		oPrint:Say((nLinIni + 0864  + (6*nLinA4))*nAL, (nColIni + 0780)*nAC, "27 - "+STR0033, oFont01) //"Indicaï¿½ï¿½o de Acidente"
		oPrint:Line((nLinIni+ 0869)*nAL  + (6*nLinA4), (nColIni + 0790)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0790)*nAC)
		oPrint:Line((nLinIni+ 0921)*nAL  + (7*nLinA4), (nColIni + 0790)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0832)*nAC)
		oPrint:Line((nLinIni+ 0869)*nAL  + (6*nLinA4), (nColIni + 0832)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0832)*nAC)
		oPrint:Say((nLinIni + 0904  + (6*nLinA4))*nAL, (nColIni + 0803)*nAC, aDados[nX, 27], oFont04)
		oPrint:Say((nLinIni + 0904  + (6*nLinA4))*nAL, (nColIni + 0850)*nAC, "0 - "+STR0034+"     "+"1 - "+STR0035+"     "+"2 - "+STR0036, oFont01) //"Acidente ou doeNºa relacionado ao trabalho"###"Trï¿½nsito"###"Outros"

		oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0285)*nAC)
		oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0020)*nAC, "28 - "+STR0037, oFont01) //"CID Principal"
		oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 28], oFont04)
		oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0290)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0565)*nAC)
		oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0300)*nAC, "29 - "+STR0038, oFont01) //"CID (2)"
		oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0310)*nAC, aDados[nX, 29], oFont04)
		oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0570)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0845)*nAC)
		oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0580)*nAC, "30 - "+STR0039, oFont01) //"CID (3)"
		oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0590)*nAC, aDados[nX, 30], oFont04)
		oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0850)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 1115)*nAC)
		oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0860)*nAC, "31 - "+STR0040, oFont01) //"CID (4)"
		oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0870)*nAC, aDados[nX, 31], oFont04)

		oPrint:Say((nLinIni + 1057 + (8*nLinA4))*nAL, (nColIni + 0010)*nAC, STR0041+" / "+STR0042, oFont01) //"Dados do Atendimento"###"Procedimento Realizado"
		oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0305)*nAC)
		oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0020)*nAC, "32 - "+STR0043, oFont01) //"Data do Atendimento"
		oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 32]), oFont04)
		oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0310)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0565)*nAC)
		oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0320)*nAC, "33 - "+STR0044, oFont01) //"Código Tabela"
		oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0330)*nAC, aDados[nX, 33], oFont04)
		oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0570)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0900)*nAC)
		oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0580)*nAC, "34 - "+STR0045, oFont01) //"Código Procedimento"
		oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0590)*nAC, aDados[nX, 34], oFont04)

		oPrint:Box((nLinIni + 1166)*nAL  + (9*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1260)*nAL + (10*nLinA4), (nColIni + 0505)*nAC)
		oPrint:Say((nLinIni + 1191  + (9*nLinA4))*nAL, (nColIni + 0020)*nAC, "35 - "+STR0046, oFont01) //"Tipo de Consulta"
		oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0030)*nAC)
		oPrint:Line((nLinIni + 1253)*nAL +(10*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0077)*nAC)
		oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0077)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0077)*nAC)
		oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0043)*nAC, aDados[nX, 35], oFont04)
		oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0090)*nAC, "1-"+STR0047+"   "+"2-"+STR0048+"   "+"3-"+STR0049, oFont01) //"Primeira"###"Seguimento"###"Prï¿½-Natal"
		oPrint:Box((nLinIni + 1166)*nAL  + (9*nLinA4), (nColIni + 0510)*nAC, (nLinIni + 1260)*nAL + (10*nLinA4), (nColIni + 1250)*nAC)
		oPrint:Say((nLinIni + 1191  + (9*nLinA4))*nAL, (nColIni + 0520)*nAC, "36 - "+STR0050, oFont01) //"Tipo de Saída"
		oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0530)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0530)*nAC)
		oPrint:Line((nLinIni + 1253)*nAL +(10*nLinA4), (nColIni + 0530)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0577)*nAC)
		oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0577)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0577)*nAC)
		oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0543)*nAC, aDados[nX, 36], oFont04)
		oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0590)*nAC, "1-"+STR0051+"   "+"2-"+STR0052+"   "+"3-"+STR0053+"   "+"4-"+STR0054+"   "+"5-"+STR0055, oFont01) //"Retorno"###"Retorno SADT"###"Referï¿½ncia"###"Internação"###"Alta"

		oPrint:Box((nLinIni + 1265)*nAL + (10*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1557)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1290 + (10*nLinA4))*nAL, (nColIni + 0020)*nAC, "37 - "+STR0056, oFont01) //"Observacao"
		nLin := 1335

		/*For nI := 1 To MlCount(aDados[nX, 37], 89)
		cObs := MemoLine(aDados[nX, 37], 89, nI)
		oPrint:Say((nLinIni + nLin + (10*nLinA4))*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
		nLin += 35
		Next nI
		*/
		oPrint:Box((nLinIni + 1562)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 0010)*nAC, (nLinIni + 1734)*nAL + IIf(nLayout ==2,(14*nLinA4),(22*nLinA4)), (nColIni + 1185 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1587 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 0020)*nAC, "38 - "+STR0057, oFont01) //"Data e Assinatura do Profissional"
		oPrint:Say((nLinIni + 1627 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 38]), oFont04)
		oPrint:Box((nLinIni + 1562)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 1190 + nColA4)*nAC, (nLinIni + 1734)*nAL + IIf(nLayout ==2,(14*nLinA4),(22*nLinA4)), (nColIni + 2390 + nColA4)*nAC)
		oPrint:Say((nLinIni + 1587 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 1200 + nColA4)*nAC, "39 - "+STR0058, oFont01) //"Data e Assinatura do Beneficiário ou Responsï¿½vel"
		oPrint:Say((nLinIni + 1627 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 1210 + nColA4)*nAC, DtoC(aDados[nX, 39]), oFont04)

		oPrint:EndPage()	// Finaliza a pagina

	Next nX

	If lGerTXT .And. !lWeb
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Imprime Relatorio
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:Print()
	Else
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Visualiza impressao grafica antes de imprimir
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:Print()
	EndIf

	Return (cFileName)


	***************************************************************************************************

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½SADT      - R234SADT - Baseado na função padrão PLSTISS2                ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Parametros aDados - Array com as informações do relatório              ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ lGerTXT - Define se imprime direto sem passar pela tela	   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½			 de configuracao/preview do relatorio 		       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ nLayout - Define o formato de papï¿½l para impressao:         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½           1 - Formato Ofï¿½cio II (216x330mm)                 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½           2 - Formato A4 (210x297mm)                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½  		 3 - Formato Carta (216x279mm)     			       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function R234SADT(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

	//(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

	Local nLinMax
	Local nColMax
	Local nLinIni	:= 0 // Linha Lateral (inicial) Esquerda
	Local nColIni	:= 0 // Coluna Lateral (inicial) Esquerda
	Local nLimFim	:= 0
	Local nColA4    := 0
	Local nColSoma  := 0
	Local nColSoma2 := 0
	Local nLinA4	:= 0
	Local cFileLogo
	Local nLin
	Local nOldLinIni
	Local nOldColIni
	Local nI, nJ, nX, nN
	Local nV, nV1, nV2, nV3, nV4
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local oPrint    := Nil
	Local lImpnovo  :=.T.
	Local nVolta    := 0
	Local nP        := 0
	Local nP1       := 0
	Local nP2       := 0
	Local nP3       := 0
	Local nP4       := 0
	Local nT        := 0
	Local nT1       := 0
	Local nT2       := 0
	Local nT3       := 0
	Local nT4       := 0
	Local nTotOPM   := 0
	Local nProx     := 0
	LOCAL cFileName	:= ""
	LOCAL cRel      := "guisadt"
	LOCAL cPathSrvJ := GETMV("MV_RELT")
	LOCAL nAL		:= 0.25
	LOCAL nAC		:= 0.24
	Local lImpPrc   := .T.

	DEFAULT lGerTXT 	:= .F.
	DEFAULT nLayout 	:= 2
	DEFAULT cLogoGH 	:= ""
	DEFAULT lWeb		:= .F.
	DEFAULT cPathRelW 	:= ""
	DEFAULT aDados 	:= { {;
	"123456",;
	"12345678901234567892",;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	Replicate("M",20),;
	CtoD("12/12/07"),;
	Replicate("M",70),;
	"123456789102345",;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"1234567",;
	Replicate("M",70),;
	"1234567",;
	"123456789102345",;
	"ES",;
	"12345",;
	{ CtoD("12/12/07"), "2210" },;
	"E",;
	"12345",;
	Replicate("M",70),;
	{ "10", "20", "30", "40", "50" } ,;
	{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234" },;
	{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60) },;
	{ 111,111,11,1,1 },;
	{ 999,999,99,9,9 },;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"999",;
	Replicate("M",40),;
	"MMMMM",;
	Replicate("M",15),;
	Replicate("M",40),;
	"MM",;
	"1234567",;
	"12345-678",;
	{ "1234567", "27.456.658/0001-35" },;
	Replicate("M",70),;
	"1234567",;
	"123456789102345",;
	"MM",;
	{ "12345", "01" },;
	"01",;
	"1",;
	"1",;
	"1",;
	{ 12,"M" },;
	{ CtoD("01/01/07"),CtoD("01/02/07"),CtoD("01/03/07"),CtoD("01/04/07"),CtoD("01/05/07")},;
	{ "0107","0207","0307","0407","0507" },;
	{ "0607","0707","0807","0907","1007" },;
	{ "MM","AA","BB","CC","DD"},;
	{ "1234567890","2345678901","3456789012","4567890123","5678901234"},;
	{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60)},;
	{ 12,1,2,3,4},;
	{ "M","A","B","C","D"},;
	{ "M","E","F","G","H"},;
	{ 111.00,222.00,333.00,444.00,999.99 },;
	{ 99999999.99,22222.22,33333.33,44444.44,11111.11 },;
	{ 11111111.11,55555.00,66666.00,77777.00,88888.00 },;
	{ CtoD("01/01/07"),CtoD("02/01/07"),CtoD("03/01/07"),CtoD("04/01/07"),CtoD("05/01/07"),CtoD("06/01/07"),CtoD("07/01/07"),CtoD("08/01/07"),CtoD("09/01/07"),CtoD("10/01/07")},;
	Replicate("M", 240),;
	{1333333.22},;
	{2333333.22},;
	{3333333.22},;
	{4333333.22},;
	{5333333.22},;
	{6333333.22},;
	{73333333.22},;
	{ "11", "22", "33", "44", "55", "66", "77", "88", "99" },;
	{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
	{ Replicate ("M", 60), Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60) },;
	{ 01, 1, 2, 03, 04, 05, 06, 7, 99 }, ;
	{ Replicate ("I", 40), Replicate ("J", 40), Replicate ("K", 40), Replicate ("L", 40), Replicate ("M", 40), Replicate ("N", 40), Replicate ("O", 40), Replicate ("P", 40), Replicate ("Q", 40) },;
	{ 999999.99, 111111.99, 222229.99, 333999.99, 444449.99, 555559.99, 666669,99, 777779.99, 888899.99 },;
	{ "11", "12", "13", "14", "15", "16", "17", "18", "19" },;
	{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
	{ Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60), Replicate ("I", 60) },;
	{ 01, 2, 3, 04, 05, 06, 07, 8, 99 }, ;
	{ Replicate ("J", 20), Replicate ("K", 20), Replicate ("L", 20), Replicate ("M", 20), Replicate ("N", 20), Replicate ("O", 20), Replicate ("P", 20), Replicate ("Q", 20), Replicate ("R", 20) },;
	{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
	{ 399999999.99, 499999999.99, 599999999.99, 699999.99, 799999.99, 899999.99, 99.99, 09.99, 19.99 },;
	{1999999.99},;
	CtoD("01/01/07"),;
	CtoD("02/01/07"),;
	CtoD("03/01/07"),;
	CtoD("04/01/07") } }

	oFont01	:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½ Nao permite acionar a impressao quando for na web.
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	//						New ( < cFilePrintert >, [ nDevice], [ lAdjustToLegacy], [ cPathInServer], [ lDisabeSetup ], [ lTReport], [ @oPrintSetup], [ cPrinter], [ lServer], [ lPDFAsPNG], [ lRaw], [ lViewPDF] )
	if !lWeb
		oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
	else
		oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
		If lSrvUnix
			AjusPath(@oPrint)
		EndIf
	Endif
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Tratamento para impressao via job
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//oPrint:lInJob  := lWeb
	oPrint:lServer := lWeb
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½ Caminho do arquivo
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	oPrint:cPathPDF := cPathSrvJ

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Modo paisagem
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	oPrint:SetLandscape()

	if nLayout ==2
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Papï¿½l A4
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:SetPaperSize(9)
	Elseif nLayout ==3
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Papï¿½l Carta
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:SetPaperSize(1)
	Else
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:SetPaperSize(14)
	Endif
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Device
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If lWeb
		oPrint:setDevice(IMP_PDF)
		//oPrint:lPDFAsPNG := .T.
	EndIf
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½aï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	//ï¿½Verifica se existe alguma impressora configurada para Impressao Grafica
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	If  !lWeb
		oPrint:Setup()
		lImpnovo:=(oPrint:nModalResult == 1)
	EndIf

	If oPrint:nPaperSize  == 9 // Papï¿½l A4
		nLinMax	:=	2000
		nColMax	:=	3365 //3508 //3380 //3365
		nLayout 	:= 2
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	Elseif oPrint:nPaperSize == 1 // Papel Carta
		nLinMax	:=	2000
		nColMax	:=	3175
		nLayout 	:= 3
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
	Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
		nLinMax	:=	2435
		nColMax	:=	3765
		nLayout 	:= 1
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	Endif

	While lImpnovo

		lImpnovo:=.F.
		nVolta  += 1
		nT      += 5
		nT1     += 5
		nT2     +=10
		nT3     += 9
		nT4     += 9
		nProx   += 1

		For nX := 1 To Len(aDados)

			If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 25 To 29
				If Len(aDados[nX, nI]) < nT
					For nJ := Len(aDados[nX, nI]) + 1 To nT
						If AllTrim(Str(nI)) $ "28,29"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 51 To 62
				If Len(aDados[nX, nI]) < nT1
					For nJ := Len(aDados[nX, nI]) + 1 To nT1
						If AllTrim(Str(nI)) $ "51"
							aAdd(aDados[nX, nI], StoD(""))
						ElseIf AllTrim(Str(nI)) $ "57,60,61,62"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 63 To 63
				If Len(aDados[nX, nI]) < nT2
					For nJ := Len(aDados[nX, nI]) + 1 To nT2
						aAdd(aDados[nX, nI], StoD(""))
					Next nJ
				EndIf
			Next nI

			For nI := 65 To 71
				If Len(aDados[nX, nI]) < nVolta
					For nJ := Len(aDados[nX, nI]) + 1 To nVolta
						If AllTrim(Str(nI)) $ "65,66,67,68,69,70,71"
							aAdd(aDados[nX, nI], 0)
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 72 To 77
				If Len(aDados[nX, nI]) < nT3
					For nJ := Len(aDados[nX, nI]) + 1 To nT3
						If AllTrim(Str(nI)) $ "75,77"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 78 To 84
				If Len(aDados[nX, nI]) < nT4
					For nJ := Len(aDados[nX, nI]) + 1 To nT4
						If AllTrim(Str(nI)) $ "81,83,84"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 85 To 85
				If Len(aDados[nX, nI]) < nVolta
					For nJ := Len(aDados[nX, nI]) + 1 To nVolta
						aAdd(aDados[nX, nI], 0)
					Next nJ
				EndIf
			Next nI
			If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni	:= 150
				nLimFim	:= 400
			Else
				nLinIni	:= 000
				nLimFim	:= 230
			Endif


			nColIni		:= 000
			nColA4		:= 000
			nLinA4		:= 000
			nColSoma	:= 000
			nColSoma2	:= 000

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			//ï¿½Inicia uma nova pagina
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:StartPage()
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½Box Principal                                                 ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLimFim + nLinMax)*nAL, (nColIni + nColMax)*nAC)
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½Carrega e Imprime Logotipo da Empresa                         ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 	// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papï¿½l A4
				nColA4    := -0395
				nLinA4    := -0010
				nColSoma  := -0300
				nColSoma2 := -0190
			Elseif nLayout == 3// Carta
				nColA4    := -0590
				nLinA4    := -0010
				nColSoma  := -0300
				nColSoma2 := -0190
			Endif

			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 1702)*nAC + (nColA4/2), STR0060, oFont02n,,,, 2) //"GUIA DE HONORARIO INDIVIDUAL"
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 2930 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, "2 - "+STR0002, oFont01) //"Nº"
			oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 3026 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, aDados[nX, 02], oFont03n)

			oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 0315)*nAC)
			oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "1 - "+STR0003, oFont01) //"Registro ANS"
			oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0320			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1035)*nAC)
			oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0330			)*nAC, "3 - "+STR0061, oFont01) //"Nº Guia Principal"
			oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0340			)*nAC, aDados[nX, 03], oFont04)
			oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1040			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1345)*nAC)
			oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1050			)*nAC, "4 - "+STR0062, oFont01) //"Data da Autorização"
			oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1060			)*nAC, DtoC(aDados[nX, 04]), oFont04)
			oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1350			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1755)*nAC)
			oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1360			)*nAC, "5 - "+STR0063, oFont01) //"Senha"
			oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1370			)*nAC, aDados[nX, 05], oFont04)
			oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1760			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2165)*nAC)
			oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1770			)*nAC, "6 - "+STR0064, oFont01) //"Data Validade da Senha"
			oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1780			)*nAC, DtoC(aDados[nX, 06]), oFont04)
			oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 2170			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2465)*nAC)
			oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 2180			)*nAC, "7 - "+STR0004, oFont01) //"Data de Emissão da Guia"
			oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 2190			)*nAC, DtoC(aDados[nX, 07]), oFont04)

			oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010			)*nAC, STR0005, oFont01) //"Dados do Beneficiário"
			oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 0425)*nAC)
			oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "8 - "+STR0006, oFont01) //"Número da Carteira"
			oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 08], oFont04)
			oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0430			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1572 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0440			)*nAC, "9 - "+STR0007, oFont01) //"Plano"
			oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0450			)*nAC, aDados[nX, 09], oFont04)
			oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1577 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1835 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1587 + nColA4	)*nAC, "10 - "+STR0008, oFont01) //"Validade da Carteira"
			oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1597 + nColA4	)*nAC, DtoC(aDados[nX, 10]), oFont04)
			oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1840 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3290 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1850 + nColA4	)*nAC, "11 - "+STR0009, oFont01) //"Nome"
			oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1860 + nColA4	)*nAC, SubStr(aDados[nX, 11], 1, 52), oFont04)
			oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 3295 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 3305 + nColA4	)*nAC, "12 - "+STR0010, oFont01) //"Número do Cartão Nacional de Saúde"
			oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 3315 + nColA4	)*nAC, aDados[nX, 12], oFont04)

			oPrint:Say((nLinIni + 0403 + nLinA4)*nAL, (nColIni + 0010			)*nAC, STR0065, oFont01) //"Dados do Contratado Solicitante"
			oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 0426)*nAC)
			oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "13 - "+STR0012, oFont01) //"Código na Operadora / CNPJ / CPF"
			oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 13], oFont04)
			oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0431			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2245)*nAC)
			oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0441			)*nAC, "14 - "+STR0013, oFont01) //"Nome do Contratado"
			oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0451			)*nAC, SubStr(aDados[nX, 14], 1, 65), oFont04)
			oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 2250			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2480)*nAC)
			oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 2260			)*nAC, "15 - "+STR0014, oFont01) //"Código CNES"
			oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 2270			)*nAC, aDados[nX, 15], oFont04)

			oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 1824)*nAC)
			oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "16 - "+STR0066, oFont01) //"Nome do Profissional Solicitante"
			oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 0030			)*nAC, SubStr(aDados[nX, 16], 1, 66), oFont04)
			oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 1829			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2122)*nAC)
			oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 1839			)*nAC, "17 - "+STR0022, oFont01) //"Conselho Profissional"
			oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 1849			)*nAC, aDados[nX, 17], oFont04)
			oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2127			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2480)*nAC)
			oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2137			)*nAC, "18 - "+STR0023, oFont01) //"Número no Conselho"
			oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2147			)*nAC, aDados[nX, 18], oFont04)
			oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2485			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2575)*nAC)
			oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2495			)*nAC, "19 - "+STR0018, oFont01) //"UF"
			oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2505			)*nAC, aDados[nX, 19], oFont04)
			oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2580			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2790)*nAC)
			oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2590			)*nAC, "20 - "+STR0024, oFont01) //"Código CBO S"
			oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2600			)*nAC, aDados[nX, 20], oFont04)

			oPrint:Say((nLinIni + 0631 + nLinA4)*nAL, (nColIni + 0010)*nAC, STR0067, oFont01) //"Dados da Solicitação / Procedimentos e Exames Solicitados"
			oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0315)*nAC)
			oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0020)*nAC, "21 - "+STR0068, oFont01) //"Data/Hora da Solicitação"
			oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 21,1]) + " " + Transform(aDados[nX, 21,2], "@R 99:99"), oFont04)
			oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0735)*nAC)
			oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0330)*nAC, "22 - "+STR0069, oFont01) //"Carï¿½ter da Solicitação"
			oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0340)*nAC)
			oPrint:Line((nLinIni + 0728)*nAL+ (nLinA4/2), 	(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
			oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0387)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
			oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0353)*nAC, aDados[nX, 22], oFont04)
			oPrint:Say((nLinIni + 0706 + nLinA4)*nAL, (nColIni + 0400)*nAC, STR0070+"  "+STR0071, oFont01) //"E-Eletiva"###"U-Urgência/Emergï¿½ncia"
			oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0740)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0905)*nAC)
			oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0750)*nAC, "23 - "+STR0072, oFont01) //"CID 10"
			oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0760)*nAC, aDados[nX, 23], oFont04)
			oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0910)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0920)*nAC, "24 - "+STR0073, oFont01) //"Indicaï¿½ï¿½o Clínica (obrigatï¿½rio se pequena cirurgia, terapia, consulta referenciada e alto custo)"
			oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0930)*nAC, aDados[nX, 24], oFont04)

			oPrint:Box((nLinIni + 0760)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1005)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "25 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0150			)*nAC, "26 - "+STR0075, oFont01) //"Código do Procedimento"
			oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0450			)*nAC, "27 - "+STR0076, oFont01) //"Descrição"
			oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3400 + nColA4	)*nAC, "28 - "+STR0077, oFont01,,,,1) //"Qt.Solic."
			oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3610 + nColA4	)*nAC, "29 - "+STR0078, oFont01,,,,1) //"Qt.Autoriz."

			nOldLinIni := nLinIni

			if nVolta = 1
				nV:=1
			Endif

			For nP := nV To nT
				if nVolta <> 1
					nN:=nP-((5*nVolta)-5)
					oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
				endif
				oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 25, nP], oFont04)
				oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0150)*nAC			, aDados[nX, 26, nP], oFont04)
				oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0450)*nAC			, aDados[nX, 27, nP], oFont04)
				oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3425 + nColA4)*nAC, IIf(Empty(aDados[nX, 28, nP]), "", Transform(aDados[nX, 28, nP], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3635 + nColA4)*nAC, IIf(Empty(aDados[nX, 29, nP]), "", Transform(aDados[nX, 29, nP], "@E 9999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nP

			if nT < Len(aDados[nX, 26]).or. lImpnovo
				nV:=nP
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			oPrint:Say((nLinIni + 1000 + nLinA4)*nAL, (nColIni + 0010			)*nAC, STR0079, oFont01) //"Dados do Contratado Executante"
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 0416)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "30 - "+STR0012, oFont01) //"Código na Operadora / CNPJ / CPF"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 30], oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0421			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1316 + nColSoma)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0431			)*nAC, "31 - "+STR0013, oFont01) //"Nome do Contratado"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0441			)*nAC, SubStr(aDados[nX, 31], 1, 32), oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1321 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1433 + nColSoma)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1331 + nColSoma)*nAC, "32 - "+STR0015, oFont01) //"T.L."
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1341 + nColSoma)*nAC, aDados[nX, 32], oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1438 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 2413 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1448 + nColSoma)*nAC, "33-34-35 - "+STR0016, oFont01) //"Logradouro - Número - Complemento"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1458 + nColSoma)*nAC, SubStr(AllTrim(aDados[nX, 33]) + IIf(!Empty(aDados[nX, 34]), ", ","") + AllTrim(aDados[nX, 34]) + IIf(!Empty(aDados[nX, 35]), " - ","") + AllTrim(aDados[nX, 35]), 1, 35), oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 2418 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3023 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 2428 + nColA4	)*nAC, "36 - "+STR0017, oFont01) //"Município"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 2438 + nColA4	)*nAC, SubStr(aDados[nX, 36], 1, 21), oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3028 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3130 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3038 + nColA4	)*nAC, "37 - "+STR0018, oFont01) //"UF"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3048 + nColA4	)*nAC, aDados[nX, 37], oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3135 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3320 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3145 + nColA4	)*nAC, "38 - "+STR0080, oFont01) //"Cód.IBGE"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3155 + nColA4	)*nAC, aDados[nX, 38], oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3325 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3510 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3335 + nColA4	)*nAC, "39 - "+STR0020, oFont01) //"CEP"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3345 + nColA4	)*nAC, aDados[nX, 39], oFont04)
			oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3515 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3525 + nColA4	)*nAC, "40 - "+STR0014, oFont01) //"Código CNES"
			oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3535 + nColA4	)*nAC, aDados[nX, 40, 1], oFont04)

			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 0590)*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0020)*nAC, "40a - "+STR0081, oFont01) //"Código na Operadora / CPF do exec. complementar"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 40, 2], 1, 68), oFont04)
			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0595)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2436 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0605)*nAC, "41 - "+STR0082, oFont01) //"Nome do Profissional Executante/Complementar"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0615)*nAC, SubStr(aDados[nX, 41], 1, 68), oFont04)
			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2441 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2715 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2451 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "42 - "+STR0022, oFont01) //"Conselho Profissional"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2461 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 42], oFont04)
			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2720 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3055 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2730 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "43 - "+STR0023, oFont01) //"Número no Conselho"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2740 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 43], oFont04)
			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3060 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3160 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3070 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "44 - "+STR0018, oFont01) //"UF"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3080 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 44], oFont04)
			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3165 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3372 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3175 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45 - "+STR0024, oFont01) //"Código CBO S"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3185 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 1], oFont04)
			oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3377 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3387 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45a - "+STR0083, oFont01) //"Grau de Participaï¿½ï¿½o"
			oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3397 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 2], oFont04)

			oPrint:Say((nLinIni + 1236 + nLinA4)*nAL, (nColIni + 0010)*nAC, STR0041, oFont01) //"Dados do Atendimento"
			oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 1185)*nAC)
			oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 0020)*nAC, "46 - "+STR0084, oFont01) //"Tipo Atendimento"
			oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0030)*nAC)
			oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
			oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0087)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
			oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 46], oFont04)
			oPrint:Say((nLinIni + 1298 + nLinA4)*nAL, (nColIni + 0100)*nAC, "01 - "+STR0085+"    "+"02 - "+STR0086+"    "+"03 - "+STR0087+"    "+"04 - "+STR0088+"    "+"05 - "+STR0089+"    "+"06 - "+STR0090, oFont01) //"Remoï¿½ï¿½o"###"Pequena Cirurgia"###"Terapias"###"Consulta"###"Exame"###"Atendimento Domiciliar"
			oPrint:Say((nLinIni + 1328 + nLinA4)*nAL, (nColIni + 0100)*nAC, "07 - "+STR0091+"    "+"08 - "+STR0092+"    "+"09 - "+STR0093+"    "+"10 - "+STR0094, oFont01) //"SADT Internado"###"Quimioterapia"###"Radioterapia"###"TRS-Terapia Renal Substitutiva"
			oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 1190)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 2450 + nColA4/2)*nAC)
			oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 1200)*nAC, "47 - "+STR0033, oFont01) //"Indicaï¿½ï¿½o de Acidente"
			oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1210)*nAC)
			oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
			oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1257)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
			oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 1223)*nAC, aDados[nX, 47], oFont04)
			oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 1270)*nAC, "0 - "+STR0034+"   "+"1 - "+STR0035+"   "+"2 - "+STR0036, oFont01) //"Acidente ou doeNºa relacionado ao trabalho"###"Trï¿½nsito"###"Outros"
			oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 2455 + nColA4/2)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 2465 + nColA4/2)*nAC, "48 - "+STR0050, oFont01) //"Tipo de Saída"
			oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2475 + nColA4/2)*nAC)
			oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
			oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2522 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
			oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 2488 + nColA4/2)*nAC, aDados[nX, 48], oFont04)
			oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 2535 + nColA4/2)*nAC, "1 - "+STR0051+"    "+"2 - "+STR0052+"    "+"3 - "+STR0053+"    "+"4 - "+STR0054+"    "+"5 - "+STR0055+"    "+"6 - "+STR0095, oFont01) //"Retorno"###"Retorno SADT"###"Referï¿½ncia"###"Internação"###"Alta"###"óbito"

			oPrint:Say((nLinIni + 1367 + nLinA4)*nAL , (nColIni + 0010)*nAC, STR0096, oFont01) //"Consulta Referï¿½ncia"
			oPrint:Box((nLinIni + 1397)*nAL + nLinA4 , (nColIni + 0010)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0315)*nAC)
			oPrint:Say((nLinIni + 1402 + nLinA4)*nAL , (nColIni + 0020)*nAC, "49 - "+STR0026, oFont01) //"Tipo de DoeNºa"
			oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC)
			oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
			oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0077)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
			oPrint:Say((nLinIni + 1432  + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 49], oFont04)
			oPrint:Say((nLinIni + 1442  + nLinA4)*nAL, (nColIni + 0090)*nAC, STR0027+"    "+STR0028, oFont01) //"A-Aguda"###"C-Crï¿½nica"
			oPrint:Box((nLinIni + 1397)*nAL  + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0770)*nAC)
			oPrint:Say((nLinIni + 1402  + nLinA4)*nAL, (nColIni + 0330)*nAC, "50 - "+STR0029, oFont01) //"Tempo de DoeNºa"
			oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC)
			oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
			oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0426)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
			If aDados[nX,50,1] > 0
				oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 50,1], 2, 0))=="00","",(StrZero(aDados[nX, 50,1], 2, 0))), oFont04)
			Endif
			oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0434)*nAC, "-", oFont01)
			oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0447)*nAC)
			oPrint:Line((nLinIni+ 1477)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
			oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0494)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
			oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0457)*nAC, aDados[nX, 50,2], oFont04)
			oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0510)*nAC, STR0030+"  "+STR0031+"  "+STR0032, oFont01) //"A-Anos"###"M-Meses"###"D-Dias"

			oPrint:Say((nLinIni + 1478 + nLinA4)*nAL, (nColIni + 0010)*nAC, STR0097, oFont01) //"Procedimentos e Exames realizados"
			oPrint:Box((nLinIni + 1526)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1766)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0020)*nAC, "51 - "+STR0098, oFont01) //"Data"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0210)*nAC, "52 - "+STR0099, oFont01) //"Hora Inicial"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0380)*nAC, "53 - "+STR0100, oFont01) //"Hora Final"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0540)*nAC, "54 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0660)*nAC, "55 - "+STR0075, oFont01) //"Código do Procedimento"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0940)*nAC, "56 - "+STR0076, oFont01) //"Descrição"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3675)*nAC + nColA4, "57 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3795)*nAC + nColA4, "58 - "+STR0102, oFont01) //"Via"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4040)*nAC + nColA4, "59 - "+STR0103, oFont01) //"Tec."
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4260)*nAC + nColA4, "60 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4500)*nAC + nColA4, "61 - "+STR0105, oFont01,,,,1) //"Valor Unitï¿½rio - R$"
			oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4745)*nAC + nColA4, "62 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni

			if nVolta=1
				nV1:=1
			Endif

			If ExistBlock("PLSGTISS")
				lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"02",lImpPrc})
			EndIf

			If lImpPrc

				For nP1 := nV1 To nT1
					if nVolta <> 1
						nN:=nP1-((5*nVolta)-5)
						oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
					else
						oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
					endif
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0065)*nAC, IIf(Empty(aDados[nX, 51, nP1]), "", DtoC(aDados[nX, 51, nP1])), oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0210)*nAC, IIf(Empty(aDados[nX, 52, nP1]), "", Transform(aDados[nX, 52, nP1], "@R 99:99")), oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0380)*nAC, IIf(Empty(aDados[nX, 53, nP1]), "", Transform(aDados[nX, 53, nP1], "@R 99:99")), oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0540)*nAC, aDados[nX, 54, nP1], oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0660)*nAC, aDados[nX, 55, nP1], oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0940)*nAC, SUBSTR(aDados[nX, 56, nP1],1,51), oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2445 + nColA4)*nAC, IIf(Empty(aDados[nX, 57, nP1]), "", Transform(aDados[nX, 57, nP1], "@E 9999.99")), oFont04,,,,1)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2560 + nColA4)*nAC, aDados[nX, 58, nP1], oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2840 + nColA4)*nAC, aDados[nX, 59, nP1], oFont04)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3050 + nColA4)*nAC, IIf(Empty(aDados[nX, 60, nP1]), "", Transform(aDados[nX, 60, nP1], "@E 9999.99")), oFont04,,,,1)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3240 + nColA4)*nAC, IIf(Empty(aDados[nX, 61, nP1]), "", Transform(aDados[nX, 61, nP1], "@E 99,999,999.99")), oFont04,,,,1)
					oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3510 + nColA4)*nAC, IIf(Empty(aDados[nX, 62, nP1]), "", Transform(aDados[nX, 62, nP1], "@E 99,999,999.99")), oFont04,,,,1)
					nLinIni += 40
				Next nP1

			EndIf

			if nT1 < Len(aDados[nX, 55]).or. lImpnovo
				nV1:=nP1
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			oPrint:Box((nLinIni + 1771)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1971)*nAL + (2*nLinA4), (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1766 + nLinA4)*nAL, (nColIni + 0020)*nAC, "63 - "+STR0107, oFont01) //"Data e Assinatura de Procedimentos em Sï¿½rie"

			nOldColIni := nColIni

			if nVolta=1
				nV2:=1
			Endif

			For nP2 := nV2 To nT2 Step 2
				if nVolta <> 1
					nN:=nP2-((10*nVolta)-10)
					oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
				oPrint:Line((nLinIni + 1861)*nAL + nLinA4,(nColIni + 0230)*nAC, (nLinIni + 1861)*nAL + nLinA4, (nColIni + 0757 + nColSoma2)*nAC)
				if nLayout ==1
					nColIni += 727
				Elseif nLayout ==2
					nColIni += 670
				Else
					nColIni += 630
				Endif
			Next nP2

			nColIni := nOldColIni

			nOldColIni := nColIni

			if nVolta=1
				nV2:=1
			Endif

			For nP2 := nV2+1 To nT2+1 Step 2
				if nVolta <> 1
					nN:=nP2-((10*nVolta)-10)
					oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
				oPrint:Line((nLinIni + 1945)*nAL + (2*nLinA4),(nColIni + 0230)*nAC, (nLinIni + 1945)*nAL + (2*nLinA4), (nColIni + 0757 + nColSoma2)*nAC)
				if nLayout ==1
					nColIni += 727
				Elseif nLayout ==2
					nColIni += 670
				Else
					nColIni += 630
				Endif
			Next nP2

			nColIni := nOldColIni

			if nT2 < Len(aDados[nX, 63]).or. lImpnovo
				nV2:=nP2-1
				lImpnovo:=.T.
			Endif

			oPrint:Box((nLinIni + 1976)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 2136)*nAL + (3*nLinA4), (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1950 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "64 - "+STR0056, oFont01) //"Observaï¿½ï¿½o"

			If nModulo == 51    //Gestï¿½o Hospitalar
				if nVolta=1
					nV1:=1
				Endif

				nLin := 1988
				For nP1 := nV1 To nT1
					if nVolta <> 1
						nN:=nP1-((5*nVolta)-5)
						oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
					else
						oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
					endif
					oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0065)*nAC, aDados[nX, 64, nP1], oFont04)

					nLin += 35
				Next nP1

				if nT1 < Len(aDados[nX, 64]).or. lImpnovo
					nV1:=nP1
					lImpnovo:=.T.
				Endif
			Else
				nLin := 1991

				For nI := 1 To MlCount(aDados[nX, 64], 130)
					cObs := MemoLine(aDados[nX, 64], 130, nI)
					oPrint:Say((nLinIni + nLin + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
					nLin += 35
				Next nI

			Endif
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0010)*nAC			 		, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 0591 + (nColA4/7) )*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0020)*nAC				 	, "65 - "+STR0108, oFont01) //"Total Procedimentos R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0220 + (nColA4/6))*nAC 	, Transform(aDados[nX, 65,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0596 + (nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1117 + 2*(nColA4/7))*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0606 + (nColA4/7))*nAC	, "66 - "+STR0109, oFont01) //"Total Taxas e Aluguï¿½is R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0806 + 2*(nColA4/6))*nAC	, Transform(aDados[nX, 66,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1122 + 2*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1643  + 3*(nColA4/7))*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1132 + 2*(nColA4/7))*nAC	, "67 - "+STR0110, oFont01) //"Total Materiais R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1332 + 3*(nColA4/6))*nAC	, Transform(aDados[nX, 67,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1648 + 3*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2169 + 4*(nColA4/7) )*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1658 + 3*(nColA4/7))*nAC	, "68 - "+STR0111, oFont01) //"Total Medicamentos R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1858 + 4*(nColA4/6))*nAC	, Transform(aDados[nX, 68,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2174 + 4*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2695 + 5*(nColA4/7) )*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2184 + 4*(nColA4/7))*nAC	, "69 - "+STR0112, oFont01) //"Total Diï¿½rias R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2384 + 5*(nColA4/6))*nAC	, Transform(aDados[nX, 69,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2700 + 5*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3221 + 6*(nColA4/7) )*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2710 + 5*(nColA4/7))*nAC	, "70 - "+STR0113, oFont01) //"Total Gases Medicinais R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2910 + 6*(nColA4/6))*nAC	, Transform(aDados[nX, 70,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 3226 + 6*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3755  + 7*(nColA4/7))*nAC)
			oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 3236 + 6*(nColA4/7))*nAC	, "71 - "+STR0114, oFont01) //"Total Geral da Guia R$"
			oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 3436 + 7*(nColA4/6))*nAC	, Transform(aDados[nX, 71,nProx], "@E 999,999,999.99"), oFont04,,,,1)


			oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0010)*nAC					, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 0986 + (nColA4/4) )*nAC)
			oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC 				, "86 - "+STR0115, oFont01) //"Data e Assinatura do Solicitante"
			oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC 				, DtoC(aDados[nX, 86]), oFont04)
			oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0991  +(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 1907 + 2*(nColA4/4) )*nAC)
			oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1001  +(nColA4/4))*nAC	, "87 - "+STR0116, oFont01) //"Data e Assinatura do Responsï¿½vel pela Autorização"
			oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1011  +(nColA4/4))*nAC	, DtoC(aDados[nX, 87]), oFont04)
			oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 1912  +2*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 2828 + 3*(nColA4/4) )*nAC)
			oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1922  +2*(nColA4/4))*nAC	, "88 - "+STR0058, oFont01) //"Data e Assinatura do Beneficiário ou Responsï¿½vel"
			oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1932  +2*(nColA4/4))*nAC	, DtoC(aDados[nX, 88]), oFont04)
			oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 2833  +3*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 3750 + 4*(nColA4/4) )*nAC)
			oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 2843  +3*(nColA4/4))*nAC	, "89 - "+STR0117, oFont01) //"Data e Assinatura do Prestador Executante"
			oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 2853  +3*(nColA4/4))*nAC	, DtoC(aDados[nX, 89]), oFont04)

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			//ï¿½Finaliza a pagina
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:EndPage()
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			//ï¿½Verso da Guia - Inicia uma nova pagina
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:StartPage()
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½Box Principal                                                 ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

			oPrint:Box((nLinIni + 0010)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0490)*nAL, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0030)*nAL, (nColIni + 0020)*nAC			, STR0118, oFont01) //"OPM Solicitados"
			oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0020)*nAC			, "72 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0160)*nAC			, "73 - "+STR0119, oFont01) //"Código do OPM"
			oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0410)*nAC		 	, "74 - "+STR0120, oFont01) //"Descrição OPM"
			oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2400 + nColA4)*nAC	, "75 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2550 + nColA4)*nAC	, "76 - "+STR0121, oFont01) //"Fabricante"
			oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 3530 + nColA4)*nAC	, "77 - "+STR0105, oFont01,,,,1) //"Valor Unitï¿½rio - R$"

			nOldLinIni := nLinIni

			if nVolta=1
				nV3:=1
			Endif

			For nP3 := nV3 To nT3
				if nVolta <> 1
					nN:=nP3-((9*nVolta)-9)
					oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP3)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 72, nP3], oFont04)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 73, nP3], oFont04)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 74, nP3], oFont04)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 75, nP3]), "", Transform(aDados[nX, 75, nP3], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 76, nP3], oFont04)
				oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 3550 + nColA4)*nAC	, IIf(Empty(aDados[nX, 77, nP3]), "", Transform(aDados[nX, 77, nP3], "@E 999,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nP3

			nLinIni := nOldLinIni

			if nT3 < Len(aDados[nX, 73]).or. lImpnovo
				nV3:=nP3
				lImpnovo:=.T.
			Endif

			oPrint:Box((nLinIni + 0495)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0990)*nAL, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 0515)*nAL, (nColIni + 0020)*nAC			, STR0122, oFont01) //"OPM Utilizados"
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0020)*nAC			, "78 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0160)*nAC			, "79 - "+STR0119, oFont01) //"Código do OPM"
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0410)*nAC			, "80 - "+STR0120, oFont01) //"Descrição OPM"
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2400 + nColA4)*nAC	, "81 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2550 + nColA4)*nAC	, "82 - "+STR0123, oFont01) //"Código de Barras"
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3250 + nColA4)*nAC	, "83 - "+STR0105, oFont01,,,,1) //"Valor Unitï¿½rio - R$"
			oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3560 + nColA4)*nAC	, "84 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni

			if nVolta=1
				nV4:=1
			Endif

			For nP4 := nV4 To nT4
				if nVolta <> 1
					nN:=nP4-((9*nVolta)-9)
					oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP4)) + " - ", oFont01)
				Endif
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 78, nP4], oFont04)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 79, nP4], oFont04)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 80, nP4], oFont04)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 81, nP4]), "", Transform(aDados[nX, 81, nP4], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 82, nP4], oFont04)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3260 + nColA4)*nAC	, IIf(Empty(aDados[nX, 83, nP4]), "", Transform(aDados[nX, 83, nP4], "@E 999,999,999.99")), oFont04,,,,1)
				oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3540 + nColA4)*nAC	, IIf(Empty(aDados[nX, 84, nP4]), "", Transform(aDados[nX, 84, nP4], "@E 999,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nP4

			nLinIni := nOldLinIni

			nTotOPM:=nV4

			if nT4 < Len(aDados[nX, 79]).or. lImpnovo
				nV4:=nP4
				lImpnovo:=.T.
			Endif

			oPrint:Box((nLinIni + 1005)*nAL, (nColIni + 3395 + nColA4)*nAC, (nLinIni + 1089)*nAL, (nColIni + 3755 + nColA4)*nAC)
			oPrint:Say((nLinIni + 1025)*nAL, (nColIni + 3405 + nColA4)*nAC, "85 - "+STR0124, oFont01) //"Total OPM R$"
			oPrint:Say((nLinIni + 1055)*nAL, (nColIni + 3555 + nColA4)*nAC, Transform(aDados[nX, 85,nProx], "@E 999,999,999.99"), oFont04,,,,1)
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			//ï¿½Finaliza a pagina
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:EndPage()

		Next nX
	EndDo

	If lGerTXT .And. !lWeb
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Imprime Relatorio
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:Print()
	Else
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		//ï¿½Visualiza impressao grafica antes de imprimir
		//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		oPrint:Print()
	EndIf

	Return(cFileName)

	***************************************************************************************************

/*
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½RESUMO INTERNACAO - R234RINT - Baseado na função padrão PLSTISS4        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä´ï¿½ï¿½
ï¿½ï¿½ï¿½Parametros aDados - Array com as informações do relatório              ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ lGerTXT - Define se imprime direto sem passar pela tela 	   ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½			 de configuracao/preview do relatorio 		       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½ nLayout - Define o formato de papï¿½l para impressao:         ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½           1 - Formato Ofï¿½cio II (216x330mm)                 ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½           2 - Formato A4 (210x297mm)                        ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½          ï¿½  		 3 - Formato Carta (216x279mm)     			       ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù±ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
*/

Static Function R234RINT(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

	Local nLinMax
	Local nColMax
	Local nLinIni := 0		// Linha Lateral (inicial) Esquerda
	Local nColIni := 0		// Coluna Lateral (inicial) Esquerda
	Local nColA4  := 0
	Local nCol2A4 := 0
	Local cFileLogo
	Local nLin
	Local nOldLinIni
	Local nI, nJ, nX, nN
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local lImpnovo:=.T.
	Local nVolta  := 0
	Local nP   	  := 0
	Local nP1     := 0
	Local nP2     := 0
	Local nP3     := 0
	Local nP4     := 0
	Local nP5     := 0
	Local nT      := 0
	Local nT1     := 0
	Local nT2     := 0
	Local nT3     := 0
	Local nT4     := 0
	Local nAte    :=15
	Local nAte1   :=20
	Local nAte2   := 5

	DEFAULT lWeb		:= .F.
	DEFAULT cPathRelW 	:= ""
	Default lGerTXT := .F.
	Default nLayout := 2
	Default cLogoGH := ''
	Default aDados := { { ;
	"123456",;
	"12345678901234567892",;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	Replicate("M",40),;
	CtoD("12/12/07"),;
	Replicate("M",70),;
	"123456789102345",;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"1234567",;
	"999",;
	Replicate("M",40),;
	"MMMMM",;
	Replicate("M",15),;
	Replicate("M",40),;
	"MM",;
	"1234567",;
	"12345-678",;
	"E",;
	{ "00", "COLETIVO" },;
	{ CtoD("12/12/07"), "2210" },;
	{ CtoD("12/12/07"), "2210" },;
	"1",;
	"1",;
	{ "X","X","X","X","X","X","X","X","X" },;
	"1",;
	{ 1, 1 },;
	"123456789102345",;
	99,;
	01,;
	01,;
	"12345",;
	"12345",;
	"12345",;
	"12345",;
	"1",;
	"01",;
	"12345",;
	"1234567",;
	{ CtoD("12/01/06"),CtoD("12/02/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") },;
	{ "0107","0207","0307","0407","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },;
	{ "0607","0707","0807","0907","1007","0507","0507","0507","0507","0507","0507","0507","0507","0507","0507" },;
	{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD","DD"},;
	{ "1234567890","2345678901","3456789012","4567890123","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},;
	{ Replicate("M",60),Replicate("B",60),Replicate("C",60),Replicate("D",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60)},;
	{ 12,1,2,3,4,4,4,4,4,4,4,4,4,4,4},;
	{ "M","A","B","C","D","D","D","D","D","D","D","D","D","D","D"},;
	{ "M","E","F","G","H","D","D","D","D","D","D","D","D","D","D"},;
	{ 111.00,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99,999.99 },;
	{ 99999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11 },;
	{ 11111.11,55555.00,66666.00,77777.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00 },;
	{ "03", "04", "05", "06", "07","08","08","08","08","08","08","08","08","08","08","08","08","08","08","08","08" },;
	{ "02", "03", "04", "05", "06","07","08","08","08","08","08","08","08","08","08","08","08","08","08","08","08" },;
	{ "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102", "123456789102" },;
	{ Replicate("A", 70), Replicate("B", 70), Replicate("C", 70), Replicate("D", 70), Replicate("E", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70), Replicate("M", 70) },;
	{ "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567", "1234567" },;
	{ "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345", "123456789102345" },;
	{ "ES", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP","SC", "DF", "MM", "GO", "SP" },;
	{ "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910", "12345678910" },;
	{ "11", "12", "13", "14", "15", "16", "17", "18", "19" },;
	{ "1234567890", "2345678901", "3456789012", "4567890123", "5678901234", "6789012345", "7890123456", "8901234567", "9012345678" },;
	{ Replicate ("A", 60), Replicate ("B", 60), Replicate ("C", 60), Replicate ("D", 60), Replicate ("E", 60), Replicate ("F", 60), Replicate ("G", 60), Replicate ("H", 60), Replicate ("I", 60) },;
	{ 01, 2, 3, 04, 05, 06, 07, 8, 99 }, ;
	{ Replicate ("J", 20), Replicate ("K", 20), Replicate ("L", 20), Replicate ("M", 20), Replicate ("N", 20), Replicate ("O", 20), Replicate ("P", 20), Replicate ("Q", 20), Replicate ("R", 20) },;
	{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
	{ 199999.99, 299999.99, 399999.99, 499999.99, 599999.99, 699999.99, 799.99, 899999.99, 99.99 },;
	3999999.99,;
	{ "X","X" },;
	199999.99,;
	199999.99,;
	199999.99,;
	199999.99,;
	199999.99,;
	199999.99,;
	199999.99,;
	Replicate("M", 240),;
	CtoD("01/01/07"),;
	CtoD("04/01/07") } }

	If nLayout  == 1 // Ofï¿½cio 2
		nLinMax := 2435
		nColMax := 3705	//3765
	Elseif nLayout == 2   // Papï¿½l A4
		nLinMax	:=	2375
		nColMax	:=	3370 //3365
	Else //Carta
		nLinMax	:=	2435
		nColMax	:=	3175
	Endif

	oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal
	if nLayout == 1 // Oficio 2
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	Else  // Papï¿½l A4 ou Carta
		oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
	Endif

	oPrint	:= TMSPrinter():New(STR0168) //"GUIA DE RESUMO DE INTERNACAO"

	if nLayout ==2
		oPrint:SetPaperSize(9)// Papï¿½l A4
	Elseif nLayout ==3
		oPrint:SetPaperSize(1)// Papï¿½l Carta
	Else
		oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	Endif

	oPrint:Setup()

	oPrint:SetLandscape()

	While lImpnovo

		lImpnovo:=.F.
		nVolta  += 1
		nAte    += nP
		nAte1   += nP1
		nAte2   += nP4


		For nX := 1 To Len(aDados)

			If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 45 To 56
				If Len(aDados[nX, nI]) < nAte
					For nJ := Len(aDados[nX, nI]) + 1 To nAte
						If AllTrim(Str(nI)) $ "45"
							aAdd(aDados[nX, nI], StoD(""))
						ElseIf AllTrim(Str(nI)) $ "51,54,55,56"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			For nI := 57 To 64
				If Len(aDados[nX, nI]) < nAte1
					For nJ := Len(aDados[nX, nI]) + 1 To nAte1
						aAdd(aDados[nX, nI], "")
					Next nJ
				EndIf
			Next nI

			For nI := 65 To 71
				If Len(aDados[nX, nI]) < nAte2
					For nJ := Len(aDados[nX, nI]) + 1 To nAte2
						If AllTrim(Str(nI)) $ "68,70,71"
							aAdd(aDados[nX, nI], 0)
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			nLinIni := 000
			nColIni := 000
			nColA4  := 000
			nCol2A4 := 000

			oPrint:StartPage()		// Inicia uma nova pagina
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½Box Principal                                                 ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½Carrega e Imprime Logotipo da Empresa                         ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papï¿½l A4
				nColA4    := -0335
				nCol2A4   := -0180
			Elseif nLayout == 3// Carta
				nColA4    := -0530
				nCol2A4   := -0180
			Endif

			oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIf(nLayout == 2 .Or. nLayout == 3,nColA4+230,nColA4), STR0169, oFont02n,,,, 2) //"GUIA DE RESUMO DE Internação"
			oPrint:Say(nLinIni + 0090, nColIni + 3000 + nColA4, "2 - "+STR0002, oFont01) //"Nº"
			oPrint:Say(nLinIni + 0070, nColIni + 3096 + nColA4, aDados[nX, 02], oFont03n)

			nLinIni += 60
			oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
			oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+STR0003, oFont01) //"Registro ANS"
			oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 1035)
			oPrint:Say(nLinIni + 0180, nColIni + 0330, "3 - "+STR0170, oFont01) //"Nº Guia de Solicitação"
			oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 03], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 1040, nLinIni + 0269, nColIni + 1345)
			oPrint:Say(nLinIni + 0180, nColIni + 1050, "4 - "+STR0062, oFont01) //"Data da Autorização"
			oPrint:Say(nLinIni + 0210, nColIni + 1060, DtoC(aDados[nX, 04]), oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 1350, nLinIni + 0269, nColIni + 1755)
			oPrint:Say(nLinIni + 0180, nColIni + 1360, "5 - "+STR0063, oFont01) //"Senha"
			oPrint:Say(nLinIni + 0210, nColIni + 1370, aDados[nX, 05], oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 1760, nLinIni + 0269, nColIni + 2165)
			oPrint:Say(nLinIni + 0180, nColIni + 1770, "6 - "+STR0064, oFont01) //"Data Validade da Senha"
			oPrint:Say(nLinIni + 0210, nColIni + 1780, DtoC(aDados[nX, 06]), oFont04)
			oPrint:Box(nLinIni + 0175, nColIni + 2170, nLinIni + 0269, nColIni + 2465)
			oPrint:Say(nLinIni + 0180, nColIni + 2180, "7 - "+STR0004, oFont01) //"Data de Emissão da Guia"
			oPrint:Say(nLinIni + 0210, nColIni + 2190, DtoC(aDados[nX, 07]), oFont04)

			nLinIni += 20
			oPrint:Say(nLinIni + 0274, nColIni + 0010, STR0005, oFont01) //"Dados do Beneficiário"
			oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0425)
			oPrint:Say(nLinIni + 0309, nColIni + 0020, "8 - "+STR0006, oFont01) //"Número da Carteira"
			oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 08], oFont04)
			oPrint:Box(nLinIni + 0304, nColIni + 0430, nLinIni + 0398, nColIni + 1572)
			oPrint:Say(nLinIni + 0309, nColIni + 0440, "9 - "+STR0007, oFont01) //"Plano"
			oPrint:Say(nLinIni + 0339, nColIni + 0450, aDados[nX, 09], oFont04)
			oPrint:Box(nLinIni + 0304, nColIni + 1577, nLinIni + 0398, nColIni + 1835)
			oPrint:Say(nLinIni + 0309, nColIni + 1587, "10 - "+STR0008, oFont01) //"Validade da Carteira"
			oPrint:Say(nLinIni + 0339, nColIni + 1597, DtoC(aDados[nX, 10]), oFont04)

			oPrint:Box(nLinIni + 0403, nColIni + 0010, nLinIni + 0497, nColIni + 3090 + nColA4)
			oPrint:Say(nLinIni + 0408, nColIni + 0020, "11 - "+STR0009, oFont01) //"Nome"
			oPrint:Say(nLinIni + 0438, nColIni + 0030, aDados[nX, 11], oFont04)
			oPrint:Box(nLinIni + 0403, nColIni + 3095 + nColA4, nLinIni + 0497, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0408, nColIni + 3105 + nColA4, "12 - "+STR0010, oFont01) //"Número do Cartão Nacional de Saúde"
			oPrint:Say(nLinIni + 0438, nColIni + 3115 + nColA4, aDados[nX, 12], oFont04)

			nLinIni += 20
			oPrint:Say(nLinIni + 0502, nColIni + 0010, STR0079, oFont01) //"Dados do Contratado Executante"
			oPrint:Box(nLinIni + 0532, nColIni + 0010, nLinIni + 0626, nColIni + 0426)
			oPrint:Say(nLinIni + 0537, nColIni + 0020, "13 - "+STR0129, oFont01) //"Código na Operadora / CNPJ"
			oPrint:Say(nLinIni + 0567, nColIni + 0030, aDados[nX, 13], oFont04)
			oPrint:Box(nLinIni + 0532, nColIni + 0431, nLinIni + 0626, nColIni + 2245)
			oPrint:Say(nLinIni + 0537, nColIni + 0441, "14 - "+STR0013, oFont01) //"Nome do Contratado"
			oPrint:Say(nLinIni + 0567, nColIni + 0451, SubStr(aDados[nX, 14], 1, 65), oFont04)
			oPrint:Box(nLinIni + 0532, nColIni + 2250, nLinIni + 0626, nColIni + 2460)
			oPrint:Say(nLinIni + 0537, nColIni + 2260, "15 - "+STR0014, oFont01) //"Código CNES"
			oPrint:Say(nLinIni + 0567, nColIni + 2270, aDados[nX, 15], oFont04)

			oPrint:Box(nLinIni + 0631, nColIni + 0010, nLinIni + 0725, nColIni + 0132)
			oPrint:Say(nLinIni + 0636, nColIni + 0020, "16 - "+STR0015, oFont01) //"T.L."
			oPrint:Say(nLinIni + 0666, nColIni + 0030, aDados[nX, 16], oFont04)
			oPrint:Box(nLinIni + 0631, nColIni + 0137, nLinIni + 0725, nColIni + 2032 + nColA4)
			oPrint:Say(nLinIni + 0636, nColIni + 0147, "17-18-19 - "+STR0016, oFont01) //"Logradouro - Número - Complemento"
			oPrint:Say(nLinIni + 0666, nColIni + 0157, SubStr(AllTrim(aDados[nX, 17]) + IIf(!Empty(aDados[nX, 18]), ", ","") + AllTrim(aDados[nX, 18]) + IIf(!Empty(aDados[nX, 19]), " - ","") + AllTrim(aDados[nX, 19]), 1, 76), oFont04)
			oPrint:Box(nLinIni + 0631, nColIni + 2037 + nColA4, nLinIni + 0725, nColIni + 3165 + nColA4)
			oPrint:Say(nLinIni + 0636, nColIni + 2047 + nColA4, "20 - "+STR0017, oFont01) //"Município"
			oPrint:Say(nLinIni + 0666, nColIni + 2057 + nColA4, SubStr(aDados[nX, 20], 1, 39), oFont04)
			oPrint:Box(nLinIni + 0631, nColIni + 3170 + nColA4, nLinIni + 0725, nColIni + 3269 + nColA4)
			oPrint:Say(nLinIni + 0636, nColIni + 3180 + nColA4, "21 - "+STR0018, oFont01) //"UF"
			oPrint:Say(nLinIni + 0666, nColIni + 3190 + nColA4, aDados[nX, 21], oFont04)
			oPrint:Box(nLinIni + 0631, nColIni + 3274 + nColA4, nLinIni + 0725, nColIni + 3502 + nColA4)
			oPrint:Say(nLinIni + 0636, nColIni + 3284 + nColA4, "22 - "+STR0171, oFont01) //"Cód. IBGE"
			oPrint:Say(nLinIni + 0666, nColIni + 3294 + nColA4, aDados[nX, 22], oFont04)
			oPrint:Box(nLinIni + 0631, nColIni + 3507 + nColA4, nLinIni + 0725, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0636, nColIni + 3517 + nColA4, "23 - "+STR0020, oFont01) //"CEP"
			oPrint:Say(nLinIni + 0666, nColIni + 3527 + nColA4, aDados[nX, 23], oFont04)

			nLinIni += 20
			oPrint:Say(nLinIni + 0730, nColIni + 0010, STR0172, oFont01) //"Dados da Internação"
			oPrint:Box(nLinIni + 0760, nColIni + 0010, nLinIni + 0854, nColIni + 0465)
			oPrint:Say(nLinIni + 0765, nColIni + 0020, "24 - "+STR0131, oFont01) //"Carï¿½ter da Internação"
			oPrint:Line(nLinIni + 0790, nColIni + 0030 + nColA4, nLinIni + 0837, nColIni + 0030 + nColA4)
			oPrint:Line(nLinIni + 0837, nColIni + 0030 + nColA4, nLinIni + 0837, nColIni + 0077 + nColA4)
			oPrint:Line(nLinIni + 0790, nColIni + 0077 + nColA4, nLinIni + 0837, nColIni + 0077 + nColA4)
			oPrint:Say(nLinIni + 0795, nColIni + 0043, aDados[nX, 24], oFont04)
			oPrint:Say(nLinIni + 0805, nColIni + 0090, STR0132+"  "+STR0133, oFont01) //"E - Eletiva"###"U - Urgência/Emergï¿½ncia"
			oPrint:Line(nLinIni + 0792, nColIni + 0030, nLinIni + 0837, nColIni + 0030)
			oPrint:Line(nLinIni + 0837, nColIni + 0030, nLinIni + 0837, nColIni + 0077)
			oPrint:Line(nLinIni + 0792, nColIni + 0077, nLinIni + 0837, nColIni + 0077)
			oPrint:Box(nLinIni + 0760, nColIni + 0470, nLinIni + 0854, nColIni + 1445 + nColA4)
			oPrint:Say(nLinIni + 0765, nColIni + 0480, "25 - "+STR0173, oFont01) //"Tipo Acomodaï¿½ï¿½o Autorizada"
			oPrint:Say(nLinIni + 0795, nColIni + 0490, aDados[nX, 25, 1] + "-" + aDados[nX, 25, 2], oFont04)
			oPrint:Box(nLinIni + 0760, nColIni + 1450 + nColA4, nLinIni + 0854, nColIni + 1865 + nColA4)
			oPrint:Say(nLinIni + 0765, nColIni + 1460 + nColA4, "26 - "+STR0174, oFont01) //"Data/Hora da Internação"
			oPrint:Say(nLinIni + 0795, nColIni + 1470 + nColA4, DtoC(aDados[nX, 26,1]) + " " + Transform(aDados[nX, 26,2], "@R 99:99"), oFont04)
			oPrint:Box(nLinIni + 0760, nColIni + 1870 + nColA4, nLinIni + 0854, nColIni + 2285 + nColA4)
			oPrint:Say(nLinIni + 0765, nColIni + 1880 + nColA4, "27 - "+STR0175, oFont01) //"Data/Hora da Saída Internação"
			oPrint:Say(nLinIni + 0795, nColIni + 1890 + nColA4, DtoC(aDados[nX, 27,1]) + " " + Transform(aDados[nX, 27,2], "@R 99:99"), oFont04)
			oPrint:Box(nLinIni + 0760, nColIni + 2290 + nColA4, nLinIni + 0854, nColIni + 3055 + nColA4)
			oPrint:Say(nLinIni + 0765, nColIni + 2300 + nColA4, "28 - "+STR0176, oFont01) //"Tipo Internação"
			oPrint:Line(nLinIni + 0790, nColIni + 2310 + nColA4, nLinIni + 0837, nColIni + 2310 + nColA4)
			oPrint:Line(nLinIni + 0837, nColIni + 2310 + nColA4, nLinIni + 0837, nColIni + 2357 + nColA4)
			oPrint:Line(nLinIni + 0790, nColIni + 2357 + nColA4, nLinIni + 0837, nColIni + 2357 + nColA4)
			oPrint:Say(nLinIni + 0795, nColIni + 2323 + nColA4, aDados[nX, 28], oFont04)
			oPrint:Say(nLinIni + 0805, nColIni + 2370 + nColA4, "1 - "+STR0135+"  "+"2 - "+STR0136+"  "+"3 - "+STR0137+"  "+"4 - "+STR0138+"  "+"5 - "+STR0139, oFont01) //"Clínica"###"Cirúrgica"###"Obstétrica"###"Pediátrica"###"Psiquiátrica"
			oPrint:Box(nLinIni + 0760, nColIni + 3060 + nColA4, nLinIni + 0854, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0765, nColIni + 3070 + nColA4, "29 - "+STR0140, oFont01) //"Regime de Internação"
			oPrint:Line(nLinIni + 0790, nColIni + 3080 + nColA4, nLinIni + 0837, nColIni + 3080 + nColA4)
			oPrint:Line(nLinIni + 0837, nColIni + 3080 + nColA4, nLinIni + 0837, nColIni + 3127 + nColA4)
			oPrint:Line(nLinIni + 0790, nColIni + 3127 + nColA4, nLinIni + 0837, nColIni + 3127 + nColA4)
			oPrint:Say(nLinIni + 0795, nColIni + 3093 + nColA4, aDados[nX, 29], oFont04)
			oPrint:Say(nLinIni + 0805, nColIni + 3140 + nColA4, "1 - "+STR0141+"  "+"2 - "+STR0142+"  "+"3- "+STR0143, oFont01) //"Hospitalar"###"Hospital-dia"###"Domiciliar"

			oPrint:Box(nLinIni + 0859, nColIni + 0010, nLinIni + 0948, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0864, nColIni + 0020, '30 - '+STR0177, oFont01) //'Internação Obstétrica - (selecione mais de um se necessário com "X")'
			oPrint:Line(nLinIni + 0889, nColIni + 0030, nLinIni + 0936, nColIni + 0030)
			oPrint:Line(nLinIni + 0936, nColIni + 0030, nLinIni + 0936, nColIni + 0077)
			oPrint:Line(nLinIni + 0889, nColIni + 0077, nLinIni + 0936, nColIni + 0077)
			oPrint:Say(nLinIni + 0894, nColIni + 0043, aDados[nX, 30,1], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 0090, "- "+STR0178, oFont01) //"Em gestação"
			oPrint:Line(nLinIni + 0889, nColIni + 0240, nLinIni + 0936, nColIni + 0240)
			oPrint:Line(nLinIni + 0936, nColIni + 0240, nLinIni + 0936, nColIni + 0287)
			oPrint:Line(nLinIni + 0889, nColIni + 0287, nLinIni + 0936, nColIni + 0287)
			oPrint:Say(nLinIni + 0894, nColIni + 0253, aDados[nX, 30,2], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 0300, "- "+STR0179, oFont01) //"Aborto"
			oPrint:Line(nLinIni + 0889, nColIni + 0390, nLinIni + 0936, nColIni + 0390)
			oPrint:Line(nLinIni + 0936, nColIni + 0390, nLinIni + 0936, nColIni + 0437)
			oPrint:Line(nLinIni + 0889, nColIni + 0437, nLinIni + 0936, nColIni + 0437)
			oPrint:Say(nLinIni + 0894, nColIni + 0403, aDados[nX, 30,3], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 0450, "- "+STR0180, oFont01) //"Transtorno materno relacionado a gravidez"
			oPrint:Line(nLinIni + 0889, nColIni + 0880, nLinIni + 0936, nColIni + 0880)
			oPrint:Line(nLinIni + 0936, nColIni + 0880, nLinIni + 0936, nColIni + 0927)
			oPrint:Line(nLinIni + 0889, nColIni + 0927, nLinIni + 0936, nColIni + 0927)
			oPrint:Say(nLinIni + 0894, nColIni + 0893, aDados[nX, 30,4], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 0940, "- "+STR0181, oFont01) //""Complic. Puerpério""
			oPrint:Line(nLinIni + 0889, nColIni + 1160, nLinIni + 0936, nColIni + 1160)
			oPrint:Line(nLinIni + 0936, nColIni + 1160, nLinIni + 0936, nColIni + 1207)
			oPrint:Line(nLinIni + 0889, nColIni + 1207, nLinIni + 0936, nColIni + 1207)
			oPrint:Say(nLinIni + 0894, nColIni + 1173, aDados[nX, 30,5], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 1220, "- "+STR0182, oFont01) //"Atend. ao RN na sala de parto"
			oPrint:Line(nLinIni + 0889, nColIni + 1540, nLinIni + 0936, nColIni + 1540)
			oPrint:Line(nLinIni + 0936, nColIni + 1540, nLinIni + 0936, nColIni + 1587)
			oPrint:Line(nLinIni + 0889, nColIni + 1587, nLinIni + 0936, nColIni + 1587)
			oPrint:Say(nLinIni + 0894, nColIni + 1553, aDados[nX, 30,6], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 1600, "- "+STR0183, oFont01) //"Complicacão Neonatal"
			oPrint:Line(nLinIni + 0889, nColIni + 1850, nLinIni + 0936, nColIni + 1850)
			oPrint:Line(nLinIni + 0936, nColIni + 1850, nLinIni + 0936, nColIni + 1897)
			oPrint:Line(nLinIni + 0889, nColIni + 1897, nLinIni + 0936, nColIni + 1897)
			oPrint:Say(nLinIni + 0894, nColIni + 1863, aDados[nX, 30,7], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 1910, "- "+STR0184, oFont01) //"Bx. Peso < 2,5 Kg"
			oPrint:Line(nLinIni + 0889, nColIni + 2130, nLinIni + 0936, nColIni + 2130)
			oPrint:Line(nLinIni + 0936, nColIni + 2130, nLinIni + 0936, nColIni + 2177)
			oPrint:Line(nLinIni + 0889, nColIni + 2177, nLinIni + 0936, nColIni + 2177)
			oPrint:Say(nLinIni + 0894, nColIni + 2143, aDados[nX, 30,8], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 2190, "- "+STR0185, oFont01) //"Parto Cesáreo"
			oPrint:Line(nLinIni + 0889, nColIni + 2380, nLinIni + 0936, nColIni + 2380)
			oPrint:Line(nLinIni + 0936, nColIni + 2380, nLinIni + 0936, nColIni + 2427)
			oPrint:Line(nLinIni + 0889, nColIni + 2427, nLinIni + 0936, nColIni + 2427)
			oPrint:Say(nLinIni + 0894, nColIni + 2393, aDados[nX, 30,9], oFont04)
			oPrint:Say(nLinIni + 0904, nColIni + 2440, "- "+STR0186, oFont01) //"Parto Normal"

			oPrint:Box(nLinIni + 0953, nColIni + 0010, nLinIni + 1047, nColIni + 1060)
			oPrint:Say(nLinIni + 0958, nColIni + 0020, "31 - "+STR0187, oFont01) //"Se óbito em mulher"
			oPrint:Line(nLinIni + 0983, nColIni + 0030, nLinIni + 1030, nColIni + 0030)
			oPrint:Line(nLinIni + 1030, nColIni + 0030, nLinIni + 1030, nColIni + 0077)
			oPrint:Line(nLinIni + 0983, nColIni + 0077, nLinIni + 1030, nColIni + 0077)
			oPrint:Say(nLinIni + 0988, nColIni + 0043, aDados[nX, 31], oFont04)
			oPrint:Say(nLinIni + 0998, nColIni + 0090, "1 - "+STR0188+"  "+"2 - "+STR0189+"  "+"3 - "+STR0190, oFont01) //"Grávida"###"até 42 dias após término gestação"###"de 43 dias a 12 meses após término gestação"
			oPrint:Box(nLinIni + 0953, nColIni + 1065, nLinIni + 1047, nColIni + 1800)
			oPrint:Say(nLinIni + 0958, nColIni + 1075, "32 - "+STR0191, oFont01) //"Se óbito neonatal"
			oPrint:Line(nLinIni + 0983, nColIni + 1085, nLinIni + 1030, nColIni + 1085)
			oPrint:Line(nLinIni + 1030, nColIni + 1085, nLinIni + 1030, nColIni + 1132)
			oPrint:Line(nLinIni + 0983, nColIni + 1132, nLinIni + 1030, nColIni + 1132)
			oPrint:Say(nLinIni + 0988, nColIni + 1125, Transform(aDados[nX, 32,1], "@E 99"), oFont04,,,,1)
			oPrint:Say(nLinIni + 0998, nColIni + 1145, "- "+STR0192, oFont01) //"Qtde. óbito neonatal precoce"
			oPrint:Line(nLinIni + 0983, nColIni + 1455, nLinIni + 1030, nColIni + 1455)
			oPrint:Line(nLinIni + 1030, nColIni + 1455, nLinIni + 1030, nColIni + 1502)
			oPrint:Line(nLinIni + 0983, nColIni + 1502, nLinIni + 1030, nColIni + 1502)
			oPrint:Say(nLinIni + 0988, nColIni + 1495, Transform(aDados[nX, 32,2], "@E 99"), oFont04,,,,1)
			oPrint:Say(nLinIni + 0998, nColIni + 1515, "- "+STR0193, oFont01) //"Qtde. óbito neonatal tardio"
			oPrint:Box(nLinIni + 0953, nColIni + 1805, nLinIni + 1047, nColIni + 2125 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0))
			oPrint:Say(nLinIni + 0958, nColIni + 1815, "33 - "+STR0194, oFont01) //"Não Decl.Nasc.Vivos"
			oPrint:Say(nLinIni + 0988, nColIni + 1825 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+80,0), aDados[nX, 33], oFont04)
			oPrint:Box(nLinIni + 0953, nColIni + 2130 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), nLinIni + 1047, nColIni + 2530 + nCol2A4/2)
			oPrint:Say(nLinIni + 0958, nColIni + 2140 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), "34 - "+STR0195, oFont01) //"Qtde.Nasc.Vivos a Termo"
			oPrint:Say(nLinIni + 0988, nColIni + 2350 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), Transform(aDados[nX, 34], "@E 9999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 0953, nColIni + 2535 + nCol2A4/2, nLinIni + 1047, nColIni + 2935 + nCol2A4/2)
			oPrint:Say(nLinIni + 0958, nColIni + 2545 + nCol2A4/2, "35 - "+STR0196, oFont01) //"Qtde.Nasc.Mortos"
			oPrint:Say(nLinIni + 0988, nColIni + 2755 + nCol2A4/2, Transform(aDados[nX, 35], "@E 9999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 0953, nColIni + 2940 + nCol2A4/2, nLinIni + 1047, nColIni + 3340 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4+5,0))
			oPrint:Say(nLinIni + 0958, nColIni + 2950 + nCol2A4/2, "36 - "+STR0197, oFont01) //"Qtde.Nasc.Vivos Prematuro"
			oPrint:Say(nLinIni + 0988, nColIni + 3160 + nCol2A4/2, Transform(aDados[nX, 36], "@E 9999.99"), oFont04,,,,1)

			nLinIni += 20
			oPrint:Say(nLinIni + 1052, nColIni + 0010, STR0198, oFont01) //"Dados da Saída da Internção"
			oPrint:Box(nLinIni + 1082, nColIni + 0010, nLinIni + 1176, nColIni + 0285)
			oPrint:Say(nLinIni + 1087, nColIni + 0020, "37 - "+STR0149, oFont01) //"CID 10 Principal"
			oPrint:Say(nLinIni + 1117, nColIni + 0030, aDados[nX, 37], oFont04)
			oPrint:Box(nLinIni + 1082, nColIni + 0290, nLinIni + 1176, nColIni + 0565)
			oPrint:Say(nLinIni + 1087, nColIni + 0300, "38 - "+STR0150, oFont01) //"CID 10 (2)"
			oPrint:Say(nLinIni + 1117, nColIni + 0310, aDados[nX, 38], oFont04)
			oPrint:Box(nLinIni + 1082, nColIni + 0570, nLinIni + 1176, nColIni + 0845)
			oPrint:Say(nLinIni + 1087, nColIni + 0580, "39 - "+STR0151, oFont01) //"CID 10 (3)"
			oPrint:Say(nLinIni + 1117, nColIni + 0590, aDados[nX, 39], oFont04)
			oPrint:Box(nLinIni + 1082, nColIni + 0850, nLinIni + 1176, nColIni + 1115)
			oPrint:Say(nLinIni + 1087, nColIni + 0860, "40 - "+STR0152, oFont01) //"CID 10 (4)"
			oPrint:Say(nLinIni + 1117, nColIni + 0870, aDados[nX, 40], oFont04)
			oPrint:Box(nLinIni + 1082, nColIni + 1120, nLinIni + 1176, nColIni + 1900)
			oPrint:Say(nLinIni + 1087, nColIni + 1130, "41 - "+STR0199, oFont01) //"Indicador de Acidente"
			oPrint:Line(nLinIni + 1112, nColIni + 1140, nLinIni + 1159, nColIni + 1140)
			oPrint:Line(nLinIni + 1159, nColIni + 1140, nLinIni + 1159, nColIni + 1182)
			oPrint:Line(nLinIni + 1112, nColIni + 1182, nLinIni + 1159, nColIni + 1182)
			oPrint:Say(nLinIni + 1117, nColIni + 1153, aDados[nX, 41], oFont04)
			oPrint:Say(nLinIni + 1127, nColIni + 1200, "0 - "+STR0034+"   "+"1 - "+STR0035+"   "+"2 - "+STR0036, oFont01) //"Acidente ou doença relacionado ao trabalho"###"Trânsito"###"Outros"
			oPrint:Box(nLinIni + 1082, nColIni + 1905, nLinIni + 1176, nColIni + 2205)
			oPrint:Say(nLinIni + 1087, nColIni + 1915, "42 - "+STR0200, oFont01) //"Motivo Saída"
			oPrint:Say(nLinIni + 1117, nColIni + 1925, aDados[nX, 42], oFont04)
			oPrint:Box(nLinIni + 1082, nColIni + 2210, nLinIni + 1176, nColIni + 2510)
			oPrint:Say(nLinIni + 1087, nColIni + 2220, "43 - "+STR0201, oFont01) //"CID 10 óbito"
			oPrint:Say(nLinIni + 1117, nColIni + 2230, aDados[nX, 43], oFont04)
			oPrint:Box(nLinIni + 1082, nColIni + 2515, nLinIni + 1176, nColIni + 3000)
			oPrint:Say(nLinIni + 1087, nColIni + 2525, "44 - "+STR0202, oFont01) //"Não Declaração do óbito"
			oPrint:Say(nLinIni + 1117, nColIni + 2535, aDados[nX, 44], oFont04)

			nLinIni += 20
			oPrint:Say(nLinIni + 1181, nColIni + 0010, STR0097, oFont01) //"Procedimentos e Exames Realizados"
			oPrint:Box(nLinIni + 1211, nColIni + 0010, nLinIni + 1501, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 1216, nColIni + 0020, "45 - "+STR0098, oFont01) //"Data"
			oPrint:Say(nLinIni + 1216, nColIni + 0205, "46 - "+STR0099, oFont01) //"Hora Inicial"
			oPrint:Say(nLinIni + 1216, nColIni + 0380, "47 - "+STR0100, oFont01) //"Hora Final"
			oPrint:Say(nLinIni + 1216, nColIni + 0540, "48 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say(nLinIni + 1216, nColIni + 0660, "49 - "+STR0075, oFont01) //"Código do Procedimento"
			oPrint:Say(nLinIni + 1216, nColIni + 0940, "50 - "+STR0076, oFont01) //"Descrição"
			oPrint:Say(nLinIni + 1216, nColIni + 2825 + nColA4, "51 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say(nLinIni + 1216, nColIni + 2855 + nColA4, "52 - "+STR0102, oFont01) //"Via"
			oPrint:Say(nLinIni + 1216, nColIni + 2945 + nColA4, "53 - "+STR0103, oFont01) //"Tec."
			oPrint:Say(nLinIni + 1216, nColIni + 3235 + nColA4, "54 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
			oPrint:Say(nLinIni + 1216, nColIni + 3465 + nColA4, "55 - "+STR0105, oFont01,,,,1) //"Valor Unitï¿½rio - R$"
			oPrint:Say(nLinIni + 1216, nColIni + 3675 + nColA4, "56 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni
			if nVolta=1
				nP:=1
			Endif
			nT:=nP+4
			For nI := nP To nT
				if nVolta <> 1
					nN:=nI-(15*nVolta-15)
					oPrint:Say(nLinIni + 1271, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say(nLinIni + 1271, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
				Endif
				oPrint:Say(nLinIni + 1266, nColIni + 0065, IIf(Empty(aDados[nX, 45, nI]), "", DtoC(aDados[nX, 45, nI])), oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 0205, IIf(Empty(aDados[nX, 46, nI]), "", Transform(aDados[nX, 46, nI], "@R 99:99")), oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 0380, IIf(Empty(aDados[nX, 47, nI]), "", Transform(aDados[nX, 47, nI], "@R 99:99")), oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 0540, aDados[nX, 48, nI], oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 0660, aDados[nX, 49, nI], oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 0940, aDados[nX, 50, nI], oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 2825 + nColA4, IIf((aDados[nX, 51, nI])=0, "", Transform(aDados[nX, 51, nI], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 1266, nColIni + 2855 + nColA4, aDados[nX, 52, nI], oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 2945 + nColA4, aDados[nX, 53, nI], oFont04)
				oPrint:Say(nLinIni + 1266, nColIni + 3235 + nColA4, IIf((aDados[nX, 54, nI])=0, "", Transform(aDados[nX, 54, nI], "@E 999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 1266, nColIni + 3465 + nColA4, IIf((aDados[nX, 55, nI])=0, "", Transform(aDados[nX, 55, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 1266, nColIni + 3675 + nColA4, IIf((aDados[nX, 56, nI])=0, "", Transform(aDados[nX, 56, nI], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nI

			nLinIni := nOldLinIni
			nP:=nI

			nLinIni += 20
			oPrint:Say(nLinIni + 1506, nColIni + 0010, STR0203, oFont01) //"Identificaï¿½ï¿½o da Equipe"
			oPrint:Box(nLinIni + 1536, nColIni + 0010, nLinIni + 1866, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 1541, nColIni + 0020, "57 - "+STR0204, oFont01) //"Seq.Ref"
			oPrint:Say(nLinIni + 1541, nColIni + 0180, "58 - "+STR0205, oFont01) //"Gr.Part."
			oPrint:Say(nLinIni + 1541, nColIni + 0320, "59 - "+STR0206, oFont01) //"Código na Operadora/CPF"
			oPrint:Say(nLinIni + 1541, nColIni + 0670, "60 - "+STR0207, oFont01) //"Nome do Profissional"
			oPrint:Say(nLinIni + 1541, nColIni + 2640 + nColA4, "61 - "+STR0208, oFont01) //"Conselho Prof."
			oPrint:Say(nLinIni + 1541, nColIni + 2990 + nColA4, "62 - "+STR0209, oFont01) //"Número Conselho"
			oPrint:Say(nLinIni + 1541, nColIni + 3340 + nColA4, "63 - "+STR0018, oFont01) //"UF"
			oPrint:Say(nLinIni + 1541, nColIni + 3440 + nColA4, "64 - "+STR0210, oFont01) //"CPF"

			nOldLinIni := nLinIni
			if nVolta=1
				nP1:=1
			Endif
			nT1:=nP1+5
			For nI := nP1 To nT1
				oPrint:Say(nLinIni + 1591, nColIni + 0020, aDados[nX, 57, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 0180, aDados[nX, 58, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 0320, aDados[nX, 59, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 0670, aDados[nX, 60, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 2640 + nColA4, aDados[nX, 61, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 2990 + nColA4, aDados[nX, 62, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 3340 + nColA4, aDados[nX, 63, nI], oFont04)
				oPrint:Say(nLinIni + 1591, nColIni + 3440 + nColA4, IIf(Empty(aDados[nX, 64, nI]), "", Transform(aDados[nX, 64, nI], "@R 999.999.999-99")), oFont04)
				nLinIni += 40
			Next nI

			nP1:=nI
			nLinIni := nOldLinIni

			oPrint:Box(nLinIni + 1871, nColIni + 0010, nLinIni + 1965, nColIni + 0350)
			oPrint:Say(nLinIni + 1876, nColIni + 0020, "73 - "+STR0211, oFont01) //"Tipo Faturamento R$"
			oPrint:Line(nLinIni + 1901, nColIni + 0030, nLinIni + 1948, nColIni + 0030)
			oPrint:Line(nLinIni + 1948, nColIni + 0030, nLinIni + 1948, nColIni + 0077)
			oPrint:Line(nLinIni + 1901, nColIni + 0077, nLinIni + 1948, nColIni + 0077)
			oPrint:Say(nLinIni + 1906, nColIni + 0043, aDados[nX, 73,1], oFont04)
			oPrint:Say(nLinIni + 1916, nColIni + 0090, "- "+STR0212, oFont01) //"Total"
			oPrint:Line(nLinIni + 1901, nColIni + 0180, nLinIni + 1948, nColIni + 0180)
			oPrint:Line(nLinIni + 1948, nColIni + 0180, nLinIni + 1948, nColIni + 0227)
			oPrint:Line(nLinIni + 1901, nColIni + 0227, nLinIni + 1948, nColIni + 0227)
			oPrint:Say(nLinIni + 1906, nColIni + 0193, aDados[nX, 73,2], oFont04)
			oPrint:Say(nLinIni + 1916, nColIni + 0240, "- "+STR0213, oFont01) //"Parcial"

			oPrint:Box(nLinIni + 1871, nColIni + 0355, nLinIni + 1965, nColIni + 0827 + nColA4/3)
			oPrint:Say(nLinIni + 1876, nColIni + 0365, "74 - "+STR0108, oFont01) //"Total Procedimentos R$"
			oPrint:Say(nLinIni + 1906, nColIni + 0807 + nColA4/3, Transform(aDados[nX, 74], "@E 999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 1871, nColIni + 0832 + nColA4/3, nLinIni + 1965, nColIni + 1304 + nColA4/2)
			oPrint:Say(nLinIni + 1876, nColIni + 0842 + nColA4/3, "75 - "+STR0112, oFont01) //"Total Diï¿½rias R$"
			oPrint:Say(nLinIni + 1906, nColIni + 1284 + nColA4/2, Transform(aDados[nX, 75], "@E 999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 1871, nColIni + 1309 + nColA4/2, nLinIni + 1965, nColIni + 1781 + nColA4/2)
			oPrint:Say(nLinIni + 1876, nColIni + 1319 + nColA4/2, "76 - "+STR0109, oFont01) //"Total Taxas e Aluguï¿½is R$"
			oPrint:Say(nLinIni + 1906, nColIni + 1761 + nColA4/2, Transform(aDados[nX, 76], "@E 999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 1871, nColIni + 1786 + nColA4/2, nLinIni + 1965, nColIni + 2258 + nColA4/2)
			oPrint:Say(nLinIni + 1876, nColIni + 1796 + nColA4/2, "77 - "+STR0110, oFont01) //"Total Materiais R$"
			oPrint:Say(nLinIni + 1906, nColIni + 2238 + nColA4/2, Transform(aDados[nX, 77], "@E 999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 1871, nColIni + 2263 + nColA4/2, nLinIni + 1965, nColIni + 2735 + nColA4/2)
			oPrint:Say(nLinIni + 1876, nColIni + 2273 + nColA4/2, "78 - "+STR0111, oFont01) //"Total Medicamentos R$"
			oPrint:Say(nLinIni + 1906, nColIni + 2715 + nColA4/2, Transform(aDados[nX, 78], "@E 999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 1871, nColIni + 2740 + nColA4/2, nLinIni + 1965, nColIni + 3212 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2))
			oPrint:Say(nLinIni + 1876, nColIni + 2750 + nColA4/2, "79 - "+STR0113, oFont01) //"Total Gases Medicinais R$"
			oPrint:Say(nLinIni + 1906, nColIni + 3192 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), Transform(aDados[nX, 79], "@E 999,999.99"), oFont04,,,,1)
			oPrint:Box(nLinIni + 1871, nColIni + 3217 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), nLinIni + 1965, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 1876, nColIni + 3227 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), "80 - "+STR0214, oFont01) //"Total Geral R$"
			oPrint:Say(nLinIni + 1906, nColIni + 3675 + nColA4, Transform(aDados[nX, 80], "@E 999,999.99"), oFont04,,,,1)

			oPrint:Box(nLinIni + 1970, nColIni + 0010, nLinIni + 2158, nColIni + 1340)
			oPrint:Say(nLinIni + 1975, nColIni + 0020, "82 - "+STR0215, oFont01) //"Data e Assinatura do Contratado"
			oPrint:Say(nLinIni + 2005, nColIni + 0030, DtoC(aDados[nX, 82]), oFont04)
			oPrint:Box(nLinIni + 1970, nColIni + 1345, nLinIni + 2158, nColIni + 2695)
			oPrint:Say(nLinIni + 1975, nColIni + 1355, "83 - "+STR0216, oFont01) //"Data e Assinatura do(s) Auditor(es) da Operadora"
			oPrint:Say(nLinIni + 2005, nColIni + 1365, DtoC(aDados[nX, 83]), oFont04)

			oPrint:EndPage()	// Finaliza a pagina

			//  Verso da Guia
			oPrint:StartPage()	// Inicia uma nova pagina

			nLinIni := 0
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¿
			//ï¿½Box Principal                                                 ï¿½
			//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
			oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

			nLinIni += 20
			oPrint:Say(nLinIni + 0010, nColIni + 0010, STR0217, oFont01) //"Procedimentos e Exames Realizados (Continuaï¿½ï¿½o)"
			oPrint:Box(nLinIni + 0040, nColIni + 0010, nLinIni + 0530, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0045, nColIni + 0020, "45 - "+STR0098, oFont01) //"Data"
			oPrint:Say(nLinIni + 0045, nColIni + 0205, "46 - "+STR0099, oFont01) //"Hora Inicial"
			oPrint:Say(nLinIni + 0045, nColIni + 0380, "47 - "+STR0100, oFont01) //"Hora Final"
			oPrint:Say(nLinIni + 0045, nColIni + 0540, "48 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say(nLinIni + 0045, nColIni + 0660, "49 - "+STR0075, oFont01) //"Código do Procedimento"
			oPrint:Say(nLinIni + 0045, nColIni + 0940, "50 - "+STR0076, oFont01) //"Descrição"
			oPrint:Say(nLinIni + 0045, nColIni + 2855 + nColA4, "51 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say(nLinIni + 0045, nColIni + 2885 + nColA4, "52 - "+STR0102, oFont01) //"Via"
			oPrint:Say(nLinIni + 0045, nColIni + 2975 + nColA4, "53 - "+STR0103, oFont01) //"Tec."
			oPrint:Say(nLinIni + 0045, nColIni + 3245 + nColA4, "54 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
			oPrint:Say(nLinIni + 0045, nColIni + 3465 + nColA4, "55 - "+STR0105, oFont01,,,,1) //"Valor Unitï¿½rio - R$"
			oPrint:Say(nLinIni + 0045, nColIni + 3675 + nColA4, "56 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni

			if nVolta =1
				nP:=6
			Endif
			nT2:=nP+9

			For nI := nP To nT2
				if nVolta<>1
					nN:=nI-((15*nVolta)-15)
					oPrint:Say(nLinIni + 0100, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
				Else
					oPrint:Say(nLinIni + 0100, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
				Endif
				oPrint:Say(nLinIni + 0095, nColIni + 0065, if (Empty(aDados[nX, 45, nI]),"",DtoC(aDados[nX, 45, nI])), oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 0205, if (Empty(aDados[nX, 46, nI]),"",Transform(aDados[nX, 46, nI], "@R 99:99")), oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 0380, if (Empty(aDados[nX, 47, nI]),"",Transform(aDados[nX, 47, nI], "@R 99:99")), oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 0540, aDados[nX, 48, nI], oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 0660, aDados[nX, 49, nI], oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 0940, aDados[nX, 50, nI], oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 2855 + nColA4, IIf((aDados[nX, 51, nI])=0, "", Transform(aDados[nX, 51, nI], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0095, nColIni + 2885 + nColA4, aDados[nX, 52, nI], oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 2975 + nColA4, aDados[nX, 53, nI], oFont04)
				oPrint:Say(nLinIni + 0095, nColIni + 3245 + nColA4, IIf((aDados[nX, 54, nI])=0, "", Transform(aDados[nX, 54, nI], "@E 999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0095, nColIni + 3465 + nColA4, IIf((aDados[nX, 55, nI])=0, "", Transform(aDados[nX, 55, nI], "@E 99,999,999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 0095, nColIni + 3675 + nColA4, IIf((aDados[nX, 56, nI])=0, "", Transform(aDados[nX, 56, nI], "@E 99,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nI

			nP:=nI

			if nVolta=1
				nP3:=len(aDados[nX,49])
			Endif

			if nP3 >nI-1
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			nLinIni += 20
			oPrint:Say(nLinIni + 0535, nColIni + 0010, STR0218, oFont01) //"Identificaï¿½ï¿½o da Equipe (Continuaï¿½ï¿½o)"
			oPrint:Box(nLinIni + 0565, nColIni + 0010, nLinIni + 1215, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 0570, nColIni + 0020, "57 - "+STR0204, oFont01) //"Seq.Ref"
			oPrint:Say(nLinIni + 0570, nColIni + 0180, "58 - "+STR0205, oFont01) //"Gr.Part."
			oPrint:Say(nLinIni + 0570, nColIni + 0320, "59 - "+STR0206, oFont01) //"Código na Operadora/CPF"
			oPrint:Say(nLinIni + 0570, nColIni + 0670, "60 - "+STR0207, oFont01) //"Nome do Profissional"
			oPrint:Say(nLinIni + 0570, nColIni + 2640 + nColA4, "61 - "+STR0208, oFont01) //"Conselho Prof."
			oPrint:Say(nLinIni + 0570, nColIni + 2990 + nColA4, "62 - "+STR0209, oFont01) //"Número Conselho"
			oPrint:Say(nLinIni + 0570, nColIni + 3340 + nColA4, "63 - "+STR0018, oFont01) //"UF"
			oPrint:Say(nLinIni + 0570, nColIni + 3440 + nColA4, "64 - "+STR0210, oFont01) //"CPF"

			nOldLinIni := nLinIni
			if nVolta =1
				nP1:=7
			Endif
			nT3:=nP1+13

			For nI := nP1 To nT3
				oPrint:Say(nLinIni + 0620, nColIni + 0020, aDados[nX, 57, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 0180, aDados[nX, 58, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 0320, aDados[nX, 59, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 0670, aDados[nX, 60, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 2640 + nColA4, aDados[nX, 61, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 2990 + nColA4, aDados[nX, 62, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 3340 + nColA4, aDados[nX, 63, nI], oFont04)
				oPrint:Say(nLinIni + 0620, nColIni + 3440 + nColA4, IIf(Empty(aDados[nX, 57, nI]), "", Transform(aDados[nX, 64, nI], "@R 999.999.999-99")), oFont04)
				nLinIni += 40
			Next nI

			nP1:=nI

			if nVolta=1
				nP2:=len(aDados[nX,57])
			Endif

			if nP2 >nI-1
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			nLinIni += 20
			oPrint:Say(nLinIni + 1220, nColIni + 0020, STR0122, oFont01) //"OPM Utilizados"
			oPrint:Box(nLinIni + 1250, nColIni + 0010, nLinIni + 1540, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 1255, nColIni + 0020, "65 - "+STR0074, oFont01) //"Tabela"
			oPrint:Say(nLinIni + 1255, nColIni + 0160, "66 - "+STR0119, oFont01) //"Código do OPM"
			oPrint:Say(nLinIni + 1255, nColIni + 0410, "67 - "+STR0120, oFont01) //"Descrição OPM"
			oPrint:Say(nLinIni + 1255, nColIni + 2465 + nColA4, "68 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say(nLinIni + 1255, nColIni + 2505 + nColA4, "69 - "+STR0123, oFont01) //"Código de Barras"
			oPrint:Say(nLinIni + 1255, nColIni + 3390 + nColA4, "70 - "+STR0105, oFont01,,,,1) //"Valor Unitï¿½rio - R$"
			oPrint:Say(nLinIni + 1255, nColIni + 3665 + nColA4, "71 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni

			if nVolta=1
				nP4:=1
			Endif
			nT4:=nP4+4

			For nI := nP4 To nT4
				if nVolta <> 1
					nN:=nI-((nVolta*5)-5)
					oPrint:Say(nLinIni + 1305, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
				else
					oPrint:Say(nLinIni + 1305, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
				Endif
				oPrint:Say(nLinIni + 1300, nColIni + 0065, aDados[nX, 65, nI], oFont04)
				oPrint:Say(nLinIni + 1300, nColIni + 0160, aDados[nX, 66, nI], oFont04)
				oPrint:Say(nLinIni + 1300, nColIni + 0410, aDados[nX, 67, nI], oFont04)
				oPrint:Say(nLinIni + 1300, nColIni + 2465 + nColA4, IIf(Empty(aDados[nX, 68, nI]), "", Transform(aDados[nX, 68, nI], "@E 9999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 1300, nColIni + 2505 + nColA4, aDados[nX, 69, nI], oFont04)
				oPrint:Say(nLinIni + 1300, nColIni + 3390 + nColA4, IIf(Empty(aDados[nX, 70, nI]), "", Transform(aDados[nX, 70, nI], "@E 999,999,999.99")), oFont04,,,,1)
				oPrint:Say(nLinIni + 1300, nColIni + 3665 + nColA4, IIf(Empty(aDados[nX, 71, nI]), "", Transform(aDados[nX, 71, nI], "@E 999,999,999.99")), oFont04,,,,1)
				nLinIni += 40
			Next nI

			nP4:=nI

			if nVolta=1
				nP5:=len(aDados[nX,66])
			Endif

			if nP5 >nI-1
				lImpnovo:=.T.
			Endif

			nLinIni := nOldLinIni

			oPrint:Box(nLinIni + 1545, nColIni + 3295 + nColA4, nLinIni + 1639, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 1550, nColIni + 3305 + nColA4, "72 - "+STR0214, oFont01) //"Total Geral R$"
			oPrint:Say(nLinIni + 1580, nColIni + 3675 + nColA4, Transform(aDados[nX, 72], "@E 999,999,999.99"), oFont04,,,,1)

			oPrint:Box(nLinIni + 1644, nColIni + 0010, nLinIni + 1864, nColIni + 3695 + nColA4)
			oPrint:Say(nLinIni + 1649, nColIni + 0020, "81 - "+STR0056, oFont01) //"Observaï¿½ï¿½o"

			nLin := 1684

			For nI := 1 To MlCount(aDados[nX, 81], 130)
				cObs := MemoLine(aDados[nX, 81], 130, nI)
				oPrint:Say(nLinIni + nLin, nColIni + 0030, cObs, oFont04)
				nLin += 35
			Next nI

			oPrint:EndPage()	// Finaliza a pagina

		Next nX

	Enddo

	If lGerTXT
		oPrint:Print()	// Imprime Relatorio
	Else
		oPrint:Print()	// Visualiza impressao grafica antes de imprimir
	EndIf

	Return

	*************************************************************************************************
/***************************************************************************
*Autor: Mateus Medeiros  |    Data:08/08/2017                              *
*GUIA DE HONORARIO - R234HON - Baseado na função padrão PLSTISS5           *
****************************************************************************
*Descrição: Estrutura Relatorio TISS ( Guia Hon Individual)                *
****************************************************************************
*Parametros aDados - Array com as informações do relatório                 *
* 			 lGerTXT - Define se imprime direto sem passar pela tela       *
* 			 de configuracao/preview do relatorio 	                       *
*            nLayout - Define o formato de papel para impressao:           *
*       		1 - Formato OfÍcio II (216x330mm)                          *
*               2 - Formato A4 (210x297mm)                                 *
*               3 - Formato Carta (216x279mm)     			       		   *
/***************************************************************************/



Static Function R234HON(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW, lUnicaImp)

	Local nLinMax
	Local nColMax
	Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
	Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
	Local nColA4    :=  0
	Local nCol2A4   :=  0
	Local cFileLogo
	Local lPrinter
	Local nLin
	Local nOldLinIni
	Local nI, nJ, nX
	Local cObs
	Local oFont01
	Local oFont02n
	Local oFont03n
	Local oFont04
	Local nAte		:= 10
	Local lImpNovo	:= .T.
	Local nIni		:= 1
	Local cRel      := "guihind"
	Local oPrint	:= nil
	Local cPathSrvJ := GETMV("MV_RELT")
	Local nTweb		:= 1
	Local nLweb		:= 0
	Local nLwebC	:= 0
	Local oBrush

	Default lUnicaImp := .F.
	Default lGerTXT := .F.
	Default nLayout := 2
	Default cLogoGH := ''
	Default lWeb    := .F.
	Default cPathRelW := ''
	Default aDados := { { ;
	"123456",;
	"12345678901234567892",;
	"12345678901234567892",;
	CtoD("01/01/07"),;
	"12345678901234567892",;
	Replicate("M",40),;
	CtoD("12/12/07"),;
	Replicate("M",70),;
	"123456789102345",;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"1234567",;
	"14.141.114/00001-35",;
	Replicate("M",70),;
	"1234567",;
	{ "01", "COLETIVO" },;
	"01",;
	Replicate("M",70),;
	"1234567",;
	"123456789102345",;
	"DF",;
	"12345678910",;
	{ CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06"),CtoD("12/03/06") },;
	{ "0107","0207","0307","0407","0507","0507","0507","0507","0507","0507" },;
	{ "0607","0707","0807","0907","1007","0507","0507","0507","0507","0507" },;
	{ "MM","AA","BB","CC","DD","DD","DD","DD","DD","DD" },;
	{ "5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234","5678901234"},;
	{ Replicate("M",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60),Replicate("E",60)},;
	{ 12,1,2,3,4,4,4,4,4,4 },;
	{ "D","D","D","D","D","D","D","D","D","D"},;
	{ "M","E","F","G","H","D","D","D","D","D" },;
	{ 111.00,222.00,333.00,444.00,999.99,999.99,999.99,999.99,999.99,999.99 },;
	{ 99999.99,22222.22,33.33,44444.44,11111.11,11111.11,11111.11,11111.11,11111.11,11111.11 },;
	{ 11111.11,55555.00,66666.00,77777.00,88888.00,88888.00,88888.00,88888.00,88888.00,88888.00 },;
	3999999.99,;
	Replicate("M", 240),;
	CtoD("01/01/07"),;
	{ CtoD("04/01/07"), "0101" } } }

	If nLayout  == 1 // Oficio 2
		nLinMax := 2435
		nColMax := 3705
	Elseif nLayout == 2   // Papel A4
		nLinMax	:=	2300//2375
		nColMax	:=	3370 //3365
	Else //Carta
		nLinMax	:=	2260
		nColMax	:=	3175
	Endif

	oFont01		:= TFont():New("Arial",  8,  8, , .F., , , , .T., .F.) // Normal

	if nLayout == 1 // Oficio 2
		oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
	Else  // Papel A4 ou Carta
		oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
		oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
		oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
	Endif

	//*********************************************************
	//Nao permite acionar a impressao quando for na web.
	//*********************************************************
	If lWeb
		cPathSrvJ := cPathRelW
		cFileName := cRel+lower(CriaTrab(NIL,.F.))+".pdf"
	Else
		cFileName := cRel+CriaTrab(NIL,.F.)
	EndIf

	if !lWeb
		//"GUIA DE HONORARIO INDIVIDUAL"
		oPrint := FWMSPrinter():New ( cFileName /*STR0219*/)
	else
		oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
		If lSrvUnix
			AjusPath(@oPrint)
		EndIf
		oPrint:cPathPDF := cPathSrvJ
		/*	LOCAL nAL		:= 0.25
		LOCAL nAC		:= 0.24*/
		nTweb		:= 3.9
		nLweb		:= 0.25//10
		nLwebC		:= 0.24//-3
		oPrint:lServer := lWeb
	Endif

	oPrint:SetLandscape()		// Modo paisagem

	if nLayout == 2
		oPrint:SetPaperSize(9)// Papel A4
	Elseif nLayout == 3
		oPrint:SetPaperSize(1)// Papel Carta
	Else
		oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
	Endif


	//*******************************
	//Device
	//*******************************
	If lWeb
		oPrint:setDevice(IMP_PDF)
	Else
		// Verifica se existe alguma impressora configurada para Impressao Grafica
		lPrinter := oPrint:IsPrinterActive()

		If ! lPrinter
			oPrint:Setup()
		EndIf
	Endif

	For nX := 1 To Len(aDados)

		nAte 	:= 10
		nI		:= 0
		nIni	:= 1

		//Esta condigo do codigo faz com que
		//imprima mais de uma guia.
		If lUnicaImp
			If nX <= Len(aDados)
				lImpNovo := .T.
			EndIf
		EndIf

		While lImpNovo

			lImpNovo 	:= .F.

			If  ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
				Loop
			EndIf

			For nI := 17 To 28
				If Len(aDados[nX, nI]) < 10
					For nJ := Len(aDados[nX, nI]) + 1 To 10
						If AllTrim(Str(nI)) $ "17"
							aAdd(aDados[nX, nI], dtoc(StoD("")))
						ElseIf AllTrim(Str(nI)) $ "23,26,27,28"
							aAdd(aDados[nX, nI], "0")
						Else
							aAdd(aDados[nX, nI], "")
						EndIf
					Next nJ
				EndIf
			Next nI

			nLinIni := 000
			nColIni := 000
			nColA4  := 000
			nCol2A4 := 000

			If oPrint:Cprinter == "PDF" .OR. lWeb
				nLinIni	:= 150
				nColMax := 3035
			Else
				nLinIni := 000
			Endif
			/*	If lWeb
			nColMax := 3175
			Endif
			*/
			oPrint:StartPage()		// Inicia uma nova pagina
			oBrush := TBrush():New("",10) //- CINZA
			//**************************
			//Box Principal
			//**************************
			oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

			//*****************************************
			//Carrega e Imprime Logotipo da Empresa
			//*****************************************
			fLogoEmp(@cFileLogo,, cLogoGH)

			If File(cFilelogo)
				oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (090)/nTweb) 		// Tem que estar abaixo do RootPath
			EndIf

			If nLayout == 2 // Papel A4
				nColA4    := -0335
			Elseif nLayout == 3// Carta
				nColA4    := -0530
				nCol2A4   := -0400
			Endif

			If lWeb
				nColA4 := -550
			Endif

			oPrint:Say(3*nLweb+(nLinIni + 0080)/nTweb, (nColIni + 1852 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, OemToAnsi("GUIA DE HONORÁRIOS"), oFont02n,,,, 2) //"GUIA DE HONORARIO INDIVIDUAL"
			oPrint:Say(3*nLweb+(nLinIni + 0090)/nTweb, (nColIni + 3000 + nColA4)/nTweb, "2 - "+OemToAnsi("Nº "), oFont01) //"Nº
			oPrint:Say(3*nLweb+(nLinIni + 0090)/nTweb, (nColIni + 3096 + nColA4)/nTweb, aDados[nX, 02], oFont03n)
			// Linha 1
			nLinIni += 25
			oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 0315)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 0020)/nTweb, "1 - "+STR0003, oFont01) //"Registro ANS"
			oPrint:Say(nLweb+(nLinIni + 0220)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 01], oFont04)
			oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 0320)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 1035)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 0330)/nTweb, "3- Nº Guia de Solicitação de Internação", oFont01) //"Nº Guia de Solicitação de Internação"
			oPrint:Say(nLweb+(nLinIni + 0220)/nTweb, (nColIni + 0340)/nTweb, aDados[nX, 03], oFont04)
			oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 1038)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 1990)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 1050)/nTweb, "4 - "+OemtoAnsi("Senha"), oFont01) //"Senha"
			oPrint:Say(nLweb+(nLinIni + 0220)/nTweb, (nColIni + 1060)/nTweb, Iif(valtype(aDados[nX, 04])=="C",aDados[nX, 04],DtoC(aDados[nX, 04])), oFont04)
			oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 1995)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 3025)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 2015)/nTweb, OemtoAnsi("5 - Número da Guia Atribuído pela Operadora"), oFont01) //"Número da Guia Atribuído pela Operadora"
			oPrint:Say(nLweb+(nLinIni + 0210)/nTweb, (nColIni + 2010)/nTweb, Iif(valtype(aDados[nX, 05])=="C",aDados[nX, 04],DtoC(aDados[nX, 04])), oFont04)
			// Linha 2
			nLinIni += 19
			//Vetor de coordenadas {nTop,nLeft,nBottom,nRight}
			//oPrint:FillRect({(nLinIni + 0259)/nTweb,100,750,2300},oBrush)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0270)/nTweb, (nColIni + 0010)/nTweb, OemToAnsi("Dados do Beneficiário"), oFont01) //"Dados do Beneficiario"
			oPrint:Box((nLinIni + 0280)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 495)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 0020)/nTweb, "6 - Número da Carteira", oFont01) //"Número da Carteira"
			oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 06], oFont04)
			oPrint:Box((nLinIni + 0280)/nTweb, (nColIni + 500)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 3115 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 0510)/nTweb, "7 - Nome", oFont01) //"Nome"
			oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 0510)/nTweb, aDados[nX, 07], oFont04)
			oPrint:Box((nLinIni + 280)/nTweb, (nColIni + 3120 + nColA4)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 3027)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 2800)/nTweb, "8 - Atendimento a RN", oFont01) //"Atendimento a RN"
			oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 2880)/nTweb, aDados[nX, 08], oFont04)
			// Linha 3

			nLinIni += 25
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0403)/nTweb, (nColIni + 0010)/nTweb, STR0223, oFont01) //"Dados do Contratado (onde foi executado o procedimento)"
			oPrint:Box((nLinIni + 0410)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0528)/nTweb, (nColIni + 0426)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 435)/nTweb, (nColIni + 0020)/nTweb, "9 - Código na Operadora", oFont01) //"Codigo na Operadora / CNPJ / CPF"
			oPrint:Say(nLweb+(nLinIni + 0480)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 09], oFont04)

			oPrint:Box((nLinIni + 0410)/nTweb, (nColIni + 0431)/nTweb, (nLinIni + 0528)/nTweb, (nColIni + 2765)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 435)/nTweb, (nColIni + 0455)/nTweb,"10 - Nome do Hospital/Local", oFont01) //"Nome do Contratado"
			oPrint:Say(nLweb+(nLinIni + 0480)/nTweb, (nColIni + 0455)/nTweb, aDados[nX, 10], oFont04)

			oPrint:Box((nLinIni + 0410)/nTweb, (nColIni + 3105 + nColA4)/nTweb, (nLinIni + 0528)/nTweb,  (nColIni + 3025)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0435)/nTweb, (nColIni + 2780)/nTweb, "11-Código CNES", oFont01) //"Codigo CNES"
			oPrint:Say(nLweb+(nLinIni + 0480)/nTweb, (nColIni + 2780)/nTweb, aDados[nX, 11], oFont04)

			// Linha 4
			nLinIni += 19
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0533)/nTweb, (nColIni + 0010)/nTweb, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"

			oPrint:Box((nLinIni + 0540)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 675)/nTweb, (nColIni + 0426)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0565)/nTweb, (nColIni + 0020)/nTweb, "12 - "+"Código na Operadora / CNPJ / CPF", oFont01) //"Codigo na Operadora / CNPJ / CPF"
			oPrint:Say(nLweb+(nLinIni + 0610)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 12], oFont04)

			oPrint:Box((nLinIni + 0540)/nTweb, (nColIni + 0431)/nTweb, (nLinIni + 0675)/nTweb, (nColIni + 2765)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0565)/nTweb, (nColIni + 0441)/nTweb, "13 - "+"Nome do Contratado", oFont01) //"Nome do Contratado Executante"
			oPrint:Say(nLweb+(nLinIni + 0610)/nTweb, (nColIni + 0451)/nTweb, aDados[nX, 13], oFont04)
			oPrint:Box((nLinIni + 0540)/nTweb, (nColIni + 3105 + nColA4)/nTweb, (nLinIni + 0675)/nTweb, (nColIni + 3025)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0565)/nTweb, (nColIni + 2780)/nTweb, "14 - "+"Código CNES", oFont01) //"Codigo CNES"
			oPrint:Say(nLweb+(nLinIni + 0610)/nTweb, (nColIni + 2780)/nTweb, aDados[nX, 14], oFont04)

			// Linha 5
			nLinIni += 19
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0680)/nTweb, (nColIni + 0010)/nTweb, "Dados da Internação", oFont01) //"Dados do Contratado Executante"

			oPrint:Box((nLinIni + 0685)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0820)/nTweb, (nColIni + 0426)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0705)/nTweb, (nColIni + 0020)/nTweb, "15 - Data do Início do Faturamento", oFont01) //"Nome do Contratado Executante"
			oPrint:Say(nLweb+(nLinIni + 0755)/nTweb, (nColIni + 0020)/nTweb, dtoc(aDados[nX, 15]), oFont04)

			oPrint:Box((nLinIni + 0685)/nTweb, (nColIni + 0433)/nTweb, (nLinIni + 0820)/nTweb, (nColIni + 0723)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0705)/nTweb, (nColIni + 0441)/nTweb, "16 - Data do Fim do Faturamento", oFont01) //"Grau Part."
			oPrint:Say(nLweb+(nLinIni + 0755)/nTweb, (nColIni + 0471)/nTweb, dtoc(aDados[nX, 16]), oFont04)

			// Linha 6
			nLinIni += 19
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0825)/nTweb, (nColIni + 0010)/nTweb, STR0227, oFont01) //"Procedimentos Realizados"
			oPrint:Box(nLweb+nLwebC+(nLinIni + 0845)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1420)/nTweb, (nColIni + 3025)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0150)/nTweb, "17 - "+STR0098, oFont01) //"Data"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0380)/nTweb, "18 - "+STR0099, oFont01) //"Hora Inicial"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0540)/nTweb, "19 - "+STR0100, oFont01) //"Hora Final"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0660)/nTweb, "20 - "+"Tabela", oFont01) //"Tabela"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0820)/nTweb, "21 - "+"Código de Procedimento", oFont01) //"Codigo do Procedimento"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 1040)/nTweb,"22 - "+"Descrição", oFont01) //"Descricao"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 1950 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "23 - "+STR0101, oFont01,,,,1) //"Qtde."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2050 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "24 - "+STR0102, oFont01) //"Via"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2150 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "25 - "+STR0103, oFont01) //"Tec."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2350 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "26 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2650 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "27 - "+"Valor Unitário - R$", oFont01,,,,1) //"Valor Unitario - R$"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 3000 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "28 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

			nOldLinIni := nLinIni
			For nI := nIni To nAte

				If Len(aDados[nX, 17]) >= nI
					oPrint:Say(nLweb+(nLinIni + 0961)/nTweb, (nColIni + 0020)/nTweb, AllTrim(Str(nI)) + " - ", oFont01)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0155)/nTweb, IIf(Empty(substr(cvaltochar(aDados[nX, 17, nI]),1,2)), "", Iif(valtype(aDados[nX, 17, nI])=="C",aDados[nX, 17, nI],DtoC(aDados[nX, 17, nI]) )) , oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0450)/nTweb, IIf(Empty(aDados[nX, 18, nI]), "", Transform(aDados[nX, 18, nI], "@R 99:99")), oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0540)/nTweb, IIf(Empty(aDados[nX, 19, nI]), "", Transform(aDados[nX, 19, nI], "@R 99:99")), oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0670)/nTweb, aDados[nX, 20, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0840)/nTweb, aDados[nX, 21, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 1040)/nTweb, aDados[nX, 22, nI], oFont04)
					If valtype(aDados[nX, 23, nI]) == "C"
						if(aDados[nX, 23, nI] == "0")
							cCont23 := ""
						else
							cCont23 := Transform(aDados[nX, 23, nI],"@E 999,99")
						endif
					else
						if(aDados[nX, 23, nI] == 0)


							cCont23 := ""
						else
							cCont23 := Transform(aDados[nX, 23, nI],"@E 999,99")
						endif
					endif

					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 1950 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb,cCont23 , oFont04,,,,1)

					If valtype(aDados[nX, 24, nI]) == "C"
						if(aDados[nX, 24, nI] == "0")
							cCont24 := ""
						else
							cCont24 := Transform(aDados[nX, 24, nI],"@E 99999")
						endif
					else
						if(aDados[nX, 24, nI] == 0)


							cCont24 := ""
						else
							cCont24 := Transform(aDados[nX, 24, nI],"@E 99999")
						endif
					endif
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2060 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont24 /*IIf( aDados[nX, 24, nI] = 0,"",Transform(aDados[nX, 24, nI],"@E 99999") )*/ , oFont04)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2150 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, aDados[nX, 25, nI], oFont04)

					If valtype(aDados[nX, 26, nI]) == "C"
						if(aDados[nX, 26, nI] == "0")
							cCont26 := ""
						else
							cCont26 := Transform(aDados[nX, 26, nI],"@E 999.99")
						endif
					else
						if(aDados[nX, 26, nI] == 0)
							cCont26 := ""
						else
							cCont26 := Transform(aDados[nX, 26, nI],"@E 999.99")
						endif
					endif

					If valtype(aDados[nX, 27, nI]) == "C"
						if(aDados[nX, 27, nI] == "0")
							cCont27 := ""
						else
							cCont27 := Transform(aDados[nX, 27, nI],"@E 99,999,999.99")
						endif
					else
						if(aDados[nX, 27, nI] == 0)
							cCont27 := ""
						else
							cCont27 := Transform(aDados[nX, 27, nI],"@E 99,999,999.99")
						endif
					endif

					If valtype(aDados[nX, 28, nI]) == "C"
						if(aDados[nX, 28, nI] == "0")
							cCont28 := ""
						else
							cCont28 := Transform(aDados[nX, 28, nI],"@E 99,999,999.99")
						endif
					else
						if(aDados[nX, 28, nI] == 0)
							cCont28 := ""
						else
							cCont28 := Transform(aDados[nX, 28, nI],"@E 99,999,999.99")
						endif
					endif


					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2360 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont26 /*IIf( aDados[nX, 26, nI] = 0 , "", Transform(aDados[nX, 26, nI], "@E 999.99"))*/, oFont04,,,,1)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2650 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont27 /*IIf(aDados[nX, 27, nI] = 0, "", Transform(aDados[nX, 27, nI], "@E 99,999,999.99"))*/, oFont04,,,,1)
					oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 3000 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont28 /*IIf(aDados[nX, 28, nI] = 0 , "", Transform(aDados[nX, 28, nI], "@E 99,999,999.99"))*/, oFont04,,,,1)
					nLinIni += 45
				Endif
			Next nI

			nLinIni := nOldLinIni

			If nAte < Len(aDados[nX][27])
				lImpNovo 	:= .T.
				nIni		:= nAte + 1
				nAte		+= 10
			EndIf

			// Linha 7
			nLinIni += 45

			oPrint:Say(nLweb+nLwebC+(nLinIni + 1395)/nTweb, (nColIni + 0010)/nTweb, "Identificação do(s) Profissional(is) Executante(s)", oFont01) //"Procedimentos Realizados"
			oPrint:Box(nLweb+nLwebC+(nLinIni + 1410)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1780)/nTweb, (nColIni + 3025)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0020)/nTweb, "29-Seq.Ref" , oFont01) //"Data"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0150)/nTweb, "30-Grau Part.  ", oFont01) //"Hora Inicial"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0440)/nTweb, "31-Código na Operadora/CPF", oFont01) //"Hora Final"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0820)/nTweb, "32-Nome do Profissional", oFont01) //"Tabela"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 1090)/nTweb, "33-Conselho Profissional" , oFont01) //"Codigo do Procedimento"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 1400)/nTweb, "34-Número no Conselho", oFont01) //"Descricao"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 2010 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "35-UF"      , oFont01,,,,1) //"Qtde."
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 2400 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "36-Código CBO", oFont01) //"Codigo CBO"

			nOldLinIni := nLinIni

			For nI := nIni To 7

				If Len(aDados[nX, 29]) >= nI

					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0020)/nTweb, IIf(Empty(aDados[nX, 29, nI]), "", Iif(valtype(aDados[nX, 29, nI])=="C",aDados[nX, 29, nI],DtoC(aDados[nX, 29, nI]) )) , oFont04)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0150)/nTweb, IIf(Empty(aDados[nX, 30, nI]), "", aDados[nX, 30, nI]), oFont04)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0440)/nTweb, IIf(Empty(aDados[nX, 31, nI]), "", aDados[nX, 31, nI]), oFont04)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0820)/nTweb, aDados[nX, 32, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 1090)/nTweb, aDados[nX, 33, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 1400)/nTweb, aDados[nX, 34, nI], oFont04)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 2010 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, IIf(Empty(aDados[nX, 35, nI]), "",aDados[nX, 35, nI]) , oFont04,,,,1)
					oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 2400 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, aDados[nX, 36, nI], oFont04)
					nLinIni += 45

				Endif
			Next nI

			nLinIni := nOldLinIni
			nLinIni += 20
			//(nLinIni + 1500)/nTweb
			oPrint:Box(nLweb+nLwebC+(nLinIni + 1785)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1985)/nTweb, (nColIni + 2970 + nColA4)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1820)/nTweb, (nColIni + 0020)/nTweb,  "37 - Observação / Justificativa", oFont01) //"Observacao"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1860)/nTweb, (nColIni + 0020 + nColA4)/nTweb, 	cvaltochar(aDados[nX,37]), oFont04,,,,1)
			oPrint:Box(nLweb+nLwebC+(nLinIni + 1785)/nTweb, (nColIni + 2990 + nColA4)/nTweb, (nLinIni + 1900)/nTweb,  (nColIni + 3025)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1820)/nTweb, (nColIni + 2999 + nColA4)/nTweb, "38 - "+"Total Geral Honorários R$", oFont01) //"Total Geral Honorarios R$"
			oPrint:Say(nLweb+nLwebC+(nLinIni + 1860)/nTweb, (nColIni + 3000 + nColA4)/nTweb, Transform(aDados[nX, 35], "@E 999,999,999.99"), oFont04,,,,1)

			nLinIni := nOldLinIni

			oPrint:Box((nLinIni + 2005)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 2100)/nTweb, (nColIni + 1340)/nTweb)
			oPrint:Say(nLweb+nLwebC+(nLinIni + 2025)/nTweb, (nColIni + 0020)/nTweb, OemToAnsi("39 - Data de Emisão"), oFont01) //"Data e Assinatura do Prestador"
			oPrint:Say(nLweb+(nLinIni + 2045)/nTweb, (nColIni + 0030)/nTweb, Transform(aDados[nX, 39], "@E 999,999,999.99")			, oFont04)
			oPrint:Box((nLinIni + 2005)/nTweb, (nColIni + 1350)/nTweb, (nLinIni + 2100)/nTweb, ((nColIni + 2972 + nColA4)/nTweb))
			oPrint:Say(nLweb+nLwebC+(nLinIni + 2025)/nTweb, (nColIni + 1355)/nTweb, OemToAnsi("40 - Assinatura do Profissional Executante"), oFont01) //"Data/Hora e Assinatura do Beneficicio ou Responsavel"
			oPrint:Say(nLweb+(nLinIni + 2045)/nTweb, (nColIni + 1365)/nTweb, "  "  , oFont04)

			oPrint:EndPage()	// Finaliza a pagina

		End

	Next nX

	If lWeb
		oPrint:Print()
	Else
		oPrint:Preview()
	Endif

	Return cFileName


	*************************************************************************************************

/*User Function PLSAUDBT()

Return( {"teste","U_tst"} )

User Function TST

Alert('Merda')

Return
*/