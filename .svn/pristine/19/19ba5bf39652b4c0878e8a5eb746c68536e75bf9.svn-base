#include "Topconn.ch"
#include 'Fileio.ch'

#Define D_EVENT	 1 //Eventos
#Define D_BENEF	 2 //Beneficiarios
#Define D_DESPE	 3 //Despesas

#Define D_AMD "ambulatorial"
#Define D_HOS "hospitalar"
#Define D_OBS "hospitalarObstetricia"
#Define D_ODO "odontologico"

#Define F_BLOCK  512

/*
aQuadroI Contem os valores do itens                             ?
	[X,Y] Onde
		X 	= Codigo do Item
		Y1	= Qtd Eventos
		Y2	= Qtd Beneficiarios
		Y3	= Qtd Despesas
*/
Static aQuadroI	:=	{} 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  19/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera o arquivo XML para o SIP                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
//Function CreateXMLSIP()
User Function GeraXMLSIP()
	Local 	cSequen 	:= GetNewPar("MV_PLSEQSIP","000000000001")	
	//
	Private	cDir    	:= MV_PAR06
	Private cMesIni		:= aPeriodos[MV_PAR02,1]
	Private cPerData	:= Alltrim(MV_PAR01)+PADL(Alltrim(Str(MV_PAR02)),2,"0")//Periodo
	Private cDtOcorren	:= ""//Referencia
	Private	cPicEvento	:= BZZ->(X3Picture("BZZ_EVENTO"))//"@E 9999999999" 
	Private	cPicBenefi 	:= BZZ->(X3Picture("BZZ_BENEFI"))//"@E 9999999999" 
	Private	cPicTotal 	:= BZZ->(X3Picture("BZZ_TOTAL"))//"@E 9999999999.99" 	
	Private	isXMLOnFile	:= .F.//Quando o XML maior que .7 MB, e usado um arquivo secundario para nao estourar o String do Protheus.
	Private	lCriaHashFi	:= .T.	
	Private	cXmlTempFile:= Alltrim(cDir)+"sipbuffer.xml"
	Private	cXmlSwapFile:= Alltrim(cDir)+"sipswap.xml"
	Private cHashFile	:= "siphashfile.txt"  	
	Private cTipPla		:= ""	
	Private cUF			:=	Space(2)
	
	BA0->(DbSetOrder(1))
	If BA0->(DbSeek(xFilial("BA0")+PlsIntPad()))
		//Organiza o XML para envio.
		MontaSIPXml(cSequen)
	Else
		MsgAlert("Operadora nใo localizada.")
	EndIf
		
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณTagMensageบAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function MontaSIPXml(cSequen)
	Local cXmlOnMemory	:=	""
	//Atencao nao mudar a ordem de declaracao das variaveis cTag?????
	Local cTagMsgSip 	:=	TMensagemSIP()
	Local cTagCabecalho	:=	TCabecalho(cSequen)	
	Local cTagMensagem	:=	TagMensagem(cSequen)
	Local cTagFimSip	:=	SIPMontaXML("mensagemSIP",,,,,,,.F.,.T.,,,,.F.)

	If isXMLOnFile
		//Insere os itens que estao faltando do XML.
		InsInXMLTemp(cTagCabecalho,.T.)
		InsInXMLTemp(cTagMsgSip,.T.) 
		
		InsInXMLTemp(TEpilogo(),.F.)		
		InsInXMLTemp(cTagFimSip,.F.)				
	Else
		cXmlOnMemory	+= cTagMsgSip
		cXmlOnMemory	+= cTagCabecalho
		cXmlOnMemory	+= cTagMensagem
		cXmlOnMemory 	+=	TEpilogo()		
		cXmlOnMemory	+= cTagFimSip
	EndIf
   
	//Grava o arquivo do SIP
	WriteXMLFile(cXmlOnMemory,cSequen)	
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TMensagemSIP()
	Local cXMLCabec	:=	""
	Local cTmpTag		:=	""
	
	cTmpTag := "version="+'"1.0"'+" encoding="+'"ISO-8859-1"'+"?"
	cXMLCabec += SIPMontaXML("?xml",,,,,,,.T.,.F.,.T.,cTmpTag,,.F.)
		
	cTmpTag :='xsi:noNamespaceSchemaLocation="http://www.ans.gov.br/padroes/sip/schemas/sipV1_02.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'
	cXMLCabec += SIPMontaXML("",,,,,,,.F.,.F.,,cTmpTag,,.F.)

	cXMLCabec += SIPMontaXML("mensagemSIP",,,,,,,.T.,.F.,.T.,cTmpTag,,.F.)
	
Return cXMLCabec

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TCabecalho(cSequen)
	Local cTag	:=	""
	
	cTag += SIPMontaXML("cabecalho",,,,,,4,.T.,.F.,,,,.T.)
	
	cTag += SIPMontaXML("identificacaoTransacao",,,,,,8,.T.,.F.,,,,.T.)
	cTag += SIPMontaXML("tipoTransacao","ENVIO_SIP",,,,,12,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("sequencialTransacao",cSequen,,,,,12,.T.,.T.,,,,.T.) //MV_PLSEQSIP
	cDate:=  Gravadata(ddatabase,.F.,8)
	cTag += SIPMontaXML("dataHoraRegistroTransacao",Substr(cDate,1,4)+"-"+Substr(cDate,5,2)+"-"+Substr(cDate,7,2)+"T"+Time(),,,,,12,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("identificacaoTransacao",,,,,,8,.F.,.T.,,,,.T.)
	
	cTag += SIPMontaXML("origem",,,,,,8,.T.,.F.,,,,.T.)
	//
	If ! Empty(BA0->BA0_SUSEP)
		cTag += SIPMontaXML("registroANS",PadL(Trim(BA0->BA0_SUSEP),6,"0"),,,,,12,.T.,.T.,,,,.T.)
	Else
		cTag += SIPMontaXML("cnpj",PadL(Trim(BA0->BA0_CGC),14,"0"),,,,,12,.T.,.T.,,,,.T.)
	EndIf
	
	cTag += SIPMontaXML("origem",,,,,,8,.F.,.T.,,,,.T.)
	
	cTag += SIPMontaXML("destino",,,,,,8,.T.,.F.,,,,.T.)
	//CNPJ da ANS : 03.589.068/0001-46
	cTag += SIPMontaXML("cnpj",PadL("03589068000146",14,"0"),,,,,12,.T.,.T.,,,,.T.)

	cTag += SIPMontaXML("destino",,,,,,8,.F.,.T.,,,,.T.)
	
	cTag += SIPMontaXML("versaoPadrao","1.02",,,,,8,.T.,.T.,,,,.T.)
	
	cTag += SIPMontaXML("identificacaoSoftwareGerador",,,,,,8,.T.,.F.,,,,.T.)
	cTag += SIPMontaXML("nomeAplicativo","Microsiga Protheus Serie T",,,,,12,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("versaoAplicativo","11",,,,,12,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("fabricanteAplicativo","TOTVS",,,,,12,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("identificacaoSoftwareGerador",,,,,,8,.F.,.T.,,,,.T.)
	
	cTag += SIPMontaXML("cabecalho",,,,,,4,.F.,.T.,,,,.T.)             
	
	If isXMLOnFile	
		InsInXMLTemp(cTag,.T.)
	EndIf

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/                 
Static Function TagMensagem(cSequen)
	Local cTagMsg			:=	"" 
	Local cTagFormCont	:=	""

	//Forma de Contratacao
	cTagMsg += SIPMontaXML("mensagem",,,,,,4,.T.,.F.,,,,.T.)
	cTagMsg += SIPMontaXML("operadoraParaANS",,,,,,8,.T.,.F.,,,,.T.) //OpeANS
	cTagMsg += SIPMontaXML("sipOperadoraParaAns",,,,,,8,.T.,.F.,,,,.T.) //sipOperadoraParaAns

		cTagMsg += SIPMontaXML("envioSip",,,,,,12,.T.,.F.,,,,.T.) //EnvioSIP	 
			//dataTrimestreReconhecimento na abertura
			cTagMsg += SIPMontaXML("dataTrimestreReconhecimento",,,,,,16,.T.,.F.,,,,.T.) 
			cTagMsg += SIPMontaXML("dia","01",,,,,20,.T.,.T.,,,,.T.)     
			cTagMsg += SIPMontaXML("mes",cMesIni,,,,,20,.T.,.T.,,,,.T.)  
			cTagMsg += SIPMontaXML("ano",MV_PAR01,,,,,20,.T.,.T.,,,,.T.) 
			cTagMsg += SIPMontaXML("dataTrimestreReconhecimento",,,,,,16,.F.,.T.,,,,.T.)		
			//fim dataTrimestreReconhecimento
	
			cTagMsg += SIPMontaXML("formaContratacao",,,,,,16,.T.,.F.,,,,.T.) 

			//Segmentacao
			cTagFormCont := TFormaContratacao(20)		
			
			If isXMLOnFile
				InsInXMLTemp(cTagMsg,.T.)				
				cTagMsg	:= ""
			Else
				cTagMsg	+=	cTagFormCont
			EndIf
	
			cTagMsg += SIPMontaXML("formaContratacao",,,,,,16,.F.,.T.,,,,.T.)
		cTagMsg += SIPMontaXML("envioSip",,,,,,12,.F.,.T.,,,,.T.) //EnvioSIP
		
	cTagMsg += SIPMontaXML("sipOperadoraParaAns",,,,,,8,.F.,.T.,,,,.T.) // OpeANS
	cTagMsg += SIPMontaXML("operadoraParaANS",,,,,,8,.F.,.T.,,,,.T.) // OpeANS
	cTagMsg += SIPMontaXML("mensagem",,,,,,4,.F.,.T.,,,,.T.) //Mensagem

	If isXMLOnFile
		InsInXMLTemp(cTagMsg,.F.)
		cTagMsg	:= ""
	EndIf

Return cTagMsg

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TEpilogo()
	Local	cTag := ""

	cTag += SIPMontaXML("epilogo",,,,,,4,.T.,.F.,,,,.F.)
		cTag += SIPMontaXML("hash",GetXmlEpilogo(),,,,,4,.T.,.T.,,,.T.,.F.)
		//MemoWrite("c:\hash.txt", "Texto: "+ HashXmlF() +chr(13) +"Valor: "+ GetXmlEpilogo())
	cTag += SIPMontaXML("epilogo",,,,,,4,.F.,.T.,,,,.F.)

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TFormaContratacao(nIdent)
	Local cTag			:=	""      
	Local cContTag		:=	"" 
	Local nForCont		:=	0
	
	Private cSegEmAnalise :=	""//Codigo do segmento em Analise.

	BZZ->(DbSetOrder(3))//BZZ_FILIAL+BZZ_PERIOD+BZZ_TIPPLA
   For nForCont := 1 To 3
		cTipPla	:=	Alltrim(Str(nForCont))

		//Procura os tipos de planos possiveis
		If BZZ->(DbSeek(xFilial("BZZ")+cPerData+cTipPla))

			If nForCont == 1
				cContTag		:= "individualFamiliar"
			ElseIf nForCont == 2
				cContTag		:= "coletivoEmpresarial"
			ElseIf nForCont == 3
				cContTag		:= "coletivoAdesao"
			EndIf
			
			cTag += SIPMontaXML(cContTag,,,,,,nIdent,.T.,.F.,,,,.T.)
				cTag += SIPMontaXML("segmentacao",,,,,,nIdent+4,.T.,.F.,,,,.T.)
					
					//ambulatorial							
					If IsSegQuadroExist(D_AMD,"","")
						cSegEmAnalise	:=	D_AMD
						cTag 			+= TagAmbulatorial(nIdent+8,cTipPla)
						ChkXMLSize(@cTag)
					EndIf
					
					//hospitalar
					If IsSegQuadroExist(D_HOS,"","")
						cSegEmAnalise	:=	D_HOS
						cTag 			+= TagHospitalar(nIdent+8,cTipPla)
						ChkXMLSize(@cTag)												
					EndIf
					
					//hospitalarObstetricia()
					If IsSegQuadroExist(D_OBS,"","")
						cSegEmAnalise	:=	D_OBS
						cTag 			+= TagObsHospitalar(nIdent+8,cTipPla)
						ChkXMLSize(@cTag)												
					EndIf
					
					//odontologico    
					If IsSegQuadroExist(D_ODO,"","")					
						cSegEmAnalise	:=	D_ODO
						cTag 			+=	TagOdontologico(nIdent+8,cTipPla)
						ChkXMLSize(@cTag)												
					EndIf
						
				cTag += SIPMontaXML("segmentacao",,,,,,nIdent+4,.F.,.T.,,,,.T.)				
			cTag += SIPMontaXML(cContTag,,,,,,nIdent,.F.,.T.,,,,.T.)
		EndIf
			
	Next nForCont

	If isXMLOnFile
		InsInXMLTemp(cTag,.F.)
		cTag	:=	""				
	EndIf
		
Return cTag 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TagAmbulatorial(nIdent,cTipPla)
	Local cTag		:=	""

	cTag += SIPMontaXML("ambulatorial",,,,,,nIdent,.T.,.F.,,,,.T.)
		If GetQuadroByState(cSegEmAnalise)
			Do While ! QUAESPO->(Eof()) 
				If ! Empty(QUAESPO->BZZ_UF) 
					cUF := QUAESPO->BZZ_UF
				Else
					cUF := "NC"					
				EndIf

				If IsSegQuadroExist(cSegEmAnalise,cUF,QUAESPO->BZZ_REFERE) 
					cDtOcorren := QUAESPO->BZZ_REFERE
					cTag += SIPMontaXML("quadro",,,,,,nIdent+4,.T.,.F.,,,,.T.)	
						//Cabecalho
						cTag += TagDataTrimestreOcorrencia(Alltrim(QUAESPO->BZZ_REFERE))  
						//Carrega os itens Referentes a este item no array de processamento.
						LoadQuadro(QUAESPO->BZZ_REFERE)
						
						//ItenConsultas Medicas
						cTag += TItensConsultasMedicas(nIdent+8)
	
						//ItensOutrosAtendAmbu
						cTag += TItensOutrosAtendAmbu(nIdent+8)				
	
						//ItensExames
						cTag += TItensExames(nIdent+8)				
	
						//ItensTerapias
						cTag += TItensTerapias(nIdent+8)				
	
						//ItensDemDespMedHosp
						cTag += 	TItensDemDespMedHosp(nIdent+8)
					cTag += SIPMontaXML("quadro",,,,,,nIdent+4,.F.,.T.,,,,.T.) 
					cDtOcorren := ""				
				EndIf          
				QUAESPO->(dbSkip()) 				
			EndDo
		EndIf
		QUAESPO->(Dbclosearea())		
	cTag += SIPMontaXML("ambulatorial",,,,,,nIdent+4,.F.,.T.,,,,.T.)				

Return cTag       

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TagHospitalar(nIdent,cTipPla)
	Local cTag	:=	""

	//A tag hospitalar obstreticia contem todos os iten do hospitalar + obstrtecia.
	cTag	:=	TagObsHospitalar(nIdent,cTipPla)

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TagObsHospitalar(nIdent,cTipPla)
	Local cTag	:=	""         

	cTag += SIPMontaXML(cSegEmAnalise,,,,,,nIdent,.T.,.F.,,,,.T.)
		If GetQuadroByState(cSegEmAnalise)
			Do While ! QUAESPO->(Eof())
				If ! Empty(QUAESPO->BZZ_UF) 
					cUF := QUAESPO->BZZ_UF
				Else
					cUF := "NC"					
				EndIf

				If IsSegQuadroExist(cSegEmAnalise,cUF,QUAESPO->BZZ_REFERE)
					cDtOcorren := QUAESPO->BZZ_REFERE
					cTag += SIPMontaXML("quadro",,,,,,nIdent+4,.T.,.F.,,,,.T.)	
						//Cabecalho
						cTag += TagDataTrimestreOcorrencia(Alltrim(QUAESPO->BZZ_REFERE))  
						//Carrega os itens Referentes a este item no array de processamento.
						LoadQuadro(QUAESPO->BZZ_REFERE)
						
						//ct_quadroHospInternacoes
						cTag += TCtQuadroHospInternacoes(nIdent+8)
						//
						cTag += TInterObstetricas(nIdent+8)
						//parto    
						If cSegEmAnalise == D_OBS
							cTag += TParto(nIdent+8)
						EndIf
						//
						cTag += TCausaInterna(nIdent+8)
						//nascidoVivo
						If cSegEmAnalise == D_OBS
							cTag +=	TNascidoVivo(nIdent+8)
						EndIf
						//
						cTag += TDemDespMedHosp(nIdent+8)					
	
					cTag += SIPMontaXML("quadro",,,,,,nIdent+4,.F.,.T.,,,,.T.)				
					cDtOcorren := ""									
				EndIf
				
				QUAESPO->(dbSkip())
			EndDo
		EndIf
		QUAESPO->(Dbclosearea())		
	cTag += SIPMontaXML(cSegEmAnalise,,,,,,nIdent+4,.F.,.T.,,,,.T.)				

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TagOdontologico(nIdent,cTipPla)
	Local cTag		:=	""         

	cTag += SIPMontaXML("odontologico",,,,,,nIdent,.T.,.F.,,,,.T.)
		If GetQuadroByState(cSegEmAnalise)
			Do While ! QUAESPO->(Eof()) 
				If ! Empty(QUAESPO->BZZ_UF) 
					cUF := QUAESPO->BZZ_UF
				Else
					cUF := "NC"					
				EndIf

				If IsSegQuadroExist(cSegEmAnalise,cUF,QUAESPO->BZZ_REFERE)
					cDtOcorren := QUAESPO->BZZ_REFERE				
					cTag += SIPMontaXML("quadro",,,,,,nIdent+4,.T.,.F.,,,,.T.)	
						//Cabecalho
						cTag += TagDataTrimestreOcorrencia(Alltrim(QUAESPO->BZZ_REFERE))  
						//Carrega os itens Referentes a este item no array de processamento.
						LoadQuadro(QUAESPO->BZZ_REFERE)
						
						//procOdonto
						cTag += TagProcOdonto(nIdent+8)
	
					cTag += SIPMontaXML("quadro",,,,,,nIdent+4,.F.,.T.,,,,.T.)				
				EndIf
				QUAESPO->(dbSkip())
			EndDo
		EndIf
		QUAESPO->(Dbclosearea())		
	cTag += SIPMontaXML("odontologico",,,,,,nIdent+4,.F.,.T.,,,,.T.)				

Return cTag       

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/                                                    
Static Function TagDataTrimestreOcorrencia(cAnoMes)
	Local cTag		:=	""
	Local cMes		:=	"10"  
	
	cTag += SIPMontaXML("dataTrimestreOcorrencia",,,,,,36,.T.,.F.,,,,.T.)  // data trimestre de ocorrencia
	
	If Substr(cAnoMes,5,2)=='01'
		cMes := "01"
	ElseIF Substr(cAnoMes,5,2)=='02'
		cMes := "04"
	ElseIf Substr(cAnoMes,5,2)=='03'
		cMes := "07"
	EndIf
	
	cTag += SIPMontaXML("dia","01",,,,,40,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("mes",cMes,,,,,40,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("ano",Substr(cAnoMes,1,4),,,,,40,.T.,.T.,,,,.T.)
	cTag += SIPMontaXML("dataTrimestreOcorrencia",,,,,,36,.F.,.T.,,,,.T.) 
	cTag += SIPMontaXML("uf",cUf,,,,,36,.T.,.T.,,,,.T.)
	
Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TItensConsultasMedicas(nIdent)
	Local cTag			:=	""

	cTag += SIPMontaXML("itensConsultasMedicas",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += SIPMontaXML("consultasMedicas",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		//Monta o Totalizador
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"A")
		//
		cTag += TagMedicasAmbConsulta(nIdent+12)
		
		cTag += TagMedProntSocConsulta(nIdent+12)

		cTag += SIPMontaXML("consultasMedicas",,,,,,nIdent+4,.F.,.T.,,,,.T.)				
	cTag += SIPMontaXML("itensConsultasMedicas",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag   

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TItensOutrosAtendAmbu(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("itensOutrosAtendAmbu",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += SIPMontaXML("outrosAtendAmb",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		//Monta o Totalizador
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"B")
		//
		cTag += 	TOutrosAtendAmb(nIdent+12)

		cTag += SIPMontaXML("outrosAtendAmb",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 
	cTag += SIPMontaXML("itensOutrosAtendAmbu",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag    

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TItensExames(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("itensExames",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += SIPMontaXML("exames",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		//Monta o Totalizador
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"C")			
		//
		cTag += 	TExames(nIdent+12)

		cTag += SIPMontaXML("exames",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 
	cTag += SIPMontaXML("itensExames",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/              
Static Function TItensTerapias(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("itensTerapias",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += SIPMontaXML("terapias",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		//Monta o Totalizador
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"D")			
		//
		cTag += 	TTerapias(nIdent+12)

		cTag += SIPMontaXML("terapias",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 
	cTag += SIPMontaXML("itensTerapias",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/                 
Static Function TItensDemDespMedHosp(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("itensDemDespMedHosp",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += GetTagEvento("demaisDespMedHosp",{D_DESPE},nIdent+4,"H")
	cTag += SIPMontaXML("itensDemDespMedHosp",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TCtQuadroHospInternacoes(nIdent)
	Local cTag			:=	""
	Local cTagQuadro  :=	"ct_quadroHospInternacoes"
	
	If cSegEmAnalise == D_OBS
		cTagQuadro	:=	"ct_quadroHospObstInternacoes"
	EndIf

	cTag += SIPMontaXML(cTagQuadro,,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += SIPMontaXML("internacoes",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		//Monta o Totalizador
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"E")
		//
		cTag += TTipoInternacao(nIdent+12)
		//
		cTag += SIPMontaXML("internacoes",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 
	cTag += SIPMontaXML(cTagQuadro,,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TInterObstetricas(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("interObstetricas",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += GetTagEvento("obstetrica" 	,{D_EVENT},nIdent+8	,"E13")			
	cTag += SIPMontaXML("interObstetricas",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TParto(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("parto",,,,,,nIdent,.T.,.F.,,,,.T.)
		//partoNormal
		cTag += GetTagEvento("partoNormal",{D_EVENT},nIdent+4	,"E131")
		//partoCesareo
		cTag += GetTagEvento("partoCesareo",{D_EVENT},nIdent+4	,"E132")
	cTag += SIPMontaXML("parto",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TNascidoVivo(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("nascidoVivo",,,,,,nIdent,.T.,.F.,,,,.T.)
		//nascidoVivo
		cTag += GetTagEvento("nascidoVivo",{D_EVENT},nIdent+4	,"G")

	cTag += SIPMontaXML("nascidoVivo",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TCausaInterna(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("causaInterna",,,,,,nIdent,.T.,.F.,,,,.T.)
		//Neoplasias
		cTag += SIPMontaXML("neoplasias",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F1")//neoplasias
			//cancerMamaFem
			cTag += SIPMontaXML("cancerMamaFem",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
			cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F11")//cancerMamaFem
				cTag += GetTagEvento("tratCirurgCancerMam",{D_EVENT},nIdent+8	,"F111")							
			cTag += SIPMontaXML("cancerMamaFem",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 			
			//cancerColoUtero
			cTag += SIPMontaXML("cancerColoUtero",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
			cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F12")//cancerColoUtero
				cTag += GetTagEvento("tratCirurgCancerColo",{D_EVENT},nIdent+8	,"F121")							
			cTag += SIPMontaXML("cancerColoUtero",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 			
			//cancerColonReto						
			cTag += SIPMontaXML("cancerColonReto",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
			cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F13")//cancerColonReto			
				cTag += GetTagEvento("tratCirurgCancerColoReto",{D_EVENT},nIdent+8	,"F131")							
			cTag += SIPMontaXML("cancerColonReto",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 			
			//cancerProstata
			cTag += SIPMontaXML("cancerProstata",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
			cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F14")//cancerProstata			
				cTag += GetTagEvento("tratCirurgCancerProst",{D_EVENT},nIdent+8	,"F141")							
			cTag += SIPMontaXML("cancerProstata",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 			
			//			
		cTag += SIPMontaXML("neoplasias",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 
		
		//diabetesMellitus
		cTag += GetTagEvento("diabetesMellitus",{D_EVENT},nIdent+4	,"F2")
		
		//doencasAparelhoCirc
		cTag += SIPMontaXML("doencasAparelhoCirc",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F3")//doencasAparelhoCirc			
			cTag += GetTagEvento("infartoAgudoMiocardio",{D_EVENT},nIdent+4	,"F31")			
			cTag += GetTagEvento("doencasHipertensivas",{D_EVENT},nIdent+4	,"F32")		
			cTag += GetTagEvento("insuficienciaCardCong",{D_EVENT},nIdent+4	,"F33")			
			//
			cTag += SIPMontaXML("doencasCerebrovasc",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
			cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F34")//doencasCerebrovasc
				cTag += GetTagEvento("acidenteVascularCere",{D_EVENT},nIdent+8	,"F341")							
			cTag += SIPMontaXML("doencasCerebrovasc",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 
		cTag += SIPMontaXML("doencasAparelhoCirc",,,,,,nIdent+4,.F.,.T.,,,,.T.)	 		
		//doencasAparelhoResp
		cTag += SIPMontaXML("doencasAparelhoResp",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		cTag += GetTagEvento("" 	,{D_EVENT},nIdent+8	,"F4")//doencasAparelhoResp			
			cTag += GetTagEvento("doencaPulmoObstrCron",{D_EVENT},nIdent+4	,"F41")			
		cTag += SIPMontaXML("doencasAparelhoResp",,,,,,nIdent+4,.F.,.T.,,,,.T.)
		//causasExternas
		cTag += GetTagEvento("causasExternas",{D_EVENT},nIdent+4	,"F5")		
	cTag += SIPMontaXML("causaInterna",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/                 
Static Function TDemDespMedHosp(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("demDespMedHosp",,,,,,nIdent,.T.,.F.,,,,.T.)
		//Deveria ser o Item H da tabela da ANS, porem o sistema de totalizacao esta separando 
		//o que e despesas Desp. Med. Hosp. do segmento ambulatorial e o que e do segmento hospitalar.
		//conforme alinhamento com o lider foi decido que sera enviado apenas o item despesas medicos hospitalar 
		//para o segmento ambulatorial.
		cTag += GetTagEvento("demaisDespMedHosp",{D_DESPE},nIdent+4	,"OO")			
	cTag += SIPMontaXML("demDespMedHosp",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TTipoInternacao(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("tipoInternacao",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += GetTotByEvento({D_EVENT},nIdent+8,"E1")//Totalizando tipoInternaxao
		//
		cTag += GetTagEvento("clinica" 	,{D_EVENT},nIdent+8	,"E11")			
		//
		cTag += TCirurgica(nIdent+8) 
      //
		cTag += TPediatrica(nIdent+8) 
	
		cTag += GetTagEvento("psiquiatrica" 	,{D_EVENT},nIdent+8	,"E15")			

		cTag += TRegimeInterncao(nIdent+8)

	cTag += SIPMontaXML("tipoInternacao",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/             
Static Function TCirurgica(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("cirurgica",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += GetTagEvento("" 	,{D_EVENT},nIdent+4	,"E12")//cirurgica

		cTag += GetTagEvento("cirurgiaBariatrica" 	,{D_EVENT},nIdent+4	,"E121")
		cTag += GetTagEvento("laqueaduraTubaria"	,{D_EVENT},nIdent+4	,"E122")
		cTag += GetTagEvento("vasectomia" 			,{D_EVENT},nIdent+4	,"E123")
		cTag += SIPMontaXML("fraturaFemur60",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
		cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"E124")//
		cTag += SIPMontaXML("fraturaFemur60",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
		cTag += GetTagEvento("revisaoArtroplastia" 	,{D_EVENT},nIdent+4	,"E125")
		cTag += GetTagEvento("implanteCdi" 				,{D_EVENT},nIdent+4	,"E126")
		cTag += GetTagEvento("implantacaoMarcap" 		,{D_EVENT},nIdent+4	,"E127")

	cTag += SIPMontaXML("cirurgica",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TPediatrica(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("pediatrica",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += GetTagEvento("" 	,{D_EVENT},nIdent+4	,"E14")//Pediatrica
		cTag += SIPMontaXML("internacaoRespira",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
		cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"E141")//
		cTag += SIPMontaXML("internacaoRespira",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
		
		//
		cTag += SIPMontaXML("internacaoUtiNeo",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
		cTag += GetTagEvento(""	,{D_EVENT},nIdent+4,"E142")//internacaoUtiNeo
			cTag += GetTagEvento("internacoesUtiNeo48"	,{D_EVENT},nIdent+4,"E1421")		
		cTag += SIPMontaXML("internacaoUtiNeo",,,,,,nIdent+4,.F.,.T.,,,,.T.)				
		//
	cTag += SIPMontaXML("pediatrica",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TRegimeInterncao(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("regimeInternacao",,,,,,nIdent,.T.,.F.,,,,.T.)
		cTag += GetTagEvento("" 	,{D_EVENT},nIdent	,"E2")//regimeInternacao
		cTag += SIPMontaXML("hospitalar",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
			cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"E21")//
		cTag += SIPMontaXML("hospitalar",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
		
		//Hospital Dia
		cTag += SIPMontaXML("hospitalDia",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
			cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+4	,"E22")
			cTag += GetTagEvento("hospitalSaudeMental"	,{D_EVENT},nIdent+8,"E221")
		cTag += SIPMontaXML("hospitalDia",,,,,,nIdent+4,.F.,.T.,,,,.T.)
		//
		cTag += SIPMontaXML("domiciliar",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
			cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"E23")//
		cTag += SIPMontaXML("domiciliar",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
	cTag += SIPMontaXML("regimeInternacao",,,,,,nIdent,.F.,.T.,,,,.T.)

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ  
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TTerapias(nIdent)
	Local cTag	:=	""

	cTag += GetTagEvento("transfusaoAmbulatorial" 	,{D_EVENT},nIdent+4	,"D1")
	cTag += GetTagEvento("quimioSistemica" 			,{D_EVENT},nIdent+4	,"D2")
	cTag += GetTagEvento("radioterapiaMegavolt" 		,{D_EVENT},nIdent+4	,"D3")
	cTag += GetTagEvento("hemodialiseAguda" 			,{D_EVENT},nIdent+4	,"D4")
	cTag += GetTagEvento("hemodialiseCronica" 		,{D_EVENT},nIdent+4	,"D5")
	cTag += GetTagEvento("implanteDispIntrauterino" ,{D_EVENT},nIdent+4	,"D6")
	
Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TExames(nIdent)
	Local cTag	:=	""

	cTag += GetTagEvento("ressonanciaMagnet" 			,{D_EVENT},nIdent+4	,"C1")
	cTag += GetTagEvento("tomografiaComputa"			,{D_EVENT},nIdent+4	,"C2")
	//procedDiagnCitopat
	cTag += SIPMontaXML("procedDiagnCitopat",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
	cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"C3")//
	cTag += SIPMontaXML("procedDiagnCitopat",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
	cTag += GetTagEvento("densitometriaOssea"			,{D_EVENT},nIdent+4	,"C4")
	cTag += GetTagEvento("ecodopplerTranstora"		,{D_EVENT},nIdent+4	,"C5")
	cTag += GetTagEvento("broncoscopiabiopsia"		,{D_EVENT},nIdent+4	,"C6")
	cTag += GetTagEvento("endoscopiaDigestiva"		,{D_EVENT},nIdent+4	,"C7")
	cTag += GetTagEvento("colonoscopia"					,{D_EVENT},nIdent+4	,"C8")
	cTag += GetTagEvento("holter24h"						,{D_EVENT},nIdent+4	,"C9")
	//Tag mamografia cont้m subItens
	cTag += SIPMontaXML("mamografiaConvDig",,,,,,nIdent+4,.T.,.F.,,,,.T.)	 
	cTag += GetTagEvento(""	,{D_EVENT},nIdent+4,"C10")		
		cTag += SIPMontaXML("mamografia50a69",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
		cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"C101")//
		cTag += SIPMontaXML("mamografia50a69",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
	cTag += SIPMontaXML("mamografiaConvDig",,,,,,nIdent+4,.F.,.T.,,,,.T.)				
	//	
	cTag += GetTagEvento("cintilografiaMiocard"		,{D_EVENT},nIdent+4	,"C11")
	cTag += GetTagEvento("cintilografiaRenal"			,{D_EVENT},nIdent+4	,"C12")
	cTag += GetTagEvento("hemoglobinaGlicada"			,{D_EVENT},nIdent+4	,"C13")
	cTag += SIPMontaXML("pesqSangueOculto",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
	cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+8,"C14")//
	cTag += SIPMontaXML("pesqSangueOculto",,,,,,nIdent+4,.F.,.T.,,,,.T.)	
	cTag += GetTagEvento("radiografia"					,{D_EVENT},nIdent+4	,"C15")
	cTag += GetTagEvento("testeErgometrico"			,{D_EVENT},nIdent+4	,"C16")
	cTag += GetTagEvento("ultraSonAbdoTotal"			,{D_EVENT},nIdent+4	,"C17")
	cTag += GetTagEvento("ultraSonAbdoInfer"			,{D_EVENT},nIdent+4	,"C18")
	cTag += GetTagEvento("ultraSonAbdoSuper"			,{D_EVENT},nIdent+4	,"C19")
	cTag += GetTagEvento("ultraSonObstMorfo"			,{D_EVENT},nIdent+4	,"C20")

Return cTag	

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณTagMedicasบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriacao da tag consultasMedicasAmb                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/               
Static Function TagMedicasAmbConsulta(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("consultasMedicasAmb",,,,,,nIdent,.T.,.F.,,,,.T.)		
		//Totais
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+4,"A1")
		
		//Eventos
		cTag += GetTagEvento("alergiaImunologia"			,{D_EVENT},nIdent+4	,"A11")
		cTag += GetTagEvento("angiologia" 					,{D_EVENT},nIdent+4	,"A12")
		cTag += GetTagEvento("cardiologia" 			  		,{D_EVENT},nIdent+4	,"A13")
		cTag += GetTagEvento("cirurgiaGeral" 				,{D_EVENT},nIdent+4	,"A14")
		cTag += GetTagEvento("clinicaMedica" 				,{D_EVENT},nIdent+4	,"A15")
		cTag += GetTagEvento("dermatologia" 				,{D_EVENT},nIdent+4	,"A16")
		cTag += GetTagEvento("endocrinologia" 		  		,{D_EVENT},nIdent+4	,"A17")
		cTag += GetTagEvento("gastroenterologia" 	  		,{D_EVENT},nIdent+4	,"A18")
		cTag += GetTagEvento("geriatria" 					,{D_EVENT},nIdent+4	,"A19")
		cTag += GetTagEvento("ginecologiaObstetricia" 	,{D_EVENT},nIdent+4	,"A110")
		cTag += GetTagEvento("hematologia" 					,{D_EVENT},nIdent+4	,"A111")
		cTag += GetTagEvento("mastologia" 					,{D_EVENT},nIdent+4	,"A112")
		cTag += GetTagEvento("nefrologia" 					,{D_EVENT},nIdent+4	,"A113")
		cTag += GetTagEvento("neurocirurgia" 				,{D_EVENT},nIdent+4	,"A114")
		cTag += GetTagEvento("neurologia" 					,{D_EVENT},nIdent+4	,"A115")
		cTag += GetTagEvento("oftalmologia" 				,{D_EVENT},nIdent+4	,"A116")
		cTag += GetTagEvento("oncologia" 					,{D_EVENT},nIdent+4	,"A117")
		cTag += GetTagEvento("otorrinolaringologia"		,{D_EVENT},nIdent+4	,"A118")
		cTag += GetTagEvento("pediatria" 					,{D_EVENT},nIdent+4	,"A119")
		cTag += GetTagEvento("proctologia" 			  		,{D_EVENT},nIdent+4	,"A120")
		cTag += GetTagEvento("psiquiatria" 			  		,{D_EVENT},nIdent+4	,"A121")
		cTag += GetTagEvento("reumatologia" 				,{D_EVENT},nIdent+4	,"A122")
		cTag += GetTagEvento("tisiopneumologia" 			,{D_EVENT},nIdent+4	,"A123")
		cTag += GetTagEvento("traumatologiaOrtopedica"	,{D_EVENT},nIdent+4	,"A124")
		cTag += GetTagEvento("urologia" 				  		,{D_EVENT},nIdent+4	,"A125")

	cTag += SIPMontaXML("consultasMedicasAmb",,,,,,nIdent,.F.,.T.,,,,.T.)	
	
Return cTag   


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณTagMedicasบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriacao da tag consultasMedicasAmb                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/               
Static Function TOutrosAtendAmb(nIdent)
	Local cTag	:=	""

	cTag += GetTagEvento("consultaSessaoFisio" 	,{D_EVENT},nIdent+4	,"B1")
	cTag += GetTagEvento("consultaSessaoFono"	,{D_EVENT},nIdent+4	,"B2")
	cTag += GetTagEvento("consultaSessaoNutri"	,{D_EVENT},nIdent+4	,"B3")
	cTag += GetTagEvento("consultaSessaoTerap"	,{D_EVENT},nIdent+4	,"B4")
	cTag += GetTagEvento("consultaSessaoPsico"	,{D_EVENT},nIdent+4	,"B5")

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณTagMedPronบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriacao da tag consultaMedProntSoc                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TagMedProntSocConsulta(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("consultaMedProntSoc",,,,,,nIdent,.T.,.F.,,,,.T.)		
		//Totais
		cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+4,"A2")			

	cTag += SIPMontaXML("consultaMedProntSoc",,,,,,nIdent,.F.,.T.,,,,.T.)	

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function TagProcOdonto(nIdent)
	Local cTag	:=	""

	cTag += SIPMontaXML("procOdonto",,,,,,nIdent,.T.,.F.,,,,.T.)		
		//Totais
		cTag += SIPMontaXML("procedimentosOdonto",,,,,,nIdent+4,.T.,.F.,,,,.T.)		
			cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"I")//procedimentosOdonto
			//		
			cTag += SIPMontaXML("consultasOdontoInic",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+12,"I1")	//Monta o Totalizador
			cTag += SIPMontaXML("consultasOdontoInic",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += SIPMontaXML("examesRadiograficos",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I2")	//Monta o Totalizador
			cTag += SIPMontaXML("examesRadiograficos",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//procedimentosPrevent
			cTag += SIPMontaXML("procedimentosPrevent",,,,,,nIdent+8,.T.,.F.,,,,.T.)	
				cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+8,"I3")//procedimentosPrevent
				//
				cTag += GetTagEvento("atividadeEduIndividual" 	,{D_EVENT},nIdent+12	,"I31")          
				//
				cTag += GetTagEvento("aplicTopProfFluorHemi" 	,{D_EVENT},nIdent+12	,"I32")
				//
				cTag += SIPMontaXML("selanteElemDentario",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
					cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I33")	//Monta o Totalizador
				cTag += SIPMontaXML("selanteElemDentario",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			cTag += SIPMontaXML("procedimentosPrevent",,,,,,nIdent+8,.F.,.T.,,,,.T.)				
			//procedimentosPrevent
			cTag += SIPMontaXML("raspSupraGengHemi",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I4")	//Monta o Totalizador
			cTag += SIPMontaXML("raspSupraGengHemi",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
   		//
			cTag += SIPMontaXML("restauraDenteDeciduo",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I5")	//Monta o Totalizador
			cTag += SIPMontaXML("restauraDenteDeciduo",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += SIPMontaXML("restauraDentePerma",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I6")	//Monta o Totalizador
			cTag += SIPMontaXML("restauraDentePerma",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += SIPMontaXML("exodontiasSimplesPer",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+12,"I7")	//Monta o Totalizador
			cTag += SIPMontaXML("exodontiasSimplesPer",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += SIPMontaXML("trataEndoConclDentesD",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I8")	//Monta o Totalizador
			cTag += SIPMontaXML("trataEndoConclDentesD",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += SIPMontaXML("trataEndoConclDentesP",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF},nIdent+12,"I9")	//Monta o Totalizador
			cTag += SIPMontaXML("trataEndoConclDentesP",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += SIPMontaXML("protesesOdontologicas",,,,,,nIdent+8,.T.,.F.,,,,.T.)	 
				cTag += GetTotByEvento({D_EVENT,D_BENEF,D_DESPE},nIdent+12,"I10")	//Monta o Totalizador
			cTag += SIPMontaXML("protesesOdontologicas",,,,,,nIdent+8,.F.,.T.,,,,.T.)	 
			//
			cTag += GetTagEvento("protesesOdontoUnitarias"	,{D_EVENT,D_DESPE},nIdent+8	,"I11")
		cTag += SIPMontaXML("procedimentosOdonto",,,,,,nIdent+4,.F.,.T.,,,,.T.)		
	cTag += SIPMontaXML("procOdonto",,,,,,nIdent,.F.,.T.,,,,.T.)	

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณGetTagEvenบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetTagEvento(cTagName,aReqEvent,nIdent,cItemSip)
	Local cTag		:=	""
	Local cValor	:=	"0"
	Local cTagItem	:=	""
	Local	cPicture	:=	""
	Local nReqIte	:=	0
	Local nValor	:=	0
	Local nPosIte	:=	Ascan(aQuadroI,{|aKey| AllTrim(aKey[1]) == AllTrim(cItemSip)})

	If ! Empty(cTagName)
		cTag += SIPMontaXML(cTagName,,,,,,nIdent,.T.,.F.,,,,.T.)	 
	EndIf
		
		For nReqIte := 1 To Len(aReqEvent)
			nValor	:=	0
			//
			If aReqEvent[nReqIte] == D_EVENT
				cPicture	:= cPicEvento//"@E 9999999999" 
				cTagItem	:=	"eventos"
            //
				If nPosIte > 0
					nValor	:=	aQuadroI[nPosIte,2,D_EVENT]
				EndIf
			ElseIf aReqEvent[nReqIte] == D_BENEF
				cPicture	:= cPicBenefi//"@E 9999999999"
				cTagItem	:=	"beneficiarios"		
            //
				If nPosIte > 0
					nValor	:=	aQuadroI[nPosIte,2,D_BENEF]
				EndIf
			ElseIf aReqEvent[nReqIte] == D_DESPE
				cPicture 	:= cPicTotal//"@E 9999999999.99" 
				cTagItem	:=	"despesas"		
				//
				If nPosIte > 0
					nValor	:=	aQuadroI[nPosIte,2,D_DESPE]
				EndIf
			EndIf
			cValor	:=	Transform(nValor,cPicture)			
			cTag 		+= SIPMontaXML(cTagItem,cValor,,,,,nIdent+4,.T.,.T.,,,,.T.)		
		Next nReqIte

	If ! Empty(cTagName)		
		cTag += SIPMontaXML(cTagName,,,,,,nIdent,.F.,.T.,,,,.T.)				
	EndIf

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณGetTotByEvบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetTotByEvento(aReqEvent,nIdent,cItem)
	Local cValor	:=	""
	Local cTagName	:=	""
	Local cTag		:=	""
	Local cSeekItem	:=	PadR(AllTrim(cItem),7," ")	
	Local nReqIte	:=	0            
	Local nQtdEvent	:=	0
	Local nQtdBenef	:=	0
	Local nVlrDespe	:=	0
	
	Local isReqBed		:=	Ascan(aReqEvent, D_BENEF) <> 0//Esta sendo solicitado o exposto?

	//Abriu o RecordSet TSEG 
	LoadTabTSeg(cSeekItem)

	Do While ! TSEG->(Eof())
		nQtdEvent	+=	TSEG->BZZ_EVENTO
		nQtdBenef	+=	TSEG->BZZ_BENEFI
		nVlrDespe	+=	If(MV_PAR08==1,If(MV_PAR12>0,TSEG->BZZ_VLRRAT,TSEG->BZZ_TOTAL),TSEG->BZZ_TOTAL)
		TSEG->(dbSkip())
	EndDo	
	
	TSEG->(dbCloseArea())

	For nReqIte := 1 To Len(aReqEvent)
		cValor	:=	"0"		
		If aReqEvent[nReqIte] == D_EVENT
			cTagName		:=	"eventos"
			cValor		:=	Transform(nQtdEvent,cPicEvento)			
		ElseIf aReqEvent[nReqIte] == D_BENEF 
			cTagName		:=	"beneficiarios"		
			cValor		:=	Transform(nQtdBenef,cPicBenefi)			
		ElseIf aReqEvent[nReqIte] == D_DESPE .And. isReqBed
			cTagName		:=	"despesas"		
			cValor		:=	Transform(nVlrDespe,cPicTotal)  			
		EndIf
		cTag += SIPMontaXML(cTagName,cValor,,,,,nIdent,.T.,.T.,,,,.T.)
	Next nReqIte

Return cTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPXML    บAuthor ณPLS-Team            บ Date ณ  08/20/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta um arquivo                                            บฑฑ
ฑฑบ          ณTemporario contento a lista de estado que deve ser          บฑฑ
ฑฑบ          ณprocessada.                                                 บฑฑ
ฑฑบ          ณTabela Quadro por estado QUA e Trimestre de ocorrencia.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetQuadroByState(cSegType)
	Local cSqlStatement	:= ""  
	Local lFilterState	:=	MV_PAR04 ==1

   If lFilterState
		cSqlStatement	+=	"Select BZZ_UF, BZZ_REFERE "
		cSqlStatement	+=	"From   " + RetSqlName("BZZ")
		cSqlStatement	+=  "	Join  " + RetSqlName("BI6")
		cSqlStatement	+=  "  	  On BZZ_FILIAL = BI6_FILIAL AND BZZ_CODSEG = BI6_CODSEG "   
		cSqlStatement	+=	"	Where		"+RetSqlName("BI6")+".D_E_L_E_T_ = ' ' And " +RetSqlName("BZZ")+".D_E_L_E_T_ = ' ' "
	
		If cSegType == D_AMD 
			cSqlStatement	+=	 " And (BZZ_ITEM Like 'A%' Or BZZ_ITEM Like 'B%' Or BZZ_ITEM Like 'C%' Or BZZ_ITEM Like 'D%' Or BZZ_ITEM = 'H' )
		ElseIf cSegType == D_HOS
			cSqlStatement	+=	 " And (BI6_SEGSIP = '1')
		ElseIf cSegType == D_OBS 
			cSqlStatement	+=	 " And (BI6_SEGSIP = '2')	
		ElseIf cSegType == D_ODO 
			cSqlStatement	+=	 " And (BZZ_ITEM Like 'I%') 		
		EndIf
		cSqlStatement	+=	"	And BZZ_UF 		<> 'FC' And BZZ_UF  <> '  '"//Sem os Expostos e sem os totalizadores de estado.
		cSqlStatement	+=	"	And BZZ_PERIOD = '"+cPerData+"'"
		cSqlStatement	+=	"	And BZZ_TIPPLA = '"+cTipPla+"'"
		If MV_PAR08==1 .AND. BZZ->(Fieldpos("BZZ_CODEMP")) > 0
			cSqlStatement	+=	"	And 	BZZ_CODEMP = '"+MV_PAR09+"' "	
			cSqlStatement	+=	"	And 	BZZ_CONEMP = '"+MV_PAR10+"' "	
			cSqlStatement	+=	"	And 	BZZ_SUBCON = '"+MV_PAR11+"' "	
		Endif	
	
		cSqlStatement	+=	"	Group By BZZ_UF, BZZ_REFERE  "
	Else
		cSqlStatement	+=	" Select '  ' BZZ_UF, BZZ_REFERE "
		cSqlStatement	+=	" From   " + RetSqlName("BZZ")
		cSqlStatement	+=	"	Where	D_E_L_E_T_ = ' '"
		cSqlStatement	+=	"         And BZZ_PERIOD = '"+cPerData+"'"
		If MV_PAR08==1 .AND. BZZ->(Fieldpos("BZZ_CODEMP")) > 0
			cSqlStatement	+=	"	And 	BZZ_CODEMP = '"+MV_PAR09+"' "	
			cSqlStatement	+=	"	And 	BZZ_CONEMP = '"+MV_PAR10+"' "	
			cSqlStatement	+=	"	And 	BZZ_SUBCON = '"+MV_PAR11+"' "	
		Endif	
	
		cSqlStatement	+=	"	Group By BZZ_REFERE  "
	EndIf

	cSqlStatement := ChangeQuery(cSqlStatement)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlStatement),"QUAESPO",.F.,.T.)
				
Return .T.
          
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณLoadQuadroบAuthor ณAlexandre Alves Silvบ Date ณ  08/20/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega no array de processamento com os itens              บฑฑ
ฑฑบDesc.     ณque sao referentes ao Quadro de processamento atual         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function LoadQuadro(cDataOcorrencia)
	Local cSqlStatement	:= ""	
	Local cSegmento		:=	"1"
	Local lFilterState	:=	MV_PAR04 ==1
	Local cSeekUF			:=	""
	
	If cSegEmAnalise == D_OBS
		cSegmento		:=	"2"
	EndIf
	//
	aQuadroI	:=	{}		

	//Retorna somente os itens sem os totalizadores.
	cSqlStatement	+= " Select BZZ_ITEM,SUM(BZZ_EVENTO) As BZZ_EVENTO ,SUM(BZZ_BENEFI) As BZZ_BENEFI"
	cSqlStatement	+= "	,SUM(BZZ_TOTAL) As BZZ_TOTAL "
	cSqlStatement	+= " From   " +RetSqlName("BZZ")
	cSqlStatement	+= "	Join  " + RetSqlName("BI6")
	cSqlStatement	+= " 		On BZZ_FILIAL = BI6_FILIAL AND BZZ_CODSEG = BI6_CODSEG "
	cSqlStatement	+=	"	Where		"+RetSqlName("BI6")+".D_E_L_E_T_ = ' ' And " +RetSqlName("BZZ")+".D_E_L_E_T_ = ' ' "

	//Filtro de acordo com o segmento.
	If cSegEmAnalise ==	D_AMD 
		//Itens ambulatorias
		cSqlStatement	+=	"		And(BZZ_ITEM Like 'A%' 	Or BZZ_ITEM Like 'B%' 	Or "
		cSqlStatement	+=	"          	BZZ_ITEM Like 'C%'	Or BZZ_ITEM Like 'D%'	Or 	BZZ_ITEM = 'H' )"
		//Nao quero os totais
		cSqlStatement	+=	"		And ( BZZ_ITEM <> 'A'	And BZZ_ITEM <> 'B' And "
		cSqlStatement	+=	"     		BZZ_ITEM <> 'C'	And BZZ_ITEM <> 'D') "
	ElseIf cSegEmAnalise ==	D_HOS .Or. cSegEmAnalise ==	D_OBS 
		//Itens Hospitalar e Hospitalar Obstreticia.
		cSqlStatement	+=	"		And(BZZ_ITEM Like 'E%' 	Or BZZ_ITEM Like 'F%' Or"
		cSqlStatement	+=	"			BZZ_ITEM = 'G'		Or BZZ_ITEM = 'H') "
		//Nao quero os totais
		cSqlStatement	+=	"		And(BZZ_ITEM <> 'E'		And BZZ_ITEM <> 'F')"		
		//Segmento selecionado.
		cSqlStatement	+= "		And	BI6_SEGSIP = '"+cSegmento+"'" 		
	ElseIf cSegEmAnalise ==	D_ODO 
		//Itens Odontologicos.
		cSqlStatement	+=	"		And(BZZ_ITEM Like 'I%')"
		//Nao quero os totais
		cSqlStatement	+=	"		And(BZZ_ITEM <> 'I')"		
	Else
		//Se nao for nenhum dos segmentos nao trazer nada.
		cSqlStatement	+= "	And BZZ_ITEM = '__'"	
	EndIf
	//Nao quero os expostos
	cSqlStatement		+= 	"	And BZZ_UF <> 'FC'"
	If lFilterState
		cSeekUF			:= IIf(cUF=="NC","  ",cUF)
		cSqlStatement	+= "	And BZZ_UF = '"+cSeekUF+"'"	
	EndIf
	//
	cSqlStatement	+=	"	And BZZ_PERIOD = '"+cPerData+"'"
	cSqlStatement	+=	"	And BZZ_TIPPLA = '"+cTipPla+"'"
	cSqlStatement	+=	"	And BZZ_REFERE = '"+cDataOcorrencia+"'"   
	
	If MV_PAR08==1 .AND. BZZ->(Fieldpos("BZZ_CODEMP")) > 0
		cSqlStatement	+=	"	And 	BZZ_CODEMP = '"+MV_PAR09+"' "	
		cSqlStatement	+=	"	And 	BZZ_CONEMP = '"+MV_PAR10+"' "	
		cSqlStatement	+=	"	And 	BZZ_SUBCON = '"+MV_PAR11+"' "	
	Endif	
	
	
	
	//	
	cSqlStatement	+= 	" Group By BZZ_ITEM"
	cSqlStatement	+= 	" Order By BZZ_ITEM "

	cSqlStatement := ChangeQuery(cSqlStatement)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlStatement),"TABITE",.F.,.T.)
	
	TABITE->(DbGoTop())
	Do While ! TABITE->(Eof())
		Aadd(aQuadroI,{TABITE->BZZ_ITEM ,{TABITE->BZZ_EVENTO,TABITE->BZZ_BENEFI,TABITE->BZZ_TOTAL}})				
		TABITE->(DbSkip())
	EndDo

	TABITE->(DbCloseArea())
	
Return .T.       

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณIsSegQuadrบAuthor ณAlexandre Alves Silvบ Date ณ  08/20/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe o segmento requisatado.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function IsSegQuadroExist(cSegType,cEstado,cDataOcorrencia)
	Local lExiste		:=	.F.	
	Local cSqlStatement	:= ""	
	Local cSegmento		:=	"1"
	
	cSqlStatement	+= 	"	Select Count(BI6_SEGSIP) SEGSIP "
	cSqlStatement	+= 	"	From " + RetSqlName("BZZ")
	cSqlStatement	+= 	"		Join  " + RetSqlName("BI6")
	cSqlStatement	+= 	" 			On BI6_FILIAL = '"+xFilial("BI6")+"'  AND BZZ_CODSEG = BI6_CODSEG "
	cSqlStatement	+= 	"   Where	BZZ_UF <> 'FC'"
	cSqlStatement	+=	"		And 	BZZ_PERIOD = '"+cPerData+"'"
   
   If cSegType == D_ODO
		cSqlStatement+=	"		And 	BZZ_ITEM like 'I%'"					
		//Itens sem classificacao
		cSqlStatement+=	"		And 	BZZ_ITEM <> 'I999'"							
	ElseIf cSegType == D_AMD
		cSqlStatement	+=	"	And( 	BZZ_ITEM Like 'A%' 	Or BZZ_ITEM Like 'B%' 	Or "
		cSqlStatement	+=	"          	BZZ_ITEM Like 'C%'	Or BZZ_ITEM Like 'D%'	Or "
		cSqlStatement	+=	"          	BZZ_ITEM = 'H' )"
		//Itens sem classificacao
		cSqlStatement	+=	"	And( 	BZZ_ITEM <> 'A999' 	And BZZ_ITEM <> 'B999' 	And "
		cSqlStatement	+=	"          	BZZ_ITEM <> 'C999'	And BZZ_ITEM <> 'D999'	And "
		cSqlStatement	+=	"          	BZZ_ITEM <> 'H999' )"
	Else//D_OBS-D_HOS
		If cSegType == D_OBS
			cSegmento		:=	"2"
		EndIf
		cSqlStatement	+=	"	And 	BI6_SEGSIP = '"+cSegmento+"'"	
		//Itens sem classificacao
		cSqlStatement	+=	"	And( 	BZZ_ITEM <> 'E999' 	And BZZ_ITEM <> 'F999' ) "
	EndIf	

	//Usado para verificar se existe quadro para o estado que esta sendo processado.
	//Se for NC, nao esta sendo realizada a quebra por estado.
	If ! Empty(cEstado) .And. cEstado <> "NC"  
		cSqlStatement	+=	"	And  	BZZ_UF = '"+cEstado+"'"	
	EndIf

	If ! Empty(cDataOcorrencia)
		cSqlStatement	+=	"	And 	BZZ_REFERE = '"+cDataOcorrencia+"'"	
	EndIf
	
	cSqlStatement	+=	"		And  	BZZ_TIPPLA = '"+cTipPla+"'"	
	cSqlStatement	+=	"	 	And 	"+RetSqlName("BI6")+".D_E_L_E_T_ = ' ' "
	cSqlStatement	+=	"	 	And 	"+RetSqlName("BZZ")+".D_E_L_E_T_ = ' ' "        
	
	
	If MV_PAR08==1 .AND. BZZ->(Fieldpos("BZZ_CODEMP")) > 0
			cSqlStatement	+=	"	And 	BZZ_CODEMP = '"+MV_PAR09+"' "	
			cSqlStatement	+=	"	And 	BZZ_CONEMP = '"+MV_PAR10+"' "	
			cSqlStatement	+=	"	And 	BZZ_SUBCON = '"+MV_PAR11+"' "	
	Endif	
	
	

	cSqlStatement := ChangeQuery(cSqlStatement)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlStatement),"TABSEG",.F.,.T.)
	
	If ! TABSEG->(Eof()) .And. TABSEG->SEGSIP > 0
		lExiste	:=	.T.
	EndIf
                   
	TABSEG->(dbCloseArea())
	
Return lExiste

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณLoadTabTSeบAuthor ณAlexandre Alves Silvบ Date ณ  08/20/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega os valores por segmento.                            บฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function LoadTabTSeg(cItem)
	Local cSqlStatement	:= ""	
	Local cSegmento		:= "1"
	Local cSeekUF		:= ""	
	Local lFilterState	:=	MV_PAR04 ==1
	
	cSqlStatement	+= 	"	Select BI6_SEGSIP, BZZ_CODSEG "
	cSqlStatement	+= 	"	       , SUM(BZZ_EVENTO) BZZ_EVENTO, SUM(BZZ_BENEFI) BZZ_BENEFI "
	cSqlStatement	+= 	"	       , SUM(BZZ_TOTAL) BZZ_TOTAL "  
	If BZZ->(FieldPos("BZZ_VLRRAT"))> 0 
		cSqlStatement	+= 	"	       , SUM(BZZ_VLRRAT) BZZ_VLRRAT "  	
	Endif
	cSqlStatement	+= 	"	From " + RetSqlName("BZZ")
	cSqlStatement	+= 	"			Join  " + RetSqlName("BI6")
	cSqlStatement	+= 	" 				On BZZ_FILIAL = BI6_FILIAL AND BZZ_CODSEG = BI6_CODSEG "
	cSqlStatement	+=	"		  	Where 	BZZ_ITEM = '"+cItem+"'"	
	
	If lFilterState
		cSeekUF		:= IIf(cUF=="NC","  ",cUF)
		cSqlStatement+= "		And 	(BZZ_UF = '"+cSeekUF+"')"
	Else
		cSqlStatement+= "		And 	(BZZ_UF <> 'FC')"
	EndIf
	
	If cSegEmAnalise == D_OBS .Or. cSegEmAnalise == D_HOS	
		If cSegEmAnalise == D_OBS
			cSegmento		:=	"2"
		EndIf
		cSqlStatement	+=	"    	And 	BI6_SEGSIP = '"+cSegmento+"'"
	EndIf

	cSqlStatement	+=	"	  	And 	BZZ_TIPPLA = '"+cTipPla+"'"
	cSqlStatement	+=	"	  	And 	BZZ_PERIOD = '"+cPerData+"'"
	If ! Empty(cDtOcorren)
		cSqlStatement	+=	"	And 	BZZ_REFERE = '"+cDtOcorren+"'"
	EndIf	
	cSqlStatement	+=	"	 	And 	"+RetSqlName("BI6")+".D_E_L_E_T_ = ' ' "
	cSqlStatement	+=	"	 	And 	"+RetSqlName("BZZ")+".D_E_L_E_T_ = ' ' "
	
	If MV_PAR08==1 .AND. BZZ->(Fieldpos("BZZ_CODEMP")) > 0
		cSqlStatement	+=	"	And 	BZZ_CODEMP = '"+MV_PAR09+"' "	
		cSqlStatement	+=	"	And 	BZZ_CONEMP = '"+MV_PAR10+"' "	
		cSqlStatement	+=	"	And 	BZZ_SUBCON = '"+MV_PAR11+"' "	
	Endif	

	
	cSqlStatement	+= 	" Group By BI6_SEGSIP,BZZ_CODSEG"	
	//Os expostos nao sao separados por segmento, so por tipo do plano.
	cSqlStatement	+= 	" Union"	
	cSqlStatement	+= 	" Select '','',0 BZZ_EVENTO,  Sum(BZZ_BENEFI) BZZ_BENEFI, 0  BZZ_TOTAL "
	If BZZ->(FieldPos("BZZ_VLRRAT"))> 0 
		cSqlStatement	+= 	"	       , 0 BZZ_VLRRAT "  	
	Endif
	cSqlStatement	+= 	"		From " + RetSqlName("BZZ")
	cSqlStatement	+=	" 		Where 	BZZ_ITEM = '"+cItem+"'"					
	cSqlStatement	+= 	"				And BZZ_UF = 'FC'  "
	cSqlStatement	+=	"	  			And BZZ_TIPPLA = '"+cTipPla+"'"
	cSqlStatement	+=	"	  			And BZZ_PERIOD = '"+cPerData+"'"
	cSqlStatement	+=	"	 			And "+RetSqlName("BZZ")+".D_E_L_E_T_ = ' ' "            
	
	If MV_PAR08==1 .AND. BZZ->(Fieldpos("BZZ_CODEMP")) > 0
		cSqlStatement	+=	"	And 	BZZ_CODEMP = '"+MV_PAR09+"' "	
		cSqlStatement	+=	"	And 	BZZ_CONEMP = '"+MV_PAR10+"' "	
		cSqlStatement	+=	"	And 	BZZ_SUBCON = '"+MV_PAR11+"' "	
	Endif	

	cSqlStatement := ChangeQuery(cSqlStatement)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cSqlStatement),"TSEG",.F.,.T.)
   
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณWriteXMLFiบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function WriteXMLFile(cXMLContent,cSequen)
	Local	cFileName	:= BA0->BA0_SUSEP+"_"+ "01"+cMesIni+MV_PAR01+"_"+Gravadata(ddatabase,.F.,5)+StrTran(Time(),":","")+".xsip"
	Local cFileDest	:= Alltrim(cDir)+cFileName
	Local nXMLFile		:= 0
	Local lGravado		:=	.T.

	If isXMLOnFile	
		FRename(cXmlTempFile,cFileDest) 
	Else
		nXMLFile		:= FCreate(cFileDest,0,,.F.)
		If nXMLFile > 0
			FWrite( nXMLFile,StrTran(cXMLContent,"> ","> "+chr(10)) )
		Else
			MsgAlert("Nao foi possivel gravar o xml no local indicado.") 
			lGravado	:= .F.
		EndIf
		FClose( nXMLFile )		
	EndIf

	If lGravado
		MsgAlert("XML gravado em: " + Alltrim(cDir)) 		
		PutMV("MV_PLSEQSIP",Soma1(cSequen))		
	EndIf

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณChkXMLSizeบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCaso o tamanho do XML que esta sendo gerado ultrapasse o li-บฑฑ
ฑฑบ          ณmite da String do Protheus 1Mb, inicia o processo de grava- บฑฑ
ฑฑบ          ณcao em arquivo temporario.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function ChkXMLSize(cXML)
	Local nXMLSize	:=	 Len(cXML)/1048576 //Tamanho da variavel em MB 
	Local nFile	:=	0

	If nXMLSize > 0.7
		If ! isXMLOnFile
			nFile	:= FCreate(cXmlTempFile,0,,.F.) 
		Else		
			nFile := FOpen(cXmlTempFile,FO_READWRITE + FO_SHARED)
			FSeek(nFile, 0, FS_END) //Posiciona no fim do arquivo				
		EndIf

     	If nFile <> -1 
			FWrite(nFile,StrTran(cXML,"> ","> "+chr(10)) )
			cXML	:=	Nil
			cXML	:=	""			
		Else
			MsgInfo("Erro na gravacao do XML")		
		EndIf
		
		FClose(nFile)
		isXMLOnFile	:=	.T. 		
	EndIf
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณInsInXMLTeบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function InsInXMLTemp(cXMLText,lOnTop)
	Local nFile			:=	0  
	Local nSwapFile	:=	0
	Local nBytesRead	:=	0
	Local cBuffer 		:= Space(F_BLOCK)
	Local lDone 		:= .F.

	If lOnTop
      //Cria um arquivo de swap.
		nSwapFile	:= FCreate(cXmlSwapFile,0,,.F.)
		FWrite(nSwapFile,StrTran(cXmlText,"> ","> "+chr(10)))
		
		//Abre o arquivo que contem os dados que serao adicionados ao final do arquivo de Swap
		nFile := FOpen(cXmlTempFile,FO_READWRITE + FO_SHARED)			
	   If nFile <> - 1
			Do While !lDone  
				nBytesRead := FRead(nFile,@cBuffer,F_BLOCK)
				If FWrite(nSwapFile,cBuffer, nBytesRead) < nBytesRead
					lDone := .T.
	    		Else
					lDone := (nBytesRead == 0)
	      		EndIf
			EndDo
			FClose(nSwapFile)
			FClose(nFile)		
		Else
			MsgInfo("Nao foi possivel localizar o arquivo contendo o XML.")
		EndIf
		//Renomeia de Swap para o nome correto.
		FErase(cXmlTempFile)
		FRename(cXmlSwapFile,cXmlTempFile) 
	Else
		//
		nFile := FOpen(cXmlTempFile,FO_READWRITE + FO_SHARED)	
		If nFile > 0
			FSeek(nFile, 0, FS_END) //Posiciona no fim do arquivo
			FWrite(nFile,StrTran(cXmlText,"> ","> "+chr(10)) ) 
		EndIf        
		FClose(nFile)
	EndIf
	
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณSIPMontaXMบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFoi necessario a criacao de uma nova funcao para calcular o บฑฑ
ฑฑบ          ณHash do arquivo para seguir a normas da ANS.                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function SIPMontaXML(cTag,cCampo,cTipo,nTam,nDec,cMask,nDesloc,lTagIn,lTagFim,lQuebra,cAtrib,lAcento,lDiopsfin)	
	Local cSIPTag		:=	MontaXML(cTag,cCampo,cTipo,nTam,nDec,cMask,nDesloc,lTagIn,lTagFim,.F.,cAtrib,lAcento,.F.)	
	Local nFile			:=	0
	
	cSipTag	:=	Alltrim(cSipTag)

	//Grava no arquivo para geracao do Hash.	
	If lDiopsfin 
		If lCriaHashFi 
			nFile			:= FCreate(cHashFile,0,,.F.)   
			lCriaHashFi	:=	.F.
		Else		
			nFile := FOpen(cHashFile,FO_READWRITE + FO_SHARED)
			FSeek(nFile, 0, FS_END) //Posiciona no fim do arquivo				
		EndIf

     	If nFile <> -1 
			FWrite(nFile,cSipTag)
		Else
			MsgInfo("Erro na gravacao do arquivo temporario para calculo do hash.")
		EndIf
		
		FClose(nFile)
	EndIf

Return cSIPTag

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณgetXmlEpilบAuthor ณMicrosiga           บ Date ณ  08/19/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o valor da hash para a tag epilogo.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function GetXmlEpilogo()
	Local cHash			:=	""	
	Local cBuffer		:=	""	
	Local cHashBuffer	:=	""	
	Local nBytesRead	:=	0
	Local nFileSize	:=	0   
	Local nInfile		:=	0

	aFile := Directory(cHashFile,"F")
	If Len(aFile) > 0 
		nFileSize := aFile[1,2]/1048576
		
		If nFileSize > 0.9
			cHash	:= MD5File(cHashFile)
		Else
        cBuffer 	:= Space(F_BLOCK)
        nInfile 	:= FOpen(cHashFile, FO_READ)
	    nFileSize	:= aFile[1,2]//Tamnho em bytes
        //
        Do While nFileSize > 0
			nBytesRead := FRead(nInfile, @cBuffer, F_BLOCK)
			nFileSize -= nBytesRead
			cHashBuffer	+= cBuffer
        EndDo
        	//
        	FClose(nInfile)
			FErase(cHashFile)	        	
			//memoWrite("c:\hashB.txt",cHashBuffer)
			cHash	:= MD5(cHashBuffer,2)		        
		EndIf
	Else
		MsgInfo("Nใo foi possivel fazer o calculo da hash. O arquivo "+cHashFile+ " nใo foi encontrado.")		
	EndIf
	 
Return cHash